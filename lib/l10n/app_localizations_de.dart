// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonUnknownUser => 'Unbekannter Benutzer';

  @override
  String get transferWalletNotConnected => 'Wallet nicht verbunden';

  @override
  String get chatCallServiceNotInitialized => 'Anrufdienst nicht initialisiert';

  @override
  String authLoginFailed(String error) {
    return 'Anmeldung fehlgeschlagen: $error';
  }

  @override
  String get chatCallBack => 'Zurückrufen';

  @override
  String get chatMissedVideoCall => 'Verpasster Videoanruf';

  @override
  String get chatMissedVoiceCall => 'Verpasster Sprachanruf';

  @override
  String get chatCallNotAnswered => 'Nicht beantwortet';

  @override
  String get chatCallDurationLabel => 'Anrufdauer';

  @override
  String get chatVoiceCallCancelled => 'Sprachanruf abgebrochen';

  @override
  String get chatVideoCallCancelled => 'Videoanruf abgebrochen';

  @override
  String get commonImage => '[Bild]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Sprachnachricht]';

  @override
  String get commonFile => '[Datei]';

  @override
  String get chatLocation => '[Standort]';

  @override
  String get chatUnknownMessage => '[Unbekannte Nachricht]';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get chatDeleteThisMessage => 'Diese Nachricht löschen?';

  @override
  String get chatMessageDeleted => 'Nachricht gelöscht';

  @override
  String get profileNotLoggedIn => 'Nicht angemeldet';

  @override
  String get chatMyLocation => 'Mein Standort';

  @override
  String get commonGroupChat => 'Gruppenchat';

  @override
  String get commonSearch => 'Suchen';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonLoadFailed => 'Laden fehlgeschlagen';

  @override
  String get commonMessages => 'Nachrichten';

  @override
  String get commonContacts => 'Kontakte';

  @override
  String get commonMe => 'Ich';

  @override
  String get commonVoiceLoading =>
      'Sprachnachricht wird geladen, bitte später erneut versuchen';

  @override
  String get commonVoiceToTextFailed => 'Sprache zu Text fehlgeschlagen';

  @override
  String get commonConvertToText => 'In Text';

  @override
  String get chatCopy => 'Kopieren';

  @override
  String get commonForward => 'Weiterleiten';

  @override
  String get commonUnfavorite => 'Favorit entfernen';

  @override
  String get commonFavorite => 'Favorit';

  @override
  String get settingsResend => 'Erneut senden';

  @override
  String get chatRecall => 'Zurückrufen';

  @override
  String get commonQuote => 'Zitieren';

  @override
  String get commonRemind => 'Erinnern';

  @override
  String get chatCopied => 'Kopiert';

  @override
  String get storySendMessageHint => 'Nachricht senden';

  @override
  String get commonMicrophonePermissionRequired =>
      'Bitte Mikrofonberechtigung erlauben';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Aufnahme starten fehlgeschlagen: $error';
  }

  @override
  String get commonRecordingTooShort => 'Aufnahme zu kurz';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Aufnahme stoppen fehlgeschlagen: $error';
  }

  @override
  String get chatReleaseToCancel => 'Loslassen zum Abbrechen';

  @override
  String get chatReleaseToSend =>
      'Loslassen zum Senden, nach oben wischen zum Abbrechen';

  @override
  String get commonHoldToTalk => 'Halten zum Sprechen';

  @override
  String get commonSend => 'Senden';

  @override
  String get commonAddFriend => 'Freund hinzufügen';

  @override
  String get commonChatServiceNotConnected => 'Chat-Dienst nicht verbunden';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Benutzer \"$query\" nicht gefunden\n\nTipps:\n• Versuchen Sie die vollständige Benutzer-ID einzugeben, z.B. @benutzername:server.com\n• Überprüfen Sie die Schreibweise des Benutzernamens';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Chat erstellen fehlgeschlagen: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Suche fehlgeschlagen: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Benutzer-ID oder Benutzernamen eingeben';

  @override
  String get contactSearching => 'Suche...';

  @override
  String get contactSearchUserToChat => 'Benutzer suchen um zu chatten';

  @override
  String get contactMatrixIdExample =>
      'Sie können eine vollständige Matrix-ID eingeben\nz.B. @benutzer:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Benutzer \"$username\" nicht gefunden';
  }

  @override
  String get commonChat => 'Chat';

  @override
  String get commonSettings => 'Einstellungen';

  @override
  String get profileEditProfile => 'Profil bearbeiten';

  @override
  String get authLogin => 'Anmelden';

  @override
  String get commonCreateGroup => 'Gruppe erstellen';

  @override
  String get chatError => 'Fehler';

  @override
  String get commonTransfer => 'Überweisung';

  @override
  String get commonReceived => 'Empfangen';

  @override
  String get commonRefunded => 'Erstattet';

  @override
  String get commonExpired => 'Abgelaufen';

  @override
  String get chatRedPacketGreeting => 'Beste Wünsche';

  @override
  String get commonN42RedPacket => 'N42 Rotes Paket';

  @override
  String get commonClaimed => 'Eingelöst';

  @override
  String get commonAllClaimed => 'Alle eingelöst';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Antworten';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get chatSelectForwardTarget => 'Empfänger auswählen';

  @override
  String commonSendCount(int count) {
    return 'Senden ($count)';
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
  String get contactFriendInfo => 'Freund-Info';

  @override
  String get contactFriendInfoDesc =>
      'Bemerkung, Telefon, Tags, Notizen, Fotos hinzufügen und Berechtigungen festlegen.';

  @override
  String get commonMoments => 'Momente';

  @override
  String get commonSendMessage => 'Nachricht';

  @override
  String get contactAudioVideoCall => 'Audio-/Videoanruf';

  @override
  String get contactVideoChannel => 'Videokanal';

  @override
  String get contactRemark => 'Bemerkung';

  @override
  String get contactRemarkName => 'Bemerkungsname';

  @override
  String get contactPhone => 'Telefon';

  @override
  String get contactTags => 'Tags';

  @override
  String get contactNotes => 'Notizen';

  @override
  String get contactPhotos => 'Fotos';

  @override
  String get contactPermissions => 'Berechtigungen';

  @override
  String get contactChatMomentsEtc => 'Chat, Momente, Sport, etc.';

  @override
  String get contactMoreInfo => 'Mehr Info';

  @override
  String get contactCommonGroups => 'Gemeinsame Gruppen';

  @override
  String get contactSource => 'Quelle';

  @override
  String get settingsNotificationSettings => 'Benachrichtigungen';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsAppearance => 'Erscheinungsbild';

  @override
  String get settingsAbout => 'Über';

  @override
  String get commonLogout => 'Abmelden';

  @override
  String get commonLogoutConfirm => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get commonSave => 'Speichern';

  @override
  String get profileNickname => 'Spitzname';

  @override
  String get profileEnterNickname => 'Spitzname eingeben';

  @override
  String get profileSignature => 'Signatur';

  @override
  String get profileAddSignature => 'Signatur hinzufügen';

  @override
  String get commonTakePhoto => 'Foto aufnehmen';

  @override
  String get profileChooseFromGallery => 'Aus Galerie wählen';

  @override
  String profileSaveFailed(String error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'Sichere, dezentrale Kommunikation';

  @override
  String get commonEndToEndEncryption => 'Ende-zu-Ende-Verschlüsselung';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Nachrichten nur für Sie und den Empfänger sichtbar';

  @override
  String get authDecentralized => 'Dezentral';

  @override
  String get authBasedOnMatrix => 'Basierend auf dem offenen Matrix-Protokoll';

  @override
  String get authWalletIntegration => 'Wallet-Integration';

  @override
  String get authEasyCryptoTransfer => 'Einfache Kryptowährungstransfers';

  @override
  String get authRegister => 'Registrieren';

  @override
  String get authAgreeTerms => 'Mit der Anmeldung stimmen Sie zu';

  @override
  String get authTermsOfService => 'Nutzungsbedingungen';

  @override
  String get authAnd => 'und';

  @override
  String get authPrivacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get authServerAddress => 'Serveradresse';

  @override
  String get authEnterServerAddress => 'Serveradresse eingeben';

  @override
  String authConnectedTo(String serverName) {
    return 'Verbunden mit $serverName';
  }

  @override
  String get authUsername => 'Benutzername';

  @override
  String get authEnterUsername => 'Benutzername eingeben';

  @override
  String get authUsernameOrEmail => 'Benutzername oder E-Mail';

  @override
  String get authEnterUsernameOrEmail => 'Benutzername oder E-Mail eingeben';

  @override
  String get authPassword => 'Passwort';

  @override
  String get authEnterPassword => 'Passwort eingeben';

  @override
  String get authRegisterAccount => 'Registrieren';

  @override
  String get authForgotPassword => 'Passwort vergessen';

  @override
  String get authOtherLoginMethods => 'Andere Anmeldemethoden';

  @override
  String get authCreateAccount => 'Konto erstellen';

  @override
  String get authJoinN42Chat => 'N42 Chat beitreten und loschatten';

  @override
  String get authUsernameHint => '3-20 Zeichen, Buchstaben/Zahlen/_';

  @override
  String get authUsernameMinLength =>
      'Benutzername muss mindestens 3 Zeichen haben';

  @override
  String get authUsernameMaxLength =>
      'Benutzername darf maximal 20 Zeichen haben';

  @override
  String get authUsernameFormat =>
      'Benutzername darf nur Buchstaben, Zahlen und Unterstriche enthalten';

  @override
  String get authPasswordHint => 'Min. 8 Zeichen';

  @override
  String get commonPasswordMinLength =>
      'Passwort muss mindestens 8 Zeichen haben';

  @override
  String get authConfirmPassword => 'Passwort bestätigen';

  @override
  String get authFilled => 'Ausgefüllt';

  @override
  String get authEnterInviteCode => 'Einladungscode eingeben';

  @override
  String get authAlreadyHaveAccount => 'Bereits ein Konto?';

  @override
  String get authLoginNow => 'Jetzt anmelden';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Status';

  @override
  String get commonLoading => 'Laden...';

  @override
  String get conversationNoConversations => 'Keine Unterhaltungen';

  @override
  String get conversationTapToChat => 'Tippen Sie oben rechts um zu chatten';

  @override
  String get conversationStartGroup => 'Gruppenchat starten';

  @override
  String get commonScan => 'Scannen';

  @override
  String get commonPayment => 'Zahlung';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature demnächst verfügbar';
  }

  @override
  String get conversationMarkAsRead => 'Als gelesen markieren';

  @override
  String get commonUnmute => 'Stummschaltung aufheben';

  @override
  String get commonMute => 'Stummschalten';

  @override
  String get conversationUnpin => 'Lösen';

  @override
  String get conversationPin => 'Anheften';

  @override
  String get conversationDeleteConversation => 'Unterhaltung löschen';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Unterhaltung mit \"$name\" löschen?';
  }

  @override
  String get commonNoContacts => 'Keine Kontakte';

  @override
  String get contactAddFriendsToChat => 'Freunde hinzufügen um zu chatten';

  @override
  String get contactNotFound => 'Kontakt nicht gefunden';

  @override
  String get contactTryOtherKeywords =>
      'Andere Stichwörter oder globale Suche versuchen';

  @override
  String get contactSearchResults => 'Suchergebnisse';

  @override
  String get contactNewFriends => 'Neue Freunde';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Offizielle Konten';

  @override
  String get contactServiceAccounts => 'Service-Konten';

  @override
  String get contactEnterpriseContacts => 'Unternehmenskontakte';

  @override
  String get contactRecommendToFriend => 'Kontakt teilen';

  @override
  String get commonSetRemark => 'Bemerkung festlegen';

  @override
  String get contactSendingCard => 'Kontaktkarte wird gesendet...';

  @override
  String get commonFileLabel => 'Datei';

  @override
  String get commonLocationLabel => 'Standort';

  @override
  String contactRecommendFailed(String error) {
    return 'Empfehlung fehlgeschlagen: $error';
  }

  @override
  String get profileEnterRemark => 'Bemerkung eingeben';

  @override
  String get contactOpeningChat => 'Chat wird geöffnet...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Chat öffnen fehlgeschlagen: $error';
  }

  @override
  String get contactAddContact => 'Kontakt hinzufügen';

  @override
  String get contactEnterUserId => 'Benutzer-ID eingeben';

  @override
  String get contactNoFriendRequests => 'Keine Freundschaftsanfragen';

  @override
  String get commonAccept => 'Annehmen';

  @override
  String get commonReject => 'Ablehnen';

  @override
  String get commonNoGroups => 'Keine Gruppen';

  @override
  String get contactSelectFriendToRecommend => 'Freund zum Empfehlen auswählen';

  @override
  String get commonSearchContacts => 'Kontakte suchen';

  @override
  String get contactNoContactsFound => 'Keine Kontakte gefunden';

  @override
  String get favoriteYesterday => 'Gestern';

  @override
  String get chatJustNow => 'Gerade eben';

  @override
  String get profileOnline => 'Online';

  @override
  String get profileOffline => 'Offline';

  @override
  String get searchContactsGroupsMessages =>
      'Kontakte, Gruppen, Nachrichten suchen';

  @override
  String get searchError => 'Suchfehler';

  @override
  String get chatSearchHint => 'Kontakte, Gruppen und Nachrichten suchen';

  @override
  String get searchHistory => 'Suchverlauf';

  @override
  String get commonClear => 'Löschen';

  @override
  String get commonAll => 'Alle';

  @override
  String get searchGroups => 'Gruppen';

  @override
  String get searchNoResults => 'Keine Ergebnisse';

  @override
  String commonGroupMembers(int count) {
    return 'Mitglieder ($count)';
  }

  @override
  String get groupMembersTitle => 'Gruppenmitglieder';

  @override
  String get groupViewAll => 'Alle anzeigen';

  @override
  String get groupOwner => 'Eigentümer';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Einladen';

  @override
  String get commonGroupAnnouncement => 'Gruppenankündigung';

  @override
  String get commonNotSet => 'Nicht festgelegt';

  @override
  String get groupDescription => 'Gruppenbeschreibung';

  @override
  String get groupPublicGroup => 'Öffentliche Gruppe';

  @override
  String get commonClearChatHistory => 'Chatverlauf löschen';

  @override
  String get commonDissolveGroup => 'Gruppe auflösen';

  @override
  String get commonLeaveGroup => 'Gruppe verlassen';

  @override
  String get groupChangeGroupName => 'Gruppennamen ändern';

  @override
  String get commonEnterGroupName => 'Gruppenname eingeben';

  @override
  String get commonConfirm => 'Bestätigen';

  @override
  String get groupEnterGroupDescription => 'Gruppenbeschreibung eingeben';

  @override
  String get groupPublish => 'Veröffentlichen';

  @override
  String get chatClearHistoryConfirm =>
      'Gesamten Chatverlauf löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get chatClearAction => 'Löschen';

  @override
  String get commonChatHistoryCleared => 'Chatverlauf gelöscht';

  @override
  String get commonDissolve => 'Auflösen';

  @override
  String get groupQrCode => 'Gruppen-QR-Code';

  @override
  String get commonSearchChatHistory => 'Chatverlauf durchsuchen';

  @override
  String get groupIdCopied => 'Gruppen-ID kopiert';

  @override
  String get transferEnterOrPasteAddress =>
      'Wallet-Adresse eingeben oder einfügen';

  @override
  String get transferSelectToken => 'Token auswählen';

  @override
  String get commonTransferAmount => 'Überweisungsbetrag';

  @override
  String get transferAvailable => 'Verfügbar';

  @override
  String get transferMemoOptional => 'Memo (optional)';

  @override
  String get transferConfirmTransfer => 'Überweisung bestätigen';

  @override
  String get transferAddressVerified => 'Adresse verifiziert';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Verfügbar: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Betrag eingeben';

  @override
  String get commonRedPacketCountMin => 'Mindestens 1 rotes Paket erforderlich';

  @override
  String get commonViewRedPacketDetails => 'Rotes-Paket-Details anzeigen';

  @override
  String get commonEnterTransferAmount => 'Überweisungsbetrag eingeben';

  @override
  String get commonTransferTo => 'Überweisen an';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'Von $senderName';
  }

  @override
  String get commonConfirmReceive => 'Empfang bestätigen';

  @override
  String get groupProfile => 'Gruppeninfo';

  @override
  String get groupRemoveMember => 'Aus Gruppe entfernen';

  @override
  String get commonRemove => 'Entfernen';

  @override
  String get profileClearStatus => 'Status löschen';

  @override
  String get profileClearStatusConfirm => 'Aktuellen Status löschen?';

  @override
  String get profileStatusCleared => 'Status gelöscht';

  @override
  String get profileUserNotExist => 'Benutzer existiert nicht';

  @override
  String get profileUserIdCopied => 'Benutzer-ID kopiert';

  @override
  String get commonReport => 'Melden';

  @override
  String get profileQrCode => 'QR-Code';

  @override
  String get profileAvatarUpdated => 'Avatar aktualisiert';

  @override
  String commonSelectImageFailed(String error) {
    return 'Bildauswahl fehlgeschlagen: $error';
  }

  @override
  String get profileChangeName => 'Namen ändern';

  @override
  String get profileMale => 'Männlich';

  @override
  String get profileFemale => 'Weiblich';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature in Entwicklung...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Adresse speichern fehlgeschlagen: $error';
  }

  @override
  String get profileAddNew => 'Hinzufügen';

  @override
  String get profileAddAddress => 'Adresse hinzufügen';

  @override
  String get profileAddressAdded => 'Adresse hinzugefügt';

  @override
  String get profileAddressUpdated => 'Adresse aktualisiert';

  @override
  String get profileDeleteAddress => 'Adresse löschen';

  @override
  String get profileAddressDeleted => 'Adresse gelöscht';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Rechnung speichern fehlgeschlagen: $error';
  }

  @override
  String get profileMyInvoices => 'Meine Rechnungen';

  @override
  String get profileAddInvoice => 'Rechnung hinzufügen';

  @override
  String get profileInvoiceAdded => 'Rechnung hinzugefügt';

  @override
  String get profileInvoiceUpdated => 'Rechnung aktualisiert';

  @override
  String get profileDeleteInvoice => 'Rechnung löschen';

  @override
  String get profileInvoiceDeleted => 'Rechnung gelöscht';

  @override
  String get profilePersonal => 'Persönlich';

  @override
  String get groupSelectAtLeastOne => 'Bitte mindestens ein Mitglied auswählen';

  @override
  String get chatFileNotExist => 'Datei existiert nicht';

  @override
  String chatSendFailed(String error) {
    return 'Senden fehlgeschlagen: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Browser kann nicht geöffnet werden';

  @override
  String chatSelectFileFailed(String error) {
    return 'Dateiauswahl fehlgeschlagen: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Einrichtung fehlgeschlagen: $error';
  }

  @override
  String get transferEnterValidAmount =>
      'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get commonAddressCopied => 'Adresse kopiert';

  @override
  String favoriteOpenItem(String content) {
    return 'Öffnen: $content';
  }

  @override
  String get favoriteDeleted => 'Gelöscht';

  @override
  String get profileWallet => 'Wallet';

  @override
  String get chatRecording => 'Aufnahme';

  @override
  String get chatInvalidVideoUrl => 'Ungültige Video-URL';

  @override
  String get chatDownloadFile => 'Datei herunterladen';

  @override
  String get chatClearChatHistoryTitle => 'Chatverlauf löschen';

  @override
  String get chatVideoCall => 'Videoanruf';

  @override
  String get commonVoiceCall => 'Sprachanruf';

  @override
  String get callLeaveMeeting => 'Meeting verlassen';

  @override
  String get chatDetails => 'Chat-Details';

  @override
  String get chatViewAllGroupMembers => 'Alle Mitglieder anzeigen';

  @override
  String get chatGroupName => 'Gruppenname';

  @override
  String get chatGroupNameUpdated => 'Gruppenname aktualisiert';

  @override
  String get chatUpdateFailed => 'Aktualisierung fehlgeschlagen';

  @override
  String get chatNoPermissionToModify =>
      'Sie haben keine Berechtigung zu ändern';

  @override
  String get chatGroupManagement => 'Gruppenverwaltung';

  @override
  String get chatMyNicknameInGroup => 'Mein Spitzname in der Gruppe';

  @override
  String get chatPinChat => 'Chat anheften';

  @override
  String get chatStrongReminder => 'Starke Erinnerung';

  @override
  String get chatSetChatBackground => 'Chat-Hintergrund festlegen';

  @override
  String get chatUnknownFile => 'Unbekannte Datei';

  @override
  String get chatDownload => 'Herunterladen';

  @override
  String get chatInvalidLocation => 'Ungültiger Standort';

  @override
  String get chatTapToCancel => 'Tippen zum Abbrechen';

  @override
  String chatCaptureFailed(Object error) {
    return 'Aufnahme fehlgeschlagen: $error';
  }

  @override
  String get chatProcessingVideo => 'Video wird verarbeitet...';

  @override
  String get chatVideoFileNotExist => 'Videodatei existiert nicht';

  @override
  String get chatVideoDataEmpty => 'Videodaten sind leer';

  @override
  String get chatVideoTooLarge => 'Videogröße darf 100MB nicht überschreiten';

  @override
  String get chatSendingVideo => 'Video wird gesendet...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Video senden fehlgeschlagen: $error';
  }

  @override
  String get chatImageFileNotExist => 'Bilddatei existiert nicht';

  @override
  String get commonImageDataEmpty => 'Bilddaten sind leer';

  @override
  String get chatSendingImage => 'Bild wird gesendet...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Bild senden fehlgeschlagen: $error';
  }

  @override
  String get chatSendLocation => 'Standort senden';

  @override
  String get chatSelectLocationAndSend => 'Standort auswählen und senden';

  @override
  String get chatShareRealTimeLocation => 'Echtzeit-Standort teilen';

  @override
  String get chatShareLocationForOneHour =>
      'Echtzeit-Standort 1 Stunde mit Freund teilen';

  @override
  String get chatLocationSent => 'Standort gesendet';

  @override
  String get chatSelectMessages => 'Nachrichten auswählen';

  @override
  String chatSelectedCount(int count) {
    return '$count ausgewählt';
  }

  @override
  String get chatSelectAll => 'Alle auswählen';

  @override
  String chatGroupChatCount(int count) {
    return 'Gruppenchat ($count)';
  }

  @override
  String get chatPrivateChat => 'Privater Chat';

  @override
  String get chatNoMessages => 'Keine Nachrichten';

  @override
  String get chatSendFirstMessage => 'Erste Nachricht senden um zu chatten';

  @override
  String get chatEncryptionNotice =>
      'Dieser Chat ist Ende-zu-Ende-verschlüsselt. Nur Sie und der Empfänger können die Nachrichten lesen.';

  @override
  String get chatMultiForward => 'Weiterleiten';

  @override
  String get chatCollect => 'Sammeln';

  @override
  String get chatNoMembers => 'Keine Mitglieder';

  @override
  String get chatMemberNotFound => 'Mitglied nicht gefunden';

  @override
  String get chatVoiceFileNotExist => 'Sprachdatei existiert nicht';

  @override
  String get chatVoiceFileEmpty => 'Sprachdatei ist leer';

  @override
  String get chatSendingVoice => 'Sprachnachricht wird gesendet...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Sprachnachricht senden fehlgeschlagen: $error';
  }

  @override
  String get chatMessageForwarded => 'Nachricht weitergeleitet';

  @override
  String chatForwardFailed(Object error) {
    return 'Weiterleiten fehlgeschlagen: $error';
  }

  @override
  String get chatUnfavorited => 'Aus Favoriten entfernt';

  @override
  String get chatFavorited => 'Zu Favoriten hinzugefügt';

  @override
  String get chatReactionAdded => 'Reaktion hinzugefügt';

  @override
  String get chatReactionRemoved => 'Reaktion entfernt';

  @override
  String get chatFailedMessageDeleted => 'Fehlgeschlagene Nachricht gelöscht';

  @override
  String get chatDeleteMessages => 'Nachrichten löschen';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Möchten Sie wirklich $count Nachrichten löschen?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Hinweis: $count Nachrichten sind von anderen und werden nur für Sie gelöscht.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count Nachrichten von Ihnen werden für alle zurückgerufen.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '$count Nachrichten zurückgerufen, $localCount nur für Sie gelöscht';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '$count Nachrichten zurückgerufen';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count Nachrichten nur für Sie gelöscht';
  }

  @override
  String chatForwardedCount(Object count) {
    return '$count Nachrichten weitergeleitet';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Weiterleiten abgeschlossen: $success erfolgreich, $failed fehlgeschlagen';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Erinnerungsfunktion nur im Gruppenchat verfügbar';

  @override
  String get chatOnlyTextSearchable =>
      'Nur Textnachrichten können durchsucht werden';

  @override
  String chatSearchFor(Object text) {
    return 'Suche \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Baidu-Suche';

  @override
  String get chatGoogleSearch => 'Google-Suche';

  @override
  String get chatBingSearch => 'Bing-Suche';

  @override
  String get chatCalling => 'Anrufen...';

  @override
  String get chatRinging => 'Klingelt...';

  @override
  String get chatInCall => 'Im Gespräch';

  @override
  String commonFeatureInDevelopment(String feature) {
    return '$feature in Entwicklung...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '$count Nachrichten gesammelt';
  }

  @override
  String commonMemberCount(int count) {
    return '$count Mitglieder';
  }

  @override
  String groupDone(int count) {
    return 'Fertig($count)';
  }

  @override
  String get profileServices => 'Dienste';

  @override
  String get commonFavorites => 'Favoriten';

  @override
  String get profileOrdersAndCards => 'Bestellungen & Karten';

  @override
  String get profileStickers => 'Sticker';

  @override
  String profileStatusSetTo(String status) {
    return 'Status gesetzt auf: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Avatar-Upload fehlgeschlagen';

  @override
  String get profilePersonalProfile => 'Persönliches Profil';

  @override
  String get profileName => 'Name';

  @override
  String get profileGender => 'Geschlecht';

  @override
  String get profileRegion => 'Region';

  @override
  String get commonMyQrCode => 'Mein QR-Code';

  @override
  String get profilePoke => 'Anstupsen';

  @override
  String get profileRingtone => 'Klingelton';

  @override
  String get profileDefaultRingtone => 'Standard-Klingelton';

  @override
  String get profileMyAddresses => 'Meine Adressen';

  @override
  String profileGenderSetTo(String gender) {
    return 'Geschlecht gesetzt auf: $gender';
  }

  @override
  String get profileSelectRegion => 'Region auswählen';

  @override
  String get profileSelectCity => 'Stadt auswählen';

  @override
  String profileRegionSetTo(String region) {
    return 'Region gesetzt auf: $region';
  }

  @override
  String get profileSetPoke => 'Anstupsen festlegen';

  @override
  String get profileFriendPokedMe => 'Freund hat mich angestupst';

  @override
  String get profileExample => 'Beispiel';

  @override
  String get profileOnTheShoulder => ' auf die Schulter';

  @override
  String get profilePokeCleared => 'Anstupsen gelöscht';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Anstupsen gesetzt auf: hat mich angestupst$suffix';
  }

  @override
  String get profileEditSignature => 'Signatur bearbeiten';

  @override
  String get profileIntroduceYourself => 'Ein Satz um sich vorzustellen';

  @override
  String get profileSignatureCleared => 'Signatur gelöscht';

  @override
  String get profileSignatureUpdated => 'Signatur aktualisiert';

  @override
  String get profileScanToAddFriend =>
      'QR-Code scannen um mich als Freund hinzuzufügen';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Klingelton gesetzt auf: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Möchten Sie die Gruppe \"$name\" wirklich auflösen? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Bitte geben Sie eine gültige Serveradresse ein';

  @override
  String get authEmailOtp => 'E-Mail-OTP';

  @override
  String get authEnterServerAddressFirst =>
      'Bitte zuerst Serveradresse eingeben';

  @override
  String get authPasskeyRequiresServer =>
      'Passkey-Anmeldung erfordert Server-Unterstützung';

  @override
  String get authLoginAgreement => 'Mit der Anmeldung stimmen Sie zu ';

  @override
  String get authPleaseAgreeToTerms =>
      'Bitte lesen und akzeptieren Sie die Nutzungsbedingungen und Datenschutzrichtlinie';

  @override
  String get authRegisterFailed => 'Registrierung fehlgeschlagen';

  @override
  String get commonReenterPassword => 'Passwort erneut eingeben';

  @override
  String get commonPasswordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get authInviteCodeBuiltIn => 'Einladungscode (Integriert)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Einladungscode ist integriert, normalerweise keine Änderung nötig';

  @override
  String get authIHaveReadAndAgree => 'Ich habe gelesen und stimme zu ';

  @override
  String get mainStartGroupChat => 'Gruppenchat starten';

  @override
  String get mainAddFriends => 'Freunde hinzufügen';

  @override
  String get mainPaymentAndCollection => 'Zahlung';

  @override
  String contactCount(int count) {
    return '$count Kontakte';
  }

  @override
  String get contactAddToHomeScreen => 'Zum Startbildschirm hinzufügen';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '${contact}s Karte an $recipient empfohlen';
  }

  @override
  String get contactEnterRemarkName => 'Bemerkungsname eingeben';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Bemerkung gesetzt auf: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Freundschaftsanfrage von $name angenommen';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Freundschaftsanfrage von $name abgelehnt';
  }

  @override
  String get commonGroupInvites => 'Gruppeneinladungen';

  @override
  String commonMyGroups(int count) {
    return 'Meine Gruppen ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Zur Gruppe eingeladen';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Möchten Sie die Gruppe \"$name\" wirklich verlassen?';
  }

  @override
  String get commonLeave => 'Verlassen';

  @override
  String get commonRecallThisMessage => 'Diese Nachricht zurückrufen?';

  @override
  String get commonSavedToGallery => 'In Galerie gespeichert';

  @override
  String get commonFailedToSave => 'Speichern fehlgeschlagen';

  @override
  String get chatSaving => 'Speichern...';

  @override
  String get commonShare => 'Teilen';

  @override
  String get chatSaveToGallery => 'In Galerie speichern';

  @override
  String chatDownloadFailed(String code) {
    return 'Download fehlgeschlagen: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Teilen fehlgeschlagen: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Bild laden fehlgeschlagen';

  @override
  String get chatVideoRecordingFailed =>
      'Videoaufnahme fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get profileRedPacket => 'Rotes Paket';

  @override
  String get commonMusic => 'Musik';

  @override
  String get commonCoupon => 'Gutschein';

  @override
  String get commonGift => 'Geschenk';

  @override
  String get commonPoll => 'Umfrage';

  @override
  String get favoriteText => 'Text';

  @override
  String get favoriteLinkLabel => 'Link';

  @override
  String get favoriteNote => 'Notiz';

  @override
  String get favoriteMyNotes => 'Meine Notizen';

  @override
  String get favoriteToday => 'Heute';

  @override
  String favoriteDaysAgoText(int count) {
    return 'vor $count Tagen';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day.$month.';
  }

  @override
  String get favoriteNoFavorites => 'Noch keine Favoriten';

  @override
  String get favoriteLongPressToFavorite =>
      'Nachricht lange drücken um zu favorisieren';

  @override
  String get favoriteNewNote => 'Neue Notiz';

  @override
  String get favoriteLink => 'Link favorisieren';

  @override
  String get favoriteEditTags => 'Tags bearbeiten';

  @override
  String get favoriteDeleteFavorite => 'Favorit löschen';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Möchten Sie diesen Favoriten wirklich löschen?';

  @override
  String get favoriteNoSearchResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get commonSendRedPacket => 'Rotes Paket senden';

  @override
  String get transferAmount => 'Betrag';

  @override
  String get commonRedPacketCover => 'Rotes-Paket-Hülle';

  @override
  String get commonRedPacketType => 'Rotes-Paket-Typ';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'Glücks';

  @override
  String get commonRedPacketCount => 'Rote-Pakete-Anzahl';

  @override
  String get commonPieces => 'Stück';

  @override
  String get commonPutMoneyInRedPacket => 'Geld ins rote Paket legen';

  @override
  String get commonRedPacketRefundNotice =>
      'Nicht eingelöste rote Pakete werden nach 24 Stunden erstattet';

  @override
  String get commonOpenRedPacket => 'Öffnen';

  @override
  String get commonRedPacketAllClaimed => 'Rotes Paket vollständig eingelöst';

  @override
  String get commonRedPacketExpired => 'Rotes Paket abgelaufen';

  @override
  String get commonAddTransferNote => 'Überweisungsnotiz hinzufügen';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'Mit diesem Emoji antworten';

  @override
  String get contactEditRemark => 'Bemerkung bearbeiten';

  @override
  String get contactSetPermissions => 'Berechtigungen festlegen';

  @override
  String get profileAddToBlacklist => 'Zur Sperrliste hinzufügen';

  @override
  String get contactDeleteContact => 'Kontakt löschen';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Möchten Sie $name wirklich löschen?';
  }

  @override
  String get transferTitle => 'Überweisung';

  @override
  String get transferReceiverAddressLabel => 'Empfängeradresse';

  @override
  String get transferSelectTokenLabel => 'Token auswählen';

  @override
  String get transferAmountLabel => 'Überweisungsbetrag';

  @override
  String get transferMemoLabel => 'Memo (optional)';

  @override
  String get transferAddMemoHint => 'Memo hinzufügen';

  @override
  String get transferSendPaymentRequest => 'Zahlungsanfrage senden';

  @override
  String get transferQrCodeGenerateFailed =>
      'QR-Code-Generierung fehlgeschlagen';

  @override
  String get transferScanQrToPayMe => 'QR-Code scannen um mich zu bezahlen';

  @override
  String get transferMyWalletAddress => 'Meine Wallet-Adresse';

  @override
  String get transferCreatePaymentRequest => 'Zahlungsanfrage erstellen';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Beste Wünsche';

  @override
  String commonSenderRedPacket(String name) {
    return '${name}s Rotes Paket';
  }

  @override
  String get transferEnterValidAddress =>
      'Bitte geben Sie eine gültige Adresse ein';

  @override
  String get transferPleaseSelectToken => 'Bitte wählen Sie einen Token';

  @override
  String get commonReceivedTransfer => 'Überweisung erhalten';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name hat ein rotes Paket gesendet';
  }

  @override
  String get commonSavedToBalance =>
      'Im Guthaben gespeichert, direkte Überweisung möglich';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Rotes Paket abgelaufen/alle eingelöst';

  @override
  String get transferScanFeatureComingSoon =>
      'Scanfunktion demnächst verfügbar...';

  @override
  String get contactSetAsStarred => 'Als Favorit festlegen';

  @override
  String get contactAddToBlocklist => 'Zur Sperrliste hinzufügen';

  @override
  String get commonClaimedYour => ' hat Ihr ';

  @override
  String get commonClaimedText => ' eingelöst ';

  @override
  String commonUserTyping(String name) {
    return '$name tippt...';
  }

  @override
  String get commonTyping => 'Tippt...';

  @override
  String get commonWaitingToReceive => 'Wartet auf Empfang';

  @override
  String get commonTapToClaim => 'Tippen zum Einlösen';

  @override
  String get commonHasBeenReceived => 'Wurde empfangen';

  @override
  String get commonGetLucky => 'Viel Glück';

  @override
  String get qrcodeCameraStartFailed => 'Kamera konnte nicht gestartet werden';

  @override
  String get qrcodeUnknownError => 'Unbekannter Fehler';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'QR-Code zum Scannen im Rahmen platzieren';

  @override
  String get qrcodeCloseManualInput => 'Manuelle Eingabe schließen';

  @override
  String get qrcodeManualInputUserId => 'Benutzer-ID manuell eingeben';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get profileSetStatus => 'Status festlegen';

  @override
  String get profileVisibleToFriends24h => 'Für Freunde 24 Stunden sichtbar';

  @override
  String get profileWriteStatus => 'Status schreiben';

  @override
  String get profileEnterYourStatus => 'Ihren Status eingeben...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Kameraberechtigung erforderlich um QR-Code zu scannen';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Kameraberechtigung wurde dauerhaft verweigert. Bitte in den Systemeinstellungen aktivieren.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Fehler bei Berechtigungsprüfung: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Ungültiger QR-Code';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Freund kann nicht hinzugefügt werden: $error';
  }

  @override
  String get qrcodeScanQrCode => 'QR-Code scannen';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Kameraberechtigung wird überprüft...';

  @override
  String get qrcodeNeedCameraPermission => 'Kameraberechtigung erforderlich';

  @override
  String get qrcodeRetryPermission => 'Erneut versuchen';

  @override
  String get qrcodeOpenSettings => 'Einstellungen öffnen';

  @override
  String get groupInviteMembers => 'Mitglieder einladen';

  @override
  String groupInviteCount(int count) {
    return 'Einladen($count)';
  }

  @override
  String get profileNoShippingAddress => 'Keine Lieferadresse';

  @override
  String get profileDefaultLabel => 'Standard';

  @override
  String get profileNoInvoice => 'Keine Rechnung';

  @override
  String get profileCompany => 'Firma';

  @override
  String get profileTaxNumber => 'Steuernummer';

  @override
  String get profileConfirmDeleteAddress =>
      'Möchten Sie diese Adresse wirklich löschen?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Möchten Sie diese Rechnung wirklich löschen?';

  @override
  String get commonGroupOwner => 'Eigentümer';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Mitglieder suchen';

  @override
  String groupTotalMembers(int count) {
    return '$count Mitglieder';
  }

  @override
  String get chatRemoveFromGroup => 'Aus Gruppe entfernen';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Möchten Sie \"$name\" wirklich aus der Gruppe entfernen?';
  }

  @override
  String get chatUnknownSong => 'Unbekanntes Lied';

  @override
  String get chatUnknownArtist => 'Unbekannter Künstler';

  @override
  String get chatUnknownContact => 'Unbekannter Kontakt';

  @override
  String get chatPersonalCard => 'Kontaktkarte';

  @override
  String get chatSingleChoice => 'Einzelauswahl';

  @override
  String get chatMultiChoice => 'Mehrfachauswahl';

  @override
  String get chatEnded => 'Beendet';

  @override
  String get chatEndPollButton => 'Umfrage beenden';

  @override
  String get chatPollHint =>
      'Umfrage wird im Chat angezeigt. Gruppenmitglieder können abstimmen.';

  @override
  String get chatSearchSongOrArtist => 'Lied oder Künstler suchen';

  @override
  String get chatNoSongsFound => 'Keine Lieder gefunden';

  @override
  String get chatSongNameOptional => 'Liedname (Optional)';

  @override
  String get chatEnterSongName => 'Liedname eingeben';

  @override
  String get chatArtistNameOptional => 'Künstlername (Optional)';

  @override
  String get chatEnterArtistName => 'Künstlername eingeben';

  @override
  String get chatRealTimeLocationSharing =>
      'Echtzeit-Standortfreigabe in Entwicklung...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Sprachanruf-Funktion in Entwicklung...';

  @override
  String get profileReportFeatureInDev => 'Meldefunktion in Entwicklung...';

  @override
  String get profileShareFeatureInDev => 'Teilenfunktion in Entwicklung...';

  @override
  String get profileQrCodeFeatureInDev => 'QR-Code-Funktion in Entwicklung...';

  @override
  String get qrcodeScanQrToAddMe =>
      'QR-Code scannen um mich als Freund hinzuzufügen';

  @override
  String get qrcodeSaveToAlbum => 'Im Album speichern';

  @override
  String get qrcodeChangeStyle => 'Stil ändern';

  @override
  String get qrcodeCopyId => 'ID kopieren';

  @override
  String get qrcodeIdCopied => 'ID kopiert';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'Weitere Stile demnächst verfügbar';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Server';

  @override
  String get profileShareContactCard => 'Kontaktkarte teilen';

  @override
  String get profileRemoveFromBlacklist => 'Von Sperrliste entfernen';

  @override
  String get profileConfirmAddBlacklist =>
      'Möchten Sie diesen Benutzer wirklich zur Sperrliste hinzufügen? Sie werden keine Nachrichten mehr von ihm erhalten.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Möchten Sie diesen Benutzer wirklich von der Sperrliste entfernen?';

  @override
  String get profileRemarkSaved => 'Bemerkung gespeichert';

  @override
  String get profileRemarkCleared => 'Bemerkung gelöscht';

  @override
  String get transferReceive => 'Empfangen';

  @override
  String get transferPleaseConnectWallet =>
      'Bitte verbinden Sie zuerst Ihre Wallet';

  @override
  String get transferSendRequest => 'Anfrage senden';

  @override
  String get transferPleaseEnterValidAmount =>
      'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get searchPlaceholder => 'Kontakte, Gruppen, Nachrichten suchen';

  @override
  String get searchEnterKeywordToSearch => 'Stichwort eingeben um zu suchen';

  @override
  String get searchClearHistory => 'Löschen';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Keine Ergebnisse für \"$query\" gefunden';
  }

  @override
  String get searchAllResults => 'Alle';

  @override
  String get searchInChat => 'Im Chat suchen';

  @override
  String get searchContactLabel => 'Kontakt';

  @override
  String get searchGroupLabel => 'Gruppe';

  @override
  String get searchConversationLabel => 'Unterhaltung';

  @override
  String get searchMessageLabel => 'Nachricht';

  @override
  String get settingsSecurityTitle => 'Sicherheit';

  @override
  String get settingsKeyBackup => 'Schlüsselsicherung';

  @override
  String get settingsBackupEncryptionKeys =>
      'Verschlüsselungsschlüssel sichern';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count Schlüssel gesichert';
  }

  @override
  String get settingsBackupNotSet => 'Sicherung nicht eingerichtet';

  @override
  String get settingsRestoreKeys => 'Schlüssel wiederherstellen';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Verschlüsselungsschlüssel aus Sicherung wiederherstellen';

  @override
  String get settingsExportKeys => 'Schlüssel exportieren';

  @override
  String get settingsExportKeysToFile => 'Schlüssel in Datei exportieren';

  @override
  String get settingsLoggedInDevices => 'Angemeldete Geräte';

  @override
  String get settingsNoOtherDevices => 'Keine anderen Geräte';

  @override
  String get settingsVerified => 'Verifiziert';

  @override
  String get settingsUnverified => 'Nicht verifiziert';

  @override
  String get settingsAdvanced => 'Erweitert';

  @override
  String get settingsCrossSigning => 'Cross-Signing';

  @override
  String get settingsEnabled => 'Aktiviert';

  @override
  String get settingsNotEnabled => 'Nicht aktiviert';

  @override
  String get settingsResetEncryption => 'Verschlüsselung zurücksetzen';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Alle Verschlüsselungsschlüssel löschen';

  @override
  String get settingsEncryptionNotSupported =>
      'Verschlüsselung nicht unterstützt';

  @override
  String get settingsNotInitialized => 'Nicht initialisiert';

  @override
  String get settingsBackupKeyTitle => 'Schlüssel sichern';

  @override
  String get settingsBackupKeyMessage =>
      'Neue Schlüsselsicherung erstellen? Dies hilft Ihnen, verschlüsselte Nachrichten auf einem neuen Gerät wiederherzustellen.';

  @override
  String get settingsBackup => 'Sichern';

  @override
  String get settingsRestoreKeyTitle => 'Schlüssel wiederherstellen';

  @override
  String get settingsRestoreKeyMessage =>
      'Geben Sie Ihr Wiederherstellungspasswort oder Ihren Wiederherstellungsschlüssel ein, um verschlüsselte Nachrichten wiederherzustellen.';

  @override
  String get settingsRestore => 'Wiederherstellen';

  @override
  String get settingsExportKeyTitle => 'Schlüssel exportieren';

  @override
  String get settingsExportKeyMessage =>
      'Die exportierte Schlüsseldatei enthält alle Ihre Verschlüsselungsschlüssel. Bitte bewahren Sie sie sicher auf.';

  @override
  String get settingsExport => 'Exportieren';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'Geräte-ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Status: Verifiziert';

  @override
  String get settingsDeviceStatusUnverified => 'Status: Nicht verifiziert';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Zuletzt aktiv: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Dieses Gerät verifizieren';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Cross-Signing ist bereits aktiviert';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Cross-Signing erfolgreich eingerichtet';

  @override
  String get settingsResetEncryptionTitle => 'Verschlüsselung zurücksetzen';

  @override
  String get settingsResetEncryptionWarning =>
      'Warnung: Dies wird alle Ihre Verschlüsselungsschlüssel löschen. Sie werden vorherige verschlüsselte Nachrichten nicht entschlüsseln können. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get settingsReset => 'Zurücksetzen';

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
      'Möchten Sie das Meeting wirklich verlassen?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'hat $name angestupst$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Keine Kontakte zum Hinzufügen verfügbar';

  @override
  String get chatAddMembers => 'Mitglieder hinzufügen';

  @override
  String chatInvitedMembers(int count) {
    return '$count Mitglieder eingeladen';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Einladung fehlgeschlagen: $error';
  }

  @override
  String get chatMemberRemoved => 'Mitglied entfernt';

  @override
  String chatRemoveFailed(String error) {
    return 'Entfernen fehlgeschlagen: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Nach dem Teilen kann die andere Person Ihren Echtzeit-Standort 1 Stunde lang sehen.';

  @override
  String get chatStartSharing => 'Teilen starten';

  @override
  String get chatLocationServiceNotEnabled =>
      'Standortdienst ist nicht aktiviert';

  @override
  String get chatEnableLocationService =>
      'Bitte aktivieren Sie den Standortdienst um diese Funktion zu nutzen';

  @override
  String get chatGoToSettings => 'Zu Einstellungen';

  @override
  String get chatLocationPermissionRequired =>
      'Standortberechtigung ist für diese Funktion erforderlich';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Standortberechtigung wurde dauerhaft verweigert. Bitte in den Einstellungen aktivieren.';

  @override
  String get chatLocationPermissionDenied => 'Standortberechtigung verweigert';

  @override
  String get chatGettingLocation => 'Standort wird ermittelt...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Standort ermitteln fehlgeschlagen: $error';
  }

  @override
  String get chatMapPreview => 'Kartenvorschau';

  @override
  String get chatSearchLocation => 'Standort suchen';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '$amount $token rotes Paket gesendet';
  }

  @override
  String get chatTransferDefault => 'Überweisung';

  @override
  String chatTransferSent(String amount, String token) {
    return '$amount $token Überweisung gesendet';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Dateiauswahl fehlgeschlagen: $error';
  }

  @override
  String get chatFileSizeLimit => 'Dateigröße darf 50MB nicht überschreiten';

  @override
  String chatFileSending(String filename) {
    return 'Datei wird gesendet: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Datei senden fehlgeschlagen: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '${name}s Kontaktkarte gesendet';
  }

  @override
  String get chatFavoritesFeature => 'Favoriten';

  @override
  String get chatCouponsFeature => 'Gutscheine';

  @override
  String get chatGiftFeature => 'Geschenk';

  @override
  String chatSharedMusic(String name) {
    return '$name geteilt';
  }

  @override
  String get chatEndPollTitle => 'Umfrage beenden';

  @override
  String get chatEndPollConfirmMessage =>
      'Möchten Sie diese Umfrage wirklich beenden? Nach dem Beenden wird die Abstimmung geschlossen.';

  @override
  String get chatPollEndedMessage => 'Umfrage beendet';

  @override
  String get chatConnectingCall => 'Verbindung wird hergestellt...';

  @override
  String get chatMuteCall => 'Stummschalten';

  @override
  String get chatSpeakerOff => 'Lautsprecher aus';

  @override
  String get chatSpeakerOn => 'Lautsprecher';

  @override
  String get chatCameraOn => 'Kamera an';

  @override
  String get chatCameraOff => 'Kamera aus';

  @override
  String get chatHangUp => 'Auflegen';

  @override
  String get chatSelectForwardTargetTitle => 'Weiterleitungsziel auswählen';

  @override
  String get chatNoForwardableChat => 'Keine Chats zum Weiterleiten verfügbar';

  @override
  String get chatNoMatchingChat => 'Keine passenden Chats gefunden';

  @override
  String get chatLocationTitle => 'Standort';

  @override
  String get chatSendButton => 'Senden';

  @override
  String get chatRetryButton => 'Erneut versuchen';

  @override
  String get chatSearchContactHint => 'Kontakte suchen';

  @override
  String get chatShareMusic => 'Musik teilen';

  @override
  String get chatRecentPlayed => 'Zuletzt';

  @override
  String get chatMyFavorites => 'Favoriten';

  @override
  String get chatNetworkLink => 'Link';

  @override
  String get chatLocalFile => 'Lokal';

  @override
  String get chatPasteMusicLink => 'Musik-Link einfügen';

  @override
  String get chatShareMusicButton => 'Musik teilen';

  @override
  String get chatSelectLocalAudio => 'Lokale Audiodatei auswählen';

  @override
  String get chatSupportedAudioFormats =>
      'Unterstützt MP3, M4A, WAV, FLAC, etc.';

  @override
  String get chatSelectFileButton => 'Datei auswählen';

  @override
  String get chatPleaseEnterMusicLink => 'Bitte Musik-Link eingeben';

  @override
  String get chatPleaseEnterValidLink => 'Bitte geben Sie eine gültige URL ein';

  @override
  String get chatSharedSong => 'Geteiltes Lied';

  @override
  String get chatSelectMember => 'Mitglied auswählen';

  @override
  String get chatSearchMemberHint => 'Mitglieder suchen';

  @override
  String get chatNoMatchingMembers => 'Keine passenden Mitglieder gefunden';

  @override
  String get commonUnknownMember => 'Unbekannt';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count Nachrichten ausgewählt';
  }

  @override
  String get chatSearchContactsOrGroups => 'Kontakte oder Gruppen suchen';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Laden...';

  @override
  String get chatVideoLoadFailed => 'Video laden fehlgeschlagen';

  @override
  String get chatPlayerInitFailed => 'Player-Initialisierung fehlgeschlagen';

  @override
  String get chatCreatePollTitle => 'Umfrage erstellen';

  @override
  String get chatSubmitPoll => 'Absenden';

  @override
  String get chatPollQuestionLabel => 'Umfragefrage';

  @override
  String get chatEnterPollQuestionHint => 'Bitte Umfragefrage eingeben';

  @override
  String get chatPollOptionsLabel => 'Umfrageoptionen';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Option $index';
  }

  @override
  String get chatAddOptionButton => 'Option hinzufügen';

  @override
  String get chatPollSettingsLabel => 'Umfrageeinstellungen';

  @override
  String get chatSelectionType => 'Auswahltyp';

  @override
  String get chatSingleChoiceLabel => 'Einzelauswahl';

  @override
  String get chatMultiChoiceLabel => 'Mehrfachauswahl';

  @override
  String get chatAnonymousPollSwitch => 'Anonyme Umfrage';

  @override
  String get chatPleaseEnterQuestion => 'Bitte Umfragefrage eingeben';

  @override
  String get chatAtLeastTwoOptions => 'Mindestens 2 Optionen erforderlich';

  @override
  String chatConfirmWithCount(int count) {
    return 'Bestätigen ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'E-Mail-Verifizierung';

  @override
  String get authEnterValidEmailAddress =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Bestätigungscode gesendet an $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Code senden fehlgeschlagen: $error';
  }

  @override
  String get authVerificationSuccess => 'Verifizierung erfolgreich';

  @override
  String get authVerificationFailed => 'Verifizierung fehlgeschlagen';

  @override
  String authVerificationCodeError(String error) {
    return 'Verifizierungscode-Fehler: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Bestätigungscode eingeben';

  @override
  String get authEnterYourEmail => 'E-Mail eingeben';

  @override
  String authWeSentCodeTo(String email) {
    return 'Wir haben einen 6-stelligen Code an\n$email gesendet';
  }

  @override
  String get authEnterEmailForCode =>
      'Geben Sie Ihre E-Mail-Adresse ein, wir senden einen Bestätigungscode';

  @override
  String get commonSendVerificationCode => 'Bestätigungscode senden';

  @override
  String get authResendVerificationCode => 'Bestätigungscode erneut senden';

  @override
  String authCanResendAfter(int seconds) {
    return 'Erneut senden nach $seconds Sekunden';
  }

  @override
  String get commonChangeEmail => 'E-Mail ändern';

  @override
  String get contactAddToContacts => 'Zu Kontakten hinzufügen';

  @override
  String get contactAddingToContacts => 'Hinzufügen...';

  @override
  String get contactAddedToContacts => 'Zu Kontakten hinzugefügt';

  @override
  String contactAddFailedWithError(String error) {
    return 'Hinzufügen fehlgeschlagen: $error';
  }

  @override
  String get contactAddPhone => 'Telefon hinzufügen';

  @override
  String get contactAddTag => 'Tags hinzufügen';

  @override
  String get contactAddText => 'Text hinzufügen';

  @override
  String get contactAddPhoto => 'Foto hinzufügen';

  @override
  String contactGroupCountLabel(int count) {
    return '$count Gruppen';
  }

  @override
  String get contactAddedViaSearch => 'Über Suche hinzugefügt';

  @override
  String get contactAddTime => 'Zeit hinzufügen';

  @override
  String get contactDoneButton => 'Fertig';

  @override
  String get callWaitingForParticipants => 'Warten auf Teilnehmer...';

  @override
  String callParticipantMe(String name) {
    return '$name (Ich)';
  }

  @override
  String get callSharingLabel => 'Teilen';

  @override
  String callScreenSharingBy(String name) {
    return '$name teilt Bildschirm';
  }

  @override
  String callParticipantCount(int count) {
    return '$count Teilnehmer';
  }

  @override
  String get callMuteLabel => 'Stummschalten';

  @override
  String get callUnmuteLabel => 'Stummschaltung aufheben';

  @override
  String get callTurnOffVideo => 'Video ausschalten';

  @override
  String get callTurnOnVideo => 'Video einschalten';

  @override
  String get callShareScreen => 'Bildschirm teilen';

  @override
  String get callStopSharing => 'Teilen beenden';

  @override
  String get callSwitchCameraLabel => 'Wechseln';

  @override
  String get callLeaveLabel => 'Verlassen';

  @override
  String get callParticipantsLabel => 'Teilnehmer';

  @override
  String get callJoiningMeeting => 'Meeting beitreten...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count Stimmen ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count Teilnehmer';
  }

  @override
  String get commonTapToRetry => 'Tippen zum Wiederholen';

  @override
  String get chatDefaultRedPacketGreeting => 'Viel Glück und Wohlstand';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Anderen ermöglichen zu suchen und beizutreten';

  @override
  String get groupConfirmClearChatHistory =>
      'Möchten Sie den Chat-Verlauf wirklich löschen?';

  @override
  String get groupCreateGroupToChat =>
      'Erstellen Sie eine Gruppe, um mit dem Chatten zu beginnen';

  @override
  String get groupEditGroupAnnouncement => 'Gruppenankündigung bearbeiten';

  @override
  String get groupEditGroupDescription => 'Gruppenbeschreibung bearbeiten';

  @override
  String get groupEnterGroupAnnouncement =>
      'Bitte geben Sie die Gruppenankündigung ein';

  @override
  String chatErrorWithMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count Mitglieder, klicken zum Kopieren der Gruppen-ID';
  }

  @override
  String get chatMusicLinkLabel => 'Musik-Link';

  @override
  String get chatNoMediaUrlAvailable => 'Keine Medien-URL verfügbar';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Sie haben keine Berechtigung, den Gruppennamen zu ändern';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Rote Umschläge und Überweisungen können nicht weitergeleitet werden';

  @override
  String get authEmailAddress => 'E-Mail-Adresse';

  @override
  String get commonEnterEmailAddress => 'E-Mail-Adresse eingeben';

  @override
  String get authEmailRecoveryHint =>
      'Wird zur Passwortwiederherstellung verwendet';

  @override
  String get commonInvalidEmailFormat =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get authOptional => 'Optional';

  @override
  String get authResetPassword => 'Passwort zurücksetzen';

  @override
  String get authEnterRegisteredEmail =>
      'Geben Sie die E-Mail-Adresse ein, mit der Sie sich registriert haben';

  @override
  String get authSendResetCode => 'Zurücksetzungscode senden';

  @override
  String authResetCodeSent(String email) {
    return 'Zurücksetzungscode gesendet an $email';
  }

  @override
  String get authEnterResetCode => 'Zurücksetzungscode eingeben';

  @override
  String get authSetNewPassword => 'Neues Passwort festlegen';

  @override
  String get commonConfirmNewPassword => 'Neues Passwort bestätigen';

  @override
  String get commonNewPassword => 'Neues Passwort';

  @override
  String get authPasswordResetSuccess =>
      'Passwort erfolgreich zurückgesetzt. Bitte melden Sie sich mit Ihrem neuen Passwort an.';

  @override
  String get authResetPasswordFailed => 'Passwort zurücksetzen fehlgeschlagen';

  @override
  String get settingsChangePassword => 'Passwort ändern';

  @override
  String get settingsCurrentPassword => 'Aktuelles Passwort';

  @override
  String get settingsEnterCurrentPassword => 'Aktuelles Passwort eingeben';

  @override
  String get settingsEnterNewPassword => 'Neues Passwort eingeben';

  @override
  String get settingsPasswordChanged =>
      'Passwort erfolgreich geändert. Bitte melden Sie sich mit Ihrem neuen Passwort an.';

  @override
  String get settingsChangePasswordFailed => 'Passwortänderung fehlgeschlagen';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Das neue Passwort muss sich vom aktuellen Passwort unterscheiden';

  @override
  String get settingsChangePasswordInfo =>
      'Nach der Passwortänderung werden Sie abgemeldet und müssen sich mit dem neuen Passwort anmelden.';

  @override
  String get settingsPasswordRequirements => 'Passwortanforderungen:';

  @override
  String get settingsSecurityNote =>
      'Aus Sicherheitsgründen müssen Sie sich nach der Passwortänderung auf allen Geräten erneut anmelden.';

  @override
  String get settingsSecurity => 'Sicherheit';

  @override
  String get settingsCurrentBoundEmail => 'Aktuell verknüpfte E-Mail';

  @override
  String get settingsNewEmailAddress => 'Neue E-Mail-Adresse';

  @override
  String get settingsEnterNewEmail => 'Neue E-Mail-Adresse eingeben';

  @override
  String get settingsVerificationCode => 'Bestätigungscode';

  @override
  String get settingsVerificationCodeSent => 'Bestätigungscode gesendet';

  @override
  String get settingsCodeSentTo => 'Bestätigungscode gesendet an';

  @override
  String get settingsDidNotReceiveCode => 'Code nicht erhalten?';

  @override
  String get settingsEmailChangedSuccess => 'E-Mail erfolgreich geändert';

  @override
  String get settingsChangeEmailFailed => 'E-Mail-Änderung fehlgeschlagen';

  @override
  String get settingsEmailSecurityNote =>
      'Ihre E-Mail wird zur Passwortwiederherstellung verwendet. Bitte bewahren Sie sie sicher auf.';

  @override
  String get commonGoogleLogin => 'Mit Google anmelden';

  @override
  String get commonAppleLogin => 'Mit Apple anmelden';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageChanged => 'Sprache geändert';

  @override
  String get settingsBiometricLogin => 'Biometrische Anmeldung';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Mit $type anmelden';
  }

  @override
  String get settingsBiometricLoginEnabled =>
      'Biometrische Anmeldung aktiviert';

  @override
  String get settingsBiometricLoginDisabled =>
      'Biometrische Anmeldung deaktiviert';

  @override
  String get settingsEnableBiometricLogin =>
      'Biometrische Anmeldung aktivieren';

  @override
  String get settingsBiometricEnabled =>
      'Aktiviert - Biometrie zum Anmelden verwenden';

  @override
  String get settingsBiometricDisabled => 'Deaktiviert - Tippen zum Aktivieren';

  @override
  String get settingsBiometricNeedRelogin =>
      'Bitte abmelden und erneut anmelden, um die biometrische Anmeldung zu aktivieren';

  @override
  String get authOr => 'ODER';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Der Kamerazugriff ist auf diesem Gerät eingeschränkt';

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
      'Stupser-Suffix eingeben, z.B.: auf die Schulter';

  @override
  String get groupAlbum => 'Gruppenalbum';

  @override
  String get groupFiles => 'Gruppendateien';

  @override
  String get groupImages => 'Bilder';

  @override
  String get groupVideos => 'Videos';

  @override
  String get groupTotal => 'Gesamt';

  @override
  String get groupSize => 'Größe';

  @override
  String get groupNoMedia => 'Keine Medien';

  @override
  String get groupNoMediaDescription =>
      'Noch keine Fotos oder Videos in dieser Gruppe';

  @override
  String get groupDocuments => 'Dokumente';

  @override
  String get groupNoFiles => 'Keine Dateien';

  @override
  String get groupNoFilesDescription => 'Noch keine Dateien in dieser Gruppe';

  @override
  String groupDownloadStarted(String filename) {
    return 'Herunterladen von $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Keine gemeinsamen Gruppen';

  @override
  String get contactNoCommonGroupsDescription =>
      'Ihr habt keine gemeinsamen Gruppen';

  @override
  String get chatVoiceMessage => 'Sprache';

  @override
  String get chatMessage => 'Nachricht';

  @override
  String get conversationHideChat => 'Ausblenden';

  @override
  String get settingsQuickReply => 'Schnellantwort';

  @override
  String get commonTranslate => 'Übersetzen';

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
    return 'Unterhaltung: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Kontakt: $userId';
  }

  @override
  String get commonDiscover => 'Entdecken';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Demnächst verfügbar)';
  }

  @override
  String get commonPageNotFound => 'Seite nicht gefunden';

  @override
  String get commonBackToHome => 'Zurück zur Startseite';

  @override
  String get settingsMessageNotifications => 'Nachrichtenbenachrichtigungen';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Neue Nachrichtenbenachrichtigungen erhalten';

  @override
  String get settingsShowMessagePreview => 'Nachrichtenvorschau anzeigen';

  @override
  String get settingsShowMessageContentInNotification =>
      'Nachrichteninhalt in Benachrichtigungen anzeigen';

  @override
  String get settingsNotificationSound => 'Benachrichtigungston';

  @override
  String get settingsPlaySoundOnMessage =>
      'Ton bei Nachrichtenempfang abspielen';

  @override
  String get commonVibration => 'Vibration';

  @override
  String get settingsVibrateOnMessage => 'Bei Nachrichtenempfang vibrieren';

  @override
  String get settingsDoNotDisturbMode => 'Nicht stören';

  @override
  String get settingsDoNotDisturbDescription =>
      'Keine Benachrichtigungen während der festgelegten Zeit';

  @override
  String get settingsStartTime => 'Startzeit';

  @override
  String get settingsEndTime => 'Endzeit';

  @override
  String get settingsDeleteQuickReply => 'Schnellantwort löschen';

  @override
  String get settingsEditQuickReply => 'Schnellantwort bearbeiten';

  @override
  String get settingsAddQuickReply => 'Schnellantwort hinzufügen';

  @override
  String get settingsManageQuickReplies => 'Schnellantworten verwalten';

  @override
  String get settingsNoQuickReplies => 'Keine Schnellantworten';

  @override
  String get settingsDefaultQuickReplies =>
      'Standard-Schnellantworten werden angezeigt';

  @override
  String get settingsWhoCanSee => 'Wer kann sehen';

  @override
  String get settingsLastSeen => 'Zuletzt gesehen';

  @override
  String get settingsHiddenChats => 'Versteckte Chats';

  @override
  String get settingsMessagesLabel => 'Nachrichten';

  @override
  String get settingsAllowStrangerMessages =>
      'Nachrichten von Fremden erlauben';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Nachrichten von Nicht-Kontakten empfangen';

  @override
  String get settingsReadReceipts => 'Lesebestätigungen';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Andere wissen lassen, dass Sie ihre Nachrichten gelesen haben';

  @override
  String get settingsTypingIndicator => 'Tippanzeige';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Andere wissen lassen, dass Sie tippen';

  @override
  String get settingsEveryone => 'Alle';

  @override
  String get settingsContactsOnly => 'Nur Kontakte';

  @override
  String get settingsNobody => 'Niemand';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Wer kann $title sehen';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Version $version';
  }

  @override
  String get settingsCheckForUpdates => 'Nach Updates suchen';

  @override
  String get settingsOpenSourceLicenses => 'Open-Source-Lizenzen';

  @override
  String get settingsFeedbackAndSuggestions => 'Feedback & Vorschläge';

  @override
  String get settingsBuiltOnMatrix => 'Basiert auf Matrix-Protokoll';

  @override
  String get settingsNoHiddenChats => 'Keine versteckten Chats';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Chats, die du versteckst, werden hier angezeigt';

  @override
  String get settingsUnhideChat => 'Einblenden';

  @override
  String get settingsDarkMode => 'Dunkelmodus';

  @override
  String get settingsFontSize => 'Schriftgröße';

  @override
  String get settingsBubbleStyle => 'Blasenstil';

  @override
  String get settingsFollowSystem => 'System folgen';

  @override
  String get settingsAutoSwitchBySystem =>
      'Automatisch nach Systemeinstellungen wechseln';

  @override
  String get settingsLightMode => 'Hellmodus';

  @override
  String get settingsAlwaysUseLightTheme => 'Immer helles Design verwenden';

  @override
  String get settingsDarkModeOption => 'Dunkelmodus';

  @override
  String get settingsAlwaysUseDarkTheme => 'Immer dunkles Design verwenden';

  @override
  String get settingsFontSizeSmall => 'Klein';

  @override
  String get settingsFontSizeStandard => 'Standard';

  @override
  String get settingsFontSizeLarge => 'Groß';

  @override
  String get settingsFontSizeExtraLarge => 'Sehr groß';

  @override
  String get settingsBubbleStyleWechat => 'WeChat-Stil';

  @override
  String get settingsBubbleStyleWechatDesc => 'Klassischer WeChat-Blasenstil';

  @override
  String get settingsBubbleStyleModern => 'Moderner Stil';

  @override
  String get settingsBubbleStyleModernDesc => 'Sauberer moderner Blasenstil';

  @override
  String get settingsBubbleStyleClassic => 'Klassischer Stil';

  @override
  String get settingsBubbleStyleClassicDesc => 'Traditioneller Blasenstil';

  @override
  String get discoverVideoChannels => 'Kanäle';

  @override
  String get discoverLive => 'Live';

  @override
  String get discoverListen => 'Hören';

  @override
  String get discoverWatch => 'Ansehen';

  @override
  String get discoverSearchDiscover => 'Suchen';

  @override
  String get discoverNearbyPeople => 'In der Nähe';

  @override
  String get discoverGames => 'Spiele';

  @override
  String get discoverMiniPrograms => 'Mini-Programme';

  @override
  String get chatAlreadyInCall => 'Bereits im Gespräch';

  @override
  String get commonConnectionFailed => 'Verbindung fehlgeschlagen';

  @override
  String get chatCallRejected => 'Anruf abgelehnt';

  @override
  String get chatNoAnswer => 'Keine Antwort';

  @override
  String get commonClose => 'Schließen';

  @override
  String get chatSelectContact => 'Kontakt auswählen';

  @override
  String get chatVoteRemoved => 'Stimme entfernt';

  @override
  String get chatVoteChanged => 'Stimme geändert';

  @override
  String get chatVoted => 'Abgestimmt';

  @override
  String chatReplyTo(String name) {
    return 'Antworten an $name';
  }

  @override
  String get chatCurrentLocation => 'Aktueller Standort';

  @override
  String chatNearbyPlace(int index) {
    return 'Ort in der Nähe $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Ca. $distance';
  }

  @override
  String get chatAddress => 'Adresse';

  @override
  String get chatLatitude => 'Breitengrad';

  @override
  String get chatLongitude => 'Längengrad';

  @override
  String get groupDescriptionUpdated => 'Gruppenbeschreibung aktualisiert';

  @override
  String get groupAvatarUpdated => 'Gruppen-Avatar aktualisiert';

  @override
  String get callDecline => 'Ablehnen';

  @override
  String get callAnswer => 'Annehmen';

  @override
  String get callIncomingVideoCall => 'Eingehender Videoanruf';

  @override
  String get callIncomingVoiceCall => 'Eingehender Sprachanruf';

  @override
  String get callVideoCallInProgress => 'Videoanruf';

  @override
  String get callVoiceCallInProgress => 'Sprachanruf';

  @override
  String get callReconnectingCall => 'Verbindung wird wiederhergestellt...';

  @override
  String get callEnded => 'Anruf beendet';

  @override
  String get callFailed => 'Anruf fehlgeschlagen';

  @override
  String get callLivekitNotConfigured => 'LiveKit nicht konfiguriert';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Meeting beitreten fehlgeschlagen: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Bildschirmfreigabe fehlgeschlagen: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Keine N42 Beans';

  @override
  String get profileN42BeanDetails => 'N42 Bean Details';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean ist ein Token zum Einlösen von virtuellen Gegenständen und Diensten in N42. Derzeit verfügbar für:';

  @override
  String get profileN42BeanFeature1 =>
      'Exklusive Mitglieder-Sticker und Themes';

  @override
  String get profileN42BeanFeature2 => 'Chat-Blasen-Anpassung';

  @override
  String get profileN42BeanFeature3 => 'Rote Umschlag-Cover-Anpassung';

  @override
  String get profileN42BeanFeature4 => 'Exklusives Nickname-Abzeichen';

  @override
  String get profileN42BeanFeature5 => 'Gruppenchat-Privilegien';

  @override
  String get profileN42BeanFeature6 => 'Cloud-Speicher-Erweiterung';

  @override
  String get profileN42BeanFeature7 => 'Videoanruf-Beauty-Filter';

  @override
  String get profileN42BeanFeature8 => 'Moments-Hintergrund-Anpassung';

  @override
  String get profileN42BeanFeature9 => 'VIP-Kundenservice-Priorität';

  @override
  String get profileGotIt => 'Verstanden';

  @override
  String get profileNoN42BeanRecords => 'Keine N42 Bean Einträge';

  @override
  String get profileMoodAndThoughts => 'Stimmung & Gedanken';

  @override
  String get profileStatusHappy => 'Glücklich';

  @override
  String get profileStatusCracked => 'Erschüttert';

  @override
  String get profileStatusLucky => 'Glücklich';

  @override
  String get profileStatusSunny => 'Sonnig';

  @override
  String get profileStatusTired => 'Müde';

  @override
  String get profileStatusDaydream => 'Tagtraum';

  @override
  String get profileStatusRushing => 'In Eile';

  @override
  String get profileStatusOverthinking => 'Grübeln';

  @override
  String get profileStatusEnergized => 'Energiegeladen';

  @override
  String get profileWorkAndStudy => 'Arbeit & Studium';

  @override
  String get profileStatusWorking => 'Arbeiten';

  @override
  String get profileStatusStudying => 'Lernen';

  @override
  String get profileStatusBusy => 'Beschäftigt';

  @override
  String get profileStatusSlacking => 'Faulenzen';

  @override
  String get profileStatusTraveling => 'Reisen';

  @override
  String get profileStatusGoingHome => 'Nach Hause gehen';

  @override
  String get profileStatusDnd => 'Nicht stören';

  @override
  String get profileActivities => 'Aktivitäten';

  @override
  String get profileStatusHanging => 'Abhängen';

  @override
  String get profileStatusCheckIn => 'Einchecken';

  @override
  String get profileStatusExercising => 'Sport treiben';

  @override
  String get profileStatusCoffee => 'Kaffee';

  @override
  String get profileStatusBubbleTea => 'Bubble Tea';

  @override
  String get profileStatusEating => 'Essen';

  @override
  String get profileStatusParenting => 'Elternzeit';

  @override
  String get profileStatusSavingWorld => 'Welt retten';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Ruhe';

  @override
  String get profileStatusRetreat => 'Rückzug';

  @override
  String get profileStatusHome => 'Zuhause';

  @override
  String get profileStatusSleeping => 'Schlafen';

  @override
  String get profileStatusCatLover => 'Katzenliebhaber';

  @override
  String get profileStatusDogWalking => 'Hund ausführen';

  @override
  String get profileStatusGaming => 'Spielen';

  @override
  String get profileStatusListening => 'Hören';

  @override
  String get profileEditAddress => 'Adresse bearbeiten';

  @override
  String get profileRecipient => 'Empfänger';

  @override
  String get profileEnterRecipientName => 'Empfängername eingeben';

  @override
  String get profilePhoneNumber => 'Telefonnummer';

  @override
  String get profileEnterPhoneNumber => 'Telefonnummer eingeben';

  @override
  String get profileRegionHint => 'Bundesland/Stadt/Bezirk';

  @override
  String get profileDetailedAddress => 'Detaillierte Adresse';

  @override
  String get profileDetailedAddressHint => 'Straße, Hausnummer, etc.';

  @override
  String get profileSetAsDefaultAddress => 'Als Standardadresse festlegen';

  @override
  String get profilePleaseCompleteInfo => 'Bitte alle Felder ausfüllen';

  @override
  String get profileEditInvoice => 'Rechnung bearbeiten';

  @override
  String get profileInvoiceType => 'Rechnungstyp: ';

  @override
  String get profileCompanyName => 'Firmenname';

  @override
  String get profilePersonalName => 'Persönlicher Name';

  @override
  String get profileEnterCompanyName => 'Firmenname eingeben';

  @override
  String get profileEnterName => 'Name eingeben';

  @override
  String get profileTaxIdNumber => 'Steuer-ID-Nummer';

  @override
  String get profileEnterTaxIdNumber => 'Steuer-ID-Nummer eingeben';

  @override
  String get profileBankNameOptional => 'Bankname (Optional)';

  @override
  String get profileEnterBankName => 'Bankname eingeben';

  @override
  String get profileBankAccountOptional => 'Bankkonto (Optional)';

  @override
  String get profileEnterBankAccount => 'Bankkonto eingeben';

  @override
  String get profileCompanyAddressOptional => 'Firmenadresse (Optional)';

  @override
  String get profileEnterCompanyAddress => 'Firmenadresse eingeben';

  @override
  String get profileCompanyPhoneOptional => 'Firmentelefon (Optional)';

  @override
  String get profileEnterCompanyPhone => 'Firmentelefon eingeben';

  @override
  String get profileSetAsDefaultInvoice => 'Als Standardrechnung festlegen';

  @override
  String get profileRingtoneVibrate => 'Vibrieren';

  @override
  String get profileRingtoneSilent => 'Lautlos';

  @override
  String get profileVibrateMode => 'Vibrationsmodus';

  @override
  String get profileSilentMode => 'Lautlosmodus';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Abspielen fehlgeschlagen: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Spielt ab: $ringtoneName';
  }

  @override
  String get profileStop => 'Stopp';

  @override
  String get profileSelectRingtone => 'Klingelton auswählen';

  @override
  String get profileLoadingRingtones => 'Klingeltöne werden geladen...';

  @override
  String get profileNoRingtonesFound => 'Keine Klingeltöne gefunden';

  @override
  String mainMessagesWithCount(int count) {
    return 'Nachrichten($count)';
  }

  @override
  String get storyViewers => 'Zuschauer';

  @override
  String get storyNoViewers => 'Noch keine Zuschauer';

  @override
  String get storyReplyToStory => 'Auf Story antworten...';

  @override
  String get commonCopiedToClipboard => 'In Zwischenablage kopiert';

  @override
  String get commonMore => 'Mehr';

  @override
  String get commonTranslating => 'Übersetze...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Übersetzt aus $language';
  }

  @override
  String get commonTranslation => 'Übersetzung';

  @override
  String get commonTranslationFailed => 'Übersetzung fehlgeschlagen';

  @override
  String get commonAllRead => 'Alles gelesen';

  @override
  String commonReadCount(int count) {
    return '$count gelesen';
  }

  @override
  String get commonYouRecalledMessage =>
      'Sie haben eine Nachricht zurückgerufen';

  @override
  String get commonMessageRecalled => 'Nachricht zurückgerufen';

  @override
  String get commonReEdit => 'Bearbeiten';

  @override
  String get commonWalletArea => 'Wallet-Bereich';

  @override
  String get callIncomingCall => 'Eingehender Anruf';

  @override
  String get callMissedCall => 'Verpasster Anruf';

  @override
  String get groupRemoveAdmin => 'Admin entfernen';

  @override
  String get chatSelectCurrency => 'Währung auswählen';

  @override
  String get chatSelectEmoji => 'Emoji auswählen';

  @override
  String get chatSelectRedPacketCover => 'Cover auswählen';

  @override
  String get groupSetAsAdmin => 'Als Admin festlegen';

  @override
  String get chatVideoPlaybackFailed => 'Videowiedergabe fehlgeschlagen';

  @override
  String get groupViewProfile => 'Profil anzeigen';

  @override
  String get favoriteAddLinkComingSoon =>
      'Link-hinzufügen-Funktion demnächst verfügbar';

  @override
  String get favoriteNewNoteComingSoon =>
      'Neue-Notiz-Funktion demnächst verfügbar';

  @override
  String get qrcodeSaveFeatureComingSoon =>
      'Speicherfunktion demnächst verfügbar';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Teilenfunktion demnächst verfügbar';

  @override
  String qrcodeProcessFailed(String error) {
    return 'QR-Code-Verarbeitung fehlgeschlagen: $error';
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
  String get gameCenter => 'Spiele';

  @override
  String get gameHighScore => 'Bestleistung';

  @override
  String get gameScore => 'Punkte';

  @override
  String get gameOver => 'Spiel vorbei';

  @override
  String get gamePlayAgain => 'Nochmal spielen';

  @override
  String get gameLeaderboard => 'Bestenliste';

  @override
  String get gamePause => 'Pausiert';

  @override
  String get gameResume => 'Tippen zum Fortfahren';

  @override
  String get gameConfirmExit => 'Spiel beenden?';

  @override
  String get gameNoScores => 'Noch keine Ergebnisse';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Kacheln zusammenführen bis 2048';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Blöcke fallen und Reihen löschen';

  @override
  String get gameMinesweeper => 'Minesweeper';

  @override
  String get gameMinesweeperDesc => 'Finde alle sicheren Felder';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => 'Verbinde 3 oder mehr Juwelen';

  @override
  String get gameMinesweeperEasy => 'Leicht';

  @override
  String get gameMinesweeperMedium => 'Mittel';

  @override
  String get gameMinesLeft => 'Minen übrig';

  @override
  String get gameTimeLeft => 'Zeit';

  @override
  String get gameLevel => 'Level';

  @override
  String get gameNext => 'Nächstes';

  @override
  String get gameBestTime => 'Bestzeit';

  @override
  String get gameNewRecord => 'Neuer Rekord!';

  @override
  String get gameLines => 'Reihen';

  @override
  String get storyMyStory => '我的动态';

  @override
  String get storageSmartCleanup => '智能清理';

  @override
  String get storageOldMediaFiles => '旧媒体文件';

  @override
  String get storageLargeFiles => '大文件';

  @override
  String get storageAppCache => '应用缓存';

  @override
  String get storageSettings => '存储设置';

  @override
  String get storageAutoCleanup => '自动清理';

  @override
  String storageAutoCleanupDesc(int days) {
    return '自动清理 $days 天以上未访问的文件';
  }

  @override
  String get storageCleanupPeriod => '清理周期';

  @override
  String get storagePreserveThumbnails => '保留缩略图';

  @override
  String get storagePreserveThumbnailsDesc => '清理时保留图片缩略图';

  @override
  String get storageWarningHigh => '存储空间较高，建议清理旧文件。';

  @override
  String get storageWarningCritical => '存储空间严重不足，请立即清理。';

  @override
  String storageFreed(String size, int count) {
    return '已释放 $size（$count 个文件）';
  }

  @override
  String storageDays(int days) {
    return '$days 天';
  }

  @override
  String storageViewAllRooms(int count) {
    return '查看全部 $count 个房间';
  }

  @override
  String get storageNoFiles => '暂无文件';

  @override
  String get storageFilePinned => '已保留';

  @override
  String storageDeleteSelected(int count) {
    return '删除 $count 个选中文件？文件可从服务器重新下载。';
  }

  @override
  String get backupRestore => '备份与恢复';

  @override
  String get backupCreate => '创建备份';

  @override
  String get backupCreateDesc => '备份设置和加密密钥。消息将在重新登录后从服务器恢复。';

  @override
  String get backupIncludeKeys => '包含加密密钥';

  @override
  String get backupIncludeKeysDesc => '读取加密消息所必需';

  @override
  String get backupPasswordProtect => '密码保护';

  @override
  String get backupEnterPassword => '输入备份密码';

  @override
  String get backupHistory => '备份历史';

  @override
  String get backupNoBackups => '暂无备份';

  @override
  String get backupRestore2 => '恢复';

  @override
  String get backupDelete => '删除';

  @override
  String get backupDeleteConfirm => '确定删除此备份？此操作不可撤销。';

  @override
  String get backupRestoreFromFile => '从文件恢复';

  @override
  String get backupRestoreFromFileDesc => '导入来自其他设备或之前备份的 .n42backup 文件。';

  @override
  String get backupChooseFile => '选择备份文件';

  @override
  String get backupRestoring => '恢复中...';

  @override
  String backupCreated(int rooms, int messages) {
    return '备份已创建：$rooms 个房间，$messages 条消息';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '已恢复 $settings 项设置（来自 $rooms 个房间）';
  }

  @override
  String backupFailed(String error) {
    return '备份失败：$error';
  }

  @override
  String get backupPasswordRequired => '此备份需要密码';

  @override
  String get blocGroupNotFound => '群组未找到';

  @override
  String blocGroupMembersInvited(int count) {
    return '已邀请$count位成员';
  }

  @override
  String get blocGroupMemberRemoved => '成员已移除';

  @override
  String get blocGroupAdminRemoved => '已取消管理员';

  @override
  String get blocGroupLeft => '已退出群聊';

  @override
  String get blocGroupDisbanded => '群聊已解散';

  @override
  String get blocGroupJoined => '已加入群聊';

  @override
  String get blocGroupInviteDeclined => '已拒绝邀请';

  @override
  String get blocGroupTokenGateUpdated => 'Token 门槛已更新';

  @override
  String get blocTransferProcessing => '转账处理中...';

  @override
  String get blocTransferCancelled => '转账已取消';

  @override
  String get blocTransferFailed => '转账失败';

  @override
  String get blocPaymentProcessing => '支付处理中...';

  @override
  String get blocPaymentFailed => '支付失败';

  @override
  String get groupMaxMembers => '群人数上限';

  @override
  String get groupMaxMembersUnlimited => '不限';

  @override
  String get groupMaxMembersHint => '输入上限（留空表示不限）';

  @override
  String get groupMaxMembersUpdated => '群人数上限已更新';

  @override
  String get groupFull => '群已满员';

  @override
  String get groupChannels => '话题频道';

  @override
  String get groupChannelsEmpty => '暂无话题频道';

  @override
  String get groupChannelsCount => '个频道';

  @override
  String get groupChannelCreate => '新建频道';

  @override
  String get groupChannelName => '频道名称';

  @override
  String get groupChannelTopic => '频道话题（可选）';

  @override
  String get groupChannelDelete => '删除频道';

  @override
  String get groupChannelDeleteConfirm => '确认删除此频道？消息不可恢复。';

  @override
  String get groupBotSettings => 'Bot 设置';

  @override
  String get groupBotEnabled => '启用 Bot';

  @override
  String get groupBotWelcomeMessage => '欢迎语模板';

  @override
  String get groupBotWelcomeHint => '用 \'name\' 作为新成员名字占位符';

  @override
  String get groupBotConfigUpdated => 'Bot 设置已更新';

  @override
  String get groupContentFilter => '关键词过滤';

  @override
  String get groupContentFilterEnabled => '启用关键词过滤';

  @override
  String get groupContentFilterReplace => '替换为 ***';

  @override
  String get groupContentFilterHide => '隐藏消息';

  @override
  String get groupContentFilterAddWord => '添加关键词';

  @override
  String get groupContentFilterUpdated => '内容过滤设置已更新';

  @override
  String get chatSlashCommands => '指令';

  @override
  String get chatCommandPoll => '/poll — 创建投票';

  @override
  String get chatCommandAnnounce => '/announce — 发布公告';

  @override
  String get chatCommandWelcome => '/welcome — 设置欢迎语';

  @override
  String get chatReportMessage => '举报';

  @override
  String get chatReportReason => '举报原因';

  @override
  String get chatReportSpam => '垃圾信息';

  @override
  String get chatReportHarassment => '骚扰';

  @override
  String get chatReportInappropriate => '违规内容';

  @override
  String get chatReportOther => '其他';

  @override
  String get chatReportSuccess => '举报已提交';

  @override
  String get spacesName => '社区名称';

  @override
  String get spacesNameHint => '例如：加密交易者';

  @override
  String get spacesNameRequired => '请输入社区名称';

  @override
  String get spacesDescription => '简介';

  @override
  String get spacesDescriptionHint => '介绍一下这个社区';

  @override
  String get spacesType => '社区类型';

  @override
  String get spacesPublicDesc => '任何人均可发现并加入';

  @override
  String get spacesPrivateDesc => '仅受邀成员可加入';

  @override
  String get spacesNotFound => '社区不存在';

  @override
  String get spacesSearch => '搜索社区...';

  @override
  String get spacesMembers => '成员';

  @override
  String get spacesNoChannels => '暂无频道';

  @override
  String get spacesLeave => '退出社区';

  @override
  String spacesLeaveConfirm(String name) {
    return '确定要退出「$name」吗？';
  }

  @override
  String get spacesDelete => '解散社区';

  @override
  String spacesDeleteConfirm(String name) {
    return '此操作将永久删除「$name」及其所有频道，且不可撤销。';
  }

  @override
  String get spacesCreateChannel => '创建频道';

  @override
  String get spacesChannelName => '频道名称';

  @override
  String get spacesChannelTopic => '话题（可选）';

  @override
  String get spacesDeleteChannel => '删除频道';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return '确定要删除频道「#$name」吗？';
  }

  @override
  String get spacesEditName => '修改名称';

  @override
  String get spacesEditDescription => '修改简介';

  @override
  String spacesViewAllMembers(int count) {
    return '查看全部 $count 位成员';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return '踢出 $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return '封禁 $name';
  }

  @override
  String get spacesPromoteAdmin => '设为管理员';

  @override
  String get spacesDemoteAdmin => '撤销管理员';

  @override
  String get spacesInviteMember => '邀请成员';

  @override
  String get spacesInviteMemberUserId => '用户 ID（如 @user:server.com）';

  @override
  String get spacesSave => '保存';

  @override
  String get settingsScreenshotProtection => '截图防护';

  @override
  String get settingsScreenshotProtectionDesc => '防止截图和屏幕录制';

  @override
  String get chatSelfDestructTimer => '阅后即焚';

  @override
  String get chatTimerPickerTitle => '设置阅后即焚时间';

  @override
  String get chatTimerOff => '关闭';

  @override
  String get onChainNotificationsTitle => 'On-chain-Ereignisse';

  @override
  String get onChainMarkAllRead => 'Alle als gelesen markieren';

  @override
  String get onChainNoNotifications => 'Noch keine On-chain-Ereignisse';

  @override
  String get onChainNoNotificationsDesc =>
      'Ereignisse von abonnierten Kanälen werden hier angezeigt';

  @override
  String get onChainViewDetails => 'Details anzeigen';

  @override
  String get chatCommandHelp => '/help — Alle Befehle anzeigen';

  @override
  String get chatCommandPrice => '/price — Token-Preis abrufen';

  @override
  String get chatCommandBalance => '/balance — Wallet-Guthaben anzeigen';

  @override
  String get chatCommandChains => '/chains — 236+ unterstützte Netzwerke';

  @override
  String get chatMiniApps => 'Apps';

  @override
  String get miniAppMarketTitle => 'Mini-Apps';

  @override
  String get miniAppCategoryAll => 'Alle';

  @override
  String get miniAppSearch => 'Apps suchen...';

  @override
  String get miniAppFeatured => 'Empfohlen';

  @override
  String get miniAppAllApps => 'Alle Apps';

  @override
  String get miniAppNoResults => 'Keine Apps gefunden';

  @override
  String get slideToPayLabel => '→→→  Zum Bestätigen schieben';

  @override
  String get slideToPayConfirming => 'Wird bestätigt...';

  @override
  String get redPacketBestLuck => 'Bestes Glück';

  @override
  String get redPacketBestLuckCongrats =>
      'Bestes Glück! Sie haben am meisten bekommen!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total beansprucht';
  }

  @override
  String get redPacketStatsTotal => 'gesamt';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 Ein rotes Paket erhalten • $amount $token';
  }
}
