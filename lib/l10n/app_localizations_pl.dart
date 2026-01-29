// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class SPl extends S {
  SPl([String locale = 'pl']) : super(locale);

  @override
  String get chatModuleInitFailed =>
      'Inicjalizacja modulu czatu nie powiodla sie';

  @override
  String get checkNetworkRetry =>
      'Sprawdz polaczenie sieciowe i sprobuj ponownie';

  @override
  String get retry => 'Ponow';

  @override
  String get unknownUser => 'Nieznany uzytkownik';

  @override
  String get walletNotConnected => 'Portfel nie jest polaczony';

  @override
  String get cannotGetWalletAddress => 'Nie mozna uzyskac adresu portfela';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Zadanie platnosci: $requestId';
  }

  @override
  String get callServiceNotInitialized =>
      'Usluga polaczen nie zostala zainicjowana';

  @override
  String get alreadyInCall => 'Juz trwa polaczenie';

  @override
  String get meetingServiceNotInitialized =>
      'Usluga spotkan nie zostala zainicjowana';

  @override
  String get livekitNotConfigured => 'LiveKit nie jest skonfigurowany';

  @override
  String get unknownConversation => 'Nieznana rozmowa';

  @override
  String startCallFailed(String error) {
    return 'Nie udalo sie rozpoczac polaczenia: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Nie udalo sie odebrać: $error';
  }

  @override
  String get connectionFailed => 'Polaczenie nie powiodlo sie';

  @override
  String get callRejected => 'Polaczenie odrzucone';

  @override
  String get noAnswer => 'Brak odpowiedzi';

  @override
  String get invalidLoginResponse => 'Nieprawidlowa odpowiedz logowania';

  @override
  String loginFailed(String error) {
    return 'Logowanie nie powiodlo sie: $error';
  }

  @override
  String get sessionRestoreFailed => 'Przywrocenie sesji nie powiodlo sie';

  @override
  String get additionalVerificationRequired => 'Wymagana dodatkowa weryfikacja';

  @override
  String registrationFailed(String error) {
    return 'Rejestracja nie powiodla sie: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Nie mozna polaczyc sie z serwerem: $error';
  }

  @override
  String get wrongUsernamePassword =>
      'Nieprawidlowa nazwa uzytkownika lub haslo';

  @override
  String get usernameTaken => 'Nazwa uzytkownika jest juz zajeta';

  @override
  String get invalidUsernameFormat => 'Nieprawidlowy format nazwy uzytkownika';

  @override
  String get rateLimitExceeded => 'Zbyt wiele zapytan, sprobuj pozniej';

  @override
  String get loginExpired => 'Sesja logowania wygasla';

  @override
  String joinMeetingFailed(String error) {
    return 'Nie udalo sie dolaczyc do spotkania: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Udostepnianie ekranu nie powiodlo sie: $error';
  }

  @override
  String get answer => 'Odbierz';

  @override
  String get decline => 'Odrzuc';

  @override
  String get missedCall => 'Nieodebrane polaczenie';

  @override
  String get callBack => 'Oddzwon';

  @override
  String get incomingCall => 'Polaczenie przychodzace';

  @override
  String get missedVideoCall => 'Nieodebrane polaczenie wideo';

  @override
  String get missedVoiceCall => 'Nieodebrane polaczenie glosowe';

  @override
  String get passkeyNotInitialized => 'Klucz dostepu nie zostal zainicjowany';

  @override
  String get googleSignInNotConfigured =>
      'Logowanie Google nie jest skonfigurowane';

  @override
  String get encryptedMessage => '[Zaszyfrowana wiadomosc]';

  @override
  String get sticker => '[Naklejka]';

  @override
  String get groupCreated => 'Grupa utworzona';

  @override
  String get groupNameChanged => 'Nazwa grupy zostala zmieniona';

  @override
  String get groupAvatarChanged => 'Awatar grupy zostal zmieniony';

  @override
  String get groupAnnouncementChanged => 'Ogloszenie grupy zostalo zmienione';

  @override
  String get image => '[Obraz]';

  @override
  String get video => '[Wideo]';

  @override
  String get voice => '[Glos]';

  @override
  String get file => '[Plik]';

  @override
  String get location => '[Lokalizacja]';

  @override
  String get unknownMessage => '[Nieznana wiadomosc]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName dolaczyl(a) do grupy';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName opuscil(a) grupe';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName zostal(a) zaproszony(a)';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName zostal(a) usuniety(a)';
  }

  @override
  String get avatarDataEmpty => 'Dane awatara sa puste';

  @override
  String get avatarTooLarge => 'Plik awatara jest za duzy, maks. 10MB';

  @override
  String get uploadAvatarFailed => 'Nie udalo sie przeslac awatara';

  @override
  String get delete => 'Usun';

  @override
  String get notLoggedIn => 'Nie zalogowano';

  @override
  String roomNotExist(String roomId) {
    return 'Pokoj nie zostal znaleziony: $roomId';
  }

  @override
  String get uploadImageFailed => 'Nie udalo sie przeslac obrazu';

  @override
  String get matrixClientNotInitialized =>
      'Klient Matrix nie zostal zainicjowany';

  @override
  String get uploadVoiceFailed =>
      'Nie udalo sie przeslac glosu: Nie mozna uzyskac URI MXC';

  @override
  String get uploadVideoFailed =>
      'Nie udalo sie przeslac wideo: Nie mozna uzyskac URI MXC';

  @override
  String get uploadFileFailed =>
      'Nie udalo sie przeslac pliku: Nie mozna uzyskac URI MXC';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Lokalizacja: $lat, $lon';
  }

  @override
  String get myLocation => 'Moja lokalizacja';

  @override
  String get pollEnded => 'Ankieta zakonczona';

  @override
  String get groupChat => 'Czat grupowy';

  @override
  String get search => 'Szukaj';

  @override
  String get cancel => 'Anuluj';

  @override
  String get userCancelled => 'Uzytkownik anulowal';

  @override
  String get noData => 'Brak danych';

  @override
  String get noSearchResults => 'Brak wynikow wyszukiwania';

  @override
  String get tryDifferentKeyword => 'Sprobuj innego slowa kluczowego';

  @override
  String get loadFailed => 'Nie udalo sie zaladowac';

  @override
  String get checkNetwork => 'Sprawdz polaczenie sieciowe';

  @override
  String get networkConnectionFailed => 'Polaczenie sieciowe nie powiodlo sie';

  @override
  String get checkNetworkSettings => 'Sprawdz ustawienia sieci';

  @override
  String get messages => 'Wiadomosci';

  @override
  String get contacts => 'Kontakty';

  @override
  String get discover => 'Odkrywaj';

  @override
  String get me => 'Ja';

  @override
  String get voiceLoading => 'Ladowanie glosu, sprobuj pozniej';

  @override
  String get voiceToTextFailed => 'Konwersja glosu na tekst nie powiodla sie';

  @override
  String get converting => 'Konwertowanie...';

  @override
  String get convertToText => 'Na tekst';

  @override
  String get convertToTextTitle => 'Konwertuj na tekst';

  @override
  String get selectEmoji => 'Wybierz emotikon';

  @override
  String get frequentlyUsed => 'Czesto uzywane';

  @override
  String get copy => 'Kopiuj';

  @override
  String get forward => 'Przekaz dalej';

  @override
  String get unfavorite => 'Usun z ulubionych';

  @override
  String get favorite => 'Ulubione';

  @override
  String get resend => 'Wyslij ponownie';

  @override
  String get recall => 'Wycofaj';

  @override
  String get multiSelect => 'Wielokrotny wybor';

  @override
  String get quote => 'Cytuj';

  @override
  String get remind => 'Przypomnij';

  @override
  String get searchThis => 'Szukaj';

  @override
  String get recallMessageConfirm => 'Wycofac te wiadomosc?';

  @override
  String get youRecalledMessage => 'Wycofales wiadomosc';

  @override
  String get otherRecalledMessage => 'Wiadomosc wycofana';

  @override
  String get reEdit => 'Edytuj ponownie';

  @override
  String get copied => 'Skopiowano';

  @override
  String get sendMessageHint => 'Wyslij wiadomosc';

  @override
  String get microphonePermissionRequired =>
      'Prosze zezwolic na dostep do mikrofonu';

  @override
  String startRecordingFailed(String error) {
    return 'Nie udalo sie rozpoczac nagrywania: $error';
  }

  @override
  String get recordingTooShort => 'Nagranie zbyt krotkie';

  @override
  String stopRecordingFailed(String error) {
    return 'Nie udalo sie zatrzymac nagrywania: $error';
  }

  @override
  String get releaseToCancel => 'Zwolnij, aby anulowac';

  @override
  String get releaseToSend =>
      'Zwolnij, aby wyslac, przesun w gore, aby anulowac';

  @override
  String get holdToTalk => 'Przytrzymaj, aby mowic';

  @override
  String get send => 'Wyslij';

  @override
  String conversationWithId(String roomId) {
    return 'Rozmowa: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Kontakt: $userId';
  }

  @override
  String get addFriend => 'Dodaj znajomego';

  @override
  String get chatServiceNotConnected => 'Usluga czatu nie jest polaczona';

  @override
  String userNotFoundHint(String query) {
    return 'Uzytkownik \"$query\" nie zostal znaleziony\n\nWskazowki:\n• Sprobuj wprowadzic pelny identyfikator uzytkownika, np. @nazwa:serwer.com\n• Sprawdz pisownie nazwy uzytkownika';
  }

  @override
  String createChatFailed(String error) {
    return 'Nie udalo sie utworzyc czatu: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Wyszukiwanie nie powiodlo sie: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Wprowadz ID uzytkownika lub nazwe, aby wyszukac';

  @override
  String get searching => 'Wyszukiwanie...';

  @override
  String get searchUserToChat => 'Wyszukaj uzytkownika, aby rozpoczac czat';

  @override
  String get matrixIdExample =>
      'Mozesz wprowadzic pelny identyfikator Matrix\nnp. @uzytkownik:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Uzytkownik \"$username\" nie zostal znaleziony';
  }

  @override
  String get chat => 'Czat';

  @override
  String get settings => 'Ustawienia';

  @override
  String get editProfile => 'Edytuj profil';

  @override
  String get login => 'Zaloguj sie';

  @override
  String get createGroup => 'Utworz grupe';

  @override
  String developing(String title) {
    return '$title\n(Wkrotce)';
  }

  @override
  String get error => 'Blad';

  @override
  String get pageNotFound => 'Strona nie zostala znaleziona';

  @override
  String get backToHome => 'Wroc do strony glownej';

  @override
  String get allRead => 'Wszystko przeczytane';

  @override
  String readCount(int count) {
    return '$count przeczytane';
  }

  @override
  String get transfer => 'Przelew';

  @override
  String get pendingReceipt => 'Oczekujace';

  @override
  String get tapToReceive => 'Dotknij, aby odebrac';

  @override
  String get received => 'Odebrano';

  @override
  String get paymentReceived => 'Platnosc odebrana';

  @override
  String get refunded => 'Zwrocono';

  @override
  String get expired => 'Wygaslo';

  @override
  String get redPacketGreeting => 'Najlepsze zyczenia';

  @override
  String get n42RedPacket => 'Czerwona koperta N42';

  @override
  String get goodLuck => 'Powodzenia';

  @override
  String get claimed => 'Odebrano';

  @override
  String get allClaimed => 'Wszystko odebrane';

  @override
  String get emoji => 'Emotikon';

  @override
  String get love => 'Milosc';

  @override
  String get animals => 'Zwierzeta';

  @override
  String get food => 'Jedzenie';

  @override
  String get travel => 'Podroze';

  @override
  String get activities => 'Aktywnosci';

  @override
  String get objects => 'Przedmioty';

  @override
  String get symbols => 'Symbole';

  @override
  String get reply => 'Odpowiedz';

  @override
  String get copiedToClipboard => 'Skopiowano do schowka';

  @override
  String get edit => 'Edytuj';

  @override
  String get more => 'Wiecej';

  @override
  String get selectForwardTarget => 'Wybierz odbiorce';

  @override
  String sendCount(int count) {
    return 'Wyslij ($count)';
  }

  @override
  String get draft => '[Szkic] ';

  @override
  String n42Id(String id) {
    return 'ID N42: $id';
  }

  @override
  String get n42IdTitle => 'ID N42';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Informacje o znajomym';

  @override
  String get friendInfoDesc =>
      'Dodaj uwage, telefon, tagi, notatki, zdjecia i ustaw uprawnienia znajomego.';

  @override
  String get moments => 'Chwile';

  @override
  String get sendMessage => 'Wiadomosc';

  @override
  String get audioVideoCall => 'Polaczenie audio/wideo';

  @override
  String get videoChannel => 'Kanal wideo';

  @override
  String get remark => 'Uwaga';

  @override
  String get remarkName => 'Nazwa uwagi';

  @override
  String get phone => 'Telefon';

  @override
  String get tags => 'Tagi';

  @override
  String get notes => 'Notatki';

  @override
  String get photos => 'Zdjecia';

  @override
  String get permissions => 'Uprawnienia';

  @override
  String get chatMomentsEtc => 'Czat, Chwile, Sport itp.';

  @override
  String get moreInfo => 'Wiecej informacji';

  @override
  String get commonGroups => 'Wspolne grupy';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Zrodlo';

  @override
  String get notificationSettings => 'Powiadomienia';

  @override
  String get receiveNotifications =>
      'Otrzymuj powiadomienia o nowych wiadomosciach';

  @override
  String get showPreview => 'Pokaz podglad wiadomosci';

  @override
  String get showContentInNotification =>
      'Pokaz tresc wiadomosci w powiadomieniach';

  @override
  String get notificationSound => 'Dzwiek powiadomienia';

  @override
  String get playSoundOnMessage => 'Odtwarzaj dzwiek przy odbiorze wiadomosci';

  @override
  String get vibrate => 'Wibracja';

  @override
  String get vibrateOnMessage => 'Wibruj przy odbiorze wiadomosci';

  @override
  String get doNotDisturb => 'Nie przeszkadzac';

  @override
  String get dndDescription => 'Wycisz powiadomienia w okreslonych godzinach';

  @override
  String get startTime => 'Czas rozpoczecia';

  @override
  String get endTime => 'Czas zakonczenia';

  @override
  String get privacy => 'Prywatnosc';

  @override
  String get appearance => 'Wyglad';

  @override
  String get about => 'O aplikacji';

  @override
  String get logout => 'Wyloguj';

  @override
  String get logoutConfirm => 'Czy na pewno chcesz sie wylogowac?';

  @override
  String get exit => 'Wyloguj';

  @override
  String get save => 'Zapisz';

  @override
  String get nickname => 'Pseudonim';

  @override
  String get enterNickname => 'Wprowadz pseudonim';

  @override
  String get signature => 'Podpis';

  @override
  String get addSignature => 'Dodaj podpis';

  @override
  String get takePhoto => 'Zrob zdjecie';

  @override
  String get chooseFromGallery => 'Wybierz z galerii';

  @override
  String saveFailed(String error) {
    return 'Nie udalo sie zapisac: $error';
  }

  @override
  String get secureDecentralizedChat =>
      'Bezpieczna, zdecentralizowana komunikacja';

  @override
  String get endToEndEncryption => 'Szyfrowanie od konca do konca';

  @override
  String get messagesOnlyYouCanSee =>
      'Wiadomosci widoczne tylko dla Ciebie i odbiorcy';

  @override
  String get decentralized => 'Zdecentralizowany';

  @override
  String get basedOnMatrix => 'Oparty na otwartym protokole Matrix';

  @override
  String get walletIntegration => 'Integracja portfela';

  @override
  String get easyCryptoTransfer => 'Latwe przelewy kryptowalut';

  @override
  String get register => 'Zarejestruj sie';

  @override
  String get agreeTerms => 'Logujac sie, akceptujesz ';

  @override
  String get termsOfService => 'Regulamin';

  @override
  String get and => ' i ';

  @override
  String get privacyPolicy => 'Polityke prywatnosci';

  @override
  String get serverAddress => 'Adres serwera';

  @override
  String get enterServerAddress => 'Wprowadz adres serwera';

  @override
  String get validServerAddress => 'Wprowadz prawidlowy adres serwera';

  @override
  String connectedTo(String serverName) {
    return 'Polaczono z $serverName';
  }

  @override
  String get username => 'Nazwa uzytkownika';

  @override
  String get enterUsername => 'Wprowadz nazwe uzytkownika';

  @override
  String get password => 'Haslo';

  @override
  String get enterPassword => 'Wprowadz haslo';

  @override
  String get registerAccount => 'Zarejestruj sie';

  @override
  String get forgotPassword => 'Zapomniales hasla';

  @override
  String get otherLoginMethods => 'Inne metody logowania';

  @override
  String get emailVerification => 'Kod weryfikacyjny e-mail';

  @override
  String get enterServerFirst => 'Najpierw wprowadz adres serwera';

  @override
  String get passkeyNeedsServer =>
      'Logowanie kluczem dostepu wymaga wsparcia serwera';

  @override
  String googleLoginSuccess(String email) {
    return 'Logowanie Google powiodlo sie: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Logowanie Google nie powiodlo sie: $error';
  }

  @override
  String get appleLoginSuccess => 'Logowanie Apple powiodlo sie';

  @override
  String appleLoginFailed(String error) {
    return 'Logowanie Apple nie powiodlo sie: $error';
  }

  @override
  String get createAccount => 'Utworz konto';

  @override
  String get joinN42Chat => 'Dolacz do N42 Chat, aby rozpoczac rozmowe';

  @override
  String get usernameHint => '3-20 znakow, litery/cyfry/_';

  @override
  String get usernameMinLength =>
      'Nazwa uzytkownika musi miec co najmniej 3 znaki';

  @override
  String get usernameMaxLength =>
      'Nazwa uzytkownika moze miec maksymalnie 20 znakow';

  @override
  String get usernameFormat =>
      'Nazwa uzytkownika moze zawierac tylko litery, cyfry i podkreslenia';

  @override
  String get passwordHint => 'Min. 8 znakow';

  @override
  String get passwordMinLength => 'Haslo musi miec co najmniej 8 znakow';

  @override
  String get confirmPassword => 'Potwierdz haslo';

  @override
  String get reEnterPassword => 'Wprowadz haslo ponownie';

  @override
  String get passwordsNotMatch => 'Hasla nie pasuja do siebie';

  @override
  String get inviteCode => 'Kod zaproszenia (wbudowany)';

  @override
  String get filled => 'Wypelniono';

  @override
  String get enterInviteCode => 'Wprowadz kod zaproszenia';

  @override
  String get inviteCodeHint =>
      'Kod zaproszenia jest wbudowany, zwykle nie trzeba go zmieniac';

  @override
  String get agreeTermsFirst =>
      'Najpierw przeczytaj i zaakceptuj regulamin i polityke prywatnosci';

  @override
  String get iAgree => 'Przeczytałem i akceptuje';

  @override
  String get alreadyHaveAccount => 'Masz juz konto?';

  @override
  String get loginNow => 'Zaloguj sie teraz';

  @override
  String get whoCanSee => 'Kto moze zobaczyc';

  @override
  String get avatar => 'Awatar';

  @override
  String get status => 'Status';

  @override
  String get lastSeen => 'Ostatnio widziany';

  @override
  String get messageSettings => 'Wiadomosci';

  @override
  String get allowStrangerMessage => 'Zezwalaj na wiadomosci od nieznajomych';

  @override
  String get receiveNonContact => 'Odbieraj wiadomosci od osob spoza kontaktow';

  @override
  String get readReceipts => 'Potwierdzenia odczytu';

  @override
  String get letOthersKnowRead =>
      'Pozwol innym wiedziec, ze przeczytales ich wiadomosci';

  @override
  String get typingStatus => 'Status pisania';

  @override
  String get letOthersKnowTyping => 'Pozwol innym wiedziec, ze piszesz';

  @override
  String get everyone => 'Wszyscy';

  @override
  String get contactsOnly => 'Tylko kontakty';

  @override
  String get nobody => 'Nikt';

  @override
  String whoCanSeeItem(String title) {
    return 'Kto moze zobaczyc $title';
  }

  @override
  String version(String version) {
    return 'Wersja $version';
  }

  @override
  String get checkUpdate => 'Sprawdz aktualizacje';

  @override
  String get openSourceLicenses => 'Licencje open source';

  @override
  String get feedback => 'Opinie';

  @override
  String get builtOnMatrix => 'Oparty na protokole Matrix';

  @override
  String get loading => 'Ladowanie...';

  @override
  String get noConversations => 'Brak rozmow';

  @override
  String get tapToChat => 'Dotknij prawego gornego rogu, aby rozpoczac rozmowe';

  @override
  String get startGroup => 'Rozpocznij czat grupowy';

  @override
  String get scan => 'Skanuj';

  @override
  String get payment => 'Platnosc';

  @override
  String featureComingSoon(String feature) {
    return '$feature wkrotce dostepne';
  }

  @override
  String get markAsRead => 'Oznacz jako przeczytane';

  @override
  String get unmute => 'Wlacz dzwiek';

  @override
  String get mute => 'Wycisz';

  @override
  String get unpin => 'Odepnij';

  @override
  String get pin => 'Przypnij';

  @override
  String get deleteConversation => 'Usun rozmowe';

  @override
  String deleteConversationConfirm(String name) {
    return 'Usunac rozmowe z \"$name\"?';
  }

  @override
  String get noContacts => 'Brak kontaktow';

  @override
  String get addFriendsToChat => 'Dodaj znajomych, aby rozpoczac rozmowe';

  @override
  String get contactNotFound => 'Kontakt nie zostal znaleziony';

  @override
  String get tryOtherKeywords =>
      'Sprobuj innych slow kluczowych lub wyszukiwania globalnego';

  @override
  String get searchResults => 'Wyniki wyszukiwania';

  @override
  String get newFriends => 'Nowi znajomi';

  @override
  String get chatOnlyFriends => 'Znajomi tylko do czatu';

  @override
  String get officialAccounts => 'Konta oficjalne';

  @override
  String get serviceAccounts => 'Konta uslugowe';

  @override
  String get enterpriseContacts => 'Kontakty firmowe';

  @override
  String contactsCount(int count) {
    return '$count kontaktow';
  }

  @override
  String get recommendToFriend => 'Udostepnij kontakt';

  @override
  String get setRemark => 'Ustaw uwage';

  @override
  String get addToHome => 'Dodaj do ekranu glownego';

  @override
  String get sendingCard => 'Wysylanie wizytowki...';

  @override
  String get contactCard => '[Wizytowka]';

  @override
  String get fileLabel => 'Plik';

  @override
  String get locationLabel => 'Lokalizacja';

  @override
  String cardSent(String contact, String friend) {
    return 'Wyslano wizytowke $contact do $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Polecenie nie powiodlo sie: $error';
  }

  @override
  String get enterRemark => 'Wprowadz uwage';

  @override
  String remarkSet(String remark) {
    return 'Uwaga ustawiona na: $remark';
  }

  @override
  String get openingChat => 'Otwieranie czatu...';

  @override
  String openChatFailed(String error) {
    return 'Nie udalo sie otworzyc czatu: $error';
  }

  @override
  String get addContact => 'Dodaj kontakt';

  @override
  String get enterUserId => 'Wprowadz ID uzytkownika';

  @override
  String get noFriendRequests => 'Brak zaproszen do znajomych';

  @override
  String get accept => 'Akceptuj';

  @override
  String get reject => 'Odrzuc';

  @override
  String acceptedRequest(String name) {
    return 'Zaakceptowano zaproszenie od $name';
  }

  @override
  String rejectedRequest(String name) {
    return 'Odrzucono zaproszenie od $name';
  }

  @override
  String get noGroups => 'Brak grup';

  @override
  String get creatingGroup => 'Tworzenie grupy wkrotce dostepne...';

  @override
  String get selectFriendToRecommend => 'Wybierz znajomego do polecenia';

  @override
  String get searchContacts => 'Szukaj kontaktow';

  @override
  String get noContactsFound => 'Nie znaleziono kontaktow';

  @override
  String get yesterday => 'Wczoraj';

  @override
  String get monday => 'Pon';

  @override
  String get tuesday => 'Wt';

  @override
  String get wednesday => 'Sr';

  @override
  String get thursday => 'Czw';

  @override
  String get friday => 'Pt';

  @override
  String get saturday => 'Sob';

  @override
  String get sunday => 'Niedz';

  @override
  String get justNow => 'Przed chwila';

  @override
  String minutesAgo(int count) {
    return '$count min temu';
  }

  @override
  String hoursAgo(int count) {
    return '$count godz. temu';
  }

  @override
  String daysAgo(int count) {
    return '$count dni temu';
  }

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String minutesAgoOnline(int count) {
    return 'Online $count min temu';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Online $count godz. temu';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Online $count dni temu';
  }

  @override
  String get searchContactsGroupsMessages =>
      'Szukaj kontaktow, grup, wiadomosci';

  @override
  String get searchError => 'Blad wyszukiwania';

  @override
  String get searchHint => 'Szukaj kontaktow, grup i wiadomosci';

  @override
  String get enterKeyword => 'Wprowadz slowa kluczowe, aby wyszukac';

  @override
  String get searchHistory => 'Historia wyszukiwania';

  @override
  String get clear => 'Wyczysc';

  @override
  String noResultsFor(String query) {
    return 'Brak wynikow dla \"$query\"';
  }

  @override
  String get all => 'Wszystko';

  @override
  String get groups => 'Grupy';

  @override
  String get noResults => 'Brak wynikow';

  @override
  String get groupInfo => 'Informacje o grupie';

  @override
  String groupMembers(int count) {
    return 'Czlonkowie ($count)';
  }

  @override
  String get groupMembersTitle => 'Członkowie grupy';

  @override
  String get viewAll => 'Zobacz wszystko';

  @override
  String get owner => 'Wlasciciel';

  @override
  String get admin => 'Administrator';

  @override
  String get invite => 'Zapros';

  @override
  String get groupAnnouncement => 'Ogloszenie grupy';

  @override
  String get notSet => 'Nie ustawiono';

  @override
  String get groupDescription => 'Opis grupy';

  @override
  String get publicGroup => 'Grupa publiczna';

  @override
  String get allowSearchJoin => 'Zezwalaj innym na wyszukiwanie i dolaczanie';

  @override
  String get clearChatHistory => 'Wyczysc historie czatu';

  @override
  String get dissolveGroup => 'Rozwiaz grupe';

  @override
  String get leaveGroup => 'Opusc grupe';

  @override
  String get changeGroupName => 'Zmien nazwe grupy';

  @override
  String get enterGroupName => 'Wprowadz nazwe grupy';

  @override
  String get confirm => 'Potwierdz';

  @override
  String get changeGroupDescription => 'Zmien opis grupy';

  @override
  String get enterGroupDescription => 'Wprowadz opis grupy';

  @override
  String get editAnnouncement => 'Edytuj ogloszenie';

  @override
  String get enterAnnouncement => 'Wprowadz ogloszenie';

  @override
  String get publish => 'Opublikuj';

  @override
  String get clearHistoryConfirm =>
      'Wyczyścic cala historie czatu? Tej operacji nie mozna cofnac.';

  @override
  String get clearAction => 'Wyczysc';

  @override
  String get chatHistoryCleared => 'Historia czatu wyczyszczona';

  @override
  String leaveGroupConfirm(String name) {
    return 'Opuscic \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Rozwiazac \"$name\"? Tej operacji nie mozna cofnac.';
  }

  @override
  String get dissolve => 'Rozwiaz';

  @override
  String get groupQrCode => 'Kod QR grupy';

  @override
  String get searchChatHistory => 'Szukaj w historii czatu';

  @override
  String get groupIdCopied => 'ID grupy skopiowano';

  @override
  String tapCopyGroupId(int count) {
    return '$count czlonkow · Dotknij, aby skopiowac ID grupy';
  }

  @override
  String get receiverAddress => 'Adres odbiorcy';

  @override
  String get enterOrPasteAddress => 'Wprowadz lub wklej adres portfela';

  @override
  String get selectToken => 'Wybierz token';

  @override
  String get transferAmount => 'Kwota przelewu';

  @override
  String get available => 'Dostepne';

  @override
  String get allAmount => 'Wszystko';

  @override
  String get memoOptional => 'Notatka (opcjonalna)';

  @override
  String get addMemo => 'Dodaj notatke';

  @override
  String get confirmTransfer => 'Potwierdz przelew';

  @override
  String get invalidAddress => 'Wprowadz prawidlowy adres odbiorcy';

  @override
  String get invalidAmount => 'Wprowadz prawidlowa kwote';

  @override
  String get selectTokenPlease => 'Wybierz token';

  @override
  String get addressVerified => 'Adres zweryfikowany';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Dostepne: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Funkcja skanowania w trakcie rozwoju...';

  @override
  String get enterAmount => 'Wprowadz kwote';

  @override
  String get redPacketCountMin => 'Wymagana co najmniej 1 czerwona koperta';

  @override
  String get viewRedPacketDetails => 'Zobacz szczegoly czerwonej koperty';

  @override
  String get enterTransferAmount => 'Wprowadz kwote przelewu';

  @override
  String get transferTo => 'Przelew do';

  @override
  String get selectCurrency => 'Wybierz walute';

  @override
  String get receiveTransfer => 'Odebrany przelew';

  @override
  String fromSender(String name, Object senderName) {
    return 'Od $senderName';
  }

  @override
  String get confirmReceive => 'Potwierdz odbiór';

  @override
  String get groupProfile => 'Informacje o grupie';

  @override
  String get viewProfile => 'Zobacz profil';

  @override
  String get removeMember => 'Usun z grupy';

  @override
  String removeMemberConfirm(String name) {
    return 'Usunac \"$name\" z grupy?';
  }

  @override
  String get remove => 'Usun';

  @override
  String get clearStatus => 'Wyczysc status';

  @override
  String get clearStatusConfirm => 'Wyczyścic biezacy status?';

  @override
  String get statusCleared => 'Status wyczyszczony';

  @override
  String statusSet(String result) {
    return 'Status ustawiony na: $result';
  }

  @override
  String get userNotExist => 'Uzytkownik nie istnieje';

  @override
  String get userIdCopied => 'ID uzytkownika skopiowano';

  @override
  String get voiceCallInDevelopment =>
      'Polaczenie glosowe w trakcie rozwoju...';

  @override
  String get report => 'Zglos';

  @override
  String get reportInDevelopment => 'Funkcja zglaszania w trakcie rozwoju...';

  @override
  String get shareCard => 'Udostepnij wizytowke';

  @override
  String get shareInDevelopment => 'Funkcja udostepniania w trakcie rozwoju...';

  @override
  String get qrCode => 'Kod QR';

  @override
  String get qrCodeInDevelopment => 'Funkcja kodu QR w trakcie rozwoju...';

  @override
  String get avatarUpdated => 'Awatar zaktualizowany';

  @override
  String selectImageFailed(String error) {
    return 'Nie udalo sie wybrac obrazu: $error';
  }

  @override
  String get changeName => 'Zmien nazwe';

  @override
  String get male => 'Mezczyzna';

  @override
  String get female => 'Kobieta';

  @override
  String genderSet(String gender) {
    return 'Plec ustawiona na: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Region ustawiony na: $region';
  }

  @override
  String get setPatText => 'Ustaw tekst poklepania';

  @override
  String get changeSignature => 'Zmien podpis';

  @override
  String ringtoneSet(String result) {
    return 'Dzwonek ustawiony na: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature w trakcie rozwoju...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Nie udalo sie zapisac adresu: $error';
  }

  @override
  String get myAddress => 'Moj adres';

  @override
  String get addNew => 'Dodaj';

  @override
  String get addAddress => 'Dodaj adres';

  @override
  String get addressAdded => 'Adres dodany';

  @override
  String get addressUpdated => 'Adres zaktualizowany';

  @override
  String get deleteAddress => 'Usun adres';

  @override
  String get deleteAddressConfirm => 'Usunac ten adres?';

  @override
  String get addressDeleted => 'Adres usuniety';

  @override
  String get setDefaultAddress => 'Ustaw jako domyslny';

  @override
  String get fillCompleteInfo => 'Wypelnij wszystkie pola';

  @override
  String saveInvoiceFailed(String error) {
    return 'Nie udalo sie zapisac faktury: $error';
  }

  @override
  String get myInvoices => 'Moje faktury';

  @override
  String get addInvoice => 'Dodaj fakture';

  @override
  String get invoiceAdded => 'Faktura dodana';

  @override
  String get invoiceUpdated => 'Faktura zaktualizowana';

  @override
  String get deleteInvoice => 'Usun fakture';

  @override
  String get deleteInvoiceConfirm => 'Usunac te fakture?';

  @override
  String get invoiceDeleted => 'Faktura usunieta';

  @override
  String get invoiceType => 'Typ faktury: ';

  @override
  String get personal => 'Osobista';

  @override
  String get enterprise => 'Firmowa';

  @override
  String get setDefaultInvoice => 'Ustaw jako domyslna';

  @override
  String get enterTaxId => 'Wprowadz NIP';

  @override
  String get vibrateMode => 'Tryb wibracji';

  @override
  String get silentMode => 'Tryb cichy';

  @override
  String playing(String ringtoneName) {
    return 'Odtwarzanie: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Nie udalo sie odtworzyc: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Wprowadz nazwe grupy';

  @override
  String get selectAtLeastOne => 'Wybierz co najmniej jednego czlonka';

  @override
  String get fillStatus => 'Napisz status';

  @override
  String get fileNotExist => 'Plik nie istnieje';

  @override
  String sendFailed(String error) {
    return 'Wyslanie nie powiodlo sie: $error';
  }

  @override
  String get cannotOpenBrowser => 'Nie mozna otworzyc przegladarki';

  @override
  String selectFileFailed(String error) {
    return 'Nie udalo sie wybrac pliku: $error';
  }

  @override
  String get enterMusicLink => 'Wprowadz link do muzyki';

  @override
  String get enterValidLink => 'Wprowadz prawidlowy link';

  @override
  String get enterPollQuestion => 'Wprowadz pytanie ankiety';

  @override
  String get minTwoOptions => 'Wymagane co najmniej 2 opcje';

  @override
  String get crossDeviceEnabled => 'Podpisywanie miedzyurzadzeniowe wlaczone';

  @override
  String get crossDeviceSet =>
      'Podpisywanie miedzyurzadzeniowe skonfigurowane pomyslnie';

  @override
  String setupFailed(String error) {
    return 'Konfiguracja nie powiodla sie: $error';
  }

  @override
  String get receiveAmount => 'Kwota do otrzymania';

  @override
  String get enterValidAmount => 'Wprowadz prawidlowa kwote';

  @override
  String get addressCopied => 'Adres skopiowany';

  @override
  String openItem(String content) {
    return 'Otworz: $content';
  }

  @override
  String get newNoteComingSoon => 'Nowa notatka wkrotce dostepna';

  @override
  String get addLinkComingSoon => 'Dodawanie linkow wkrotce dostepne';

  @override
  String get deleted => 'Usunieto';

  @override
  String get shareComingSoon => 'Udostepnianie wkrotce dostepne';

  @override
  String get saveComingSoon => 'Zapisywanie wkrotce dostepne';

  @override
  String get moreStylesComingSoon => 'Wiecej stylow wkrotce dostepnych';

  @override
  String get wallet => 'Portfel';

  @override
  String get walletArea => 'Strefa portfela';

  @override
  String get recording => 'Nagrywanie';

  @override
  String get invalidVideoUrl => 'Nieprawidlowy adres URL wideo';

  @override
  String get downloadFile => 'Pobierz plik';

  @override
  String get clearChatHistoryTitle => 'Wyczysc historie czatu';

  @override
  String get cannotUndo => 'Tej operacji nie mozna cofnac';

  @override
  String get videoCall => 'Polaczenie wideo';

  @override
  String get voiceCall => 'Polaczenie glosowe';

  @override
  String get leaveMeeting => 'Opusc spotkanie';

  @override
  String get chatDetails => 'Szczegoly czatu';

  @override
  String get viewAllGroupMembers => 'Zobacz wszystkich czlonkow';

  @override
  String get groupName => 'Nazwa grupy';

  @override
  String get groupNameUpdated => 'Nazwa grupy zaktualizowana';

  @override
  String get updateFailed => 'Aktualizacja nie powiodla sie';

  @override
  String get noPermissionToModify => 'Nie masz uprawnien do modyfikacji';

  @override
  String get groupManagement => 'Zarzadzanie grupa';

  @override
  String get myNicknameInGroup => 'Moj pseudonim w grupie';

  @override
  String get pinChat => 'Przypnij czat';

  @override
  String get strongReminder => 'Silne przypomnienie';

  @override
  String get setChatBackground => 'Ustaw tlo czatu';

  @override
  String get unknownFile => 'Nieznany plik';

  @override
  String get download => 'Pobierz';

  @override
  String get invalidLocation => 'Nieprawidlowa lokalizacja';

  @override
  String get address => 'Adres';

  @override
  String get latitude => 'Szerokosc geograficzna';

  @override
  String get longitude => 'Dlugosc geograficzna';

  @override
  String get close => 'Zamknij';

  @override
  String get tapToCancel => 'Dotknij, aby anulowac';

  @override
  String captureFailed(Object error) {
    return 'Przechwytywanie nie powiodlo sie: $error';
  }

  @override
  String get processingVideo => 'Przetwarzanie wideo...';

  @override
  String get videoFileNotExist => 'Plik wideo nie istnieje';

  @override
  String get videoDataEmpty => 'Dane wideo sa puste';

  @override
  String get videoTooLarge => 'Rozmiar wideo nie moze przekraczac 100MB';

  @override
  String get sendingVideo => 'Wysylanie wideo...';

  @override
  String sendVideoFailed(Object error) {
    return 'Nie udalo sie wyslac wideo: $error';
  }

  @override
  String get imageFileNotExist => 'Plik obrazu nie istnieje';

  @override
  String get imageDataEmpty => 'Dane obrazu sa puste';

  @override
  String get sendingImage => 'Wysylanie obrazu...';

  @override
  String sendImageFailed(Object error) {
    return 'Nie udalo sie wyslac obrazu: $error';
  }

  @override
  String get sendLocation => 'Wyslij lokalizacje';

  @override
  String get selectLocationAndSend => 'Wybierz lokalizacje i wyslij';

  @override
  String get shareRealTimeLocation =>
      'Udostepnij lokalizacje w czasie rzeczywistym';

  @override
  String get shareLocationForOneHour =>
      'Udostepnij lokalizacje znajomemu przez 1 godzine';

  @override
  String get locationSent => 'Lokalizacja wyslana';

  @override
  String get selectMessages => 'Wybierz wiadomosci';

  @override
  String selectedCount(int count) {
    return 'Wybrano $count';
  }

  @override
  String get selectAll => 'Wybierz wszystko';

  @override
  String groupChatCount(int count) {
    return 'Czat grupowy ($count)';
  }

  @override
  String get privateChat => 'Czat prywatny';

  @override
  String get noMessages => 'Brak wiadomosci';

  @override
  String get sendFirstMessage =>
      'Wyslij pierwsza wiadomosc, aby rozpoczac rozmowe';

  @override
  String get encryptionNotice =>
      'Ten czat jest szyfrowany od konca do konca. Tylko Ty i odbiorca mozecie czytac wiadomosci.';

  @override
  String replyTo(String name) {
    return 'Odpowiedz do $name';
  }

  @override
  String get multiForward => 'Przekaz dalej';

  @override
  String get collect => 'Zbierz';

  @override
  String get noMembers => 'Brak czlonkow';

  @override
  String get memberNotFound => 'Czlonek nie zostal znaleziony';

  @override
  String get voiceFileNotExist => 'Plik glosowy nie istnieje';

  @override
  String get voiceFileEmpty => 'Plik glosowy jest pusty';

  @override
  String get sendingVoice => 'Wysylanie glosu...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Nie udalo sie wyslac glosu: $error';
  }

  @override
  String get messageCopied => 'Wiadomosc skopiowana';

  @override
  String get messageForwarded => 'Wiadomosc przekazana';

  @override
  String forwardFailed(Object error) {
    return 'Przekazanie nie powiodlo sie: $error';
  }

  @override
  String get unfavorited => 'Usunieto z ulubionych';

  @override
  String get favorited => 'Dodano do ulubionych';

  @override
  String get reactionAdded => 'Reakcja dodana';

  @override
  String get failedMessageDeleted => 'Nieudana wiadomosc usunieta';

  @override
  String get deleteMessages => 'Usun wiadomosci';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Czy na pewno chcesz usunac $count wiadomosci?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Uwaga: $count wiadomosci jest od innych, mozna usunac tylko lokalnie.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count wiadomosci od Ciebie zostanie wycofanych.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Wycofano $count wiadomosci, usunieto $localCount lokalnie';
  }

  @override
  String recalledMessages(Object count) {
    return 'Wycofano $count wiadomosci';
  }

  @override
  String deletedLocally(Object count) {
    return 'Usunieto $count wiadomosci (lokalnie)';
  }

  @override
  String forwardedCount(Object count) {
    return 'Przekazano $count wiadomosci';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Przekazanie zakonczone: $success udanych, $failed nieudanych';
  }

  @override
  String get remindOnlyInGroup =>
      'Funkcja przypomnienia jest dostepna tylko w czacie grupowym';

  @override
  String get onlyTextSearchable => 'Mozna wyszukiwac tylko wiadomosci tekstowe';

  @override
  String searchFor(Object text) {
    return 'Szukaj \"$text\"';
  }

  @override
  String get baiduSearch => 'Wyszukiwanie Baidu';

  @override
  String get googleSearch => 'Wyszukiwanie Google';

  @override
  String get bingSearch => 'Wyszukiwanie Bing';

  @override
  String get calling => 'Dzwonie...';

  @override
  String get connecting => 'Laczenie...';

  @override
  String get ringing => 'Dzwoni...';

  @override
  String get inCall => 'W trakcie polaczenia';

  @override
  String featureInDevelopment(String feature) {
    return 'Funkcja w trakcie rozwoju...';
  }

  @override
  String collectMessages(Object count) {
    return 'Zebrano $count wiadomosci';
  }

  @override
  String get voted => 'Zaglosowano';

  @override
  String get voteChanged => 'Glos zmieniony';

  @override
  String get voteRemoved => 'Glos usuniety';

  @override
  String get endPoll => 'Zakoncz ankiete';

  @override
  String get endPollConfirm =>
      'Czy na pewno chcesz zakonczyc te ankiete? Po zakonczeniu nie bedzie mozna glosowac.';

  @override
  String memberCount(int count) {
    return '$count czlonkow';
  }

  @override
  String get videoChannels => 'Kanaly';

  @override
  String get live => 'Na zywo';

  @override
  String get listen => 'Sluchaj';

  @override
  String get watch => 'Ogladaj';

  @override
  String get searchDiscover => 'Szukaj';

  @override
  String get nearbyPeople => 'W poblizu';

  @override
  String get games => 'Gry';

  @override
  String get miniPrograms => 'Miniprogramy';

  @override
  String done(int count) {
    return 'Gotowe($count)';
  }

  @override
  String get services => 'Uslugi';

  @override
  String get favorites => 'Ulubione';

  @override
  String get ordersAndCards => 'Zamowienia i karty';

  @override
  String get stickers => 'Naklejki';

  @override
  String statusSetTo(String status) {
    return 'Status ustawiony na: $status';
  }

  @override
  String get avatarUploadFailed => 'Przesylanie awatara nie powiodlo sie';

  @override
  String get personalProfile => 'Profil osobisty';

  @override
  String get name => 'Imie';

  @override
  String get gender => 'Plec';

  @override
  String get region => 'Region';

  @override
  String get myQrCode => 'Moj kod QR';

  @override
  String get poke => 'Szturchnij';

  @override
  String get ringtone => 'Dzwonek';

  @override
  String get defaultRingtone => 'Domyslny dzwonek';

  @override
  String get myAddresses => 'Moje adresy';

  @override
  String genderSetTo(String gender) {
    return 'Plec ustawiona na: $gender';
  }

  @override
  String get selectRegion => 'Wybierz region';

  @override
  String get selectCity => 'Wybierz miasto';

  @override
  String regionSetTo(String region) {
    return 'Region ustawiony na: $region';
  }

  @override
  String get setPoke => 'Ustaw szturchniecie';

  @override
  String get friendPokedMe => 'Znajomy mnie szturchnal';

  @override
  String get enterPokeSuffix =>
      'Wprowadz przyrostek szturchniecia, np.: w ramie';

  @override
  String get example => 'Przyklad';

  @override
  String get onTheShoulder => ' w ramie';

  @override
  String get pokeCleared => 'Szturchniecie wyczyszczone';

  @override
  String pokeSetTo(String suffix) {
    return 'Szturchniecie ustawione na: szturchnal mnie$suffix';
  }

  @override
  String get editSignature => 'Edytuj podpis';

  @override
  String get introduceYourself => 'Zdanie, ktore Cie opisuje';

  @override
  String get signatureCleared => 'Podpis wyczyszczony';

  @override
  String get signatureUpdated => 'Podpis zaktualizowany';

  @override
  String get scanToAddFriend =>
      'Zeskanuj powyzszy kod QR, aby dodac mnie jako znajomego';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Dzwonek ustawiony na: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Czy na pewno chcesz rozwiązać \"$name\"? Tej operacji nie można cofnąć.';
  }

  @override
  String get enterValidServerAddress => 'Wprowadz prawidlowy adres serwera';

  @override
  String get emailOtp => 'Kod OTP z e-maila';

  @override
  String get enterServerAddressFirst => 'Najpierw wprowadz adres serwera';

  @override
  String get passkeyRequiresServer =>
      'Logowanie kluczem dostepu wymaga wsparcia serwera';

  @override
  String get loginAgreement => 'Logujac sie, akceptujesz ';

  @override
  String get pleaseAgreeToTerms =>
      'Przeczytaj i zaakceptuj Regulamin i Polityke prywatnosci';

  @override
  String get registerFailed => 'Rejestracja nie powiodla sie';

  @override
  String get reenterPassword => 'Wprowadz haslo ponownie';

  @override
  String get passwordsDoNotMatch => 'Hasla nie pasuja do siebie';

  @override
  String get inviteCodeBuiltIn => 'Kod zaproszenia (wbudowany)';

  @override
  String get inviteCodeBuiltInNote =>
      'Kod zaproszenia jest wbudowany, zwykle nie trzeba go zmieniac';

  @override
  String get iHaveReadAndAgree => 'Przeczytałem i akceptuje ';

  @override
  String get startGroupChat => 'Rozpocznij czat grupowy';

  @override
  String get addFriends => 'Dodaj znajomych';

  @override
  String get paymentAndCollection => 'Platnosc';

  @override
  String messagesWithCount(int count) {
    return 'Wiadomosci($count)';
  }

  @override
  String contactCount(int count) {
    return '$count kontaktow';
  }

  @override
  String get addToHomeScreen => 'Dodaj do ekranu glownego';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Polecono wizytowke $contact do $recipient';
  }

  @override
  String get enterRemarkName => 'Wprowadz nazwe uwagi';

  @override
  String remarkSetTo(String remark) {
    return 'Uwaga ustawiona na: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Zaakceptowano zaproszenie od $name';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Odrzucono zaproszenie od $name';
  }

  @override
  String get groupInvites => 'Zaproszenia do grupy';

  @override
  String myGroups(int count) {
    return 'Moje grupy ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Zaproszono do dolaczenia do grupy';

  @override
  String confirmLeaveGroup(String name) {
    return 'Czy na pewno chcesz opuścić \"$name\"?';
  }

  @override
  String get leave => 'Opusc';

  @override
  String get saveMedia => 'Zapisz';

  @override
  String get recallThisMessage => 'Wycofac te wiadomosc?';

  @override
  String get messageRecalled => 'Wiadomosc wycofana';

  @override
  String get savedToGallery => 'Zapisano w galerii';

  @override
  String get failedToSave => 'Nie udalo sie zapisac';

  @override
  String get saving => 'Zapisywanie...';

  @override
  String get share => 'Udostepnij';

  @override
  String get saveToGallery => 'Zapisz w galerii';

  @override
  String downloadFailed(String code) {
    return 'Pobieranie nie powiodło się: $code';
  }

  @override
  String get noMediaUrl => 'Brak dostepnego adresu URL mediow';

  @override
  String shareFailed(String error) {
    return 'Udostępnianie nie powiodło się: $error';
  }

  @override
  String get failedToLoadImage => 'Nie udalo sie zaladowac obrazu';

  @override
  String get failedToLoadMoreMessages =>
      'Nie udalo sie zaladowac wiecej wiadomosci';

  @override
  String get failedToSend => 'Nie udalo sie wyslac';

  @override
  String get failedToSendImage => 'Nie udalo sie wyslac obrazu';

  @override
  String get failedToSendVoice => 'Nie udalo sie wyslac glosu';

  @override
  String get failedToSendFile => 'Nie udalo sie wyslac pliku';

  @override
  String get failedToSendVideo => 'Nie udalo sie wyslac wideo';

  @override
  String get failedToSendLocation => 'Nie udalo sie wyslac lokalizacji';

  @override
  String get failedToResend => 'Nie udalo sie wyslac ponownie';

  @override
  String get failedToRecall => 'Nie udalo sie wycofac';

  @override
  String get failedToReply => 'Nie udalo sie odpowiedziec';

  @override
  String get failedToAddReaction => 'Nie udalo sie dodac reakcji';

  @override
  String get failedToSendPoll => 'Nie udalo sie wyslac ankiety';

  @override
  String get failedToVote => 'Nie udalo sie zaglosowac';

  @override
  String get failedToLoadMessages => 'Nie udalo sie zaladowac wiadomosci';

  @override
  String get callFeatureComingSoon =>
      'Funkcja polaczen glosowych i wideo wkrotce dostepna';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Czerwone koperty i przelewy nie moga byc przekazywane';

  @override
  String get videoRecordingFailed =>
      'Nagrywanie wideo nie powiodlo sie. Sprobuj ponownie.';

  @override
  String get redPacket => 'Czerwona koperta';

  @override
  String get music => 'Muzyka';

  @override
  String get coupon => 'Kupon';

  @override
  String get gift => 'Prezent';

  @override
  String get poll => 'Ankieta';

  @override
  String get text => 'Tekst';

  @override
  String get link => 'Link';

  @override
  String get note => 'Notatka';

  @override
  String get myNotes => 'Moje notatki';

  @override
  String get today => 'Dzisiaj';

  @override
  String daysAgoText(int count) {
    return '$count dni temu';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Brak ulubionych';

  @override
  String get longPressToFavorite =>
      'Przytrzymaj wiadomosc, aby dodac do ulubionych';

  @override
  String get newNote => 'Nowa notatka';

  @override
  String get favoriteLink => 'Ulubiony link';

  @override
  String get editTags => 'Edytuj tagi';

  @override
  String get deleteFavorite => 'Usun z ulubionych';

  @override
  String get deleteFavoriteConfirm =>
      'Czy na pewno chcesz usunac ten ulubiony element?';

  @override
  String get noSearchResultsFound => 'Nie znaleziono wynikow';

  @override
  String get sendRedPacket => 'Wyslij czerwona koperte';

  @override
  String get amount => 'Kwota';

  @override
  String get redPacketCover => 'Okladka czerwonej koperty';

  @override
  String get redPacketType => 'Typ czerwonej koperty';

  @override
  String get normalRedPacket => 'Zwykla';

  @override
  String get luckyRedPacket => 'Szczesliwa';

  @override
  String get redPacketCount => 'Liczba czerwonych kopert';

  @override
  String get pieces => 'sztuk';

  @override
  String get putMoneyInRedPacket => 'Wloz pieniadze do czerwonej koperty';

  @override
  String get redPacketRefundNotice =>
      'Nieodebrane czerwone koperty zostana zwrocone po 24 godzinach';

  @override
  String get openRedPacket => 'Otworz';

  @override
  String get redPacketAllClaimed => 'Wszystkie czerwone koperty odebrane';

  @override
  String get redPacketExpired => 'Czerwona koperta wygasla';

  @override
  String get addTransferNote => 'Dodaj notatke do przelewu';

  @override
  String get yuan => 'PLN';

  @override
  String get savedToChangeCanTransfer =>
      'Zapisano na saldo, mozna przelewac bezposrednio';

  @override
  String get replyWithEmoji => 'Odpowiedz tym emotikonem';

  @override
  String get claimedYourRedPacket => 'odebral(a) Twoja';

  @override
  String get claimedRedPacket => 'odebral(a)';

  @override
  String get otherTyping => 'pisze...';

  @override
  String get processing => 'Przetwarzanie...';

  @override
  String get transferCancelled => 'Przelew anulowany';

  @override
  String get transferFailed => 'Przelew nie powiodl sie';

  @override
  String get creatingPaymentRequest => 'Tworzenie zadania platnosci...';

  @override
  String get processingPayment => 'Przetwarzanie platnosci...';

  @override
  String get paymentFailed => 'Platnosc nie powiodla sie';

  @override
  String get clickRetry => 'Dotknij, aby ponowic';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get editRemark => 'Edytuj uwage';

  @override
  String get setPermissions => 'Ustaw uprawnienia';

  @override
  String get recommendToFriends => 'Polec znajomym';

  @override
  String get setStarFriend => 'Ustaw jako ulubionego znajomego';

  @override
  String get addToBlacklist => 'Dodaj do czarnej listy';

  @override
  String get complain => 'Zglos';

  @override
  String get deleteContact => 'Usun kontakt';

  @override
  String deleteContactConfirm(String name) {
    return 'Czy na pewno chcesz usunac $name?';
  }

  @override
  String get transferTitle => 'Przelew';

  @override
  String get receiverAddressLabel => 'Adres odbiorcy';

  @override
  String get selectTokenLabel => 'Wybierz token';

  @override
  String get transferAmountLabel => 'Kwota przelewu';

  @override
  String get memoLabel => 'Notatka (opcjonalna)';

  @override
  String get enterOrPasteAddressHint => 'Wprowadz lub wklej adres portfela';

  @override
  String get scanInDevelopment => 'Funkcja skanowania w trakcie rozwoju...';

  @override
  String get availableLabel => 'Dostepne';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Dostepne: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Dodaj notatke';

  @override
  String get receiveTitle => 'Odbierz';

  @override
  String get walletNotConnectedTitle => 'Portfel nie jest polaczony';

  @override
  String get connectWalletFirst => 'Najpierw polacz portfel';

  @override
  String get sendPaymentRequest => 'Wyslij zadanie platnosci';

  @override
  String get qrCodeGenerateFailed => 'Generowanie kodu QR nie powiodlo sie';

  @override
  String get scanQrToPayMe => 'Zeskanuj kod QR, aby mi zaplacic';

  @override
  String get myWalletAddress => 'Moj adres portfela';

  @override
  String get createPaymentRequest => 'Utworz zadanie platnosci';

  @override
  String get selectTokenHint => 'Wybierz token';

  @override
  String get amountLabel => 'Kwota';

  @override
  String get cancelButton => 'Anuluj';

  @override
  String get sendRequestButton => 'Wyslij zadanie';

  @override
  String get allReadReceipt => 'Wszystko przeczytane';

  @override
  String readCountReceipt(int count) {
    return '$count przeczytane';
  }

  @override
  String n42IdLabel(String id) {
    return 'ID N42: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Najlepsze zyczenia';

  @override
  String senderRedPacket(String name) {
    return 'Czerwona koperta od $name';
  }

  @override
  String get allButton => 'Wszystko';

  @override
  String get enterValidAddress => 'Wprowadz prawidlowy adres';

  @override
  String get pleaseSelectToken => 'Wybierz token';

  @override
  String get receivedTransfer => 'Odebrany przelew';

  @override
  String get selectForwardRecipient => 'Wybierz odbiorce przekazania';

  @override
  String get emojiFaces => 'Twarze';

  @override
  String get emojiHearts => 'Serca';

  @override
  String get emojiAnimals => 'Zwierzeta';

  @override
  String get emojiFood => 'Jedzenie';

  @override
  String get emojiTransport => 'Transport';

  @override
  String get emojiActivities => 'Aktywnosci';

  @override
  String get emojiObjects => 'Przedmioty';

  @override
  String get emojiSymbols => 'Symbole';

  @override
  String get transferProcessing => 'Przetwarzanie przelewu...';

  @override
  String senderSentRedPacket(String name) {
    return '$name wyslal(a) czerwona koperte';
  }

  @override
  String get savedToBalance =>
      'Zapisano na saldo, mozna przelewac bezposrednio';

  @override
  String get redPacketExpiredOrEmpty =>
      'Czerwona koperta wygasla/wszystkie odebrane';

  @override
  String get scanFeatureComingSoon => 'Funkcja skanowania wkrotce dostepna...';

  @override
  String get setAsStarred => 'Ustaw jako ulubione';

  @override
  String get addToBlocklist => 'Dodaj do listy zablokowanych';

  @override
  String get claimedYour => ' odebral(a) Twoja ';

  @override
  String get claimedText => ' odebral(a) ';

  @override
  String userTyping(String name) {
    return '$name pisze...';
  }

  @override
  String get typing => 'Pisze...';

  @override
  String get waitingToReceive => 'Oczekiwanie na odbiór';

  @override
  String get tapToClaim => 'Dotknij, aby odebrac';

  @override
  String get hasBeenReceived => 'Zostalo odebrane';

  @override
  String get getLucky => 'Niech Ci sie szczesci';

  @override
  String get cameraStartFailed => 'Kamera nie uruchomila sie';

  @override
  String get unknownError => 'Nieznany blad';

  @override
  String get placeQrCodeInFrame => 'Umiesc kod QR w ramce, aby zeskanowac';

  @override
  String get closeManualInput => 'Zamknij reczne wprowadzanie';

  @override
  String get manualInputUserId => 'Reczne wprowadzanie ID uzytkownika';

  @override
  String get add => 'Dodaj';

  @override
  String get ringtoneClear => 'Wyczysc';

  @override
  String get ringtonePhone => 'Telefon';

  @override
  String get ringtoneClassic => 'Klasyczny';

  @override
  String get ringtoneSoft => 'Lagodny';

  @override
  String get ringtoneVibrate => 'Wibracja';

  @override
  String get ringtoneSilent => 'Cichy';

  @override
  String get stop => 'Zatrzymaj';

  @override
  String get selectRingtone => 'Wybierz dzwonek';

  @override
  String get loadingRingtones => 'Ladowanie dzwonkow...';

  @override
  String get noRingtonesFound => 'Nie znaleziono dzwonkow';

  @override
  String get moodAndThoughts => 'Nastroj i mysli';

  @override
  String get statusHappy => 'Szczesliwy';

  @override
  String get statusCracked => 'Rozbity';

  @override
  String get statusLucky => 'Szczęsliwy';

  @override
  String get statusSunny => 'Sloneczny';

  @override
  String get statusTired => 'Zmęczony';

  @override
  String get statusDaydream => 'Marzenia na jawie';

  @override
  String get statusRushing => 'W pospichu';

  @override
  String get statusOverthinking => 'Zamyslony';

  @override
  String get statusEnergized => 'Pelen energii';

  @override
  String get workAndStudy => 'Praca i nauka';

  @override
  String get statusWorking => 'Pracuje';

  @override
  String get statusStudying => 'Ucze sie';

  @override
  String get statusBusy => 'Zajety';

  @override
  String get statusSlacking => 'Obijam sie';

  @override
  String get statusTraveling => 'Podrozuje';

  @override
  String get statusGoingHome => 'Wracam do domu';

  @override
  String get statusDnd => 'Nie przeszkadzac';

  @override
  String get statusHanging => 'Spotykam sie';

  @override
  String get statusCheckIn => 'Meldunek';

  @override
  String get statusExercising => 'Cwicze';

  @override
  String get statusCoffee => 'Kawa';

  @override
  String get statusBubbleTea => 'Bubble tea';

  @override
  String get statusEating => 'Jem';

  @override
  String get statusParenting => 'Opieka nad dziecmi';

  @override
  String get statusSavingWorld => 'Ratuje swiat';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Odpoczynek';

  @override
  String get statusRetreat => 'Odwrot';

  @override
  String get statusHome => 'W domu';

  @override
  String get statusSleeping => 'Spie';

  @override
  String get statusCatLover => 'Kociarz';

  @override
  String get statusDogWalking => 'Spacer z psem';

  @override
  String get statusGaming => 'Gram';

  @override
  String get statusListening => 'Slucham';

  @override
  String get setStatus => 'Ustaw status';

  @override
  String get visibleToFriends24h => 'Widoczne dla znajomych przez 24 godziny';

  @override
  String get writeStatus => 'Napisz status';

  @override
  String get enterYourStatus => 'Wprowadz swoj status...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Wymagane uprawnienie do kamery, aby skanowac kod QR';

  @override
  String get cameraPermissionDenied =>
      'Uprawnienie do kamery zostalo trwale odrzucone. Wlacz je w ustawieniach systemu.';

  @override
  String get cannotGetCameraPermission =>
      'Nie mozna uzyskac uprawnienia do kamery';

  @override
  String permissionCheckError(String error) {
    return 'Blad sprawdzania uprawnienia: $error';
  }

  @override
  String get invalidQrCode => 'Nieprawidlowy kod QR';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Nie udalo sie przetworzyc kodu QR: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Nie mozna dodac znajomego: $error';
  }

  @override
  String get scanQrCode => 'Skanuj kod QR';

  @override
  String get checkingCameraPermission => 'Sprawdzanie uprawnienia do kamery...';

  @override
  String get needCameraPermission => 'Wymagane uprawnienie do kamery';

  @override
  String get retryPermission => 'Ponow';

  @override
  String get openSettings => 'Otworz ustawienia';

  @override
  String get inviteMembers => 'Zapros czlonkow';

  @override
  String inviteCount(int count) {
    return 'Zapros($count)';
  }

  @override
  String get noShippingAddress => 'Brak adresu dostawy';

  @override
  String get defaultLabel => 'Domyslny';

  @override
  String get editAddress => 'Edytuj adres';

  @override
  String get recipient => 'Odbiorca';

  @override
  String get enterRecipientName => 'Wprowadz nazwe odbiorcy';

  @override
  String get phoneNumber => 'Numer telefonu';

  @override
  String get enterPhoneNumber => 'Wprowadz numer telefonu';

  @override
  String get regionHint => 'Wojewodztwo/Miasto/Dzielnica';

  @override
  String get detailedAddress => 'Szczegolowy adres';

  @override
  String get detailedAddressHint => 'Ulica, numer budynku itp.';

  @override
  String get setAsDefaultAddress => 'Ustaw jako domyslny adres';

  @override
  String get pleaseCompleteInfo => 'Wypelnij wszystkie pola';

  @override
  String get noInvoice => 'Brak faktury';

  @override
  String get company => 'Firma';

  @override
  String get taxNumber => 'NIP';

  @override
  String get editInvoice => 'Edytuj fakture';

  @override
  String get companyName => 'Nazwa firmy';

  @override
  String get enterCompanyName => 'Wprowadz nazwe firmy';

  @override
  String get personalName => 'Imie i nazwisko';

  @override
  String get enterName => 'Wprowadz imie i nazwisko';

  @override
  String get taxIdNumber => 'Numer NIP';

  @override
  String get enterTaxIdNumber => 'Wprowadz numer NIP';

  @override
  String get bankNameOptional => 'Nazwa banku (opcjonalna)';

  @override
  String get enterBankName => 'Wprowadz nazwe banku';

  @override
  String get bankAccountOptional => 'Numer konta bankowego (opcjonalny)';

  @override
  String get enterBankAccount => 'Wprowadz numer konta bankowego';

  @override
  String get companyAddressOptional => 'Adres firmy (opcjonalny)';

  @override
  String get enterCompanyAddress => 'Wprowadz adres firmy';

  @override
  String get companyPhoneOptional => 'Telefon firmy (opcjonalny)';

  @override
  String get enterCompanyPhone => 'Wprowadz telefon firmy';

  @override
  String get setAsDefaultInvoice => 'Ustaw jako domyslna fakture';

  @override
  String get confirmDeleteAddress => 'Czy na pewno chcesz usunac ten adres?';

  @override
  String get confirmDeleteInvoice => 'Czy na pewno chcesz usunac te fakture?';

  @override
  String get groupOwner => 'Wlasciciel';

  @override
  String get groupAdmin => 'Administrator';

  @override
  String get searchMembers => 'Szukaj czlonkow';

  @override
  String totalMembers(int count) {
    return '$count czlonkow';
  }

  @override
  String get removeFromGroup => 'Usun z grupy';

  @override
  String confirmRemoveMember(String name) {
    return 'Czy na pewno chcesz usunac \"$name\" z grupy?';
  }

  @override
  String get setAsAdmin => 'Ustaw jako administratora';

  @override
  String get removeAdmin => 'Usun administratora';

  @override
  String get deleteContactSuccess => 'Kontakt usuniety';

  @override
  String get unknownSong => 'Nieznany utwor';

  @override
  String get unknownArtist => 'Nieznany artysta';

  @override
  String get unknownContact => 'Nieznany kontakt';

  @override
  String get personalCard => 'Wizytowka';

  @override
  String get singleChoice => 'Pojedynczy wybor';

  @override
  String get multiChoice => 'Wielokrotny wybor';

  @override
  String get ended => 'Zakonczone';

  @override
  String get endPollButton => 'Zakoncz ankiete';

  @override
  String get createPoll => 'Utworz ankiete';

  @override
  String get pollQuestion => 'Pytanie ankiety';

  @override
  String get pollOptions => 'Opcje ankiety';

  @override
  String optionPlaceholder(int index) {
    return 'Opcja $index';
  }

  @override
  String get addOption => 'Dodaj opcje';

  @override
  String get pollSettings => 'Ustawienia ankiety';

  @override
  String get anonymousPoll => 'Anonimowa ankieta';

  @override
  String get pollHint =>
      'Ankieta bedzie wyswietlana na czacie. Czlonkowie grupy moga glosowac.';

  @override
  String get searchSongOrArtist => 'Szukaj utworu lub artysty';

  @override
  String get noSongsFound => 'Nie znaleziono utworow';

  @override
  String get supportedMusicPlatforms =>
      'Obsluguje linki muzyczne z NetEase, QQ Music itp.';

  @override
  String get songNameOptional => 'Nazwa utworu (opcjonalna)';

  @override
  String get enterSongName => 'Wprowadz nazwe utworu';

  @override
  String get artistNameOptional => 'Nazwa artysty (opcjonalna)';

  @override
  String get enterArtistName => 'Wprowadz nazwe artysty';

  @override
  String get shareSong => 'Udostepnij utwor';

  @override
  String get realTimeLocationSharing =>
      'Udostepnianie lokalizacji w czasie rzeczywistym w trakcie rozwoju...';

  @override
  String get voiceCallFeatureInDev =>
      'Funkcja polaczenia glosowego w trakcie rozwoju...';

  @override
  String get reportFeatureInDev => 'Funkcja zglaszania w trakcie rozwoju...';

  @override
  String get shareFeatureInDev => 'Funkcja udostepniania w trakcie rozwoju...';

  @override
  String get qrCodeFeatureInDev => 'Funkcja kodu QR w trakcie rozwoju...';

  @override
  String get scanQrToAddMe =>
      'Zeskanuj powyzszy kod QR, aby dodac mnie jako znajomego';

  @override
  String get saveToAlbum => 'Zapisz w albumie';

  @override
  String get changeStyle => 'Zmien styl';

  @override
  String get copyId => 'Kopiuj ID';

  @override
  String get idCopied => 'ID skopiowane';

  @override
  String get shareFeatureComingSoon => 'Funkcja udostepniania wkrotce dostepna';

  @override
  String get saveFeatureComingSoon => 'Funkcja zapisywania wkrotce dostepna';

  @override
  String get moreStylesFeatureComingSoon => 'Wiecej stylow wkrotce dostepnych';

  @override
  String get confirmEndPoll => 'Czy na pewno chcesz zakonczyc te ankiete?';

  @override
  String get cannotVoteAfterEnd => 'Po zakonczeniu nie bedzie mozna glosowac.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Serwer';

  @override
  String get shareContactCard => 'Udostepnij wizytowke';

  @override
  String get removeFromBlacklist => 'Usun z czarnej listy';

  @override
  String get confirmAddBlacklist =>
      'Czy na pewno chcesz dodac tego uzytkownika do czarnej listy? Nie bedziesz otrzymywac od niego wiadomosci.';

  @override
  String get confirmRemoveBlacklist =>
      'Czy na pewno chcesz usunac tego uzytkownika z czarnej listy?';

  @override
  String get remarkSaved => 'Uwaga zapisana';

  @override
  String get remarkCleared => 'Uwaga wyczyszczona';

  @override
  String get receive => 'Odbierz';

  @override
  String get pleaseConnectWallet => 'Najpierw polacz portfel';

  @override
  String get sendRequest => 'Wyslij zadanie';

  @override
  String get pleaseEnterValidAmount => 'Wprowadz prawidlowa kwote';

  @override
  String get searchPlaceholder => 'Szukaj kontaktow, grup, wiadomosci';

  @override
  String get enterKeywordToSearch => 'Wprowadz slowo kluczowe, aby wyszukac';

  @override
  String get clearHistory => 'Wyczysc';

  @override
  String noResultsForQuery(String query) {
    return 'Brak wynikow dla \"$query\"';
  }

  @override
  String get allResults => 'Wszystko';

  @override
  String get searchInChat => 'Szukaj na czacie';

  @override
  String get contactLabel => 'Kontakt';

  @override
  String get groupLabel => 'Grupa';

  @override
  String get conversationLabel => '会话';

  @override
  String get messageLabel => 'Wiadomosc';

  @override
  String get securityTitle => 'Bezpieczenstwo';

  @override
  String get keyBackup => 'Kopia zapasowa kluczy';

  @override
  String get backupEncryptionKeys => 'Kopia zapasowa kluczy szyfrowania';

  @override
  String keysBackedUp(int count) {
    return '$count kluczy skopiowanych';
  }

  @override
  String get backupNotSet => 'Kopia zapasowa nie ustawiona';

  @override
  String get restoreKeys => 'Przywroc klucze';

  @override
  String get restoreKeysFromBackup =>
      'Przywroc klucze szyfrowania z kopii zapasowej';

  @override
  String get exportKeys => 'Eksportuj klucze';

  @override
  String get exportKeysToFile => 'Eksportuj klucze do pliku';

  @override
  String get loggedInDevices => 'Zalogowane urzadzenia';

  @override
  String get noOtherDevices => 'Brak innych urzadzen';

  @override
  String get verified => 'Zweryfikowane';

  @override
  String get unverified => 'Niezweryfikowane';

  @override
  String get advanced => 'Zaawansowane';

  @override
  String get crossSigning => 'Podpisywanie krzyzowe';

  @override
  String get enabled => 'Wlaczone';

  @override
  String get notEnabled => 'Nie wlaczone';

  @override
  String get resetEncryption => 'Zresetuj szyfrowanie';

  @override
  String get deleteAllEncryptionKeys => 'Usun wszystkie klucze szyfrowania';

  @override
  String get encryptionNotSupported => 'Szyfrowanie nie jest obslugiwane';

  @override
  String get notInitialized => 'Nie zainicjowano';

  @override
  String get backupKeyTitle => 'Kopia zapasowa kluczy';

  @override
  String get backupKeyMessage =>
      'Utworzyc nowa kopie zapasowa kluczy? Pomoze to przywrocic zaszyfrowane wiadomosci na nowym urzadzeniu.';

  @override
  String get backup => 'Kopia zapasowa';

  @override
  String get restoreKeyTitle => 'Przywroc klucze';

  @override
  String get restoreKeyMessage =>
      'Wprowadz haslo odzyskiwania lub klucz odzyskiwania, aby przywrocic zaszyfrowane wiadomosci.';

  @override
  String get restore => 'Przywroc';

  @override
  String get exportKeyTitle => 'Eksportuj klucze';

  @override
  String get exportKeyMessage =>
      'Wyeksportowany plik kluczy zawiera wszystkie Twoje klucze szyfrowania. Przechowuj go w bezpiecznym miejscu.';

  @override
  String get export => 'Eksportuj';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID urzadzenia: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Status: Zweryfikowane';

  @override
  String get deviceStatusUnverified => 'Status: Niezweryfikowane';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Ostatnia aktywnosc: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Zweryfikuj to urzadzenie';

  @override
  String get crossSigningAlreadyEnabled =>
      'Podpisywanie krzyzowe jest juz wlaczone';

  @override
  String get crossSigningSetupSuccess =>
      'Konfiguracja podpisywania krzyzowego powiodla sie';

  @override
  String get resetEncryptionTitle => 'Zresetuj szyfrowanie';

  @override
  String get resetEncryptionWarning =>
      'Ostrzezenie: Spowoduje to usuniecie wszystkich kluczy szyfrowania. Nie bedziesz moc odszyfrowac poprzednich zaszyfrowanych wiadomosci. Tej operacji nie mozna cofnac.';

  @override
  String get reset => 'Zresetuj';

  @override
  String get leaveMeetingConfirm => 'Czy na pewno chcesz opuscic spotkanie?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'szturchnal(a) $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Brak dostepnych kontaktow do dodania';

  @override
  String get addMembers => 'Dodaj czlonkow';

  @override
  String invitedMembers(int count) {
    return 'Zaproszono $count czlonkow';
  }

  @override
  String inviteFailed(String error) {
    return 'Zaproszenie nie powiodlo sie: $error';
  }

  @override
  String get memberRemoved => 'Czlonek usuniety';

  @override
  String removeFailed(String error) {
    return 'Usuniecie nie powiodlo sie: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Po udostepnieniu druga strona bedzie widziec Twoja lokalizacje w czasie rzeczywistym przez 1 godzine.';

  @override
  String get startSharing => 'Rozpocznij udostepnianie';

  @override
  String get locationServiceNotEnabled =>
      'Usluga lokalizacji nie jest wlaczona';

  @override
  String get enableLocationService =>
      'Wlacz usluge lokalizacji, aby korzystac z tej funkcji';

  @override
  String get goToSettings => 'Przejdz do ustawien';

  @override
  String get locationPermissionRequired =>
      'Wymagane uprawnienie do lokalizacji dla tej funkcji';

  @override
  String get locationPermissionDeniedPermanent =>
      'Uprawnienie do lokalizacji zostalo trwale odrzucone. Wlacz je w ustawieniach.';

  @override
  String get locationPermissionDenied => 'Uprawnienie do lokalizacji odrzucone';

  @override
  String get gettingLocation => 'Pobieranie lokalizacji...';

  @override
  String getLocationFailed(String error) {
    return 'Nie udalo sie uzyskac lokalizacji: $error';
  }

  @override
  String get currentLocation => 'Biezaca lokalizacja';

  @override
  String nearbyPlace(int index) {
    return 'Miejsce w poblizu $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Okolo $distance';
  }

  @override
  String get mapPreview => 'Podglad mapy';

  @override
  String get searchLocation => 'Szukaj lokalizacji';

  @override
  String redPacketSent(String amount, String token) {
    return 'Wyslano $amount $token czerwona koperte';
  }

  @override
  String get transferDefault => 'Przelew';

  @override
  String transferSent(String amount, String token) {
    return 'Wyslano $amount $token przelew';
  }

  @override
  String pickFileFailed(String error) {
    return 'Nie udalo sie wybrac pliku: $error';
  }

  @override
  String get fileSizeLimit => 'Rozmiar pliku nie moze przekraczac 50MB';

  @override
  String fileSending(String filename) {
    return 'Wysylanie pliku: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Nie udalo sie wyslac pliku: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Wyslano wizytowke $name';
  }

  @override
  String get favoritesFeature => 'Ulubione';

  @override
  String get couponsFeature => 'Kupony';

  @override
  String get giftFeature => 'Prezent';

  @override
  String sharedMusic(String name) {
    return 'Udostepniono $name';
  }

  @override
  String get endPollTitle => 'Zakoncz ankiete';

  @override
  String get endPollConfirmMessage =>
      'Czy na pewno chcesz zakonczyc te ankiete? Glosowanie zostanie zamkniete po zakonczeniu.';

  @override
  String get pollEndedMessage => 'Ankieta zakonczona';

  @override
  String get connectingCall => 'Łączenie...';

  @override
  String get muteCall => 'Wycisz';

  @override
  String get speakerOff => 'Glosnik wylaczony';

  @override
  String get speakerOn => 'Glosnik';

  @override
  String get cameraOn => 'Kamera wlaczona';

  @override
  String get cameraOff => 'Kamera wylaczona';

  @override
  String get hangUp => 'Rozlacz';

  @override
  String get selectForwardTargetTitle => 'Wybierz cel przekazania';

  @override
  String get noForwardableChat => 'Brak czatow dostepnych do przekazania';

  @override
  String get noMatchingChat => 'Nie znaleziono pasujacych czatow';

  @override
  String get imagePreview => '[Obraz]';

  @override
  String get voicePreview => '[Glos]';

  @override
  String get videoPreview => '[Wideo]';

  @override
  String filePreviewWithName(String filename) {
    return '[Plik] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Lokalizacja] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Muzyka] $title';
  }

  @override
  String get messagePreview => '[Wiadomosc]';

  @override
  String get locationTitle => 'Lokalizacja';

  @override
  String get sendButton => 'Wyslij';

  @override
  String get retryButton => 'Ponow';

  @override
  String get selectContact => 'Wybierz kontakt';

  @override
  String get searchContactHint => 'Szukaj kontaktow';

  @override
  String get shareMusic => 'Udostepnij muzyke';

  @override
  String get recentPlayed => 'Ostatnie';

  @override
  String get myFavorites => 'Ulubione';

  @override
  String get networkLink => 'Link';

  @override
  String get localFile => 'Lokalne';

  @override
  String get musicLinkRequired => 'Link do muzyki *';

  @override
  String get pasteMusicLink => 'Wklej link do muzyki';

  @override
  String get enterSongNamePlaceholder => 'Wprowadz nazwe utworu';

  @override
  String get enterArtistNamePlaceholder => 'Wprowadz nazwe artysty';

  @override
  String get shareMusicButton => 'Udostepnij muzyke';

  @override
  String get selectLocalAudio => 'Wybierz lokalny plik audio';

  @override
  String get supportedAudioFormats => 'Obsluguje MP3, M4A, WAV, FLAC itp.';

  @override
  String get selectFileButton => 'Wybierz plik';

  @override
  String get pleaseEnterMusicLink => 'Wprowadz link do muzyki';

  @override
  String get pleaseEnterValidLink => 'Wprowadz prawidlowy adres URL';

  @override
  String get sharedSong => 'Udostepniony utwor';

  @override
  String get selectMember => 'Wybierz czlonka';

  @override
  String get searchMemberHint => 'Szukaj czlonkow';

  @override
  String get noMatchingMembers => 'Nie znaleziono pasujacych czlonkow';

  @override
  String get unknownMember => 'Nieznany';

  @override
  String selectedMessagesCount(int count) {
    return 'Wybrano $count wiadomosci';
  }

  @override
  String get searchContactsOrGroups => 'Szukaj kontaktow lub grup';

  @override
  String get noMatchingConversations => 'Nie znaleziono pasujacych rozmow';

  @override
  String get videoTitle => 'Wideo';

  @override
  String get loadingText => 'Ladowanie...';

  @override
  String get videoPlaybackFailed => 'Odtwarzanie wideo nie powiodlo sie';

  @override
  String get videoLoadFailed => 'Ladowanie wideo nie powiodlo sie';

  @override
  String get playerInitFailed => 'Inicjalizacja odtwarzacza nie powiodla sie';

  @override
  String get createPollTitle => 'Utworz ankiete';

  @override
  String get submitPoll => 'Zatwierdz';

  @override
  String get pollQuestionLabel => 'Pytanie ankiety';

  @override
  String get enterPollQuestionHint => 'Wprowadz pytanie ankiety';

  @override
  String get pollOptionsLabel => 'Opcje ankiety';

  @override
  String optionHintWithIndex(int index) {
    return 'Opcja $index';
  }

  @override
  String get addOptionButton => 'Dodaj opcje';

  @override
  String get pollSettingsLabel => 'Ustawienia ankiety';

  @override
  String get selectionType => 'Typ wyboru';

  @override
  String get singleChoiceLabel => 'Pojedynczy';

  @override
  String get multiChoiceLabel => 'Wielokrotny';

  @override
  String get anonymousPollSwitch => 'Anonimowa ankieta';

  @override
  String get pleaseEnterQuestion => 'Wprowadz pytanie ankiety';

  @override
  String get atLeastTwoOptions => 'Wymagane co najmniej 2 opcje';

  @override
  String confirmWithCount(int count) {
    return 'Potwierdz ($count)';
  }

  @override
  String get emailVerificationTitle => 'Weryfikacja e-mail';

  @override
  String get enterValidEmailAddress => 'Wprowadz prawidlowy adres e-mail';

  @override
  String verificationCodeSentTo(String email) {
    return 'Kod weryfikacyjny wyslany na $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Nie udalo sie wyslac kodu: $error';
  }

  @override
  String get verificationSuccess => 'Weryfikacja powiodla sie';

  @override
  String get verificationFailed => 'Weryfikacja nie powiodla sie';

  @override
  String verificationCodeError(String error) {
    return 'Blad kodu weryfikacyjnego: $error';
  }

  @override
  String get enterVerificationCode => 'Wprowadz kod weryfikacyjny';

  @override
  String get enterYourEmail => 'Wprowadz e-mail';

  @override
  String weSentCodeTo(String email) {
    return 'Wyslalismy 6-cyfrowy kod na\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Wprowadz adres e-mail, wyslimy kod weryfikacyjny';

  @override
  String get sendVerificationCode => 'Wyslij kod weryfikacyjny';

  @override
  String get resendVerificationCode => 'Wyslij ponownie kod weryfikacyjny';

  @override
  String canResendAfter(int seconds) {
    return 'Mozna wyslac ponownie za $seconds sekund';
  }

  @override
  String get changeEmail => 'Zmien e-mail';

  @override
  String get addToContacts => 'Dodaj do kontaktow';

  @override
  String get addingToContacts => 'Dodawanie...';

  @override
  String get addedToContacts => 'Dodano do kontaktow';

  @override
  String addFailedWithError(String error) {
    return 'Dodawanie nie powiodlo sie: $error';
  }

  @override
  String get addPhone => 'Dodaj telefon';

  @override
  String get addTag => 'Dodaj tagi';

  @override
  String get addText => 'Dodaj tekst';

  @override
  String get addPhoto => 'Dodaj zdjecie';

  @override
  String groupCountLabel(int count) {
    return '$count grup';
  }

  @override
  String get addedViaSearch => 'Dodano przez wyszukiwanie';

  @override
  String get addTime => 'Dodaj czas';

  @override
  String get doneButton => 'Gotowe';

  @override
  String get waitingForParticipants =>
      'Oczekiwanie na dolaczenie uczestnikow...';

  @override
  String participantMe(String name) {
    return '$name (Ja)';
  }

  @override
  String get sharingLabel => 'Udostepnianie';

  @override
  String screenSharingBy(String name) {
    return '$name udostepnia ekran';
  }

  @override
  String participantCount(int count) {
    return '$count uczestnikow';
  }

  @override
  String get muteLabel => 'Wycisz';

  @override
  String get unmuteLabel => 'Wlacz dzwiek';

  @override
  String get turnOffVideo => 'Wylacz wideo';

  @override
  String get turnOnVideo => 'Wlacz wideo';

  @override
  String get shareScreen => 'Udostepnij ekran';

  @override
  String get stopSharing => 'Zatrzymaj udostepnianie';

  @override
  String get switchCameraLabel => 'Przelacz';

  @override
  String get leaveLabel => 'Opusc';

  @override
  String get participantsLabel => 'Uczestnicy';

  @override
  String get joiningMeeting => 'Dolaczanie do spotkania...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count głosów ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count uczestników';
  }

  @override
  String get tapToRetry => 'Dotknij, aby ponowić';

  @override
  String get noConversationsToForward => 'Brak rozmów do przekazania';

  @override
  String get defaultRedPacketGreeting => 'Powodzenia i dobrobytu';

  @override
  String get emojiCategoryFace => 'Buźki';

  @override
  String get emojiCategoryHeart => 'Serca';

  @override
  String get emojiCategoryAnimal => 'Zwierzęta';

  @override
  String get emojiCategoryFood => 'Jedzenie';

  @override
  String get emojiCategoryTransport => 'Transport';

  @override
  String get emojiCategoryActivity => 'Aktywności';

  @override
  String get emojiCategoryObject => 'Przedmioty';

  @override
  String get emojiCategorySymbol => 'Symbole';

  @override
  String get allowOthersToSearchAndJoin =>
      'Zezwól innym na wyszukiwanie i dołączanie';

  @override
  String get allowStrangerMessages => 'Zezwalaj na wiadomości od nieznajomych';

  @override
  String get alwaysUseDarkTheme => 'Zawsze używaj ciemnego motywu';

  @override
  String get alwaysUseLightTheme => 'Zawsze używaj jasnego motywu';

  @override
  String get autoSwitchBySystem =>
      'Automatycznie przełączaj według ustawień systemowych';

  @override
  String get bubbleStyle => 'Styl dymków';

  @override
  String get bubbleStyleClassic => 'Styl klasyczny';

  @override
  String get bubbleStyleClassicDesc => 'Tradycyjny styl dymków';

  @override
  String get bubbleStyleModern => 'Styl nowoczesny';

  @override
  String get bubbleStyleModernDesc => 'Czysty nowoczesny styl dymków';

  @override
  String get bubbleStyleWechat => 'Styl WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Klasyczny styl dymków WeChat';

  @override
  String get callEnded => 'Połączenie zakończone';

  @override
  String get callFailed => 'Połączenie nieudane';

  @override
  String get checkForUpdates => 'Sprawdź aktualizacje';

  @override
  String get confirmClearChatHistory =>
      'Czy na pewno chcesz usunąć historię czatu?';

  @override
  String get createGroupToChat => 'Utwórz grupę, aby rozpocząć czat';

  @override
  String get darkMode => 'Tryb ciemny';

  @override
  String get darkModeOption => 'Tryb ciemny';

  @override
  String get doNotDisturbDescription =>
      'Nie otrzymuj powiadomień w określonym czasie';

  @override
  String get doNotDisturbMode => 'Nie przeszkadzać';

  @override
  String get editGroupAnnouncement => 'Edytuj ogłoszenie grupy';

  @override
  String get editGroupDescription => 'Edytuj opis grupy';

  @override
  String get enterGroupAnnouncement => 'Wpisz ogłoszenie grupy';

  @override
  String errorWithMessage(String message) {
    return 'Błąd: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Opinie i sugestie';

  @override
  String get followSystem => 'Podążaj za systemem';

  @override
  String get fontSize => 'Rozmiar czcionki';

  @override
  String get fontSizeExtraLarge => 'Bardzo duży';

  @override
  String get fontSizeLarge => 'Duży';

  @override
  String get fontSizeSmall => 'Mały';

  @override
  String get fontSizeStandard => 'Standardowy';

  @override
  String get incomingVideoCall => 'Przychodzące połączenie wideo';

  @override
  String get incomingVoiceCall => 'Przychodzące połączenie głosowe';

  @override
  String get letOthersKnowYouRead =>
      'Pozwól innym wiedzieć, że przeczytałeś ich wiadomości';

  @override
  String get letOthersKnowYouTyping => 'Pozwól innym wiedzieć, że piszesz';

  @override
  String get lightMode => 'Tryb jasny';

  @override
  String memberCountClickToCopy(int count) {
    return '$count członków, kliknij aby skopiować ID grupy';
  }

  @override
  String get messageNotifications => 'Powiadomienia o wiadomościach';

  @override
  String get messagesLabel => 'Wiadomości';

  @override
  String get musicLinkLabel => 'Link do muzyki';

  @override
  String get noMediaUrlAvailable => 'URL multimediów niedostępny';

  @override
  String get noPermissionToEditGroupName =>
      'Nie masz uprawnień do edycji nazwy grupy';

  @override
  String get receiveMessagesFromNonContacts =>
      'Otrzymuj wiadomości od osób spoza kontaktów';

  @override
  String get receiveNewMessageNotifications =>
      'Otrzymuj powiadomienia o nowych wiadomościach';

  @override
  String get reconnectingCall => 'Ponowne łączenie...';

  @override
  String get redPacketTransferCannotForward =>
      'Czerwone koperty i przelewy nie mogą być przekazywane';

  @override
  String get showMessageContentInNotification =>
      'Pokaż treść wiadomości w powiadomieniach';

  @override
  String get showMessagePreview => 'Pokaż podgląd wiadomości';

  @override
  String get typingIndicator => 'Wskaźnik pisania';

  @override
  String versionInfo(String version) {
    return 'Wersja $version';
  }

  @override
  String get vibration => 'Wibracje';

  @override
  String get videoCallInProgress => 'Połączenie wideo';

  @override
  String get voiceCallInProgress => 'Połączenie głosowe';

  @override
  String whoCanSeeTitle(String title) {
    return 'Kto może zobaczyć $title';
  }
}
