// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class SPl extends S {
  SPl([String locale = 'pl']) : super(locale);

  @override
  String get commonRetry => 'Ponow';

  @override
  String get commonUnknownUser => 'Nieznany uzytkownik';

  @override
  String get transferWalletNotConnected => 'Portfel nie jest polaczony';

  @override
  String get chatCallServiceNotInitialized =>
      'Usluga polaczen nie zostala zainicjowana';

  @override
  String authLoginFailed(String error) {
    return 'Logowanie nie powiodlo sie: $error';
  }

  @override
  String get chatCallBack => 'Oddzwon';

  @override
  String get chatMissedVideoCall => 'Nieodebrane polaczenie wideo';

  @override
  String get chatMissedVoiceCall => 'Nieodebrane polaczenie glosowe';

  @override
  String get chatCallNotAnswered => 'Brak odpowiedzi';

  @override
  String get chatCallDurationLabel => 'Czas rozmowy';

  @override
  String get chatVoiceCallCancelled => 'Rozmowa głosowa anulowana';

  @override
  String get chatVideoCallCancelled => 'Rozmowa wideo anulowana';

  @override
  String get commonImage => '[Obraz]';

  @override
  String get chatVideo => '[Wideo]';

  @override
  String get chatVoice => '[Glos]';

  @override
  String get commonFile => '[Plik]';

  @override
  String get chatLocation => '[Lokalizacja]';

  @override
  String get chatUnknownMessage => '[Nieznana wiadomosc]';

  @override
  String get commonDelete => 'Usun';

  @override
  String get chatDeleteThisMessage => 'Usunąć tę wiadomość?';

  @override
  String get chatMessageDeleted => 'Wiadomość usunięta';

  @override
  String get profileNotLoggedIn => 'Nie zalogowano';

  @override
  String get chatMyLocation => 'Moja lokalizacja';

  @override
  String get commonGroupChat => 'Czat grupowy';

  @override
  String get commonSearch => 'Szukaj';

  @override
  String get commonCancel => 'Anuluj';

  @override
  String get commonLoadFailed => 'Nie udalo sie zaladowac';

  @override
  String get commonMessages => 'Wiadomosci';

  @override
  String get commonContacts => 'Kontakty';

  @override
  String get commonMe => 'Ja';

  @override
  String get commonVoiceLoading => 'Ladowanie glosu, sprobuj pozniej';

  @override
  String get commonVoiceToTextFailed =>
      'Konwersja glosu na tekst nie powiodla sie';

  @override
  String get commonConvertToText => 'Na tekst';

  @override
  String get chatCopy => 'Kopiuj';

  @override
  String get commonForward => 'Przekaz dalej';

  @override
  String get commonUnfavorite => 'Usun z ulubionych';

  @override
  String get commonFavorite => 'Ulubione';

  @override
  String get settingsResend => 'Wyslij ponownie';

  @override
  String get chatRecall => 'Wycofaj';

  @override
  String get commonQuote => 'Cytuj';

  @override
  String get commonRemind => 'Przypomnij';

  @override
  String get chatCopied => 'Skopiowano';

  @override
  String get storySendMessageHint => 'Wyslij wiadomosc';

  @override
  String get commonMicrophonePermissionRequired =>
      'Prosze zezwolic na dostep do mikrofonu';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Nie udalo sie rozpoczac nagrywania: $error';
  }

  @override
  String get commonRecordingTooShort => 'Nagranie zbyt krotkie';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Nie udalo sie zatrzymac nagrywania: $error';
  }

  @override
  String get chatReleaseToCancel => 'Zwolnij, aby anulowac';

  @override
  String get chatReleaseToSend =>
      'Zwolnij, aby wyslac, przesun w gore, aby anulowac';

  @override
  String get commonHoldToTalk => 'Przytrzymaj, aby mowic';

  @override
  String get commonSend => 'Wyslij';

  @override
  String get commonAddFriend => 'Dodaj znajomego';

  @override
  String get commonChatServiceNotConnected => 'Usluga czatu nie jest polaczona';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Uzytkownik \"$query\" nie zostal znaleziony\n\nWskazowki:\n• Sprobuj wprowadzic pelny identyfikator uzytkownika, np. @nazwa:serwer.com\n• Sprawdz pisownie nazwy uzytkownika';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Nie udalo sie utworzyc czatu: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Wyszukiwanie nie powiodlo sie: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Wprowadz ID uzytkownika lub nazwe, aby wyszukac';

  @override
  String get contactSearching => 'Wyszukiwanie...';

  @override
  String get contactSearchUserToChat =>
      'Wyszukaj uzytkownika, aby rozpoczac czat';

  @override
  String get contactMatrixIdExample =>
      'Mozesz wprowadzic pelny identyfikator Matrix\nnp. @uzytkownik:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Uzytkownik \"$username\" nie zostal znaleziony';
  }

  @override
  String get commonChat => 'Czat';

  @override
  String get commonSettings => 'Ustawienia';

  @override
  String get profileEditProfile => 'Edytuj profil';

  @override
  String get authLogin => 'Zaloguj sie';

  @override
  String get commonCreateGroup => 'Utworz grupe';

  @override
  String get chatError => 'Blad';

  @override
  String get commonTransfer => 'Przelew';

  @override
  String get commonReceived => 'Odebrano';

  @override
  String get commonRefunded => 'Zwrocono';

  @override
  String get commonExpired => 'Wygaslo';

  @override
  String get chatRedPacketGreeting => 'Najlepsze zyczenia';

  @override
  String get commonN42RedPacket => 'Czerwona koperta N42';

  @override
  String get commonClaimed => 'Odebrano';

  @override
  String get commonAllClaimed => 'Wszystko odebrane';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Odpowiedz';

  @override
  String get commonEdit => 'Edytuj';

  @override
  String get chatSelectForwardTarget => 'Wybierz odbiorce';

  @override
  String commonSendCount(int count) {
    return 'Wyslij ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'ID N42: $id';
  }

  @override
  String get profileN42IdTitle => 'ID N42';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Informacje o znajomym';

  @override
  String get contactFriendInfoDesc =>
      'Dodaj uwage, telefon, tagi, notatki, zdjecia i ustaw uprawnienia znajomego.';

  @override
  String get commonMoments => 'Chwile';

  @override
  String get commonSendMessage => 'Wiadomosc';

  @override
  String get contactAudioVideoCall => 'Polaczenie audio/wideo';

  @override
  String get contactVideoChannel => 'Kanal wideo';

  @override
  String get contactRemark => 'Uwaga';

  @override
  String get contactRemarkName => 'Nazwa uwagi';

  @override
  String get contactPhone => 'Telefon';

  @override
  String get contactTags => 'Tagi';

  @override
  String get contactNotes => 'Notatki';

  @override
  String get contactPhotos => 'Zdjecia';

  @override
  String get contactPermissions => 'Uprawnienia';

  @override
  String get contactChatMomentsEtc => 'Czat, Chwile, Sport itp.';

  @override
  String get contactMoreInfo => 'Wiecej informacji';

  @override
  String get contactCommonGroups => 'Wspolne grupy';

  @override
  String get contactSource => 'Zrodlo';

  @override
  String get settingsNotificationSettings => 'Powiadomienia';

  @override
  String get settingsPrivacy => 'Prywatnosc';

  @override
  String get settingsAppearance => 'Wyglad';

  @override
  String get settingsAbout => 'O aplikacji';

  @override
  String get commonLogout => 'Wyloguj';

  @override
  String get commonLogoutConfirm => 'Czy na pewno chcesz sie wylogowac?';

  @override
  String get commonSave => 'Zapisz';

  @override
  String get profileNickname => 'Pseudonim';

  @override
  String get profileEnterNickname => 'Wprowadz pseudonim';

  @override
  String get profileSignature => 'Podpis';

  @override
  String get profileAddSignature => 'Dodaj podpis';

  @override
  String get commonTakePhoto => 'Zrob zdjecie';

  @override
  String get profileChooseFromGallery => 'Wybierz z galerii';

  @override
  String profileSaveFailed(String error) {
    return 'Nie udalo sie zapisac: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Bezpieczna, zdecentralizowana komunikacja';

  @override
  String get commonEndToEndEncryption => 'Szyfrowanie od konca do konca';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Wiadomosci widoczne tylko dla Ciebie i odbiorcy';

  @override
  String get authDecentralized => 'Zdecentralizowany';

  @override
  String get authBasedOnMatrix => 'Oparty na otwartym protokole Matrix';

  @override
  String get authWalletIntegration => 'Integracja portfela';

  @override
  String get authEasyCryptoTransfer => 'Latwe przelewy kryptowalut';

  @override
  String get authRegister => 'Zarejestruj sie';

  @override
  String get authAgreeTerms => 'Logujac sie, akceptujesz';

  @override
  String get authTermsOfService => 'Regulamin';

  @override
  String get authAnd => 'i';

  @override
  String get authPrivacyPolicy => 'Polityke prywatnosci';

  @override
  String get authServerAddress => 'Adres serwera';

  @override
  String get authEnterServerAddress => 'Wprowadz adres serwera';

  @override
  String authConnectedTo(String serverName) {
    return 'Polaczono z $serverName';
  }

  @override
  String get authUsername => 'Nazwa uzytkownika';

  @override
  String get authEnterUsername => 'Wprowadz nazwe uzytkownika';

  @override
  String get authPassword => 'Haslo';

  @override
  String get authEnterPassword => 'Wprowadz haslo';

  @override
  String get authRegisterAccount => 'Zarejestruj sie';

  @override
  String get authForgotPassword => 'Zapomniales hasla';

  @override
  String get authOtherLoginMethods => 'Inne metody logowania';

  @override
  String get authCreateAccount => 'Utworz konto';

  @override
  String get authJoinN42Chat => 'Dolacz do N42 Chat, aby rozpoczac rozmowe';

  @override
  String get authUsernameHint => '3-20 znakow, litery/cyfry/_';

  @override
  String get authUsernameMinLength =>
      'Nazwa uzytkownika musi miec co najmniej 3 znaki';

  @override
  String get authUsernameMaxLength =>
      'Nazwa uzytkownika moze miec maksymalnie 20 znakow';

  @override
  String get authUsernameFormat =>
      'Nazwa uzytkownika moze zawierac tylko litery, cyfry i podkreslenia';

  @override
  String get authPasswordHint => 'Min. 8 znakow';

  @override
  String get commonPasswordMinLength => 'Haslo musi miec co najmniej 8 znakow';

  @override
  String get authConfirmPassword => 'Potwierdz haslo';

  @override
  String get authFilled => 'Wypelniono';

  @override
  String get authEnterInviteCode => 'Wprowadz kod zaproszenia';

  @override
  String get authAlreadyHaveAccount => 'Masz juz konto?';

  @override
  String get authLoginNow => 'Zaloguj sie teraz';

  @override
  String get profileAvatar => 'Awatar';

  @override
  String get profileStatus => 'Status';

  @override
  String get commonLoading => 'Ladowanie...';

  @override
  String get conversationNoConversations => 'Brak rozmow';

  @override
  String get conversationTapToChat =>
      'Dotknij prawego gornego rogu, aby rozpoczac rozmowe';

  @override
  String get conversationStartGroup => 'Rozpocznij czat grupowy';

  @override
  String get commonScan => 'Skanuj';

  @override
  String get commonPayment => 'Platnosc';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature wkrotce dostepne';
  }

  @override
  String get conversationMarkAsRead => 'Oznacz jako przeczytane';

  @override
  String get commonUnmute => 'Wlacz dzwiek';

  @override
  String get commonMute => 'Wycisz';

  @override
  String get conversationUnpin => 'Odepnij';

  @override
  String get conversationPin => 'Przypnij';

  @override
  String get conversationDeleteConversation => 'Usun rozmowe';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Usunac rozmowe z \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Brak kontaktow';

  @override
  String get contactAddFriendsToChat =>
      'Dodaj znajomych, aby rozpoczac rozmowe';

  @override
  String get contactNotFound => 'Kontakt nie zostal znaleziony';

  @override
  String get contactTryOtherKeywords =>
      'Sprobuj innych slow kluczowych lub wyszukiwania globalnego';

  @override
  String get contactSearchResults => 'Wyniki wyszukiwania';

  @override
  String get contactNewFriends => 'Nowi znajomi';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Konta oficjalne';

  @override
  String get contactServiceAccounts => 'Konta uslugowe';

  @override
  String get contactEnterpriseContacts => 'Kontakty firmowe';

  @override
  String get contactRecommendToFriend => 'Udostepnij kontakt';

  @override
  String get commonSetRemark => 'Ustaw uwage';

  @override
  String get contactSendingCard => 'Wysylanie wizytowki...';

  @override
  String get commonFileLabel => 'Plik';

  @override
  String get commonLocationLabel => 'Lokalizacja';

  @override
  String contactRecommendFailed(String error) {
    return 'Polecenie nie powiodlo sie: $error';
  }

  @override
  String get profileEnterRemark => 'Wprowadz uwage';

  @override
  String get contactOpeningChat => 'Otwieranie czatu...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Nie udalo sie otworzyc czatu: $error';
  }

  @override
  String get contactAddContact => 'Dodaj kontakt';

  @override
  String get contactEnterUserId => 'Wprowadz ID uzytkownika';

  @override
  String get contactNoFriendRequests => 'Brak zaproszen do znajomych';

  @override
  String get commonAccept => 'Akceptuj';

  @override
  String get commonReject => 'Odrzuc';

  @override
  String get commonNoGroups => 'Brak grup';

  @override
  String get contactSelectFriendToRecommend => 'Wybierz znajomego do polecenia';

  @override
  String get commonSearchContacts => 'Szukaj kontaktow';

  @override
  String get contactNoContactsFound => 'Nie znaleziono kontaktow';

  @override
  String get favoriteYesterday => 'Wczoraj';

  @override
  String get chatJustNow => 'Przed chwila';

  @override
  String get profileOnline => 'Online';

  @override
  String get profileOffline => 'Offline';

  @override
  String get searchContactsGroupsMessages =>
      'Szukaj kontaktow, grup, wiadomosci';

  @override
  String get searchError => 'Blad wyszukiwania';

  @override
  String get chatSearchHint => 'Szukaj kontaktow, grup i wiadomosci';

  @override
  String get searchHistory => 'Historia wyszukiwania';

  @override
  String get commonClear => 'Wyczysc';

  @override
  String get commonAll => 'Wszystko';

  @override
  String get searchGroups => 'Grupy';

  @override
  String get searchNoResults => 'Brak wynikow';

  @override
  String commonGroupMembers(int count) {
    return 'Czlonkowie ($count)';
  }

  @override
  String get groupMembersTitle => 'Członkowie grupy';

  @override
  String get groupViewAll => 'Zobacz wszystko';

  @override
  String get groupOwner => 'Wlasciciel';

  @override
  String get groupAdmin => 'Administrator';

  @override
  String get groupInvite => 'Zapros';

  @override
  String get commonGroupAnnouncement => 'Ogloszenie grupy';

  @override
  String get commonNotSet => 'Nie ustawiono';

  @override
  String get groupDescription => 'Opis grupy';

  @override
  String get groupPublicGroup => 'Grupa publiczna';

  @override
  String get commonClearChatHistory => 'Wyczysc historie czatu';

  @override
  String get commonDissolveGroup => 'Rozwiaz grupe';

  @override
  String get commonLeaveGroup => 'Opusc grupe';

  @override
  String get groupChangeGroupName => 'Zmien nazwe grupy';

  @override
  String get commonEnterGroupName => 'Wprowadz nazwe grupy';

  @override
  String get commonConfirm => 'Potwierdz';

  @override
  String get groupEnterGroupDescription => 'Wprowadz opis grupy';

  @override
  String get groupPublish => 'Opublikuj';

  @override
  String get chatClearHistoryConfirm =>
      'Wyczyścic cala historie czatu? Tej operacji nie mozna cofnac.';

  @override
  String get chatClearAction => 'Wyczysc';

  @override
  String get commonChatHistoryCleared => 'Historia czatu wyczyszczona';

  @override
  String get commonDissolve => 'Rozwiaz';

  @override
  String get groupQrCode => 'Kod QR grupy';

  @override
  String get commonSearchChatHistory => 'Szukaj w historii czatu';

  @override
  String get groupIdCopied => 'ID grupy skopiowano';

  @override
  String get transferEnterOrPasteAddress => 'Wprowadz lub wklej adres portfela';

  @override
  String get transferSelectToken => 'Wybierz token';

  @override
  String get commonTransferAmount => 'Kwota przelewu';

  @override
  String get transferAvailable => 'Dostepne';

  @override
  String get transferMemoOptional => 'Notatka (opcjonalna)';

  @override
  String get transferConfirmTransfer => 'Potwierdz przelew';

  @override
  String get transferAddressVerified => 'Adres zweryfikowany';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Dostepne: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Wprowadz kwote';

  @override
  String get commonRedPacketCountMin =>
      'Wymagana co najmniej 1 czerwona koperta';

  @override
  String get commonViewRedPacketDetails => 'Zobacz szczegoly czerwonej koperty';

  @override
  String get commonEnterTransferAmount => 'Wprowadz kwote przelewu';

  @override
  String get commonTransferTo => 'Przelew do';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'Od $senderName';
  }

  @override
  String get commonConfirmReceive => 'Potwierdz odbiór';

  @override
  String get groupProfile => 'Informacje o grupie';

  @override
  String get groupRemoveMember => 'Usun z grupy';

  @override
  String get commonRemove => 'Usun';

  @override
  String get profileClearStatus => 'Wyczysc status';

  @override
  String get profileClearStatusConfirm => 'Wyczyścic biezacy status?';

  @override
  String get profileStatusCleared => 'Status wyczyszczony';

  @override
  String get profileUserNotExist => 'Uzytkownik nie istnieje';

  @override
  String get profileUserIdCopied => 'ID uzytkownika skopiowano';

  @override
  String get commonReport => 'Zglos';

  @override
  String get profileQrCode => 'Kod QR';

  @override
  String get profileAvatarUpdated => 'Awatar zaktualizowany';

  @override
  String commonSelectImageFailed(String error) {
    return 'Nie udalo sie wybrac obrazu: $error';
  }

  @override
  String get profileChangeName => 'Zmien nazwe';

  @override
  String get profileMale => 'Mezczyzna';

  @override
  String get profileFemale => 'Kobieta';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature w trakcie rozwoju...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Nie udalo sie zapisac adresu: $error';
  }

  @override
  String get profileAddNew => 'Dodaj';

  @override
  String get profileAddAddress => 'Dodaj adres';

  @override
  String get profileAddressAdded => 'Adres dodany';

  @override
  String get profileAddressUpdated => 'Adres zaktualizowany';

  @override
  String get profileDeleteAddress => 'Usun adres';

  @override
  String get profileAddressDeleted => 'Adres usuniety';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Nie udalo sie zapisac faktury: $error';
  }

  @override
  String get profileMyInvoices => 'Moje faktury';

  @override
  String get profileAddInvoice => 'Dodaj fakture';

  @override
  String get profileInvoiceAdded => 'Faktura dodana';

  @override
  String get profileInvoiceUpdated => 'Faktura zaktualizowana';

  @override
  String get profileDeleteInvoice => 'Usun fakture';

  @override
  String get profileInvoiceDeleted => 'Faktura usunieta';

  @override
  String get profilePersonal => 'Osobista';

  @override
  String get groupSelectAtLeastOne => 'Wybierz co najmniej jednego czlonka';

  @override
  String get chatFileNotExist => 'Plik nie istnieje';

  @override
  String chatSendFailed(String error) {
    return 'Wyslanie nie powiodlo sie: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Nie mozna otworzyc przegladarki';

  @override
  String chatSelectFileFailed(String error) {
    return 'Nie udalo sie wybrac pliku: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Konfiguracja nie powiodla sie: $error';
  }

  @override
  String get transferEnterValidAmount => 'Wprowadz prawidlowa kwote';

  @override
  String get commonAddressCopied => 'Adres skopiowany';

  @override
  String favoriteOpenItem(String content) {
    return 'Otworz: $content';
  }

  @override
  String get favoriteDeleted => 'Usunieto';

  @override
  String get profileWallet => 'Portfel';

  @override
  String get chatRecording => 'Nagrywanie';

  @override
  String get chatInvalidVideoUrl => 'Nieprawidlowy adres URL wideo';

  @override
  String get chatDownloadFile => 'Pobierz plik';

  @override
  String get chatClearChatHistoryTitle => 'Wyczysc historie czatu';

  @override
  String get chatVideoCall => 'Polaczenie wideo';

  @override
  String get commonVoiceCall => 'Polaczenie glosowe';

  @override
  String get callLeaveMeeting => 'Opusc spotkanie';

  @override
  String get chatDetails => 'Szczegoly czatu';

  @override
  String get chatViewAllGroupMembers => 'Zobacz wszystkich czlonkow';

  @override
  String get chatGroupName => 'Nazwa grupy';

  @override
  String get chatGroupNameUpdated => 'Nazwa grupy zaktualizowana';

  @override
  String get chatUpdateFailed => 'Aktualizacja nie powiodla sie';

  @override
  String get chatNoPermissionToModify => 'Nie masz uprawnien do modyfikacji';

  @override
  String get chatGroupManagement => 'Zarzadzanie grupa';

  @override
  String get chatMyNicknameInGroup => 'Moj pseudonim w grupie';

  @override
  String get chatPinChat => 'Przypnij czat';

  @override
  String get chatStrongReminder => 'Silne przypomnienie';

  @override
  String get chatSetChatBackground => 'Ustaw tlo czatu';

  @override
  String get chatUnknownFile => 'Nieznany plik';

  @override
  String get chatDownload => 'Pobierz';

  @override
  String get chatInvalidLocation => 'Nieprawidlowa lokalizacja';

  @override
  String get chatTapToCancel => 'Dotknij, aby anulowac';

  @override
  String chatCaptureFailed(Object error) {
    return 'Przechwytywanie nie powiodlo sie: $error';
  }

  @override
  String get chatProcessingVideo => 'Przetwarzanie wideo...';

  @override
  String get chatVideoFileNotExist => 'Plik wideo nie istnieje';

  @override
  String get chatVideoDataEmpty => 'Dane wideo sa puste';

  @override
  String get chatVideoTooLarge => 'Rozmiar wideo nie moze przekraczac 100MB';

  @override
  String get chatSendingVideo => 'Wysylanie wideo...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Nie udalo sie wyslac wideo: $error';
  }

  @override
  String get chatImageFileNotExist => 'Plik obrazu nie istnieje';

  @override
  String get commonImageDataEmpty => 'Dane obrazu sa puste';

  @override
  String get chatSendingImage => 'Wysylanie obrazu...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Nie udalo sie wyslac obrazu: $error';
  }

  @override
  String get chatSendLocation => 'Wyslij lokalizacje';

  @override
  String get chatSelectLocationAndSend => 'Wybierz lokalizacje i wyslij';

  @override
  String get chatShareRealTimeLocation =>
      'Udostepnij lokalizacje w czasie rzeczywistym';

  @override
  String get chatShareLocationForOneHour =>
      'Udostepnij lokalizacje znajomemu przez 1 godzine';

  @override
  String get chatLocationSent => 'Lokalizacja wyslana';

  @override
  String get chatSelectMessages => 'Wybierz wiadomosci';

  @override
  String chatSelectedCount(int count) {
    return 'Wybrano $count';
  }

  @override
  String get chatSelectAll => 'Wybierz wszystko';

  @override
  String chatGroupChatCount(int count) {
    return 'Czat grupowy ($count)';
  }

  @override
  String get chatPrivateChat => 'Czat prywatny';

  @override
  String get chatNoMessages => 'Brak wiadomosci';

  @override
  String get chatSendFirstMessage =>
      'Wyslij pierwsza wiadomosc, aby rozpoczac rozmowe';

  @override
  String get chatEncryptionNotice =>
      'Ten czat jest szyfrowany od konca do konca. Tylko Ty i odbiorca mozecie czytac wiadomosci.';

  @override
  String get chatMultiForward => 'Przekaz dalej';

  @override
  String get chatCollect => 'Zbierz';

  @override
  String get chatNoMembers => 'Brak czlonkow';

  @override
  String get chatMemberNotFound => 'Czlonek nie zostal znaleziony';

  @override
  String get chatVoiceFileNotExist => 'Plik glosowy nie istnieje';

  @override
  String get chatVoiceFileEmpty => 'Plik glosowy jest pusty';

  @override
  String get chatSendingVoice => 'Wysylanie glosu...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Nie udalo sie wyslac glosu: $error';
  }

  @override
  String get chatMessageForwarded => 'Wiadomosc przekazana';

  @override
  String chatForwardFailed(Object error) {
    return 'Przekazanie nie powiodlo sie: $error';
  }

  @override
  String get chatUnfavorited => 'Usunieto z ulubionych';

  @override
  String get chatFavorited => 'Dodano do ulubionych';

  @override
  String get chatReactionAdded => 'Reakcja dodana';

  @override
  String get chatReactionRemoved => 'Reakcja usunieta';

  @override
  String get chatFailedMessageDeleted => 'Nieudana wiadomosc usunieta';

  @override
  String get chatDeleteMessages => 'Usun wiadomosci';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Czy na pewno chcesz usunac $count wiadomosci?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Uwaga: $count wiadomosci jest od innych i zostana usuniete tylko dla Ciebie.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count wiadomosci od Ciebie zostanie wycofanych dla wszystkich.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Wycofano $count wiadomosci, $localCount usunieto tylko dla Ciebie';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Wycofano $count wiadomosci';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count wiadomosci usunieto tylko dla Ciebie';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Przekazano $count wiadomosci';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Przekazanie zakonczone: $success udanych, $failed nieudanych';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Funkcja przypomnienia jest dostepna tylko w czacie grupowym';

  @override
  String get chatOnlyTextSearchable =>
      'Mozna wyszukiwac tylko wiadomosci tekstowe';

  @override
  String chatSearchFor(Object text) {
    return 'Szukaj \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Wyszukiwanie Baidu';

  @override
  String get chatGoogleSearch => 'Wyszukiwanie Google';

  @override
  String get chatBingSearch => 'Wyszukiwanie Bing';

  @override
  String get chatCalling => 'Dzwonie...';

  @override
  String get chatRinging => 'Dzwoni...';

  @override
  String get chatInCall => 'W trakcie polaczenia';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Funkcja w trakcie rozwoju...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Zebrano $count wiadomosci';
  }

  @override
  String commonMemberCount(int count) {
    return '$count czlonkow';
  }

  @override
  String groupDone(int count) {
    return 'Gotowe($count)';
  }

  @override
  String get profileServices => 'Uslugi';

  @override
  String get commonFavorites => 'Ulubione';

  @override
  String get profileOrdersAndCards => 'Zamowienia i karty';

  @override
  String get profileStickers => 'Naklejki';

  @override
  String profileStatusSetTo(String status) {
    return 'Status ustawiony na: $status';
  }

  @override
  String get profileAvatarUploadFailed =>
      'Przesylanie awatara nie powiodlo sie';

  @override
  String get profilePersonalProfile => 'Profil osobisty';

  @override
  String get profileName => 'Imie';

  @override
  String get profileGender => 'Plec';

  @override
  String get profileRegion => 'Region';

  @override
  String get commonMyQrCode => 'Moj kod QR';

  @override
  String get profilePoke => 'Szturchnij';

  @override
  String get profileRingtone => 'Dzwonek';

  @override
  String get profileDefaultRingtone => 'Domyslny dzwonek';

  @override
  String get profileMyAddresses => 'Moje adresy';

  @override
  String profileGenderSetTo(String gender) {
    return 'Plec ustawiona na: $gender';
  }

  @override
  String get profileSelectRegion => 'Wybierz region';

  @override
  String get profileSelectCity => 'Wybierz miasto';

  @override
  String profileRegionSetTo(String region) {
    return 'Region ustawiony na: $region';
  }

  @override
  String get profileSetPoke => 'Ustaw szturchniecie';

  @override
  String get profileFriendPokedMe => 'Znajomy mnie szturchnal';

  @override
  String get profileExample => 'Przyklad';

  @override
  String get profileOnTheShoulder => ' w ramie';

  @override
  String get profilePokeCleared => 'Szturchniecie wyczyszczone';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Szturchniecie ustawione na: szturchnal mnie$suffix';
  }

  @override
  String get profileEditSignature => 'Edytuj podpis';

  @override
  String get profileIntroduceYourself => 'Zdanie, ktore Cie opisuje';

  @override
  String get profileSignatureCleared => 'Podpis wyczyszczony';

  @override
  String get profileSignatureUpdated => 'Podpis zaktualizowany';

  @override
  String get profileScanToAddFriend =>
      'Zeskanuj powyzszy kod QR, aby dodac mnie jako znajomego';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Dzwonek ustawiony na: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Czy na pewno chcesz rozwiązać \"$name\"? Tej operacji nie można cofnąć.';
  }

  @override
  String get authEnterValidServerAddress => 'Wprowadz prawidlowy adres serwera';

  @override
  String get authEmailOtp => 'Kod OTP z e-maila';

  @override
  String get authEnterServerAddressFirst => 'Najpierw wprowadz adres serwera';

  @override
  String get authPasskeyRequiresServer =>
      'Logowanie kluczem dostepu wymaga wsparcia serwera';

  @override
  String get authLoginAgreement => 'Logujac sie, akceptujesz ';

  @override
  String get authPleaseAgreeToTerms =>
      'Przeczytaj i zaakceptuj Regulamin i Polityke prywatnosci';

  @override
  String get authRegisterFailed => 'Rejestracja nie powiodla sie';

  @override
  String get commonReenterPassword => 'Wprowadz haslo ponownie';

  @override
  String get commonPasswordsDoNotMatch => 'Hasla nie pasuja do siebie';

  @override
  String get authInviteCodeBuiltIn => 'Kod zaproszenia (wbudowany)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Kod zaproszenia jest wbudowany, zwykle nie trzeba go zmieniac';

  @override
  String get authIHaveReadAndAgree => 'Przeczytałem i akceptuje ';

  @override
  String get mainStartGroupChat => 'Rozpocznij czat grupowy';

  @override
  String get mainAddFriends => 'Dodaj znajomych';

  @override
  String get mainPaymentAndCollection => 'Platnosc';

  @override
  String contactCount(int count) {
    return '$count kontaktow';
  }

  @override
  String get contactAddToHomeScreen => 'Dodaj do ekranu glownego';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Polecono wizytowke $contact do $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Wprowadz nazwe uwagi';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Uwaga ustawiona na: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Zaakceptowano zaproszenie od $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Odrzucono zaproszenie od $name';
  }

  @override
  String get commonGroupInvites => 'Zaproszenia do grupy';

  @override
  String commonMyGroups(int count) {
    return 'Moje grupy ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Zaproszono do dolaczenia do grupy';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Czy na pewno chcesz opuścić \"$name\"?';
  }

  @override
  String get commonLeave => 'Opusc';

  @override
  String get commonRecallThisMessage => 'Wycofac te wiadomosc?';

  @override
  String get commonSavedToGallery => 'Zapisano w galerii';

  @override
  String get commonFailedToSave => 'Nie udalo sie zapisac';

  @override
  String get chatSaving => 'Zapisywanie...';

  @override
  String get commonShare => 'Udostepnij';

  @override
  String get chatSaveToGallery => 'Zapisz w galerii';

  @override
  String chatDownloadFailed(String code) {
    return 'Pobieranie nie powiodło się: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Udostępnianie nie powiodło się: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Nie udalo sie zaladowac obrazu';

  @override
  String get chatVideoRecordingFailed =>
      'Nagrywanie wideo nie powiodlo sie. Sprobuj ponownie.';

  @override
  String get profileRedPacket => 'Czerwona koperta';

  @override
  String get commonMusic => 'Muzyka';

  @override
  String get commonCoupon => 'Kupon';

  @override
  String get commonGift => 'Prezent';

  @override
  String get commonPoll => 'Ankieta';

  @override
  String get favoriteText => 'Tekst';

  @override
  String get favoriteLinkLabel => 'Link';

  @override
  String get favoriteNote => 'Notatka';

  @override
  String get favoriteMyNotes => 'Moje notatki';

  @override
  String get favoriteToday => 'Dzisiaj';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count dni temu';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Brak ulubionych';

  @override
  String get favoriteLongPressToFavorite =>
      'Przytrzymaj wiadomosc, aby dodac do ulubionych';

  @override
  String get favoriteNewNote => 'Nowa notatka';

  @override
  String get favoriteLink => 'Ulubiony link';

  @override
  String get favoriteEditTags => 'Edytuj tagi';

  @override
  String get favoriteDeleteFavorite => 'Usun z ulubionych';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Czy na pewno chcesz usunac ten ulubiony element?';

  @override
  String get favoriteNoSearchResultsFound => 'Nie znaleziono wynikow';

  @override
  String get commonSendRedPacket => 'Wyslij czerwona koperte';

  @override
  String get transferAmount => 'Kwota';

  @override
  String get commonRedPacketCover => 'Okladka czerwonej koperty';

  @override
  String get commonRedPacketType => 'Typ czerwonej koperty';

  @override
  String get commonNormalRedPacket => 'Zwykla';

  @override
  String get commonLuckyRedPacket => 'Szczesliwa';

  @override
  String get commonRedPacketCount => 'Liczba czerwonych kopert';

  @override
  String get commonPieces => 'sztuk';

  @override
  String get commonPutMoneyInRedPacket => 'Wloz pieniadze do czerwonej koperty';

  @override
  String get commonRedPacketRefundNotice =>
      'Nieodebrane czerwone koperty zostana zwrocone po 24 godzinach';

  @override
  String get commonOpenRedPacket => 'Otworz';

  @override
  String get commonRedPacketAllClaimed => 'Wszystkie czerwone koperty odebrane';

  @override
  String get commonRedPacketExpired => 'Czerwona koperta wygasla';

  @override
  String get commonAddTransferNote => 'Dodaj notatke do przelewu';

  @override
  String get commonYuan => 'PLN';

  @override
  String get commonReplyWithEmoji => 'Odpowiedz tym emotikonem';

  @override
  String get contactEditRemark => 'Edytuj uwage';

  @override
  String get contactSetPermissions => 'Ustaw uprawnienia';

  @override
  String get profileAddToBlacklist => 'Dodaj do czarnej listy';

  @override
  String get contactDeleteContact => 'Usun kontakt';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Czy na pewno chcesz usunac $name?';
  }

  @override
  String get transferTitle => 'Przelew';

  @override
  String get transferReceiverAddressLabel => 'Adres odbiorcy';

  @override
  String get transferSelectTokenLabel => 'Wybierz token';

  @override
  String get transferAmountLabel => 'Kwota przelewu';

  @override
  String get transferMemoLabel => 'Notatka (opcjonalna)';

  @override
  String get transferAddMemoHint => 'Dodaj notatke';

  @override
  String get transferSendPaymentRequest => 'Wyslij zadanie platnosci';

  @override
  String get transferQrCodeGenerateFailed =>
      'Generowanie kodu QR nie powiodlo sie';

  @override
  String get transferScanQrToPayMe => 'Zeskanuj kod QR, aby mi zaplacic';

  @override
  String get transferMyWalletAddress => 'Moj adres portfela';

  @override
  String get transferCreatePaymentRequest => 'Utworz zadanie platnosci';

  @override
  String profileN42IdLabel(String id) {
    return 'ID N42: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Najlepsze zyczenia';

  @override
  String commonSenderRedPacket(String name) {
    return 'Czerwona koperta od $name';
  }

  @override
  String get transferEnterValidAddress => 'Wprowadz prawidlowy adres';

  @override
  String get transferPleaseSelectToken => 'Wybierz token';

  @override
  String get commonReceivedTransfer => 'Odebrany przelew';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name wyslal(a) czerwona koperte';
  }

  @override
  String get commonSavedToBalance =>
      'Zapisano na saldo, mozna przelewac bezposrednio';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Czerwona koperta wygasla/wszystkie odebrane';

  @override
  String get transferScanFeatureComingSoon =>
      'Funkcja skanowania wkrotce dostepna...';

  @override
  String get contactSetAsStarred => 'Ustaw jako ulubione';

  @override
  String get contactAddToBlocklist => 'Dodaj do listy zablokowanych';

  @override
  String get commonClaimedYour => ' odebral(a) Twoja ';

  @override
  String get commonClaimedText => ' odebral(a) ';

  @override
  String commonUserTyping(String name) {
    return '$name pisze...';
  }

  @override
  String get commonTyping => 'Pisze...';

  @override
  String get commonWaitingToReceive => 'Oczekiwanie na odbiór';

  @override
  String get commonTapToClaim => 'Dotknij, aby odebrac';

  @override
  String get commonHasBeenReceived => 'Zostalo odebrane';

  @override
  String get commonGetLucky => 'Niech Ci sie szczesci';

  @override
  String get qrcodeCameraStartFailed => 'Kamera nie uruchomila sie';

  @override
  String get qrcodeUnknownError => 'Nieznany blad';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Umiesc kod QR w ramce, aby zeskanowac';

  @override
  String get qrcodeCloseManualInput => 'Zamknij reczne wprowadzanie';

  @override
  String get qrcodeManualInputUserId => 'Reczne wprowadzanie ID uzytkownika';

  @override
  String get commonAdd => 'Dodaj';

  @override
  String get profileSetStatus => 'Ustaw status';

  @override
  String get profileVisibleToFriends24h =>
      'Widoczne dla znajomych przez 24 godziny';

  @override
  String get profileWriteStatus => 'Napisz status';

  @override
  String get profileEnterYourStatus => 'Wprowadz swoj status...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Wymagane uprawnienie do kamery, aby skanowac kod QR';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Uprawnienie do kamery zostalo trwale odrzucone. Wlacz je w ustawieniach systemu.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Blad sprawdzania uprawnienia: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Nieprawidlowy kod QR';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Nie mozna dodac znajomego: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Skanuj kod QR';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Sprawdzanie uprawnienia do kamery...';

  @override
  String get qrcodeNeedCameraPermission => 'Wymagane uprawnienie do kamery';

  @override
  String get qrcodeRetryPermission => 'Ponow';

  @override
  String get qrcodeOpenSettings => 'Otworz ustawienia';

  @override
  String get groupInviteMembers => 'Zapros czlonkow';

  @override
  String groupInviteCount(int count) {
    return 'Zapros($count)';
  }

  @override
  String get profileNoShippingAddress => 'Brak adresu dostawy';

  @override
  String get profileDefaultLabel => 'Domyslny';

  @override
  String get profileNoInvoice => 'Brak faktury';

  @override
  String get profileCompany => 'Firma';

  @override
  String get profileTaxNumber => 'NIP';

  @override
  String get profileConfirmDeleteAddress =>
      'Czy na pewno chcesz usunac ten adres?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Czy na pewno chcesz usunac te fakture?';

  @override
  String get commonGroupOwner => 'Wlasciciel';

  @override
  String get commonGroupAdmin => 'Administrator';

  @override
  String get groupSearchMembers => 'Szukaj czlonkow';

  @override
  String groupTotalMembers(int count) {
    return '$count czlonkow';
  }

  @override
  String get chatRemoveFromGroup => 'Usun z grupy';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Czy na pewno chcesz usunac \"$name\" z grupy?';
  }

  @override
  String get chatUnknownSong => 'Nieznany utwor';

  @override
  String get chatUnknownArtist => 'Nieznany artysta';

  @override
  String get chatUnknownContact => 'Nieznany kontakt';

  @override
  String get chatPersonalCard => 'Wizytowka';

  @override
  String get chatSingleChoice => 'Pojedynczy wybor';

  @override
  String get chatMultiChoice => 'Wielokrotny wybor';

  @override
  String get chatEnded => 'Zakonczone';

  @override
  String get chatEndPollButton => 'Zakoncz ankiete';

  @override
  String get chatPollHint =>
      'Ankieta bedzie wyswietlana na czacie. Czlonkowie grupy moga glosowac.';

  @override
  String get chatSearchSongOrArtist => 'Szukaj utworu lub artysty';

  @override
  String get chatNoSongsFound => 'Nie znaleziono utworow';

  @override
  String get chatSongNameOptional => 'Nazwa utworu (opcjonalna)';

  @override
  String get chatEnterSongName => 'Wprowadz nazwe utworu';

  @override
  String get chatArtistNameOptional => 'Nazwa artysty (opcjonalna)';

  @override
  String get chatEnterArtistName => 'Wprowadz nazwe artysty';

  @override
  String get chatRealTimeLocationSharing =>
      'Udostepnianie lokalizacji w czasie rzeczywistym w trakcie rozwoju...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Funkcja polaczenia glosowego w trakcie rozwoju...';

  @override
  String get profileReportFeatureInDev =>
      'Funkcja zglaszania w trakcie rozwoju...';

  @override
  String get profileShareFeatureInDev =>
      'Funkcja udostepniania w trakcie rozwoju...';

  @override
  String get profileQrCodeFeatureInDev =>
      'Funkcja kodu QR w trakcie rozwoju...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Zeskanuj powyzszy kod QR, aby dodac mnie jako znajomego';

  @override
  String get qrcodeSaveToAlbum => 'Zapisz w albumie';

  @override
  String get qrcodeChangeStyle => 'Zmien styl';

  @override
  String get qrcodeCopyId => 'Kopiuj ID';

  @override
  String get qrcodeIdCopied => 'ID skopiowane';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'Wiecej stylow wkrotce dostepnych';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Serwer';

  @override
  String get profileShareContactCard => 'Udostepnij wizytowke';

  @override
  String get profileRemoveFromBlacklist => 'Usun z czarnej listy';

  @override
  String get profileConfirmAddBlacklist =>
      'Czy na pewno chcesz dodac tego uzytkownika do czarnej listy? Nie bedziesz otrzymywac od niego wiadomosci.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Czy na pewno chcesz usunac tego uzytkownika z czarnej listy?';

  @override
  String get profileRemarkSaved => 'Uwaga zapisana';

  @override
  String get profileRemarkCleared => 'Uwaga wyczyszczona';

  @override
  String get transferReceive => 'Odbierz';

  @override
  String get transferPleaseConnectWallet => 'Najpierw polacz portfel';

  @override
  String get transferSendRequest => 'Wyslij zadanie';

  @override
  String get transferPleaseEnterValidAmount => 'Wprowadz prawidlowa kwote';

  @override
  String get searchPlaceholder => 'Szukaj kontaktow, grup, wiadomosci';

  @override
  String get searchEnterKeywordToSearch =>
      'Wprowadz slowo kluczowe, aby wyszukac';

  @override
  String get searchClearHistory => 'Wyczysc';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Brak wynikow dla \"$query\"';
  }

  @override
  String get searchAllResults => 'Wszystko';

  @override
  String get searchInChat => 'Szukaj na czacie';

  @override
  String get searchContactLabel => 'Kontakt';

  @override
  String get searchGroupLabel => 'Grupa';

  @override
  String get searchConversationLabel => 'Rozmowa';

  @override
  String get searchMessageLabel => 'Wiadomosc';

  @override
  String get settingsSecurityTitle => 'Bezpieczenstwo';

  @override
  String get settingsKeyBackup => 'Kopia zapasowa kluczy';

  @override
  String get settingsBackupEncryptionKeys =>
      'Kopia zapasowa kluczy szyfrowania';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count kluczy skopiowanych';
  }

  @override
  String get settingsBackupNotSet => 'Kopia zapasowa nie ustawiona';

  @override
  String get settingsRestoreKeys => 'Przywroc klucze';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Przywroc klucze szyfrowania z kopii zapasowej';

  @override
  String get settingsExportKeys => 'Eksportuj klucze';

  @override
  String get settingsExportKeysToFile => 'Eksportuj klucze do pliku';

  @override
  String get settingsLoggedInDevices => 'Zalogowane urzadzenia';

  @override
  String get settingsNoOtherDevices => 'Brak innych urzadzen';

  @override
  String get settingsVerified => 'Zweryfikowane';

  @override
  String get settingsUnverified => 'Niezweryfikowane';

  @override
  String get settingsAdvanced => 'Zaawansowane';

  @override
  String get settingsCrossSigning => 'Podpisywanie krzyzowe';

  @override
  String get settingsEnabled => 'Wlaczone';

  @override
  String get settingsNotEnabled => 'Nie wlaczone';

  @override
  String get settingsResetEncryption => 'Zresetuj szyfrowanie';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Usun wszystkie klucze szyfrowania';

  @override
  String get settingsEncryptionNotSupported =>
      'Szyfrowanie nie jest obslugiwane';

  @override
  String get settingsNotInitialized => 'Nie zainicjowano';

  @override
  String get settingsBackupKeyTitle => 'Kopia zapasowa kluczy';

  @override
  String get settingsBackupKeyMessage =>
      'Utworzyc nowa kopie zapasowa kluczy? Pomoze to przywrocic zaszyfrowane wiadomosci na nowym urzadzeniu.';

  @override
  String get settingsBackup => 'Kopia zapasowa';

  @override
  String get settingsRestoreKeyTitle => 'Przywroc klucze';

  @override
  String get settingsRestoreKeyMessage =>
      'Wprowadz haslo odzyskiwania lub klucz odzyskiwania, aby przywrocic zaszyfrowane wiadomosci.';

  @override
  String get settingsRestore => 'Przywroc';

  @override
  String get settingsExportKeyTitle => 'Eksportuj klucze';

  @override
  String get settingsExportKeyMessage =>
      'Wyeksportowany plik kluczy zawiera wszystkie Twoje klucze szyfrowania. Przechowuj go w bezpiecznym miejscu.';

  @override
  String get settingsExport => 'Eksportuj';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID urzadzenia: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Status: Zweryfikowane';

  @override
  String get settingsDeviceStatusUnverified => 'Status: Niezweryfikowane';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Ostatnia aktywnosc: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Zweryfikuj to urzadzenie';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Podpisywanie krzyzowe jest juz wlaczone';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Konfiguracja podpisywania krzyzowego powiodla sie';

  @override
  String get settingsResetEncryptionTitle => 'Zresetuj szyfrowanie';

  @override
  String get settingsResetEncryptionWarning =>
      'Ostrzezenie: Spowoduje to usuniecie wszystkich kluczy szyfrowania. Nie bedziesz moc odszyfrowac poprzednich zaszyfrowanych wiadomosci. Tej operacji nie mozna cofnac.';

  @override
  String get settingsReset => 'Zresetuj';

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
      'Czy na pewno chcesz opuscic spotkanie?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'szturchnal(a) $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Brak dostepnych kontaktow do dodania';

  @override
  String get chatAddMembers => 'Dodaj czlonkow';

  @override
  String chatInvitedMembers(int count) {
    return 'Zaproszono $count czlonkow';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Zaproszenie nie powiodlo sie: $error';
  }

  @override
  String get chatMemberRemoved => 'Czlonek usuniety';

  @override
  String chatRemoveFailed(String error) {
    return 'Usuniecie nie powiodlo sie: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Po udostepnieniu druga strona bedzie widziec Twoja lokalizacje w czasie rzeczywistym przez 1 godzine.';

  @override
  String get chatStartSharing => 'Rozpocznij udostepnianie';

  @override
  String get chatLocationServiceNotEnabled =>
      'Usluga lokalizacji nie jest wlaczona';

  @override
  String get chatEnableLocationService =>
      'Wlacz usluge lokalizacji, aby korzystac z tej funkcji';

  @override
  String get chatGoToSettings => 'Przejdz do ustawien';

  @override
  String get chatLocationPermissionRequired =>
      'Wymagane uprawnienie do lokalizacji dla tej funkcji';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Uprawnienie do lokalizacji zostalo trwale odrzucone. Wlacz je w ustawieniach.';

  @override
  String get chatLocationPermissionDenied =>
      'Uprawnienie do lokalizacji odrzucone';

  @override
  String get chatGettingLocation => 'Pobieranie lokalizacji...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Nie udalo sie uzyskac lokalizacji: $error';
  }

  @override
  String get chatMapPreview => 'Podglad mapy';

  @override
  String get chatSearchLocation => 'Szukaj lokalizacji';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Wyslano $amount $token czerwona koperte';
  }

  @override
  String get chatTransferDefault => 'Przelew';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Wyslano $amount $token przelew';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Nie udalo sie wybrac pliku: $error';
  }

  @override
  String get chatFileSizeLimit => 'Rozmiar pliku nie moze przekraczac 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Wysylanie pliku: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Nie udalo sie wyslac pliku: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Wyslano wizytowke $name';
  }

  @override
  String get chatFavoritesFeature => 'Ulubione';

  @override
  String get chatCouponsFeature => 'Kupony';

  @override
  String get chatGiftFeature => 'Prezent';

  @override
  String chatSharedMusic(String name) {
    return 'Udostepniono $name';
  }

  @override
  String get chatEndPollTitle => 'Zakoncz ankiete';

  @override
  String get chatEndPollConfirmMessage =>
      'Czy na pewno chcesz zakonczyc te ankiete? Glosowanie zostanie zamkniete po zakonczeniu.';

  @override
  String get chatPollEndedMessage => 'Ankieta zakonczona';

  @override
  String get chatConnectingCall => 'Łączenie...';

  @override
  String get chatMuteCall => 'Wycisz';

  @override
  String get chatSpeakerOff => 'Glosnik wylaczony';

  @override
  String get chatSpeakerOn => 'Glosnik';

  @override
  String get chatCameraOn => 'Kamera wlaczona';

  @override
  String get chatCameraOff => 'Kamera wylaczona';

  @override
  String get chatHangUp => 'Rozlacz';

  @override
  String get chatSelectForwardTargetTitle => 'Wybierz cel przekazania';

  @override
  String get chatNoForwardableChat => 'Brak czatow dostepnych do przekazania';

  @override
  String get chatNoMatchingChat => 'Nie znaleziono pasujacych czatow';

  @override
  String get chatLocationTitle => 'Lokalizacja';

  @override
  String get chatSendButton => 'Wyslij';

  @override
  String get chatRetryButton => 'Ponow';

  @override
  String get chatSearchContactHint => 'Szukaj kontaktow';

  @override
  String get chatShareMusic => 'Udostepnij muzyke';

  @override
  String get chatRecentPlayed => 'Ostatnie';

  @override
  String get chatMyFavorites => 'Ulubione';

  @override
  String get chatNetworkLink => 'Link';

  @override
  String get chatLocalFile => 'Lokalne';

  @override
  String get chatPasteMusicLink => 'Wklej link do muzyki';

  @override
  String get chatShareMusicButton => 'Udostepnij muzyke';

  @override
  String get chatSelectLocalAudio => 'Wybierz lokalny plik audio';

  @override
  String get chatSupportedAudioFormats => 'Obsluguje MP3, M4A, WAV, FLAC itp.';

  @override
  String get chatSelectFileButton => 'Wybierz plik';

  @override
  String get chatPleaseEnterMusicLink => 'Wprowadz link do muzyki';

  @override
  String get chatPleaseEnterValidLink => 'Wprowadz prawidlowy adres URL';

  @override
  String get chatSharedSong => 'Udostepniony utwor';

  @override
  String get chatSelectMember => 'Wybierz czlonka';

  @override
  String get chatSearchMemberHint => 'Szukaj czlonkow';

  @override
  String get chatNoMatchingMembers => 'Nie znaleziono pasujacych czlonkow';

  @override
  String get commonUnknownMember => 'Nieznany';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Wybrano $count wiadomosci';
  }

  @override
  String get chatSearchContactsOrGroups => 'Szukaj kontaktow lub grup';

  @override
  String get chatVideoTitle => 'Wideo';

  @override
  String get chatLoadingText => 'Ladowanie...';

  @override
  String get chatVideoLoadFailed => 'Ladowanie wideo nie powiodlo sie';

  @override
  String get chatPlayerInitFailed =>
      'Inicjalizacja odtwarzacza nie powiodla sie';

  @override
  String get chatCreatePollTitle => 'Utworz ankiete';

  @override
  String get chatSubmitPoll => 'Zatwierdz';

  @override
  String get chatPollQuestionLabel => 'Pytanie ankiety';

  @override
  String get chatEnterPollQuestionHint => 'Wprowadz pytanie ankiety';

  @override
  String get chatPollOptionsLabel => 'Opcje ankiety';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Opcja $index';
  }

  @override
  String get chatAddOptionButton => 'Dodaj opcje';

  @override
  String get chatPollSettingsLabel => 'Ustawienia ankiety';

  @override
  String get chatSelectionType => 'Typ wyboru';

  @override
  String get chatSingleChoiceLabel => 'Pojedynczy';

  @override
  String get chatMultiChoiceLabel => 'Wielokrotny';

  @override
  String get chatAnonymousPollSwitch => 'Anonimowa ankieta';

  @override
  String get chatPleaseEnterQuestion => 'Wprowadz pytanie ankiety';

  @override
  String get chatAtLeastTwoOptions => 'Wymagane co najmniej 2 opcje';

  @override
  String chatConfirmWithCount(int count) {
    return 'Potwierdz ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Weryfikacja e-mail';

  @override
  String get authEnterValidEmailAddress => 'Wprowadz prawidlowy adres e-mail';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Kod weryfikacyjny wyslany na $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Nie udalo sie wyslac kodu: $error';
  }

  @override
  String get authVerificationSuccess => 'Weryfikacja powiodla sie';

  @override
  String get authVerificationFailed => 'Weryfikacja nie powiodla sie';

  @override
  String authVerificationCodeError(String error) {
    return 'Blad kodu weryfikacyjnego: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Wprowadz kod weryfikacyjny';

  @override
  String get authEnterYourEmail => 'Wprowadz e-mail';

  @override
  String authWeSentCodeTo(String email) {
    return 'Wyslalismy 6-cyfrowy kod na\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Wprowadz adres e-mail, wyslimy kod weryfikacyjny';

  @override
  String get commonSendVerificationCode => 'Wyslij kod weryfikacyjny';

  @override
  String get authResendVerificationCode => 'Wyslij ponownie kod weryfikacyjny';

  @override
  String authCanResendAfter(int seconds) {
    return 'Mozna wyslac ponownie za $seconds sekund';
  }

  @override
  String get commonChangeEmail => 'Zmien e-mail';

  @override
  String get contactAddToContacts => 'Dodaj do kontaktow';

  @override
  String get contactAddingToContacts => 'Dodawanie...';

  @override
  String get contactAddedToContacts => 'Dodano do kontaktow';

  @override
  String contactAddFailedWithError(String error) {
    return 'Dodawanie nie powiodlo sie: $error';
  }

  @override
  String get contactAddPhone => 'Dodaj telefon';

  @override
  String get contactAddTag => 'Dodaj tagi';

  @override
  String get contactAddText => 'Dodaj tekst';

  @override
  String get contactAddPhoto => 'Dodaj zdjecie';

  @override
  String contactGroupCountLabel(int count) {
    return '$count grup';
  }

  @override
  String get contactAddedViaSearch => 'Dodano przez wyszukiwanie';

  @override
  String get contactAddTime => 'Dodaj czas';

  @override
  String get contactDoneButton => 'Gotowe';

  @override
  String get callWaitingForParticipants =>
      'Oczekiwanie na dolaczenie uczestnikow...';

  @override
  String callParticipantMe(String name) {
    return '$name (Ja)';
  }

  @override
  String get callSharingLabel => 'Udostepnianie';

  @override
  String callScreenSharingBy(String name) {
    return '$name udostepnia ekran';
  }

  @override
  String callParticipantCount(int count) {
    return '$count uczestnikow';
  }

  @override
  String get callMuteLabel => 'Wycisz';

  @override
  String get callUnmuteLabel => 'Wlacz dzwiek';

  @override
  String get callTurnOffVideo => 'Wylacz wideo';

  @override
  String get callTurnOnVideo => 'Wlacz wideo';

  @override
  String get callShareScreen => 'Udostepnij ekran';

  @override
  String get callStopSharing => 'Zatrzymaj udostepnianie';

  @override
  String get callSwitchCameraLabel => 'Przelacz';

  @override
  String get callLeaveLabel => 'Opusc';

  @override
  String get callParticipantsLabel => 'Uczestnicy';

  @override
  String get callJoiningMeeting => 'Dolaczanie do spotkania...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count głosów ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count uczestników';
  }

  @override
  String get commonTapToRetry => 'Dotknij, aby ponowić';

  @override
  String get chatDefaultRedPacketGreeting => 'Powodzenia i dobrobytu';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Zezwól innym na wyszukiwanie i dołączanie';

  @override
  String get groupConfirmClearChatHistory =>
      'Czy na pewno chcesz usunąć historię czatu?';

  @override
  String get groupCreateGroupToChat => 'Utwórz grupę, aby rozpocząć czat';

  @override
  String get groupEditGroupAnnouncement => 'Edytuj ogłoszenie grupy';

  @override
  String get groupEditGroupDescription => 'Edytuj opis grupy';

  @override
  String get groupEnterGroupAnnouncement => 'Wpisz ogłoszenie grupy';

  @override
  String chatErrorWithMessage(String message) {
    return 'Błąd: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count członków, kliknij aby skopiować ID grupy';
  }

  @override
  String get chatMusicLinkLabel => 'Link do muzyki';

  @override
  String get chatNoMediaUrlAvailable => 'URL multimediów niedostępny';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Nie masz uprawnień do edycji nazwy grupy';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Czerwone koperty i przelewy nie mogą być przekazywane';

  @override
  String get authEmailAddress => 'Adres e-mail';

  @override
  String get commonEnterEmailAddress => 'Wprowadź adres e-mail';

  @override
  String get authEmailRecoveryHint => 'Używany do odzyskiwania hasła';

  @override
  String get commonInvalidEmailFormat => 'Wprowadź prawidłowy adres e-mail';

  @override
  String get authOptional => 'Opcjonalnie';

  @override
  String get authResetPassword => 'Resetuj hasło';

  @override
  String get authEnterRegisteredEmail =>
      'Wprowadź adres e-mail, z którym się zarejestrowałeś';

  @override
  String get authSendResetCode => 'Wyślij kod resetowania';

  @override
  String authResetCodeSent(String email) {
    return 'Kod resetowania wysłany na $email';
  }

  @override
  String get authEnterResetCode => 'Wprowadź kod resetowania';

  @override
  String get authSetNewPassword => 'Ustaw nowe hasło';

  @override
  String get commonConfirmNewPassword => 'Potwierdź nowe hasło';

  @override
  String get commonNewPassword => 'Nowe hasło';

  @override
  String get authPasswordResetSuccess =>
      'Hasło zostało pomyślnie zresetowane. Zaloguj się nowym hasłem.';

  @override
  String get authResetPasswordFailed => 'Nie udało się zresetować hasła';

  @override
  String get settingsChangePassword => 'Zmień hasło';

  @override
  String get settingsCurrentPassword => 'Aktualne hasło';

  @override
  String get settingsEnterCurrentPassword => 'Wprowadź aktualne hasło';

  @override
  String get settingsEnterNewPassword => 'Wprowadź nowe hasło';

  @override
  String get settingsPasswordChanged =>
      'Hasło zostało pomyślnie zmienione. Zaloguj się nowym hasłem.';

  @override
  String get settingsChangePasswordFailed => 'Nie udało się zmienić hasła';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Nowe hasło musi się różnić od aktualnego';

  @override
  String get settingsChangePasswordInfo =>
      'Po zmianie hasła zostaniesz wylogowany i musisz zalogować się nowym hasłem.';

  @override
  String get settingsPasswordRequirements => 'Wymagania dotyczące hasła:';

  @override
  String get settingsSecurityNote =>
      'Ze względów bezpieczeństwa po zmianie hasła musisz zalogować się ponownie na wszystkich urządzeniach.';

  @override
  String get settingsSecurity => 'Bezpieczeństwo';

  @override
  String get settingsCurrentBoundEmail => 'Aktualnie powiązany e-mail';

  @override
  String get settingsNewEmailAddress => 'Nowy adres e-mail';

  @override
  String get settingsEnterNewEmail => 'Wprowadź nowy adres e-mail';

  @override
  String get settingsVerificationCode => 'Kod weryfikacyjny';

  @override
  String get settingsVerificationCodeSent => 'Kod weryfikacyjny wysłany';

  @override
  String get settingsCodeSentTo => 'Kod weryfikacyjny wysłany na';

  @override
  String get settingsDidNotReceiveCode => 'Nie otrzymałeś kodu?';

  @override
  String get settingsEmailChangedSuccess => 'E-mail został pomyślnie zmieniony';

  @override
  String get settingsChangeEmailFailed => 'Nie udało się zmienić adresu e-mail';

  @override
  String get settingsEmailSecurityNote =>
      'Twój e-mail jest używany do odzyskiwania hasła. Chroń go.';

  @override
  String get commonGoogleLogin => 'Zaloguj przez Google';

  @override
  String get commonAppleLogin => 'Zaloguj przez Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsLanguageChanged => 'Język zmieniony';

  @override
  String get settingsBiometricLogin => 'Logowanie biometryczne';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Zaloguj się za pomocą $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Logowanie biometryczne włączone';

  @override
  String get settingsBiometricLoginDisabled =>
      'Logowanie biometryczne wyłączone';

  @override
  String get settingsEnableBiometricLogin => 'Włącz logowanie biometryczne';

  @override
  String get settingsBiometricEnabled =>
      'Włączono - Użyj biometrii do logowania';

  @override
  String get settingsBiometricDisabled => 'Wyłączono - Dotknij, aby włączyć';

  @override
  String get settingsBiometricNeedRelogin =>
      'Wyloguj się i zaloguj ponownie, aby włączyć logowanie biometryczne';

  @override
  String get authOr => 'LUB';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Dostęp do kamery jest ograniczony na tym urządzeniu';

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
      'Wprowadź sufiks szturchnięcia, np.: w ramię';

  @override
  String get groupAlbum => 'Album grupy';

  @override
  String get groupFiles => 'Pliki grupy';

  @override
  String get groupImages => 'Obrazy';

  @override
  String get groupVideos => 'Filmy';

  @override
  String get groupTotal => 'Łącznie';

  @override
  String get groupSize => 'Rozmiar';

  @override
  String get groupNoMedia => 'Brak mediów';

  @override
  String get groupNoMediaDescription => 'Brak zdjęć i filmów w tej grupie';

  @override
  String get groupDocuments => 'Dokumenty';

  @override
  String get groupNoFiles => 'Brak plików';

  @override
  String get groupNoFilesDescription => 'Brak plików w tej grupie';

  @override
  String groupDownloadStarted(String filename) {
    return 'Pobieranie $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Brak wspólnych grup';

  @override
  String get contactNoCommonGroupsDescription => 'Nie macie wspólnych grup';

  @override
  String get chatVoiceMessage => 'Głos';

  @override
  String get chatMessage => 'Wiadomość';

  @override
  String get conversationHideChat => 'Ukryj';

  @override
  String get settingsQuickReply => 'Szybka odpowiedź';

  @override
  String get commonTranslate => 'Przetłumacz';

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
    return 'Rozmowa: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Kontakt: $userId';
  }

  @override
  String get commonDiscover => 'Odkrywaj';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Wkrotce)';
  }

  @override
  String get commonPageNotFound => 'Strona nie zostala znaleziona';

  @override
  String get commonBackToHome => 'Wroc do strony glownej';

  @override
  String get settingsMessageNotifications => 'Powiadomienia o wiadomościach';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Otrzymuj powiadomienia o nowych wiadomościach';

  @override
  String get settingsShowMessagePreview => 'Pokaż podgląd wiadomości';

  @override
  String get settingsShowMessageContentInNotification =>
      'Pokaż treść wiadomości w powiadomieniach';

  @override
  String get settingsNotificationSound => 'Dzwiek powiadomienia';

  @override
  String get settingsPlaySoundOnMessage =>
      'Odtwarzaj dzwiek przy odbiorze wiadomosci';

  @override
  String get commonVibration => 'Wibracje';

  @override
  String get settingsVibrateOnMessage => 'Wibruj przy odbiorze wiadomosci';

  @override
  String get settingsDoNotDisturbMode => 'Nie przeszkadzać';

  @override
  String get settingsDoNotDisturbDescription =>
      'Nie otrzymuj powiadomień w określonym czasie';

  @override
  String get settingsStartTime => 'Czas rozpoczecia';

  @override
  String get settingsEndTime => 'Czas zakonczenia';

  @override
  String get settingsDeleteQuickReply => 'Usuń szybką odpowiedź';

  @override
  String get settingsEditQuickReply => 'Edytuj szybką odpowiedź';

  @override
  String get settingsAddQuickReply => 'Dodaj szybką odpowiedź';

  @override
  String get settingsManageQuickReplies => 'Zarządzaj szybkimi odpowiedziami';

  @override
  String get settingsNoQuickReplies => 'Brak szybkich odpowiedzi';

  @override
  String get settingsDefaultQuickReplies =>
      'Zostaną wyświetlone domyślne szybkie odpowiedzi';

  @override
  String get settingsWhoCanSee => 'Kto moze zobaczyc';

  @override
  String get settingsLastSeen => 'Ostatnio widziany';

  @override
  String get settingsHiddenChats => 'Ukryte czaty';

  @override
  String get settingsMessagesLabel => 'Wiadomości';

  @override
  String get settingsAllowStrangerMessages =>
      'Zezwalaj na wiadomości od nieznajomych';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Otrzymuj wiadomości od osób spoza kontaktów';

  @override
  String get settingsReadReceipts => 'Potwierdzenia odczytu';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Pozwól innym wiedzieć, że przeczytałeś ich wiadomości';

  @override
  String get settingsTypingIndicator => 'Wskaźnik pisania';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Pozwól innym wiedzieć, że piszesz';

  @override
  String get settingsEveryone => 'Wszyscy';

  @override
  String get settingsContactsOnly => 'Tylko kontakty';

  @override
  String get settingsNobody => 'Nikt';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Kto może zobaczyć $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Wersja $version';
  }

  @override
  String get settingsCheckForUpdates => 'Sprawdź aktualizacje';

  @override
  String get settingsOpenSourceLicenses => 'Licencje open source';

  @override
  String get settingsFeedbackAndSuggestions => 'Opinie i sugestie';

  @override
  String get settingsBuiltOnMatrix => 'Oparty na protokole Matrix';

  @override
  String get settingsNoHiddenChats => 'Brak ukrytych czatów';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Ukryte czaty pojawią się tutaj';

  @override
  String get settingsUnhideChat => 'Pokaż';

  @override
  String get settingsDarkMode => 'Tryb ciemny';

  @override
  String get settingsFontSize => 'Rozmiar czcionki';

  @override
  String get settingsBubbleStyle => 'Styl dymków';

  @override
  String get settingsFollowSystem => 'Podążaj za systemem';

  @override
  String get settingsAutoSwitchBySystem =>
      'Automatycznie przełączaj według ustawień systemowych';

  @override
  String get settingsLightMode => 'Tryb jasny';

  @override
  String get settingsAlwaysUseLightTheme => 'Zawsze używaj jasnego motywu';

  @override
  String get settingsDarkModeOption => 'Tryb ciemny';

  @override
  String get settingsAlwaysUseDarkTheme => 'Zawsze używaj ciemnego motywu';

  @override
  String get settingsFontSizeSmall => 'Mały';

  @override
  String get settingsFontSizeStandard => 'Standardowy';

  @override
  String get settingsFontSizeLarge => 'Duży';

  @override
  String get settingsFontSizeExtraLarge => 'Bardzo duży';

  @override
  String get settingsBubbleStyleWechat => 'Styl WeChat';

  @override
  String get settingsBubbleStyleWechatDesc => 'Klasyczny styl dymków WeChat';

  @override
  String get settingsBubbleStyleModern => 'Styl nowoczesny';

  @override
  String get settingsBubbleStyleModernDesc => 'Czysty nowoczesny styl dymków';

  @override
  String get settingsBubbleStyleClassic => 'Styl klasyczny';

  @override
  String get settingsBubbleStyleClassicDesc => 'Tradycyjny styl dymków';

  @override
  String get discoverVideoChannels => 'Kanaly';

  @override
  String get discoverLive => 'Na zywo';

  @override
  String get discoverListen => 'Sluchaj';

  @override
  String get discoverWatch => 'Ogladaj';

  @override
  String get discoverSearchDiscover => 'Szukaj';

  @override
  String get discoverNearbyPeople => 'W poblizu';

  @override
  String get discoverGames => 'Gry';

  @override
  String get discoverMiniPrograms => 'Miniprogramy';

  @override
  String get chatAlreadyInCall => 'Juz trwa polaczenie';

  @override
  String get commonConnectionFailed => 'Polaczenie nie powiodlo sie';

  @override
  String get chatCallRejected => 'Polaczenie odrzucone';

  @override
  String get chatNoAnswer => 'Brak odpowiedzi';

  @override
  String get commonClose => 'Zamknij';

  @override
  String get chatSelectContact => 'Wybierz kontakt';

  @override
  String get chatVoteRemoved => 'Glos usuniety';

  @override
  String get chatVoteChanged => 'Glos zmieniony';

  @override
  String get chatVoted => 'Zaglosowano';

  @override
  String chatReplyTo(String name) {
    return 'Odpowiedz do $name';
  }

  @override
  String get chatCurrentLocation => 'Biezaca lokalizacja';

  @override
  String chatNearbyPlace(int index) {
    return 'Miejsce w poblizu $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Okolo $distance';
  }

  @override
  String get chatAddress => 'Adres';

  @override
  String get chatLatitude => 'Szerokosc geograficzna';

  @override
  String get chatLongitude => 'Dlugosc geograficzna';

  @override
  String get groupDescriptionUpdated => 'Opis grupy zaktualizowany';

  @override
  String get groupAvatarUpdated => 'Awatar grupy zaktualizowany';

  @override
  String get callDecline => 'Odrzuc';

  @override
  String get callAnswer => 'Odbierz';

  @override
  String get callIncomingVideoCall => 'Przychodzące połączenie wideo';

  @override
  String get callIncomingVoiceCall => 'Przychodzące połączenie głosowe';

  @override
  String get callVideoCallInProgress => 'Połączenie wideo';

  @override
  String get callVoiceCallInProgress => 'Połączenie głosowe';

  @override
  String get callReconnectingCall => 'Ponowne łączenie...';

  @override
  String get callEnded => 'Połączenie zakończone';

  @override
  String get callFailed => 'Połączenie nieudane';

  @override
  String get callLivekitNotConfigured => 'LiveKit nie jest skonfigurowany';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Nie udalo sie dolaczyc do spotkania: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Udostepnianie ekranu nie powiodlo sie: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Brak N42 Bean';

  @override
  String get profileN42BeanDetails => 'Szczegóły N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean to token do wymiany na wirtualne przedmioty i usługi w N42. Obecnie dostępne:';

  @override
  String get profileN42BeanFeature1 =>
      'Ekskluzywne naklejki i motywy dla członków';

  @override
  String get profileN42BeanFeature2 => 'Personalizacja dymków czatu';

  @override
  String get profileN42BeanFeature3 =>
      'Personalizacja okładek czerwonych kopert';

  @override
  String get profileN42BeanFeature4 => 'Ekskluzywna odznaka pseudonimu';

  @override
  String get profileN42BeanFeature5 => 'Przywileje czatu grupowego';

  @override
  String get profileN42BeanFeature6 => 'Rozszerzenie pamięci w chmurze';

  @override
  String get profileN42BeanFeature7 => 'Filtry upiększające do rozmów wideo';

  @override
  String get profileN42BeanFeature8 => 'Personalizacja tła Moments';

  @override
  String get profileN42BeanFeature9 => 'Priorytetowa obsługa klienta VIP';

  @override
  String get profileGotIt => 'Rozumiem';

  @override
  String get profileNoN42BeanRecords => 'Brak rekordów N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Nastroj i mysli';

  @override
  String get profileStatusHappy => 'Szczesliwy';

  @override
  String get profileStatusCracked => 'Rozbity';

  @override
  String get profileStatusLucky => 'Szczęsliwy';

  @override
  String get profileStatusSunny => 'Sloneczny';

  @override
  String get profileStatusTired => 'Zmęczony';

  @override
  String get profileStatusDaydream => 'Marzenia na jawie';

  @override
  String get profileStatusRushing => 'W pospichu';

  @override
  String get profileStatusOverthinking => 'Zamyslony';

  @override
  String get profileStatusEnergized => 'Pelen energii';

  @override
  String get profileWorkAndStudy => 'Praca i nauka';

  @override
  String get profileStatusWorking => 'Pracuje';

  @override
  String get profileStatusStudying => 'Ucze sie';

  @override
  String get profileStatusBusy => 'Zajety';

  @override
  String get profileStatusSlacking => 'Obijam sie';

  @override
  String get profileStatusTraveling => 'Podrozuje';

  @override
  String get profileStatusGoingHome => 'Wracam do domu';

  @override
  String get profileStatusDnd => 'Nie przeszkadzac';

  @override
  String get profileActivities => 'Aktywnosci';

  @override
  String get profileStatusHanging => 'Spotykam sie';

  @override
  String get profileStatusCheckIn => 'Meldunek';

  @override
  String get profileStatusExercising => 'Cwicze';

  @override
  String get profileStatusCoffee => 'Kawa';

  @override
  String get profileStatusBubbleTea => 'Bubble tea';

  @override
  String get profileStatusEating => 'Jem';

  @override
  String get profileStatusParenting => 'Opieka nad dziecmi';

  @override
  String get profileStatusSavingWorld => 'Ratuje swiat';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Odpoczynek';

  @override
  String get profileStatusRetreat => 'Odwrot';

  @override
  String get profileStatusHome => 'W domu';

  @override
  String get profileStatusSleeping => 'Spie';

  @override
  String get profileStatusCatLover => 'Kociarz';

  @override
  String get profileStatusDogWalking => 'Spacer z psem';

  @override
  String get profileStatusGaming => 'Gram';

  @override
  String get profileStatusListening => 'Slucham';

  @override
  String get profileEditAddress => 'Edytuj adres';

  @override
  String get profileRecipient => 'Odbiorca';

  @override
  String get profileEnterRecipientName => 'Wprowadz nazwe odbiorcy';

  @override
  String get profilePhoneNumber => 'Numer telefonu';

  @override
  String get profileEnterPhoneNumber => 'Wprowadz numer telefonu';

  @override
  String get profileRegionHint => 'Wojewodztwo/Miasto/Dzielnica';

  @override
  String get profileDetailedAddress => 'Szczegolowy adres';

  @override
  String get profileDetailedAddressHint => 'Ulica, numer budynku itp.';

  @override
  String get profileSetAsDefaultAddress => 'Ustaw jako domyslny adres';

  @override
  String get profilePleaseCompleteInfo => 'Wypelnij wszystkie pola';

  @override
  String get profileEditInvoice => 'Edytuj fakture';

  @override
  String get profileInvoiceType => 'Typ faktury: ';

  @override
  String get profileCompanyName => 'Nazwa firmy';

  @override
  String get profilePersonalName => 'Imie i nazwisko';

  @override
  String get profileEnterCompanyName => 'Wprowadz nazwe firmy';

  @override
  String get profileEnterName => 'Wprowadz imie i nazwisko';

  @override
  String get profileTaxIdNumber => 'Numer NIP';

  @override
  String get profileEnterTaxIdNumber => 'Wprowadz numer NIP';

  @override
  String get profileBankNameOptional => 'Nazwa banku (opcjonalna)';

  @override
  String get profileEnterBankName => 'Wprowadz nazwe banku';

  @override
  String get profileBankAccountOptional => 'Numer konta bankowego (opcjonalny)';

  @override
  String get profileEnterBankAccount => 'Wprowadz numer konta bankowego';

  @override
  String get profileCompanyAddressOptional => 'Adres firmy (opcjonalny)';

  @override
  String get profileEnterCompanyAddress => 'Wprowadz adres firmy';

  @override
  String get profileCompanyPhoneOptional => 'Telefon firmy (opcjonalny)';

  @override
  String get profileEnterCompanyPhone => 'Wprowadz telefon firmy';

  @override
  String get profileSetAsDefaultInvoice => 'Ustaw jako domyslna fakture';

  @override
  String get profileRingtoneVibrate => 'Wibracja';

  @override
  String get profileRingtoneSilent => 'Cichy';

  @override
  String get profileVibrateMode => 'Tryb wibracji';

  @override
  String get profileSilentMode => 'Tryb cichy';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Nie udalo sie odtworzyc: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Odtwarzanie: $ringtoneName';
  }

  @override
  String get profileStop => 'Zatrzymaj';

  @override
  String get profileSelectRingtone => 'Wybierz dzwonek';

  @override
  String get profileLoadingRingtones => 'Ladowanie dzwonkow...';

  @override
  String get profileNoRingtonesFound => 'Nie znaleziono dzwonkow';

  @override
  String mainMessagesWithCount(int count) {
    return 'Wiadomosci($count)';
  }

  @override
  String get storyViewers => 'Widzowie';

  @override
  String get storyNoViewers => 'Brak widzów';

  @override
  String get storyReplyToStory => 'Odpowiedz na relację...';

  @override
  String get commonCopiedToClipboard => 'Skopiowano do schowka';

  @override
  String get commonMore => 'Wiecej';

  @override
  String get commonTranslating => 'Tłumaczenie...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Przetłumaczono z $language';
  }

  @override
  String get commonTranslation => 'Tłumaczenie';

  @override
  String get commonTranslationFailed => 'Tłumaczenie nie powiodło się';

  @override
  String get commonAllRead => 'Wszystko przeczytane';

  @override
  String commonReadCount(int count) {
    return '$count przeczytane';
  }

  @override
  String get commonYouRecalledMessage => 'Wycofales wiadomosc';

  @override
  String get commonMessageRecalled => 'Wiadomosc wycofana';

  @override
  String get commonReEdit => 'Edytuj ponownie';

  @override
  String get commonWalletArea => 'Strefa portfela';

  @override
  String get callIncomingCall => 'Polaczenie przychodzace';

  @override
  String get callMissedCall => 'Nieodebrane polaczenie';

  @override
  String get groupRemoveAdmin => 'Usun administratora';

  @override
  String get chatSelectCurrency => 'Wybierz walute';

  @override
  String get chatSelectEmoji => 'Wybierz emotikon';

  @override
  String get chatSelectRedPacketCover => 'Wybierz okładkę';

  @override
  String get groupSetAsAdmin => 'Ustaw jako administratora';

  @override
  String get chatVideoPlaybackFailed => 'Odtwarzanie wideo nie powiodlo sie';

  @override
  String get groupViewProfile => 'Zobacz profil';

  @override
  String get favoriteAddLinkComingSoon => 'Dodawanie linkow wkrotce dostepne';

  @override
  String get favoriteNewNoteComingSoon => 'Nowa notatka wkrotce dostepna';

  @override
  String get qrcodeSaveFeatureComingSoon =>
      'Funkcja zapisywania wkrotce dostepna';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Funkcja udostepniania wkrotce dostepna';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Nie udalo sie przetworzyc kodu QR: $error';
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

  @override
  String get momentVisibilityPublic => '公开';

  @override
  String get momentVisibilityPrivate => '私密';

  @override
  String get momentVisibilityPartial => '部分可见';

  @override
  String get momentVisibilityExcluded => '不给谁看';

  @override
  String momentUserMoments(String userName) {
    return '$userName的朋友圈';
  }

  @override
  String get momentForwardTo => '转发给';

  @override
  String get momentForwardSuccess => '转发成功';

  @override
  String get momentSelectFriends => '选择好友';

  @override
  String get momentSelectTags => '按标签选择';

  @override
  String momentSelectedCount(int count) {
    return '已选择 ($count)';
  }

  @override
  String get momentNoMomentsYet => '暂无动态';

  @override
  String get momentForwardMoment => '转发动态';

  @override
  String get momentAddComment => '写评论...';

  @override
  String momentForwardContent(String content) {
    return '[朋友圈] $content';
  }

  @override
  String get momentDeleteMoment => '删除动态';

  @override
  String get momentDeleteConfirm => '确定要删除这条动态吗？';

  @override
  String get momentComment => '评论';

  @override
  String get momentWriteComment => '写评论...';

  @override
  String get momentLike => '赞';

  @override
  String get momentUnlike => '取消';

  @override
  String get momentForward => '转发';

  @override
  String get momentDelete => '删除';

  @override
  String get momentReply => '回复';

  @override
  String get momentMoment => '动态';

  @override
  String momentLikesCount(int count) {
    return '$count 个赞';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count 条评论';
  }

  @override
  String get momentNoComments => '暂无评论';

  @override
  String get momentFailedToLoad => '图片加载失败';

  @override
  String momentReplyTo(String userName) {
    return '回复 $userName...';
  }

  @override
  String get momentNoConversations => '暂无会话';

  @override
  String get momentJustNow => '刚刚';

  @override
  String momentMinutesAgo(int count) {
    return '$count分钟前';
  }

  @override
  String momentHoursAgo(int count) {
    return '$count小时前';
  }

  @override
  String momentDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String get chatGroupAnnouncementHint => '输入群公告';

  @override
  String get chatGroupAnnouncementEmpty => '暂无群公告';

  @override
  String get chatEditNickname => '编辑群昵称';

  @override
  String get chatNicknameHint => '输入你在群里的昵称';

  @override
  String get contactAddPhoneHint => '输入电话号码';

  @override
  String get contactNotesHint => '添加联系人备忘';

  @override
  String get reportTitle => '投诉';

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonHarassment => '骚扰';

  @override
  String get reportReasonFraud => '欺诈';

  @override
  String get reportReasonOther => '其他';

  @override
  String get reportSubmitted => '投诉已提交';

  @override
  String get reportDescription => '补充说明（选填）';

  @override
  String get qrcodeSaved => '二维码已保存到相册';

  @override
  String get chatSendRedPacketInChat => '请在聊天中发送红包';

  @override
  String get commonSaveFailed => '保存失败';

  @override
  String get reportSelectReason => '请选择投诉原因';

  @override
  String get gameCenter => 'Gry';

  @override
  String get gameHighScore => 'Najlepszy';

  @override
  String get gameScore => 'Wynik';

  @override
  String get gameOver => 'Koniec gry';

  @override
  String get gamePlayAgain => 'Zagraj ponownie';

  @override
  String get gameLeaderboard => 'Ranking';

  @override
  String get gamePause => 'Pauza';

  @override
  String get gameResume => 'Dotknij, aby wznowić';

  @override
  String get gameConfirmExit => 'Wyjść z gry?';

  @override
  String get gameNoScores => 'Brak wyników';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Łącz kafelki, aby osiągnąć 2048';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Upuszczaj i usuwaj linie';

  @override
  String get gameMinesweeper => 'Saper';

  @override
  String get gameMinesweeperDesc => 'Znajdź wszystkie bezpieczne pola';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => 'Połącz 3 lub więcej klejnotów';

  @override
  String get gameMinesweeperEasy => 'Łatwy';

  @override
  String get gameMinesweeperMedium => 'Średni';

  @override
  String get gameMinesLeft => 'Pozostałe miny';

  @override
  String get gameTimeLeft => 'Czas';

  @override
  String get gameLevel => 'Poziom';

  @override
  String get gameNext => 'Następny';

  @override
  String get gameBestTime => 'Najlepszy czas';

  @override
  String get gameNewRecord => 'Nowy rekord!';

  @override
  String get gameLines => 'Linie';

  @override
  String get storyMyStory => '我的动态';
}
