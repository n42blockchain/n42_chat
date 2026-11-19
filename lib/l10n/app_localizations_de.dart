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
  String authLoginFailed(Object error) {
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
      'Die Mikrofonberechtigung wurde verweigert. Bitte aktivieren Sie es in den Systemeinstellungen, um Sprachnachrichten zu verwenden.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Aufnahme starten fehlgeschlagen: $error';
  }

  @override
  String get commonRecordingTooShort => 'Aufnahme zu kurz';

  @override
  String commonStopRecordingFailed(Object error) {
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
  String get commonChat => 'Chatten';

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
  String get chatReadAloud => 'Vorlesen';

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
  String contactN42Id(Object id) {
    return 'N42-ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42-ID';

  @override
  String get profileN42Bean => 'N42 Bohne';

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
  String get contactTags => 'Schlagworte';

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
  String profileSaveFailed(Object error) {
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
  String get authAnd => ' und ';

  @override
  String get authPrivacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get authServerAddress => 'Serveradresse';

  @override
  String get authEnterServerAddress => 'Serveradresse eingeben';

  @override
  String authConnectedTo(Object serverName) {
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
  String commonFeatureComingSoon(Object feature) {
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
  String conversationDeleteConversationConfirm(Object name) {
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
  String get contactChatOnlyFriends => 'Nur Chat-Freunde';

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
  String contactRecommendFailed(Object error) {
    return 'Empfehlung fehlgeschlagen: $error';
  }

  @override
  String get profileEnterRemark => 'Bemerkung eingeben';

  @override
  String get contactOpeningChat => 'Chat wird geöffnet...';

  @override
  String contactOpenChatFailed(Object error) {
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
  String commonGroupMembers(Object count) {
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
  String get transferMemoOptional => 'Notiz (optional)';

  @override
  String get transferConfirmTransfer => 'Überweisung bestätigen';

  @override
  String get transferAddressVerified => 'Adresse verifiziert';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
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
  String commonFromSender(String name) {
    return 'Von $name';
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
  String commonSelectImageFailed(Object error) {
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
  String profileSaveAddressFailed(Object error) {
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
  String profileSaveInvoiceFailed(Object error) {
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
  String favoriteOpenItem(Object content) {
    return 'Öffnen: $content';
  }

  @override
  String get favoriteDeleted => 'Gelöscht';

  @override
  String get profileWallet => 'Geldbörse';

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
  String commonFeatureInDevelopment(Object feature) {
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
  String get authRegistrationDisabled =>
      'Die Registrierung auf diesem Server ist deaktiviert. Bitte den Administrator um Aktivierung bitten.';

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
  String get transferMemoLabel => 'Notiz (optional)';

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
    return 'N42-ID: $id';
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
  String get profileOk => 'Okay';

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
  String get searchClearHistoryConfirm => 'Gesamten Suchverlauf löschen?';

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
  String get settingsDeleteAccountTitle => 'Konto löschen';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Dieses Matrix-Konto deaktivieren und seine lokalen Chatdaten bereinigen';

  @override
  String get settingsDeleteAccountExplanation =>
      'Damit wird die dauerhafte Deaktivierung des Matrix-Kontos angefordert. Nach Bestätigung durch den Server entfernt diese App die lokale Chatsitzung und die Verschlüsselungsschlüssel dieses Kontos, sobald dies sicher möglich ist. Andere Konten und Ihre Wallet bleiben erhalten. Föderation und serverseitige Aufbewahrung können die Datenlöschung einschränken.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Matrix-Passwort, falls angefordert';

  @override
  String get settingsDeleteAccountServerErase =>
      'Datenlöschung auf dem Server anfordern';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Bitten Sie diesen Homeserver, Kontodaten zu löschen, soweit dies unterstützt wird. Kopien auf anderen Servern oder aufgrund von Aufbewahrungspflichten können erhalten bleiben.';

  @override
  String get settingsDeleteAccountChooseStage =>
      'Dieses Matrix-Konto verifizieren';

  @override
  String get settingsDeleteAccountUsePassword => 'Matrix-Passwort verwenden';

  @override
  String get settingsDeleteAccountUseBrowser => 'Im Browser fortfahren';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Von der Matrix-Verifizierung zurückkehren';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Die Rückkehr aus dem Browser bestätigt keine Löschung. Prüfen Sie die ursprüngliche Anfrage beim Matrix-Server.';

  @override
  String get settingsDeleteAccountCheckServer => 'Beim Server prüfen';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'Der Matrix-Server hat die Kontolöschung nicht bestätigt.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Lokale Kontobereinigung ausstehend';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Bereinigung eines zuvor deaktivierten Matrix-Kontos prüfen';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Ausstehende Bereinigungsdatensätze konnten nicht gelesen werden. Zum Wiederholen tippen.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Das Matrix-Konto wurde deaktiviert, die lokale Bereinigung steht jedoch noch aus. Andere Konten bleiben verfügbar.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'Die Kontoverwaltung wurde im Browser geöffnet. Die Löschung wurde in dieser App nicht bestätigt, daher bleibt Ihre Chatsitzung verfügbar.';

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
  String get settingsCrossSigning => 'Gegensignieren';

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
  String get settingsBackupSuccess => 'Schlüssel erfolgreich gesichert';

  @override
  String get settingsBackupFailed => 'Die Sicherung ist fehlgeschlagen';

  @override
  String get settingsRecoveryKey => 'Wiederherstellungsschlüssel';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Bitte bewahren Sie diesen Wiederherstellungsschlüssel an einem sicheren Ort auf. Sie benötigen es, um Ihre verschlüsselten Nachrichten auf einem neuen Gerät wiederherzustellen.';

  @override
  String get settingsRecoveryKeySaved => 'Ich habe es gespeichert';

  @override
  String get settingsRestoreSuccess =>
      'Schlüssel erfolgreich wiederhergestellt';

  @override
  String get settingsRestoreEmpty =>
      'In dieser Sicherung wurden keine Nachrichtenschlüssel gefunden.';

  @override
  String settingsRestoreSessions(int count) {
    return '$count Schlüsselsitzungen wiederhergestellt. Nachrichten ohne Schlüssel können verschlüsselt bleiben.';
  }

  @override
  String get settingsRestoreFailed => 'Wiederherstellung fehlgeschlagen';

  @override
  String get settingsPassword => 'Passwort';

  @override
  String get settingsEnterRecoveryKey =>
      'Geben Sie den Wiederherstellungsschlüssel ein';

  @override
  String get settingsEnterPassword => 'Passwort eingeben';

  @override
  String get settingsExportSuccess =>
      'Schlüssel wurden erfolgreich in die Serversicherung exportiert';

  @override
  String get settingsExportNeedBackupFirst =>
      'Bitte erstellen Sie zunächst ein Schlüssel-Backup';

  @override
  String get settingsExportFailed => 'Der Export ist fehlgeschlagen';

  @override
  String get settingsResetSuccess =>
      'Zurücksetzen der Verschlüsselung erfolgreich';

  @override
  String get settingsResetFailed => 'Zurücksetzen fehlgeschlagen';

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
  String get chatNoMediaUrlAvailable => 'Keine Medien-URL verfügbar';

  @override
  String chatDownloadFailed(String code) {
    return 'Download fehlgeschlagen: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Musik-Link';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Rote Umschläge und Überweisungen können nicht weitergeleitet werden';

  @override
  String commonShareFailed(String error) {
    return 'Teilen fehlgeschlagen: $error';
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
  String groupMemberCountClickToCopy(Object count) {
    return '$count Mitglieder, klicken zum Kopieren der Gruppen-ID';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Sie haben keine Berechtigung, den Gruppennamen zu ändern';

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
  String get settingsTranslation => 'Übersetzung';

  @override
  String get settingsTranslateTextTo => 'Text übersetzen in';

  @override
  String get settingsTranslateDescription =>
      'Wählen Sie die Sprache aus, in die Nachrichten übersetzt werden sollen.';

  @override
  String get settingsAutoTranslate =>
      'Empfangene Nachrichten automatisch übersetzen';

  @override
  String get settingsAutoTranslateDescription =>
      'Übersetzen Sie im Chat empfangene Nachrichten automatisch in die von Ihnen ausgewählte Sprache.';

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
  String get authPasskeyLabel => 'Hauptschlüssel';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apfel';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Dieser Server hat keine SSO-Anmeldeanbieter konfiguriert';

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
  String get contactCreateTag => 'Tag erstellen';

  @override
  String get contactEnterTagName => 'Geben Sie den Tag-Namen ein';

  @override
  String get contactEditTag => 'Tag bearbeiten';

  @override
  String get contactDeleteTag => 'Tag löschen';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Sind Sie sicher, dass Sie das Tag „$tagName“ löschen möchten?';
  }

  @override
  String get contactNoTags => 'Noch keine Tags';

  @override
  String get contactFriendPermissions => 'Freundesberechtigungen';

  @override
  String get contactSetChatOnly => 'Als „Nur Chat“ festlegen';

  @override
  String get contactChatOnlyDesc =>
      'Kann nur mit Ihnen chatten, andere Inhalte werden ausgeblendet';

  @override
  String get contactHideMyMoments => 'Verstecke meine Momente';

  @override
  String get contactHideMyMomentsDesc =>
      'Dieser Freund kann meine Momente nicht sehen';

  @override
  String get contactHideTheirMoments => 'Verstecken Sie ihre Momente';

  @override
  String get contactHideTheirMomentsDesc =>
      'Die Momente dieses Freundes werden nicht angezeigt';

  @override
  String get contactHideMyStatus => 'Meinen Status ausblenden';

  @override
  String get contactHideMyStatusDesc =>
      'Dieser Freund kann meine Statusaktualisierungen nicht sehen';

  @override
  String get contactNoChatOnlyFriends => 'Keine Nur-Chat-Freunde';

  @override
  String get contactNoOfficialAccounts => 'Keine offiziellen Konten';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Folgen Sie offiziellen Konten, um die neuesten Updates zu erhalten';

  @override
  String get contactNoServiceAccounts => 'Keine Dienstkonten';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Abonnieren Sie Dienstkonten für praktische Dienste';

  @override
  String get contactNoEnterpriseContacts => 'Keine Unternehmenskontakte';

  @override
  String get contactEnterpriseContactsDesc =>
      'Unternehmenskontakte werden hier angezeigt';

  @override
  String get profileCardPack => 'Kartenpaket';

  @override
  String get profileOrders => 'Bestellungen';

  @override
  String get profileNoOrders => 'Keine Befehle';

  @override
  String get profileOrdersDesc => 'Ihre Bestellungen werden hier angezeigt';

  @override
  String get profileNoCards => 'Keine Karten';

  @override
  String get profileCardsDesc => 'Ihre Karten werden hier angezeigt';

  @override
  String get favoriteEnterTagsHint =>
      'Geben Sie Tags durch Kommas getrennt ein';

  @override
  String get favoriteTagsUpdated => 'Tags aktualisiert';

  @override
  String get favoriteForwardedContent => 'Inhalt weitergeleitet';

  @override
  String get favoriteEnterNoteContent => 'Geben Sie den Notizinhalt ein';

  @override
  String get favoriteNoteAdded => 'Hinweis hinzugefügt';

  @override
  String get favoriteLinkTitle => 'Linktitel';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Link hinzugefügt';

  @override
  String get contactPhotoAdded => 'Foto hinzugefügt';

  @override
  String get contactEnterPhone => 'Geben Sie die Telefonnummer ein';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Unterhaltung: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Kontakt: $userId';
  }

  @override
  String get commonDiscover => 'Entdecken';

  @override
  String commonDeveloping(Object title) {
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
  String get discoverLive => 'Lebe';

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
  String get groupVisibilityUpdated => 'Gruppensichtbarkeit aktualisiert';

  @override
  String get groupChannelCreated => 'Kanal erstellt';

  @override
  String get groupChannelUpdated => 'Kanal aktualisiert';

  @override
  String get groupChannelDeleted => 'Kanal gelöscht';

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
  String callJoinMeetingFailed(Object error) {
    return 'Meeting beitreten fehlgeschlagen: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Bildschirmfreigabe fehlgeschlagen: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bohne';

  @override
  String get profileNoN42Bean => 'Keine N42 Beans';

  @override
  String get profileN42BeanDetails => 'N42-Bean-Details';

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
  String profilePlayFailed(Object ringtoneName) {
    return 'Abspielen fehlgeschlagen: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
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
  String commonReadCount(Object count) {
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
  String get securityDeviceIdRequired => 'Geräte-ID ist erforderlich';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Überprüfung konnte nicht gestartet werden: $error';
  }

  @override
  String get securityVerificationFailed => 'Die Überprüfung ist fehlgeschlagen';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Überprüfung fehlgeschlagen: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Bestätigung abgelehnt – Emoji stimmte nicht überein';

  @override
  String get securityWaitingForDeviceAccept =>
      'Warten auf die Annahme durch das andere Gerät...';

  @override
  String get securityVerifyDevice => 'Überprüfen Sie dieses Gerät';

  @override
  String get securityConfirmEmojiMatch =>
      'Vergewissern Sie sich, dass die folgenden Emojis auf beiden Geräten in derselben Reihenfolge angezeigt werden';

  @override
  String get securityEmojiDontMatch => 'Sie passen nicht zusammen';

  @override
  String get securityEmojiMatch => 'Sie passen zusammen';

  @override
  String get securityWaitingForDeviceConfirm =>
      'Warten auf die Bestätigung des anderen Geräts...';

  @override
  String get securityVerificationSuccess => 'Verifizierung erfolgreich!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Dieses Gerät ist jetzt verifiziert und vertrauenswürdig.';

  @override
  String get securityCompareEmoji =>
      'Vergleichen Sie die Emojis auf beiden Geräten';

  @override
  String get securityCompareNumbers =>
      'Vergleichen Sie die Zahlen auf beiden Geräten';

  @override
  String get commonTryAgain => 'Versuchen Sie es erneut';

  @override
  String get commonDone => 'Fertig';

  @override
  String get chatExportTitle => 'Chat exportieren';

  @override
  String get chatExportSuccess => 'Export erfolgreich';

  @override
  String chatExportFailed(String error) {
    return 'Export fehlgeschlagen: $error';
  }

  @override
  String get chatExportFormat => 'Exportformat';

  @override
  String get chatExportHtmlDesc =>
      'In jedem Browser mit gestaltetem Layout lesbar';

  @override
  String get chatExportJsonDesc =>
      'Maschinenlesbares strukturiertes Datenformat';

  @override
  String get chatExportDateRange => 'Datumsbereich';

  @override
  String get chatExportAll => 'Alle Nachrichten';

  @override
  String get chatExportLastWeek => 'Letzte 7 Tage';

  @override
  String get chatExportLastMonth => 'Letzten Monat';

  @override
  String get chatExportLast3Months => 'Letzte 3 Monate';

  @override
  String get chatExportMessageCount => 'Zu exportierende Nachrichten';

  @override
  String get chatExportButton => 'Exportieren und teilen';

  @override
  String get chatMediaGallery => 'Mediengalerie';

  @override
  String get chatExportHistory => 'Chatverlauf exportieren';

  @override
  String get pdfLoadFailed => 'PDF konnte nicht geladen werden';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'Alle';

  @override
  String get mediaImages => 'Bilder';

  @override
  String get mediaVideos => 'Videos';

  @override
  String get mediaFiles => 'Dateien';

  @override
  String get mediaAudio => 'Audio';

  @override
  String mediaItemsCount(int count) {
    return '$count Artikel';
  }

  @override
  String get mediaNoMediaFound => 'Keine Medien gefunden';

  @override
  String get spacesTitle => 'Gemeinschaften';

  @override
  String get spacesCreate => 'Erstellen Sie eine Community';

  @override
  String get spacesJoined => 'Beigetreten';

  @override
  String get spacesDiscover => 'Entdecken';

  @override
  String get spacesNoJoined => 'Es sind noch keine Communities beigetreten';

  @override
  String get spacesExplore => 'Entdecken Sie Communities';

  @override
  String get spacesNoPublic => 'Keine öffentlichen Communities gefunden';

  @override
  String get spacesJoin => 'Machen Sie mit';

  @override
  String get spacesSubSpaces => 'Untergemeinschaften';

  @override
  String get spacesChannels => 'Kanäle';

  @override
  String spacesMembersCount(int count) {
    return '$count-Mitglieder';
  }

  @override
  String get spacesPublic => 'Öffentlich';

  @override
  String get spacesPrivate => 'Privat';

  @override
  String get spacesSuggested => 'Vorgeschlagen';

  @override
  String spacesChannelsCount(int count) {
    return '$count-Kanäle';
  }

  @override
  String get callInCallChat => 'In-Call-Chat';

  @override
  String callMessagesCount(int count) {
    return '$count-Nachrichten';
  }

  @override
  String get callNoMessagesYet =>
      'Noch keine Nachrichten.\nSenden Sie eine Nachricht, um loszulegen.';

  @override
  String get callTypeMessage => 'Geben Sie eine Nachricht ein...';

  @override
  String get callYouSender => 'Du';

  @override
  String get callChatLabel => 'Chatten';

  @override
  String get chatEdited => 'Bearbeitet';

  @override
  String get chatEditHistory => 'Verlauf bearbeiten';

  @override
  String get chatOriginalMessage => 'Original';

  @override
  String chatEditedAt(String time) {
    return 'Bearbeitet unter $time';
  }

  @override
  String get chatViewOnce => 'Einmal ansehen';

  @override
  String get chatViewOncePhoto => 'Einmaliges Foto ansehen';

  @override
  String get chatViewOnceVideo => 'Video einmal ansehen';

  @override
  String get chatViewOnceViewed => 'Gesehen';

  @override
  String get chatViewOnceExpired => 'Abgelaufen';

  @override
  String get chatViewOnceTap => 'Zum Ansehen antippen';

  @override
  String get chatAutoFaceBlur => 'Automatische Gesichtsunschärfe';

  @override
  String get chatAutoFaceBlurDesc =>
      'Gesichter beim Senden von Fotos automatisch unkenntlich machen';

  @override
  String get threadReplyInThread => 'Im Thread antworten';

  @override
  String threadReplies(int count) {
    return '$count antwortet';
  }

  @override
  String get threadReply => '1 Antwort';

  @override
  String threadLatestReply(String preview) {
    return 'Neueste: $preview';
  }

  @override
  String get threadTitle => 'Faden';

  @override
  String get threadReplyPlaceholder => 'Im Thread antworten...';

  @override
  String threadParticipants(int count) {
    return '$count Teilnehmer';
  }

  @override
  String get voiceRoomTitle => 'Sprachraum';

  @override
  String get voiceRoomCreate => 'Erstellen Sie einen Sprachraum';

  @override
  String get voiceRoomJoin => 'Machen Sie mit';

  @override
  String get voiceRoomLeave => 'Geh';

  @override
  String get voiceRoomEnd => 'Endraum';

  @override
  String get voiceRoomRaiseHand => 'Hand heben';

  @override
  String get voiceRoomLowerHand => 'Untere Hand';

  @override
  String get voiceRoomMute => 'Stumm';

  @override
  String get voiceRoomUnmute => 'Stummschaltung aufheben';

  @override
  String get voiceRoomHost => 'Gastgeber';

  @override
  String get voiceRoomSpeakers => 'Lautsprecher';

  @override
  String get voiceRoomListeners => 'Zuhörer';

  @override
  String get voiceRoomLive => 'LEBEN';

  @override
  String get voiceRoomEnded => 'Beendet';

  @override
  String get voiceRoomScheduled => 'Geplant';

  @override
  String get voiceRoomApprove => 'Genehmigen';

  @override
  String get voiceRoomDemote => 'Zum Listener wechseln';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name hob die Hand';
  }

  @override
  String get voiceRoomName => 'Raumname';

  @override
  String get voiceRoomTopic => 'Thema (optional)';

  @override
  String get voiceRoomNoActive => 'Keine Active-Voice-Räume';

  @override
  String get voiceRoomConnecting => 'Verbinden...';

  @override
  String get usernameTitle => 'Benutzername';

  @override
  String get usernameSet => 'Benutzernamen festlegen';

  @override
  String get usernameChange => 'Benutzernamen ändern';

  @override
  String get usernamePlaceholder => 'Geben Sie den Benutzernamen ein';

  @override
  String get usernameAvailable => 'Benutzername verfügbar';

  @override
  String get usernameUnavailable => 'Benutzername bereits vergeben';

  @override
  String get usernameInvalid =>
      '3-30 Zeichen, Kleinbuchstaben, Zahlen, Unterstrich. Muss mit einem Buchstaben beginnen.';

  @override
  String get usernameReserved => 'Dieser Benutzername ist reserviert';

  @override
  String get usernameSaved => 'Benutzername gespeichert';

  @override
  String get usernameSearchHint => 'Suche nach @Benutzername';

  @override
  String get ensName => 'ENS-Name';

  @override
  String get ensLinked => 'Verbunden mit ENS';

  @override
  String get ensResolving => 'ENS wird gelöst...';

  @override
  String get ensNotFound => 'ENS-Name nicht gefunden';

  @override
  String get tokenGateTitle => 'Token-Tor';

  @override
  String get tokenGateEnable => 'Aktivieren Sie Token Gate';

  @override
  String get tokenGateDisable => 'Deaktivieren Sie Token Gate';

  @override
  String get tokenGateAddRule => 'Regel hinzufügen';

  @override
  String get tokenGateRemoveRule => 'Regel entfernen';

  @override
  String get tokenGateContractAddress => 'Vertragsadresse';

  @override
  String get tokenGateMinBalance => 'Mindestguthaben';

  @override
  String get tokenGateTokenId => 'Token-ID (ERC-1155)';

  @override
  String get tokenGateChainId => 'Ketten-ID';

  @override
  String get tokenGateVerifying => 'Token-Bestände werden überprüft...';

  @override
  String get tokenGateVerified => 'Verifizierung bestanden';

  @override
  String get tokenGateDenied => 'Sie erfüllen die Token-Anforderungen nicht';

  @override
  String get tokenGateOperatorAnd => 'Muss ALLE Regeln erfüllen';

  @override
  String get tokenGateOperatorOr => 'Muss JEDE Regel erfüllen';

  @override
  String get tokenGateRuleErc20 => 'ERC-20-Token';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Multi-Token (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Natives Token';

  @override
  String get tokenGateSaved => 'Token-Gate gespeichert';

  @override
  String get tokenGateEnableDescription =>
      'Fordern Sie die Mitglieder auf, Token zu besitzen, um beitreten zu können';

  @override
  String get tokenGateOperator => 'Regellogik';

  @override
  String get tokenGateRules => 'Regeln';

  @override
  String get tokenGateSymbol => 'Symbol (optional)';

  @override
  String get tokenGateChain => 'Kette';

  @override
  String get tokenGateTokenStandard => 'Token-Standard';

  @override
  String get tokenGateDenialMessage => 'Ablehnungsnachricht';

  @override
  String get tokenGateDenialMessageHint =>
      'Meldung wird angezeigt, wenn die Überprüfung fehlschlägt';

  @override
  String get tokenGateVerifyTitle => 'Token-Verifizierung';

  @override
  String get tokenGateVerifyPassed => 'Überprüfung bestanden';

  @override
  String get tokenGateVerifyFailed => 'Überprüfung fehlgeschlagen';

  @override
  String get tokenGateRetryVerify => 'Versuchen Sie es noch einmal';

  @override
  String get tokenGateRequired => 'Erforderlich';

  @override
  String get tokenGateYourBalance => 'Ihr Gleichgewicht';

  @override
  String get tokenGateRulesActive => 'Regeln aktiv';

  @override
  String get tokenGateDisabled => 'Deaktiviert';

  @override
  String get ensNotBound => 'Nicht gebunden';

  @override
  String get liveLocation => 'Live-Standort';

  @override
  String get stopLiveLocation => 'Hören Sie auf zu teilen';

  @override
  String get startLiveLocation => 'Beginnen Sie mit dem Teilen';

  @override
  String get selectDuration => 'Wählen Sie Dauer aus';

  @override
  String get groupChatFiles => 'Chat-Dateien';

  @override
  String get groupLinks => 'Links';

  @override
  String get groupNoLinks => 'Noch keine Links';

  @override
  String get chatBackground => 'Chat-Hintergrund';

  @override
  String get solidColors => 'Einfarbige Farben';

  @override
  String get gradients => 'Farbverläufe';

  @override
  String get defaultBackground => 'Standard';

  @override
  String get settingsFontSizeSlider => 'Schriftgröße';

  @override
  String get autoDownload => 'Automatischer Download';

  @override
  String get images => 'Bilder';

  @override
  String get voice => 'Stimme';

  @override
  String get video => 'Video';

  @override
  String get files => 'Dateien';

  @override
  String get mobileData => 'Mobile Daten';

  @override
  String get roaming => 'Wandernd';

  @override
  String get storageManagement => 'Lagerung';

  @override
  String get totalUsage => 'Gesamtnutzung';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Andere';

  @override
  String get clearCache => 'Cache leeren';

  @override
  String get cacheCleared => 'Cache geleert';

  @override
  String get clearCacheFailed => 'Cache konnte nicht geleert werden';

  @override
  String get confirmClearCache => 'Alle Cache-Daten löschen?';

  @override
  String get mapView => 'Kartenansicht';

  @override
  String liveLocationSharingCount(int count) {
    return '$count Personen teilen ihren Standort';
  }

  @override
  String get minutes15 => '15 Minuten';

  @override
  String get minutes30 => '30 Minuten';

  @override
  String get hour1 => '1 Stunde';

  @override
  String get hours8 => '8 Stunden';

  @override
  String get personalCard => 'Persönliche Karte';

  @override
  String get downloadFailed => 'Der Download ist fehlgeschlagen';

  @override
  String get locationExpired => 'Abgelaufen';

  @override
  String secondsRemaining(int count) {
    return '$count Sekunden';
  }

  @override
  String minutesRemaining(int count) {
    return '$count Minuten';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours Stunden $minutes Minuten';
  }

  @override
  String get favoriteMessages => 'Favoriten';

  @override
  String get linksCopied => 'Link kopiert';

  @override
  String get noLinksFound => 'Keine Links gefunden';

  @override
  String get roomStorageRanking => 'Rangliste der Raumaufbewahrung';

  @override
  String get downloadComplete => 'Download abgeschlossen';

  @override
  String get downloading => 'Herunterladen...';

  @override
  String get draftSaved => 'Entwurf gespeichert';

  @override
  String get voiceRecording => 'Sprachaufzeichnung';

  @override
  String get searchLocation => 'Standort suchen';

  @override
  String get tapToSearch => 'Zum Suchen tippen';

  @override
  String get settingsThisDevice => 'Dieses Gerät';

  @override
  String get settingsJustNow => 'Gerade eben';

  @override
  String get settingsDeviceId => 'Geräte-ID';

  @override
  String get settingsStatus => 'Status';

  @override
  String get settingsLastActive => 'Zuletzt aktiv';

  @override
  String get settingsIpAddress => 'IP-Adresse';

  @override
  String get settingsRenameDevice => 'Gerät umbenennen';

  @override
  String get settingsDeviceNameHint => 'Geben Sie den Gerätenamen ein';

  @override
  String get settingsDeviceRenamed => 'Gerät umbenannt';

  @override
  String get settingsRenameFailed => 'Umbenennen fehlgeschlagen';

  @override
  String get settingsRemoteLogout => 'Remote-Abmeldung';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Sind Sie sicher, dass Sie sich „$deviceName“ abmelden möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Gerät abgemeldet';

  @override
  String get settingsLogoutFailed => 'Die Abmeldung ist fehlgeschlagen';

  @override
  String get settingsLogout => 'Abmelden';

  @override
  String get settingsVerifyIdentity => 'Identität überprüfen';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Geben Sie Ihr Passwort ein, um diese Aktion zu bestätigen.';

  @override
  String get scheduledSendTitle => 'Nachricht planen';

  @override
  String get scheduledSendInOneHour => 'In 1 Stunde';

  @override
  String get scheduledSendTonight => 'Heute Abend (20:00 Uhr)';

  @override
  String get scheduledSendTomorrowMorning => 'Morgen früh (9:00 Uhr)';

  @override
  String get scheduledSendCustom => 'Wählen Sie ein Datum und eine Uhrzeit';

  @override
  String get scheduledMessageLabel => 'Geplant';

  @override
  String get scheduledMessageCancel => 'Geplante Nachricht abbrechen';

  @override
  String get chatLockTitle => 'Chat-Sperre';

  @override
  String get chatLockEnable => 'Sperren Sie diesen Chat';

  @override
  String get chatLockDisable => 'Schalten Sie diesen Chat frei';

  @override
  String get chatLockDescription =>
      'Gesperrte Chats erfordern zum Öffnen eine biometrische oder PIN-Verifizierung';

  @override
  String get chatLockVerifyTitle => 'Chat gesperrt';

  @override
  String get chatLockVerifySubtitle =>
      'Bestätigen Sie, um auf diesen Chat zuzugreifen';

  @override
  String get chatLockVerifyFailed => 'Die Überprüfung ist fehlgeschlagen';

  @override
  String get chatLockEnabled => 'Chat gesperrt';

  @override
  String get chatLockDisabled => 'Chat freigeschaltet';

  @override
  String get chatLockPinTitle => 'PIN eingeben';

  @override
  String get chatLockPinSetTitle => 'PIN festlegen';

  @override
  String get chatLockPinConfirmTitle => 'PIN bestätigen';

  @override
  String get chatLockPinMismatch => 'PIN stimmt nicht überein';

  @override
  String get chatLockUseBiometric => 'Verwenden Sie biometrische Daten';

  @override
  String get chatLockUsePin => 'PIN verwenden';

  @override
  String get mediaEditorUndo => 'Rückgängig machen';

  @override
  String get mediaEditorRedo => 'Wiederholen';

  @override
  String get mediaEditorCrop => 'Zuschneiden';

  @override
  String get mediaEditorFilter => 'Filtern';

  @override
  String get mediaEditorDraw => 'Zeichnen';

  @override
  String get mediaEditorText => 'Text';

  @override
  String get aiAssistant => 'KI-Assistent';

  @override
  String get aiAssistantWelcome =>
      'Hallo! Ich bin der N42 AI Assistant. Wie kann ich dir helfen?';

  @override
  String get aiAssistantNotConfigured => 'AI-Dienst nicht konfiguriert';

  @override
  String get aiAssistantSettings => 'AI-Einstellungen';

  @override
  String get aiAssistantClearHistory => 'Chatverlauf löschen';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Sind Sie sicher, dass Sie den gesamten AI-Chatverlauf löschen möchten?';

  @override
  String get aiAssistantStopGenerating => 'Hören Sie auf zu generieren';

  @override
  String get aiAssistantModel => 'Modell';

  @override
  String get aiAssistantTemperature => 'Temperatur';

  @override
  String get aiAssistantMaxTokens => 'Max. Token';

  @override
  String get aiAssistantContextWindow => 'Kontextfenster';

  @override
  String get aiAssistantServiceStatus => 'Servicestatus';

  @override
  String get aiAssistantAvailable => 'Verfügbar';

  @override
  String get aiAssistantUnavailable => 'Nicht verfügbar';

  @override
  String get aiSummarize => 'KI-Zusammenfassung';

  @override
  String aiSummarizeUnread(int count) {
    return 'Fassen Sie ungelesene $count-Nachrichten zusammen';
  }

  @override
  String get aiSummarizeLoading => 'Zusammenfassend...';

  @override
  String get aiSummarizeError => 'Zusammenfassung fehlgeschlagen';

  @override
  String get aiRewrite => 'KI-Umschreibung';

  @override
  String get aiRewriteFormal => 'Formell';

  @override
  String get aiRewriteCasual => 'Lässig';

  @override
  String get aiRewritePlayful => 'Verspielt';

  @override
  String get aiRewriteProfessional => 'Professionell';

  @override
  String get aiRewriteAccept => 'Benutzen';

  @override
  String get aiRewriteCancel => 'Abbrechen';

  @override
  String get aiRewriteLoading => 'Umschreiben...';

  @override
  String get aiLinkSummary => 'KI-Zusammenfassung';

  @override
  String get aiLinkSummaryAnalyzing => 'Analysieren...';

  @override
  String get chatFolderManagement => 'Ordner verwalten';

  @override
  String get chatFolderSystem => 'Systemordner';

  @override
  String get chatFolderCustom => 'Benutzerdefinierte Ordner';

  @override
  String get chatFolderEmpty => 'Noch keine benutzerdefinierten Ordner';

  @override
  String get chatFolderCreate => 'Ordner erstellen';

  @override
  String get chatFolderEdit => 'Ordner bearbeiten';

  @override
  String get chatFolderNameHint => 'Ordnername';

  @override
  String get chatFolderAll => 'Alle';

  @override
  String get chatFolderUnread => 'Ungelesen';

  @override
  String get chatFolderPersonal => 'Persönlich';

  @override
  String get chatFolderGroups => 'Gruppen';

  @override
  String get chatFolderChannels => 'Kanäle';

  @override
  String get chatFolderMuted => 'Stummgeschaltet';

  @override
  String get storyAddMusic => 'Musik hinzufügen';

  @override
  String get storyChangeMusic => 'Musik ändern';

  @override
  String get storyBackgroundMusic => 'Hintergrundmusik';

  @override
  String get storyMusicPreview => 'Vorschau (max. 15 Sekunden)';

  @override
  String get storyChooseFromDevice => 'Wählen Sie „Gerät“.';

  @override
  String get storyUseThisMusic => 'Benutze diese Musik';

  @override
  String get authPasskeyNotSupported =>
      'Der Passkey wird auf diesem Gerät nicht unterstützt';

  @override
  String get authPasskeyRegister => 'Passkey registrieren';

  @override
  String get authPasskeyNoRegistered => 'Keine Passkeys registriert';

  @override
  String get authPasskeyRegisterHint =>
      'Registrieren Sie einen Passkey für dieses Konto. Die eigenständige Anmeldung mit Passschlüssel wird später aktiviert.';

  @override
  String get authPasskeyNameYours => 'Benennen Sie Ihren Passkey';

  @override
  String get authPasskeyRegistered => 'In diesem Konto gespeicherter Passkey';

  @override
  String get authPasskeyDeleted =>
      'Der Passkey wurde von diesem Konto entfernt';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Passkey „$name“ löschen? Sie müssen es erneut registrieren, bevor Sie später die Passkey-Anmeldung verwenden können.';
  }

  @override
  String get momentVisibilityPublic => 'Öffentlich';

  @override
  String get momentVisibilityPrivate => 'Privat';

  @override
  String get momentVisibilityPartial => 'Ausgewählte Freunde';

  @override
  String get momentVisibilityExcluded => 'Schließen Sie einige Freunde aus';

  @override
  String momentUserMoments(String userName) {
    return '${userName}s Momente';
  }

  @override
  String get momentForwardTo => 'Weiterleiten an';

  @override
  String get momentForwardSuccess => 'Erfolgreich weitergeleitet';

  @override
  String get momentSelectFriends => 'Wählen Sie Freunde aus';

  @override
  String get momentSelectTags => 'Nach Tags auswählen';

  @override
  String momentSelectedCount(int count) {
    return 'Ausgewählt ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Noch keine Momente';

  @override
  String get momentForwardMoment => 'Vorwärtsmoment';

  @override
  String get momentAddComment => 'Kommentar hinzufügen...';

  @override
  String momentForwardContent(String content) {
    return '[Moment] $content';
  }

  @override
  String get momentDeleteMoment => 'Moment löschen';

  @override
  String get momentDeleteConfirm =>
      'Sind Sie sicher, dass Sie diesen Moment löschen möchten?';

  @override
  String get momentComment => 'Kommentar';

  @override
  String get momentWriteComment => 'Schreibe einen Kommentar...';

  @override
  String get momentLike => 'Wie';

  @override
  String get momentUnlike => 'Anders als';

  @override
  String get momentForward => 'Vorwärts';

  @override
  String get momentDelete => 'Löschen';

  @override
  String get momentReply => 'antworten';

  @override
  String get momentMoment => 'Augenblick';

  @override
  String momentLikesCount(int count) {
    return '$count gefällt';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count Kommentare';
  }

  @override
  String get momentNoComments => 'Noch keine Kommentare';

  @override
  String get momentFailedToLoad => 'Bild konnte nicht geladen werden';

  @override
  String momentReplyTo(String userName) {
    return 'Antwort auf $userName...';
  }

  @override
  String get momentNoConversations => 'Keine Gespräche';

  @override
  String get momentJustNow => 'gerade jetzt';

  @override
  String momentMinutesAgo(int count) {
    return 'Vor ${count}m';
  }

  @override
  String momentHoursAgo(int count) {
    return 'Vor ${count}h';
  }

  @override
  String momentDaysAgo(int count) {
    return 'Vor ${count}d';
  }

  @override
  String get chatGroupAnnouncementHint => 'Geben Sie die Gruppenansage ein';

  @override
  String get chatGroupAnnouncementEmpty => 'Keine Ankündigung';

  @override
  String get chatEditNickname => 'Spitzname bearbeiten';

  @override
  String get chatNicknameHint =>
      'Geben Sie Ihren Spitznamen in dieser Gruppe ein';

  @override
  String get contactAddPhoneHint => 'Geben Sie die Telefonnummer ein';

  @override
  String get contactNotesHint => 'Fügen Sie Notizen zu diesem Kontakt hinzu';

  @override
  String get reportTitle => 'Bericht';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Belästigung';

  @override
  String get reportReasonFraud => 'Betrug';

  @override
  String get reportReasonOther => 'Andere';

  @override
  String get reportSubmitted => 'Bericht eingereicht';

  @override
  String get reportDescription => 'Zusätzliche Beschreibung (optional)';

  @override
  String get qrcodeSaved => 'QR-Code im Album gespeichert';

  @override
  String get chatSendRedPacketInChat =>
      'Bitte senden Sie ein rotes Paket im Chat';

  @override
  String get commonSaveFailed => 'Speichern fehlgeschlagen';

  @override
  String get reportSelectReason => 'Bitte wählen Sie einen Grund aus';

  @override
  String get reportUnavailable =>
      'Melden Sie sich an, um eine Meldung zu senden.';

  @override
  String get reportAccountChanged =>
      'Das Konto wurde gewechselt. Öffnen Sie diese Meldung erneut, um sie zu senden.';

  @override
  String get reportUnsupported =>
      'Dieser Homeserver unterstützt keine Nutzermeldungen.';

  @override
  String get reportRoomUnsupported =>
      'Dieser Homeserver unterstützt keine Raummeldungen.';

  @override
  String get reportRateLimited =>
      'Zu viele Meldungen. Versuchen Sie es später erneut.';

  @override
  String get reportCouldNotSend =>
      'Die Meldung konnte nicht gesendet werden. Versuchen Sie es erneut.';

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
  String get gameBlockDrop => 'Block-Drop';

  @override
  String get gameBlockDropDesc => 'Blöcke fallen und Reihen löschen';

  @override
  String get gameMinesweeper => 'Minensuchboot';

  @override
  String get gameMinesweeperDesc => 'Finde alle sicheren Felder';

  @override
  String get gameMatch3 => 'Spiel 3';

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
  String get gameLevel => 'Ebene';

  @override
  String get gameNext => 'Nächstes';

  @override
  String get gameBestTime => 'Bestzeit';

  @override
  String get gameNewRecord => 'Neuer Rekord!';

  @override
  String get gameLines => 'Reihen';

  @override
  String get storyMyStory => 'Meine Geschichte';

  @override
  String get storageSmartCleanup => 'Intelligente Reinigung';

  @override
  String get storageOldMediaFiles => 'Alte Mediendateien';

  @override
  String get storageLargeFiles => 'Große Dateien';

  @override
  String get storageAppCache => 'App-Cache';

  @override
  String get storageSettings => 'Speichereinstellungen';

  @override
  String get storageAutoCleanup => 'Automatische Bereinigung';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Bereinigen Sie automatisch Dateien, die älter als $days Tage sind';
  }

  @override
  String get storageCleanupPeriod => 'Aufräumzeitraum';

  @override
  String get storagePreserveThumbnails => 'Miniaturansichten beibehalten';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Behalten Sie die Miniaturansichten der Bilder während der Bereinigung bei';

  @override
  String get storageWarningHigh =>
      'Die Speichernutzung ist hoch. Erwägen Sie, alte Dateien zu bereinigen.';

  @override
  String get storageWarningCritical =>
      'Der Speicher ist kritisch niedrig. Bitte räumen Sie auf, um Speicherplatz freizugeben.';

  @override
  String storageFreed(String size, int count) {
    return 'Freigegebene $size ($count-Dateien)';
  }

  @override
  String storageDays(int days) {
    return '$days Tage';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Alle $count-Räume anzeigen';
  }

  @override
  String get storageNoFiles => 'Keine Dateien gefunden';

  @override
  String get storageFilePinned => 'Angepinnt';

  @override
  String storageDeleteSelected(int count) {
    return '$count ausgewählte Dateien löschen? Sie können erneut vom Server heruntergeladen werden.';
  }

  @override
  String get backupRestore => 'Sichern und Wiederherstellen';

  @override
  String get backupCreate => 'Backup erstellen';

  @override
  String get backupCreateDesc =>
      'Sichern Sie Ihre Einstellungen und Verschlüsselungsschlüssel. Nachrichten werden nach der erneuten Anmeldung vom Server wiederhergestellt.';

  @override
  String get backupIncludeKeys => 'Fügen Sie Verschlüsselungsschlüssel hinzu';

  @override
  String get backupIncludeKeysDesc =>
      'Erforderlich zum Lesen verschlüsselter Nachrichten';

  @override
  String get backupPasswordProtect => 'Passwortschutz';

  @override
  String get backupEnterPassword => 'Geben Sie das Backup-Passwort ein';

  @override
  String get backupHistory => 'Sicherungsverlauf';

  @override
  String get backupNoBackups => 'Noch keine Backups';

  @override
  String get backupRestore2 => 'Wiederherstellen';

  @override
  String get backupDelete => 'Löschen';

  @override
  String get backupDeleteConfirm =>
      'Sind Sie sicher, dass Sie dieses Backup löschen möchten? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get backupRestoreFromFile => 'Aus Datei wiederherstellen';

  @override
  String get backupRestoreFromFileDesc =>
      'Importieren Sie eine .n42backup-Datei von einem anderen Gerät oder einem früheren Backup.';

  @override
  String get backupChooseFile => 'Wählen Sie Sicherungsdatei';

  @override
  String get backupRestoring => 'Wiederherstellung...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Backup erstellt: $rooms Räume, $messages Nachrichten';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '$settings-Einstellungen aus $rooms-Räumen wiederhergestellt';
  }

  @override
  String backupFailed(String error) {
    return 'Sicherung fehlgeschlagen: $error';
  }

  @override
  String get backupPasswordRequired => 'Dieses Backup ist passwortgeschützt';

  @override
  String get blocGroupNotFound => 'Gruppe nicht gefunden';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Eingeladene(s) $count-Mitglied(er)';
  }

  @override
  String get blocGroupMemberRemoved => 'Mitglied entfernt';

  @override
  String get blocGroupAdminRemoved => 'Administrator entfernt';

  @override
  String get blocGroupLeft => 'Hat die Gruppe verlassen';

  @override
  String get blocGroupDisbanded => 'Gruppe aufgelöst';

  @override
  String get blocGroupJoined => 'Der Gruppe beigetreten';

  @override
  String get blocGroupInviteDeclined => 'Einladung abgelehnt';

  @override
  String get blocGroupTokenGateUpdated => 'Token-Gate aktualisiert';

  @override
  String get blocTransferProcessing => 'Übertragung wird bearbeitet...';

  @override
  String get blocTransferCancelled => 'Übertragung abgebrochen';

  @override
  String get blocTransferFailed => 'Die Übertragung ist fehlgeschlagen';

  @override
  String get blocPaymentProcessing => 'Zahlung wird bearbeitet...';

  @override
  String get blocPaymentFailed => 'Die Zahlung ist fehlgeschlagen';

  @override
  String get groupMaxMembers => 'Mitgliederlimit';

  @override
  String get groupMaxMembersUnlimited => 'Unbegrenzt';

  @override
  String get groupMaxMembersHint =>
      'Limit eingeben (leer lassen für unbegrenzt)';

  @override
  String get groupMaxMembersUpdated => 'Mitgliederlimit aktualisiert';

  @override
  String get groupFull => 'Die Gruppe ist ausgelastet';

  @override
  String get groupChannels => 'Themenkanäle';

  @override
  String get groupChannelsEmpty => 'Noch keine Kanäle';

  @override
  String get groupChannelsCount => 'Kanäle';

  @override
  String get groupChannelCreate => 'Neuer Kanal';

  @override
  String get groupChannelName => 'Kanalname';

  @override
  String get groupChannelTopic => 'Kanalthema (optional)';

  @override
  String get groupChannelDelete => 'Kanal löschen';

  @override
  String get groupChannelDeleteConfirm =>
      'Diesen Kanal löschen? Alle Nachrichten gehen verloren.';

  @override
  String get groupBotSettings => 'Bot-Einstellungen';

  @override
  String get groupBotEnabled => 'Bot aktivieren';

  @override
  String get groupBotWelcomeMessage => 'Vorlage für eine Willkommensnachricht';

  @override
  String get groupBotWelcomeHint =>
      'Verwenden Sie „Name“ als Platzhalter für den Namen des neuen Mitglieds';

  @override
  String get groupBotConfigUpdated => 'Bot-Einstellungen aktualisiert';

  @override
  String get groupContentFilter => 'Inhaltsfilter';

  @override
  String get groupContentFilterEnabled =>
      'Aktivieren Sie den Schlüsselwortfilter';

  @override
  String get groupContentFilterReplace => 'Durch *** ersetzen';

  @override
  String get groupContentFilterHide => 'Nachricht ausblenden';

  @override
  String get groupContentFilterAddWord => 'Schlüsselwort hinzufügen';

  @override
  String get groupContentFilterUpdated => 'Inhaltsfilter aktualisiert';

  @override
  String get chatSlashCommands => 'Befehle';

  @override
  String get chatCommandPoll => '/poll – Erstellen Sie eine Umfrage';

  @override
  String get chatCommandAnnounce => '/announce – Ankündigung senden';

  @override
  String get chatCommandWelcome => '/welcome – Begrüßungsnachricht festlegen';

  @override
  String get chatReportMessage => 'Bericht';

  @override
  String get chatReportReason => 'Grund melden';

  @override
  String get chatReportSpam => 'Spam';

  @override
  String get chatReportHarassment => 'Belästigung';

  @override
  String get chatReportInappropriate => 'Unangemessener Inhalt';

  @override
  String get chatReportOther => 'Andere';

  @override
  String get chatReportSuccess => 'Bericht eingereicht';

  @override
  String get spacesName => 'Community-Name';

  @override
  String get spacesNameHint => 'z.B. Krypto-Händler';

  @override
  String get spacesNameRequired => 'Name ist erforderlich';

  @override
  String get spacesDescription => 'Beschreibung';

  @override
  String get spacesDescriptionHint => 'Worum geht es in dieser Community?';

  @override
  String get spacesType => 'Community-Typ';

  @override
  String get spacesPublicDesc => 'Jeder kann entdecken und mitmachen';

  @override
  String get spacesPrivateDesc => 'Nur eingeladene Mitglieder können beitreten';

  @override
  String get spacesNotFound => 'Community nicht gefunden';

  @override
  String get spacesSearch => 'Communities durchsuchen...';

  @override
  String get spacesMembers => 'Mitglieder';

  @override
  String get spacesNoChannels => 'Noch keine Kanäle';

  @override
  String get spacesLeave => 'Community verlassen';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Sind Sie sicher, dass Sie „$name“ verlassen möchten?';
  }

  @override
  String get spacesDelete => 'Community löschen';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Dadurch werden „$name“ und alle seine Kanäle dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get spacesCreateChannel => 'Kanal hinzufügen';

  @override
  String get spacesChannelName => 'Kanalname';

  @override
  String get spacesChannelTopic => 'Thema (optional)';

  @override
  String get spacesDeleteChannel => 'Kanal löschen';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Sind Sie sicher, dass Sie „#$name“ löschen möchten?';
  }

  @override
  String get spacesEditName => 'Namen bearbeiten';

  @override
  String get spacesEditDescription => 'Beschreibung bearbeiten';

  @override
  String spacesViewAllMembers(int count) {
    return 'Alle $count-Mitglieder anzeigen';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Tritt $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Verbot $name';
  }

  @override
  String get spacesPromoteAdmin => 'Zum Admin hochstufen';

  @override
  String get spacesDemoteAdmin => 'Admin entfernen';

  @override
  String get spacesInviteMember => 'Mitglied einladen';

  @override
  String get spacesInviteMemberUserId => 'Benutzer-ID (z. B. @user:server.com)';

  @override
  String get spacesSave => 'Speichern';

  @override
  String get settingsScreenshotProtection => 'Screenshot-Schutz';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Verhindern Sie Screenshots und Bildschirmaufzeichnungen';

  @override
  String get chatSelfDestructTimer => 'Selbstzerstörung';

  @override
  String get chatTimerPickerTitle => 'Selbstzerstörungstimer';

  @override
  String get chatTimerOff => 'Aus';

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

  @override
  String get web3SearchHint => '@matrix:id  •  0x Wallet-Adresse  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'Nach ID, Wallet oder ENS suchen...';

  @override
  String get web3WalletAddress => 'Wallet-Adresse';

  @override
  String get web3AddressCopied => 'Adresse kopiert';

  @override
  String get web3Copy => 'Kopieren';

  @override
  String get web3SendMessage => 'Nachricht senden';

  @override
  String get web3SendToWallet => 'An Wallet senden';

  @override
  String get web3WalletOnlyHint =>
      'Diese Adresse hat noch kein N42-Konto. Nachricht wird zugestellt, wenn sie beitreten.';

  @override
  String get web3NftAvatar => 'NFT-Avatar';

  @override
  String get web3ResolveFailed => 'Identitätsauflösung fehlgeschlagen';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS-Name \"$name\" nicht gefunden';
  }

  @override
  String get web3NoN42AccountTitle => 'Kein N42-Konto';

  @override
  String get web3NoN42AccountDesc =>
      'Diese Wallet-Adresse hat noch kein N42-Konto. Sie können Ihren N42-Einladungslink mit ihnen teilen, um loszulegen.';

  @override
  String get web3ShareInvite => 'Einladung teilen';

  @override
  String get nftPickerTitle => 'NFT-Avatar auswählen';

  @override
  String get nftPickerTabPopular => 'Beliebt';

  @override
  String get nftPickerTabCustom => 'Benutzerdefiniert';

  @override
  String get nftPickerChain => 'Kette';

  @override
  String get nftPickerContract => 'Vertragsadresse';

  @override
  String get nftPickerTokenId => 'Token-ID';

  @override
  String get nftPickerVerifyOwnership => 'Eigentumsrecht prüfen & Vorschau';

  @override
  String get nftPickerUseAsAvatar => 'Als Avatar verwenden';

  @override
  String get nftPickerPreview => 'Vorschau';

  @override
  String get nftPickerNotOwned => 'Sie besitzen dieses NFT nicht';

  @override
  String get nftPickerInvalidTokenId => 'Ungültige Token-ID';

  @override
  String get nftPickerEnterBoth => 'Geben Sie Vertragsadresse und Token-ID ein';

  @override
  String get nftPickerInfoTitle => 'NFT-Avatar — On-Chain-Verifizierung';

  @override
  String get nftPickerInfoDesc =>
      'Binden Sie einen NFT, den Sie besitzen, als Ihren Avatar. Jeder kann den Besitz in der Kette überprüfen. Wird mit einem goldenen Ring über N42 angezeigt.';

  @override
  String get nftPickerPopularCollections => 'Beliebte Sammlungen';

  @override
  String get nftPickerWalletHint =>
      'Verbinden Sie Ihre N42-Wallet, um Ihre NFTs auf 236+ Ketten zu entdecken.';

  @override
  String get profileBindNftAvatar => 'NFT-Avatar verknüpfen';

  @override
  String get profileChangeAvatar => 'Avatar ändern';

  @override
  String get groupTopics => 'Themen';

  @override
  String get groupTopicsEmpty => 'Noch keine Themen';

  @override
  String get syncInProgress => 'Nachrichtenverlauf wird synchronisiert...';

  @override
  String get recoveryKeyReminderTitle => 'Schütze deine Nachrichten';

  @override
  String get recoveryKeyReminderDesc =>
      'Erstelle einen Wiederherstellungsschlüssel, um verschlüsselte Nachrichten sicher auf mehreren Geräten zu synchronisieren';

  @override
  String get recoveryKeySetupNow => 'Jetzt einrichten';

  @override
  String get recoveryKeyRemindLater => 'Später erinnern';

  @override
  String get channelReadOnly =>
      'Nur Administratoren können in diesem Kanal posten';

  @override
  String get channelSubscribers => 'Abonnenten';

  @override
  String get channelVerified => 'Verifizierter Kanal';

  @override
  String get redPacketHistory => 'Roter Paketverlauf';

  @override
  String get redPacketSent => 'Gesendet';

  @override
  String get redPacketReceived => 'Erhalten';

  @override
  String get redPacketExpired => 'Abgelaufen';

  @override
  String get redPacketClaimed => 'Behauptet';

  @override
  String get redPacketInsufficientBalance => 'Unzureichendes Gleichgewicht';

  @override
  String selfDestructCountdown(String time) {
    return 'Selbstzerstörung in $time';
  }

  @override
  String get messageDestroyed => 'Nachricht zerstört';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Berechtigung verweigert: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'Was ist die Gasgebühr?';

  @override
  String get aiSuggestionDefi => 'DeFi-Anfängerleitfaden';

  @override
  String get aiSuggestionSecurity => 'So überprüfen Sie die Vertragssicherheit';

  @override
  String get aiSuggestionBridge => 'Cross-Chain-Bridging';

  @override
  String get channelDiscoverTitle => 'Entdecken Sie Kanäle';

  @override
  String get channelDiscoverSearch => 'Kanäle durchsuchen...';

  @override
  String get channelJoin => 'Machen Sie mit';

  @override
  String get channelJoined => 'Beigetreten';

  @override
  String get channelCategory => 'Kategorie';

  @override
  String slowModeCooldown(int seconds) {
    return 'Langsamer Modus: Warten Sie ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Adresse kopieren';

  @override
  String get addressSendMessage => 'Nachricht senden';

  @override
  String get addressViewProfile => 'Profil anzeigen';

  @override
  String get sendToAddress => 'An Wallet-Adresse senden';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Der Bestätigungscode konnte nicht gesendet werden';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Dieser Server unterstützt kein Zurücksetzen des E-Mail-Passworts';

  @override
  String get blocAuthResetPasswordFailed =>
      'Passwort konnte nicht zurückgesetzt werden';

  @override
  String get blocAuthChangePasswordFailed =>
      'Das Passwort konnte nicht geändert werden';

  @override
  String get blocAuthOldPasswordWrong => 'Falsches aktuelles Passwort';

  @override
  String get blocAuthLoginCancelled => 'Anmeldung abgebrochen';

  @override
  String get blocAuthGoogleLoginFailed =>
      'Die Google-Anmeldung ist fehlgeschlagen';

  @override
  String get blocAuthAppleLoginFailed =>
      'Die Apple-Anmeldung ist fehlgeschlagen';

  @override
  String get blocAuthSsoLoginFailed => 'Die SSO-Anmeldung ist fehlgeschlagen';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook-Anmeldung fehlgeschlagen';

  @override
  String get blocAuthTwitterLoginFailed =>
      'Die Twitter-Anmeldung ist fehlgeschlagen';

  @override
  String get blocAuthWeChatLoginFailed => 'WeChat-Anmeldung fehlgeschlagen';

  @override
  String get blocAuthWeChatNotConfigured =>
      'WeChat-Anmeldung nicht konfiguriert';

  @override
  String get blocAuthWeChatNotInstalled =>
      'Bitte installieren Sie zuerst WeChat';

  @override
  String get blocAuthPasswordWrong => 'Falsches Passwort';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Diese E-Mail ist bereits an ein anderes Konto gebunden';

  @override
  String get blocAuthChangeEmailFailed =>
      'Die E-Mail-Adresse konnte nicht geändert werden';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'Der Bestätigungscode ist falsch oder abgelaufen';

  @override
  String get blocAuthSessionExpired =>
      'Sitzung abgelaufen, bitte melden Sie sich erneut an';

  @override
  String get blocAuthSessionIncomplete =>
      'Sitzungsdaten unvollständig, bitte melden Sie sich erneut an';

  @override
  String get chatReadingMode => 'Lesemodus';

  @override
  String get groupPoints => 'Punkte';

  @override
  String get settingsPrivacySecurity => 'Datenschutz & Sicherheit';

  @override
  String get settingsSystemAccounts => 'System & Konten';

  @override
  String get settingsNotificationPrivacy => 'Benachrichtigungsdatenschutz';

  @override
  String get settingsSenderOnly => 'Nur Absender anzeigen';

  @override
  String get settingsHiddenNotification => 'Absender und Nachricht ausblenden';

  @override
  String get settingsSmartFilter => 'Intelligenter Filter';

  @override
  String get settingsEmailVerificationSent => 'Bestätigungs-E-Mail gesendet';

  @override
  String get settingsEmailLinkInstructions =>
      'Öffne den Bestätigungslink in deiner E-Mail, kehre dann hierher zurück und bestätige.';

  @override
  String get settingsSendVerificationEmail => 'Bestätigungs-E-Mail senden';

  @override
  String get chatLogoutKeyWarning =>
      'Sichere deine Verschlüsselungsschlüssel vor dem Abmelden, sonst könntest du den Zugriff auf verschlüsselte Nachrichten verlieren.';

  @override
  String get settingsBiometricUnavailable =>
      'Biometrische Authentifizierung ist nicht verfügbar. Prüfe Einrichtung und Berechtigungen in den Geräteeinstellungen.';

  @override
  String get chatEncryptionNotReady =>
      'Die sichere Verbindung ist noch nicht bereit. Die Nachricht wurde nicht gesendet. Prüfen Sie die Verbindung und Geräteverifizierung beider Konten und versuchen Sie es erneut.';

  @override
  String get contactRequestPending => 'Annahme ausstehend';

  @override
  String get chatFriendRequestPending =>
      'Die Freundschaft ist nicht bestätigt. Prüfen Sie vor dem Senden Kontakte > Neue Freunde.';

  @override
  String contactPhotoCount(int count) {
    return '$count Fotos';
  }

  @override
  String get videoPublish => 'Video veröffentlichen';

  @override
  String get videoGoLive => 'Liveübertragung starten';

  @override
  String get videoSelect => 'Video auswählen';

  @override
  String get videoLiveUnavailable => 'Liveübertragungen sind nicht verfügbar';

  @override
  String get qrcodeAlbum => 'Album';

  @override
  String get settingsSwitchAccount => 'Konto wechseln';

  @override
  String get chatFilterUnread => 'Ungelesen';

  @override
  String get chatFilterEmpty => 'Keine Unterhaltungen in diesem Filter';

  @override
  String get accountAdd => 'Konto hinzufügen';

  @override
  String get accountCurrent => 'Aktuelles Konto';

  @override
  String get accountSwitching => 'Konto wird gewechselt…';

  @override
  String get accountSwitchFailed =>
      'Kontowechsel fehlgeschlagen. Versuche es erneut oder füge das Konto hinzu, um dich neu anzumelden.';

  @override
  String get accountSessionsHint =>
      'Wechsle hier zwischen Konten. Nachrichten und sichere Sitzungen bleiben für jedes Konto getrennt.';

  @override
  String get accountNoSaved => 'Noch keine gespeicherten Konten';

  @override
  String get contactRequestSent => 'Anfrage gesendet';

  @override
  String get contactRequestsIncoming => 'Erhaltene Anfragen';

  @override
  String get contactRequestsOutgoing => 'Gesendete Anfragen';

  @override
  String get contactRequestHint =>
      'Nach Annahme der Anfrage sind Chats und Anrufe möglich.';

  @override
  String get callReturnToCall => 'Zurück zum Anruf';

  @override
  String get chatMessageSending => 'Wird gesendet';

  @override
  String get chatMessageSent => 'Gesendet';

  @override
  String get chatMessageDelivered => 'Zugestellt';

  @override
  String get chatMessageRead => 'Gelesen';

  @override
  String get chatMessageFailed => 'Nicht gesendet. Zum Wiederholen tippen.';

  @override
  String get chatMessageUnavailable =>
      'Nachricht auf diesem Gerät nicht verfügbar. Tippe hier für Wiederherstellungsoptionen.';

  @override
  String get contactStarredFriends => 'Markierte Kontakte';

  @override
  String get chatRecipientKeysMissing =>
      'Dieser Kontakt hat keine verfügbare verschlüsselte Sitzung. Bitte ihn, sich anzumelden und die App zu öffnen, und versuche es erneut. Nutze beim Kontowechsel „Konto wechseln“, statt dich abzumelden.';

  @override
  String get chatSwitchForMessaging =>
      'Konto wechseln? Mit „Konto wechseln“ bleiben Nachrichten und sichere Sitzungen erhalten. Beim Abmelden wird dieses Gerät abgemeldet; eingehende verschlüsselte Nachrichten können dadurch unlesbar werden.';

  @override
  String get aiServiceUnavailable =>
      'KI-Zusammenfassungen sind derzeit nicht verfügbar. Versuche es erneut, sobald der Dienst wieder erreichbar ist.';

  @override
  String aiSummarizeMessages(int count) {
    return '$count letzte Nachrichten zusammenfassen';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined beigetreten · $invited eingeladen';
  }

  @override
  String contactPendingCount(int count) {
    return '$count offene Anfragen';
  }

  @override
  String get chatDraftLabel => 'Entwurf';

  @override
  String get contactIndexLabel => 'Kontaktindex';

  @override
  String get transferAssetUnavailable => 'Der Zahlungswert ist nicht verfügbar';

  @override
  String get transferPaymentRequestUnavailable =>
      'Die Zahlungsanforderung ist nicht verfügbar';

  @override
  String get chatCatchUp => 'Aufholen';

  @override
  String get chatCatchUpMentions => 'Erwähnungen';

  @override
  String get chatCatchUpReplies => 'Antworten an mich';

  @override
  String get chatCatchUpPinned => 'Angeheftete Nachrichten';

  @override
  String get chatCatchUpScope =>
      'Erwähnungen und Antworten basieren auf geladenen Nachrichten, auch bereits gelesenen. Laden Sie ältere Nachrichten, um frühere Antworten zu finden.';

  @override
  String get chatCatchUpLoadMore => 'Ältere Nachrichten laden';

  @override
  String get chatActionPreview => 'Kalendervorschlag prüfen';

  @override
  String get chatActionPrivacy =>
      'Erst nach Ihrer Bestätigung werden nur der untenstehende Titel und die Uhrzeit an Ihre Kalender-App weitergegeben. Prüfen Sie die Zeitzone. Ihr Kalenderkonto kann diesen Termin synchronisieren.';

  @override
  String get chatActionTitle => 'Chat-Termin';

  @override
  String get chatActionSuggestion => 'Kalendervorschlag';

  @override
  String get chatUnreadAttention => 'Ungelesene Erwähnungen und Antworten';

  @override
  String get chatScanAgain => 'Erneut durchsuchen';

  @override
  String get chatUnreadScope =>
      'Durchsucht den Serververlauf bis zu Ihrer Lesemarkierung. Öffnen Sie eine Unterhaltung, um sie zu lesen; aktualisieren Sie, um die Ergebnisse neu zu erstellen.';

  @override
  String get chatScanIncomplete =>
      'Unvollständig: Verlauf, Entschlüsselung oder Lesemarkierung nicht verfügbar. Versuchen Sie es nach der Synchronisierung erneut.';

  @override
  String get chatHistoryShare => 'Ausgewählten Verlauf teilen';

  @override
  String get chatHistoryExplanation =>
      'Nur für Administratoren. Wählen Sie reine Textnachrichten und einen vorhandenen verschlüsselten Direktchat mit einem beigetretenen Gruppenmitglied aus. Beim Teilen werden sichtbare Prüfmeldungen in der Gruppe erstellt.';

  @override
  String get chatHistoryEnable => 'Teilen aktivieren';

  @override
  String get chatHistoryDisable => 'Teilen deaktivieren';

  @override
  String get chatHistoryPolicy => 'Richtlinie zum Teilen des Gruppenverlaufs';

  @override
  String get chatHistoryPolicyDetail =>
      'Nur Administratoren dürfen teilen. Beim Aktivieren wird die Sichtbarkeit des Gruppenverlaufs zudem auf Ereignisse nach dem Beitritt beschränkt. Legen Sie unten die Grenzen für Textnachrichten fest und bestätigen Sie.';

  @override
  String get chatHistoryPolicySaved => 'Richtlinie gespeichert';

  @override
  String get chatHistoryRecipient => 'Verschlüsselte Empfängerunterhaltung';

  @override
  String get chatHistoryReview => 'Ausgewählte Nachrichten prüfen';

  @override
  String get chatHistoryMessages => 'Nachrichten';

  @override
  String get chatHistoryConfirmDetail =>
      'Bestätigen Sie vor dem Teilen den Empfänger, jede Nachricht und deren Zeitpunkt. Bei einem fehlgeschlagenen oder unbekannten Ergebnis können Inhalte bereits gesendet worden sein: Klären Sie den Status, bevor Sie fortfahren.';

  @override
  String get chatHistoryCompleted =>
      'Ausgewählter Verlauf gesendet und Gruppenprüfmeldung bestätigt';

  @override
  String get chatHistoryPending =>
      'Ausstehend: Klären Sie den Status und bestätigen Sie dann erneut, um fortzufahren. Sendungen mit unbekanntem Ergebnis werden nie erneut gesendet.';

  @override
  String get chatHistoryReconcile => 'Sendeergebnis abgleichen';

  @override
  String get chatHistoryFailed =>
      'Vorgang konnte nicht abgeschlossen werden. Prüfen Sie Administratorrechte, Gruppenrichtlinie, Verschlüsselung, Empfängermitgliedschaft und Auswahl. Falls das Senden begonnen hat, klären Sie dessen Ergebnis.';

  @override
  String get chatDeviceActions => 'Aktionen auf dem Gerät';

  @override
  String get chatDeviceActionsReview =>
      'Nach Ihrer Bestätigung wird nur diese Nachricht den Aktionsvorschlägen auf dem Gerät bereitgestellt. Wählen Sie eine Aktion, um Kalender, Erinnerungen oder Karten zu öffnen.';

  @override
  String get chatHistoryMaxMessages => 'Nachrichtenlimit (1–50)';

  @override
  String get chatHistoryMaxHours => 'Verlaufsfenster in Stunden (1–720)';

  @override
  String get chatNotifyAll => 'Alle Nachrichten';

  @override
  String get chatNotifyAllDescription =>
      'Bei jeder neuen Nachricht in diesem Chat benachrichtigen';

  @override
  String get chatNotifyMentions => 'Nur Erwähnungen';

  @override
  String get chatNotifyMentionsDescription =>
      'Nur benachrichtigen, wenn du erwähnt wirst oder @room verwendet wird';

  @override
  String get chatNotifyMutedDescription =>
      'Benachrichtigungen für diesen Chat auf allen Geräten deaktivieren';

  @override
  String get scheduledMessagesTitle => 'Geplante Nachrichten';

  @override
  String get scheduledMessagesEmpty => 'Noch keine geplanten Nachrichten';

  @override
  String get scheduledMessagesHint =>
      'Halte Senden, Fotos, Dateien, ein GIF oder einen Sticker gedrückt, um eine Nachricht zu planen.';

  @override
  String get scheduledMessageCancelled => 'Geplante Nachricht abgebrochen';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Erstellt: $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Zustellung nicht bestätigt';

  @override
  String get scheduledRecoveryCopy => 'Wiederherstellungskopie speichern';

  @override
  String get scheduledRecoveryCopyHint =>
      'Auf diesem Gerät gespeichert, ohne Nachrichten zu ändern oder zu senden. Die Vorschau zeigt bis zu 8.000 Zeichen.';

  @override
  String get scheduledRecoveryCopies => 'Wiederherstellungskopien';

  @override
  String get scheduledRecoveryReset => 'Beschädigte Warteschlange zurücksetzen';

  @override
  String get scheduledRecoveryResetHint =>
      'Eine exakte Kopie ist auf diesem Gerät gespeichert. Alle geplanten Nachrichten dieses Kontos zurücksetzen? Einige wurden möglicherweise bereits gesendet. Kopien und Anhänge bleiben erhalten. Nichts wird erneut gesendet.';

  @override
  String get scheduledRecoveryExportHint =>
      'Diese Datei enthält unverschlüsselten Entwurfstext und Kontodaten. Anhänge sind nicht enthalten. Wähle ein vertrauenswürdiges Ziel.';

  @override
  String get scheduledRecoveryImport => 'Wiederherstellungskopie importieren';

  @override
  String get scheduledRecoveryImportHint =>
      'Diese Vorschau nur als Wiederherstellungskopie speichern. Es werden keine Nachrichten geplant oder gesendet. Anhänge sind nicht enthalten. Der Dateiautor ist nicht verifiziert.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Text zur Prüfung an den aktuellen Entwurf anhängen. Es wird nichts gesendet. Anhänge, Erwähnungen und Timer werden nicht wiederhergestellt. Prüfen Sie, ob diese Nachricht bereits zugestellt wurde.';

  @override
  String get backupRecoverLegacyArchive =>
      'Älteren lokalen Verlauf wiederherstellen';

  @override
  String get backupLegacyArchiveWarning =>
      'Der Besitzer dieses Verlaufs ist nicht bestätigt. Kopiere nur deine Räume in das unten angegebene Konto. Das Original bleibt erhalten.';

  @override
  String get backupOlderFiles => 'Ältere Sicherungsdateien';

  @override
  String get backupOlderFilesWarning =>
      'Diese Dateien gehören möglicherweise zu einem anderen Konto. Wähle eine Datei, um Inhalt und Kontozugehörigkeit vor der Wiederherstellung zu prüfen.';

  @override
  String get stickerImportTitle => 'Stickerpaket importieren';

  @override
  String get stickerImportLinkHint => 'Link zu einem Matrix-Stickerpaket';

  @override
  String get stickerImportPreview => 'Vorschau';

  @override
  String get stickerImportUnavailable =>
      'Dieses Paket ist nicht verfügbar oder du hast keinen Zugriff.';

  @override
  String get stickerImportCopyNotice =>
      'Füge eine private Kopie dieses Pakets hinzu. Seine Bilder und Metadaten sind nicht Ende-zu-Ende-verschlüsselt.';

  @override
  String get stickerImportFailed =>
      'Dieses Paket konnte nicht hinzugefügt werden. Versuche es erneut.';

  @override
  String get stickerImportAccountChanged =>
      'Das Konto wurde gewechselt oder die Sitzung ist abgelaufen. Öffne den Stickerimport erneut.';

  @override
  String get stickerPackSourceRoom => 'Ursprünglicher Chat';

  @override
  String get stickerPackImages => 'Bilder';

  @override
  String get stickerPublishNotice =>
      'Veröffentliche dieses Paket in der ausgewählten Gruppe. Bilder und Metadaten sind nicht Ende-zu-Ende-verschlüsselt. Personen, die den Gruppenstatus lesen können, können darauf zugreifen.';

  @override
  String get stickerPublishFailed =>
      'Die Veröffentlichung wurde nicht bestätigt. Prüfe die Gruppe vor einem erneuten Versuch.';

  @override
  String get stickerPublishReceiptMissing =>
      'Veröffentlicht, aber der Link wurde nicht gespeichert. Teile oder kopiere ihn, bevor du diese Seite verlässt.';

  @override
  String get stickerSubscribe => 'Updates abonnieren';

  @override
  String get stickerSubscribeNotice =>
      'Künftige Änderungen durch die Paketadministratoren übernehmen. Bilder und Metadaten sind nicht Ende-zu-Ende-verschlüsselt. Das Abo kann später beendet werden; dem Quellchat trittst du dadurch nicht bei.';

  @override
  String get stickerSubscriptions => 'Sticker-Abos';

  @override
  String get stickerUnsubscribe => 'Abo beenden';

  @override
  String get stickerSubscriptionsEmpty => 'Keine Sticker-Abos';

  @override
  String get chatAttachmentEvent => 'Termin';

  @override
  String get chatRecentMedia => 'Neueste Fotos und Videos';

  @override
  String get chatRecentMediaLoadFailed =>
      'Neueste Medien konnten nicht geladen werden';

  @override
  String get chatRecentMediaPermission =>
      'Zum Anzeigen neuester Medien ist Zugriff auf Fotos erforderlich';

  @override
  String get chatRecentMediaEmpty => 'Keine neuen Fotos oder Videos';

  @override
  String get chatRecentPhoto => 'Neuestes Foto';

  @override
  String get chatRecentVideo => 'Neuestes Video';

  @override
  String get chatAttachmentTip => 'Trinkgeld';

  @override
  String get chatAttachmentWhiteboard => 'Tafel';

  @override
  String get chatAttachmentVideoNote => 'Videonachricht';

  @override
  String get chatAttachmentCode => 'Quellcode';

  @override
  String get chatAttachmentShop => 'Geschäft';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Auswahllimit: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Heute Abend ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Morgen früh ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Nach unten scrollen';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Gib vor dem Planen eine Nachricht ein';

  @override
  String get ui3SendCode => 'Code senden';

  @override
  String get ui3CodeLanguage => 'Sprache';

  @override
  String get ui3PasteCodeHere => 'Code hier einfügen';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Erinnerung gesetzt · $time';
  }

  @override
  String get ui3RedPacketCreateFailed =>
      'Roter Umschlag konnte nicht erstellt werden';

  @override
  String get ui3SendTip => 'Trinkgeld senden';

  @override
  String get ui3TokenLabel => 'Krypto-Token';

  @override
  String get ui3NoteOptional => 'Notiz (optional)';

  @override
  String ui3TipFailed(String error) {
    return 'Trinkgeld fehlgeschlagen: $error';
  }

  @override
  String get ui3GiftNftTitle => 'NFT verschenken';

  @override
  String get ui3TokenId => 'Token-ID';

  @override
  String ui3NftGiftFailed(String error) {
    return 'NFT-Geschenk fehlgeschlagen: $error';
  }

  @override
  String get ui3AiAgentSubtitle =>
      'Aufgabe beschreiben, passende Mini-App öffnen';

  @override
  String get ui3GiftNft => 'NFT verschenken';

  @override
  String get ui3GiftNftSubtitle => 'NFT an diesen Kontakt senden';

  @override
  String get ui3MiniAppUnavailable => 'Mini-App ist nicht verfügbar';

  @override
  String ui3MediaItemsNotSent(int count) {
    return '$count ausgewählte Medien konnten nicht gesendet werden';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Fotos und Videos in chatfreundlichem Format senden';

  @override
  String get ui3OriginalImages => 'Originalbilder';

  @override
  String get ui3OriginalImagesSubtitle =>
      'Unkomprimierte Fotos als Dateien senden';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename für $time geplant';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Originalbild wird gesendet: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Originalbild geplant: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Zahlung bereits gesendet';

  @override
  String get ui3PaymentProcessing => 'Zahlung wird verarbeitet';

  @override
  String ui3ChainStatus(String status) {
    return 'Chain-Status: $status';
  }

  @override
  String get ui3NotChecked => 'Nicht geprüft';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Bestätigt: $confirmations / $required Blöcke';
  }

  @override
  String get ui3CopyTxHash => 'Transaktions-Hash kopieren';

  @override
  String get ui3VerifyAgain => 'Erneut prüfen';

  @override
  String get ui3VerifyOnChain => 'On-Chain prüfen';

  @override
  String get ui3TransferMissingChainDetails =>
      'Diese Überweisung enthält keine genauen Chain- und Asset-Angaben.';

  @override
  String get ui3ReceiptPending => 'Ausstehend auf der Chain';

  @override
  String get ui3ReceiptConfirmed => 'Bestätigt';

  @override
  String get ui3ReceiptFailed => 'Auf der Chain fehlgeschlagen';

  @override
  String get ui3ReceiptMismatch => 'Transaktionsdetails stimmen nicht überein';

  @override
  String get ui3ReceiptUnsupported => 'Chain-Prüfung nicht unterstützt';

  @override
  String get ui3ReceiptUnavailable => 'Prüfung nicht verfügbar';

  @override
  String get ui3OpenOrSave => 'Öffnen / Speichern';

  @override
  String get ui3UnableToOpenFile => 'Diese Datei kann nicht geöffnet werden.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'KI-Umformulierung fehlgeschlagen: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Nachrichten mit KI teilen?';

  @override
  String get ui3AiShareMessagesBody =>
      'Wähle die Nachrichten aus, die die KI für diese Antwort verwenden darf. Diese einmalige Freigabe läuft nach zwei Minuten ab. Wenn du die Schnellantwort schließt, werden ausstehende Ergebnisse verworfen. Zahlungen oder Exporte sind damit nicht erlaubt.';

  @override
  String get ui3OtherParticipant => 'Gegenüber';

  @override
  String get ui3ShareSelected => 'Auswahl teilen';

  @override
  String get ui3BotCommandError => 'Befehlsfehler';

  @override
  String get ui3BotUnknownCommand => 'Unbekannter Befehl';

  @override
  String get ui3BotTypeHelp => 'Gib /help ein, um verfügbare Befehle zu sehen.';

  @override
  String get ui3FilesMediaLinks => 'Dateien, Medien & Links';

  @override
  String get ui3ChatStorage => 'Chat-Speicher';

  @override
  String get ui3EncryptionKeysDevices => 'Verschlüsselungsschlüssel & Geräte';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'Verschlüsselungsdienst ist noch nicht verfügbar';

  @override
  String get ui3ExportLoadingHistory =>
      'Weiterer Chatverlauf wird für den Export geladen...';

  @override
  String get ui3ExportTxtDesc =>
      'Klartext-Protokoll für Notizen, Backup oder Compliance-Prüfung';

  @override
  String get ui3ExportCustomRange => 'Eigener Zeitraum';

  @override
  String get ui3ExportStart => 'Beginn';

  @override
  String get ui3ExportEnd => 'Ende';

  @override
  String get ui3ExportSelectDate => 'Datum auswählen';

  @override
  String get ui3FolderFilterUnreadOnly => 'Nur ungelesene';

  @override
  String get ui3FolderFilterMutedOnly => 'Nur stummgeschaltete';

  @override
  String get ui3FolderFilterNoDms => 'Ohne Direktnachrichten';

  @override
  String get ui3FolderFilterNoGroups => 'Ohne Gruppen';

  @override
  String get ui3FolderFilterNoChannels => 'Ohne Kanäle';

  @override
  String get ui3FolderFilterAllChats => 'Alle Chats';

  @override
  String get ui3Create => 'Erstellen';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Ordner „$name“ löschen?';
  }

  @override
  String get a11yDecreaseTextSize => 'Text verkleinern';

  @override
  String get a11yIncreaseTextSize => 'Text vergrößern';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes Min. Lesezeit';
  }

  @override
  String get ui3TipOnChain => 'Auf der Chain ✓';

  @override
  String get ui3ViewSource => 'Quelltext anzeigen';

  @override
  String get a11yPreviousPage => 'Vorherige Seite';

  @override
  String get a11yNextPage => 'Nächste Seite';

  @override
  String get ui3OpenExternalLinkTitle => 'Externen Link öffnen?';

  @override
  String get ui3Open => 'Öffnen';

  @override
  String get ui3UnableToOpenLink => 'Dieser Link kann nicht geöffnet werden.';

  @override
  String get ui3ImageUnavailable => 'Bild nicht verfügbar';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Bild von $host laden';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Bild von $host erneut laden';
  }

  @override
  String get ui3TranslatedByN42 => 'Übersetzt von N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Aus $language übersetzt von N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Whiteboard leeren?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Alle Striche werden für alle entfernt. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get ui3WhiteboardLive => 'Whiteboard · Echtzeit';

  @override
  String get a11yPenColor => 'Stiftfarbe';

  @override
  String get ui3AiDescribeOcr => 'KI-Beschreibung / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Dieses Dokument kann nicht sicher angezeigt werden. Prüfe die Verbindung und die Dateigröße (max. 2 MB).';

  @override
  String get ui3AiConsentMessage =>
      'Wähle die Nachrichten aus, die die KI für diese Zusammenfassung verwenden darf. Diese einmalige Freigabe läuft nach zwei Minuten ab. Zahlungen oder Exporte sind damit nicht erlaubt.';

  @override
  String get ui3AiSuggestedReplies => 'Antwortvorschläge';

  @override
  String get ui3AiGeneratingSuggestions => 'Vorschläge werden erstellt...';

  @override
  String get ui3StickersEmpty => 'Noch keine Sticker';

  @override
  String get ui3StickersGet => 'Sticker holen';

  @override
  String get a11yFormatBold => 'Fett';

  @override
  String get a11yFormatItalic => 'Kursiv';

  @override
  String get a11yFormatStrikethrough => 'Durchgestrichen';

  @override
  String get a11yFormatInlineCode => 'Inline-Code';

  @override
  String get a11yFormatCodeBlock => 'Codeblock';

  @override
  String get a11yFormatChecklistItem => 'Checklisten-Eintrag';

  @override
  String get a11yFormatBulletList => 'Aufzählung';

  @override
  String get a11yFormatNumberedList => 'Nummerierte Liste';

  @override
  String get a11yFormatLink => 'Link einfügen';

  @override
  String get a11yFormatTable => 'Tabelle';

  @override
  String get a11yFormatMeetingTemplate => 'Besprechungsvorlage';

  @override
  String get a11yEmojiSmileys => 'Smileys & Personen';

  @override
  String get a11yEmojiHearts => 'Herzen';

  @override
  String get a11yEmojiAnimals => 'Tiere & Natur';

  @override
  String get a11yEmojiFood => 'Essen & Trinken';

  @override
  String get a11yEmojiTravel => 'Reisen & Orte';

  @override
  String get a11yEmojiActivities => 'Aktivitäten';

  @override
  String get a11yEmojiObjects => 'Objekte';

  @override
  String get a11yEmojiSymbols => 'Symbole';

  @override
  String get ui3FrequentlyUsed => 'Häufig verwendet';

  @override
  String get ui3NoEditHistory => 'Kein Bearbeitungsverlauf';

  @override
  String get ui3EventNew => 'Neuer Termin';

  @override
  String get ui3EventTitleLabel => 'Titel';

  @override
  String get ui3EventLocationOptional => 'Ort (optional)';

  @override
  String get ui3EventDescriptionOptional => 'Beschreibung (optional)';

  @override
  String get ui3EventSend => 'Termin senden';

  @override
  String get ui3EventTitleRequired => 'Titel ist erforderlich';

  @override
  String get ui3EventEndAfterStart => 'Endzeit muss nach dem Beginn liegen';

  @override
  String get ui3MiniAppAgentIntro =>
      'Beschreibe, was du tun möchtest – ich öffne die passende Mini-App.';

  @override
  String get ui3MiniAppAgentExample => 'z. B. ETH gegen USDC tauschen';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Keine passende Mini-App gefunden. Formuliere es anders.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return '$appName öffnen';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Unterstützt Song-Links von NetEase Cloud Music, QQ Music, Kugou, Kuwo und mehr';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'Markiere eine nicht leere richtige Antwort';

  @override
  String get ui3PollQuizMode => 'Quiz-Modus';

  @override
  String get ui3PollAnswerExplanationHint => 'Erklärung zur Antwort (optional)';

  @override
  String get a11yCorrectAnswer => 'Richtige Antwort';

  @override
  String get ui3AiSuggestions => 'KI-Vorschläge';

  @override
  String get a11yPaste => 'Einfügen';

  @override
  String get a11yRefresh => 'Aktualisieren';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Bewahre diesen Schlüssel sicher auf. Er ist die einzige Möglichkeit, deine verschlüsselten Nachrichten wiederherzustellen, wenn du den Zugriff auf alle Geräte verlierst.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Gespeichert: $path';
  }

  @override
  String get ui3UnknownAccount => 'Unbekanntes Konto';

  @override
  String get ui3UnknownHomeserver => 'Unbekannter Homeserver';

  @override
  String get ui3ImportRecoveryKey => 'Wiederherstellungsschlüssel importieren';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Gib deinen Wiederherstellungsschlüssel ein oder füge ihn ein, um die Raumschlüssel für den verschlüsselten Nachrichtenverlauf wiederherzustellen.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Konto: $account\\nHomeserver: $homeserver';
  }

  @override
  String get ui3Import => 'Importieren';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Ungültiges Format des Wiederherstellungsschlüssels';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '$restored von $total Schlüsseln wiederhergestellt. $failed Schlüssel fehlgeschlagen. Prüfe Konto, Netzwerk und Backup und versuche es erneut. Ein Teil des Verlaufs bleibt möglicherweise unlesbar.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '$restored von $total Schlüsseln erfolgreich wiederhergestellt';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Import fehlgeschlagen: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Passkey-Registrierung fehlgeschlagen: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'Mein Passkey';

  @override
  String get ui3PasskeyNameHint => 'z. B. iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Passkey konnte nicht gelöscht werden';

  @override
  String get ui3TwoFactorAuth => 'Zwei-Faktor-Authentifizierung';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'An – Code aus Authenticator-App erforderlich';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Aus – mit einer Authenticator-App (TOTP) schützen';

  @override
  String get ui3ShowRecoveryKey => 'Wiederherstellungsschlüssel anzeigen';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Wiederherstellungsschlüssel zur Sicherung anzeigen';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Nachrichten mit einem Wiederherstellungsschlüssel wiederherstellen';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Wiederherstellungsschlüssel konnte nicht erstellt werden';

  @override
  String get ui3TotpIncorrectCode => 'Falscher Code, versuche es erneut';

  @override
  String get ui3TwoFactorEnabled => 'Zwei-Faktor-Authentifizierung aktiviert';

  @override
  String get ui3TwoFactorDisabled =>
      'Zwei-Faktor-Authentifizierung deaktiviert';

  @override
  String get ui3TwoFactorTurnOffTitle =>
      'Zwei-Faktor-Authentifizierung deaktivieren?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'Deine Authenticator-App wird nicht mehr benötigt. Du kannst sie später mit einem neuen Schlüssel erneut einrichten.';

  @override
  String get ui3TurnOff => 'Deaktivieren';

  @override
  String get ui3TwoFactorTotpTitle => 'Zwei-Faktor (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'Zwei-Faktor-Authentifizierung ist aktiviert';

  @override
  String get ui3TwoFactorCodeRequired =>
      'Ein Code aus deiner Authenticator-App ist erforderlich.';

  @override
  String get ui3TotpStepScan =>
      '1. Scanne diesen QR-Code mit einer Authenticator-App (Google Authenticator, Authy, 1Password …) oder gib den Schlüssel manuell ein.';

  @override
  String get ui3TotpKeyCopied => 'Schlüssel kopiert';

  @override
  String get ui3TotpStepConfirm =>
      '2. Gib zur Bestätigung den 6-stelligen Code ein.';

  @override
  String get ui3Enable => 'Aktivieren';

  @override
  String get ui3BackupSettingsDesc =>
      'Sichere deine lokalen Chat-Einstellungen. Nachrichten werden nach erneuter Anmeldung vom Server wiederhergestellt.';

  @override
  String get ui3BackupKeysSeparate =>
      'Verschlüsselungsschlüssel werden separat verwaltet';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Nutze Sicherheit > Wiederherstellungsschlüssel, um den Zugriff auf verschlüsselte Nachrichten zu sichern.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms Räume  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Importiere eine .n42backup-Datei von einem anderen Gerät oder aus einer früheren Sicherung. Verschlüsselungsschlüssel werden separat mit deinem Wiederherstellungsschlüssel wiederhergestellt.';

  @override
  String get ui3UsernameSessionRequired =>
      'Benutzername erfordert eine aktive Sitzung';

  @override
  String get ui3SecuritySessionRequired =>
      'Sicherheitseinstellungen erfordern eine aktive Sitzung';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'Verknüpfte Konten erfordern eine aktive Sitzung';

  @override
  String get ui3SystemAccounts => 'System & Konten';

  @override
  String get ui3AccountIdentity => 'Konto & Identität';

  @override
  String get ui3Accounts => 'Konten';

  @override
  String get ui3DevicesSessions => 'Geräte & Sitzungen';

  @override
  String get ui3Integrations => 'Integrationen';

  @override
  String get ui3ConnectedAccounts => 'Verknüpfte Konten';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Telegram-, WhatsApp-, Discord- und API-Bridge-Integrationen';

  @override
  String get ui3SystemOverview => 'Systemübersicht';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konten',
      one: '1 Konto',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Geräte',
      one: '1 Gerät',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Ende-zu-Ende-Verschlüsselung, Screenshot-Schutz und Proxy-Steuerung';

  @override
  String get ui3ConversationPrivacy => 'Privatsphäre in Unterhaltungen';

  @override
  String get ui3NetworkPrivacy => 'Netzwerk-Privatsphäre';

  @override
  String get ui3IdentityPrivacy => 'Identitäts-Privatsphäre';

  @override
  String get ui3EncryptionKeyBackup => 'Verschlüsselung & Schlüssel-Backup';

  @override
  String get ui3DevicesVerification => 'Geräte & Verifizierung';

  @override
  String get ui3ChipE2eeDefault => 'E2EE standardmäßig';

  @override
  String get ui3ChipManualE2ee => 'E2EE manuell';

  @override
  String get ui3ChipSelfDestruct => 'Selbstzerstörung';

  @override
  String get ui3ChipScreenshotGuard => 'Screenshot-Schutz';

  @override
  String get ui3ChipIpProxy => 'IP / Proxyserver';

  @override
  String get ui3ChipLinkPreviewsOff => 'Linkvorschau aus';

  @override
  String get ui3ChipPublicHandle => 'Öffentlicher Nutzername';

  @override
  String get a11yShowPassword => 'Passwort anzeigen';

  @override
  String get a11yHidePassword => 'Passwort verbergen';

  @override
  String get a11yCheckServer => 'Server prüfen';

  @override
  String get ui3AuthAnonymousRegistration => 'Anonyme Registrierung';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Erstelle ein Konto, ohne Telefonnummer oder E-Mail zu verknüpfen. Ein Nutzername wird automatisch erzeugt.';

  @override
  String get ui3AuthAnonymousModeOn => 'Anonymer Modus ist aktiv';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'Die App erstellt einen zufälligen Matrix-Nutzernamen für dich. Du kannst dich später mit dem erzeugten Konto und Passwort anmelden.';

  @override
  String get ui3AuthChooseLoginMethod => 'Anmeldemethode wählen';

  @override
  String get ui3AuthSsoOpenFailed =>
      'SSO-Anmeldeseite konnte nicht geöffnet werden';

  @override
  String get ui3AuthWalletUnavailable => 'Wallet ist nicht verfügbar';

  @override
  String get ui3ProfileSubscriptions => 'Abonnements';

  @override
  String get ui3ProfileBuySellCrypto => 'Krypto kaufen / verkaufen';

  @override
  String get ui3ProfileOnDeviceAi => 'KI auf dem Gerät';

  @override
  String get ui3ProfileSetAUsername => 'Nutzernamen festlegen';

  @override
  String get ui3ProfileAvatarStudio => 'Avatar-Studio';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT-Avatar / Dekorationen';

  @override
  String get ui3ProfileCustomize => 'Anpassen';

  @override
  String get ui3ProfileQrSubtitle =>
      'Scannen, um dieses Profil zu öffnen oder einen Chat zu starten';

  @override
  String get ui3PrivacyHardening => 'Datenschutz-Härtung';

  @override
  String get ui3HidePhoneNumber => 'Telefonnummer verbergen';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Verknüpfte Telefonnummer auf Profilseiten auf diesem Gerät maskieren';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'Neue Chats standardmäßig verschlüsseln';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Neue Direktchats und private Räume mit aktivierter E2EE starten';

  @override
  String get ui3PrivateChatMode => 'Privater Chatmodus';

  @override
  String get ui3PrivateChatModeDesc =>
      'Screenshots beim Anzeigen privater oder verschlüsselter Chats vorübergehend blockieren';

  @override
  String get ui3DefaultSelfDestructTimer => 'Standard-Selbstzerstörungstimer';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Einen Standard-Selbstzerstörungstimer auf neu gesendete Nachrichten anwenden';

  @override
  String get ui3LinkPreviews => 'Linkvorschauen';

  @override
  String get ui3LinkPreviewsDesc =>
      'Titel, Beschreibungen und Vorschaubilder laden, wenn Nachrichten URLs enthalten';

  @override
  String get ui3IpAddressProtection => 'IP-Adressschutz';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Matrix- und Linkvorschau-Anfragen, wenn verfügbar, über deinen konfigurierten HTTP-Datenschutz-Proxy leiten';

  @override
  String get ui3UseTorProxy => 'Tor / Privoxy HTTP-Proxy verwenden';

  @override
  String get ui3UseTorProxyDesc =>
      'Verwende einen lokalen HTTP-Proxy-Endpunkt wie Privoxy auf 127.0.0.1:8118. Natives SOCKS5-Tor-Routing wird hier nicht unterstützt.';

  @override
  String get ui3CustomProxy => 'Eigener Proxy';

  @override
  String get ui3CustomProxyDesc =>
      'Einen eigenen HTTP- oder HTTPS-Proxy für Matrix-Verkehr und Linkvorschauen verwenden';

  @override
  String get ui3ProxyEndpoint => 'Proxy-Adresse';

  @override
  String get ui3ProxyEndpointDesc =>
      'HTTP/HTTPS-Proxy-Adresse (SOCKS nicht unterstützt)';

  @override
  String get ui3InvalidEndpoint => 'Ungültige Adresse';

  @override
  String get ui3CustomProxyStaysOff =>
      'Eigener Proxy bleibt aus, bis du eine gültige Adresse festlegst';

  @override
  String get ui3NotificationFilterNote =>
      'Prioritätsregeln benachrichtigen immer (auch bei Stummschaltung, Nur-Erwähnungen und Nicht stören). Stummgeschaltete Schlüsselwörter unterdrücken Benachrichtigungen.';

  @override
  String get ui3PriorityKeywords => 'Prioritäts-Schlüsselwörter';

  @override
  String get ui3PriorityKeywordHint => 'z. B. dringend';

  @override
  String get ui3MutedKeywords => 'Stummgeschaltete Schlüsselwörter';

  @override
  String get ui3MutedKeywordHint => 'z. B. Spam';

  @override
  String get ui3PrioritySenders => 'Prioritäts-Absender';

  @override
  String get ui3CaseSensitive => 'Groß-/Kleinschreibung beachten';

  @override
  String get ui3None => 'Keine';

  @override
  String get ui3SmartReplyTranslation => 'Übersetzung für Smart Replies';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Deine Nachrichten vor dem Senden automatisch in die Sprache des Empfängers übersetzen.';

  @override
  String get ui3FromPhotos => 'Aus Fotos';

  @override
  String get ui3ChangePhoto => 'Foto ändern';

  @override
  String get ui3RoamingUsesMobileData => 'Roaming nutzt Mobilfunkregeln';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'Eine eigene Roaming-Erkennung ist noch nicht verfügbar, daher folgt Roaming derzeit den Einstellungen für automatische Downloads über Mobilfunk.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return '„$content“ löschen?';
  }

  @override
  String get ui3ResetToDefaults => 'Auf Standard zurücksetzen';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Dadurch werden alle eigenen Schnellantworten entfernt und die Standards wiederhergestellt. Fortfahren?';

  @override
  String get ui3LocalLlmUnavailable => 'Auf diesem Gerät nicht unterstützt';

  @override
  String get ui3LocalLlmNotDownloaded => 'Modell nicht heruntergeladen';

  @override
  String get ui3LocalLlmReady => 'Bereit (auf dem Gerät)';

  @override
  String get ui3LocalLlmDescription =>
      'Wenn aktiviert und bereit, laufen KI-Funktionen (Zusammenfassen, Umschreiben, Übersetzen, Antworten) vollständig auf dem Gerät – Daten verlassen nie dein Telefon. Andernfalls wird der Cloud-Anbieter genutzt.';

  @override
  String get ui3UseOnDeviceAi => 'KI auf dem Gerät verwenden';

  @override
  String get ui3UseOnDeviceAiDesc => 'Lokale Inferenz bevorzugen, wenn bereit';

  @override
  String get ui3DownloadModel => 'Modell herunterladen';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'Inferenz auf dem Gerät erfordert die native Laufzeitumgebung (Android MediaPipe / iOS Core ML). Sie wird automatisch aktiviert, sobald der Plattform-Handler verfügbar ist.';

  @override
  String get ui3PhotoAvatar => 'Foto-Avatar';

  @override
  String get ui3AvatarStyles => 'Avatar-Stile';

  @override
  String get ui3AvatarStylesDesc =>
      'Eine Dekorationsauswahl für Profil- und Avatar-Einstiegspunkte verwenden.';

  @override
  String get ui3ReplaceNftAvatar => 'NFT-Avatar ersetzen';

  @override
  String get ui3NftAvatarDesc =>
      'Verwende ein On-Chain-Sammlerstück als Avatar.';

  @override
  String get ui3UsePhotoAvatar => 'Foto-Avatar verwenden';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Hochgeladenen Avatar behalten und NFT-Verknüpfung aufheben.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Avatar-Stil festgelegt auf: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT-Avatar aktualisiert';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Zurück zum Foto-Avatar gewechselt';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Melde dich an, um den Verlauf roter Umschläge zu sehen';

  @override
  String get ui3RedPacketActive => 'Aktiv';

  @override
  String get ui3RedPacketCompleted => 'Abgeschlossen';

  @override
  String get ui3CardsAndPasses => 'Karten und Pässe';

  @override
  String get ui3CardsAndPassesDesc =>
      'Wallet-Karten, Gutscheine und Pässe werden in der Haupt-App verwaltet.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'Kartenpaket erfordert die Haupt-App';

  @override
  String get ui3OpenCardPack => 'Kartenpaket öffnen';

  @override
  String get ui3UnableToOpenChat =>
      'Chat mit diesem Kontakt kann nicht geöffnet werden';

  @override
  String get ui3WalletManagedInMainApp =>
      'Wallet wird in der Haupt-App verwaltet';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Pläne';
  }

  @override
  String get ui3NewPlan => 'Neuer Plan';

  @override
  String get ui3MySubscriptions => 'Meine Abonnements';

  @override
  String get ui3AvailablePlans => 'Verfügbare Pläne';

  @override
  String get ui3NoPlansYet =>
      'Noch keine Pläne · tippe auf „Neuer Plan“, um einen zu erstellen';

  @override
  String ui3DaysLeft(Object days) {
    return 'Noch $days T.';
  }

  @override
  String get ui3SubscriptionCancelled => 'Gekündigt';

  @override
  String get ui3AutoRenewOn => 'Automatische Verlängerung: an';

  @override
  String get ui3AutoRenewOff => 'Automatische Verlängerung: aus';

  @override
  String get ui3CancelSubscriptionTitle => 'Abonnement kündigen?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Dein Abo für $name bleibt bis zum Ablauf aktiv und wird nicht verlängert.';
  }

  @override
  String get ui3Subscribe => 'Abonnieren';

  @override
  String ui3SubscribedTo(Object name) {
    return '$name abonniert';
  }

  @override
  String get ui3PlanPriceLabel => 'Preis (z. B. 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Beschreibung (optional)';

  @override
  String get ui3PlanBenefitsLabel => 'Vorteile (durch Kommas getrennt)';

  @override
  String get ui3PlanPeriod => 'Zeitraum:';

  @override
  String get ui3Monthly => 'Monatlich';

  @override
  String get ui3Yearly => 'Jährlich';

  @override
  String get ui3SaveRemarkFailed => 'Notiz konnte nicht gespeichert werden';

  @override
  String get ui3CopyLink => 'Link kopieren';

  @override
  String get ui3Connect => 'Verbinden';

  @override
  String get ui3CommonTokens => 'Gemeinsame Token';

  @override
  String get ui3SharedNfts => 'Gemeinsame NFTs';

  @override
  String get ui3TransactionHistory => 'Transaktionsverlauf';

  @override
  String get ui3CommonDaos => 'Gemeinsame DAOs';

  @override
  String get ui3SameChains => 'Gleiche Chains';

  @override
  String get ui3ChatInitFailed => 'Chat konnte nicht initialisiert werden';

  @override
  String get ui3CheckNetworkRetry =>
      'Bitte prüfe deine Netzwerkverbindung und versuche es erneut';

  @override
  String get ui3FromContacts => 'Aus Kontakten';

  @override
  String get ui3FindFriendsFromContacts =>
      'Freunde in deinen Telefonkontakten finden';

  @override
  String get ui3EnsOrDomain => 'ENS / Domäne';

  @override
  String get ui3LoadingContacts => 'Kontakte werden geladen...';

  @override
  String get ui3ContactsPermissionRequired =>
      'Zugriff auf Kontakte erforderlich';

  @override
  String get ui3ContactsPermissionMessage =>
      'Um Freunde in deinen Kontakten zu finden, erlaube bitte den Zugriff auf deine Kontakte.';

  @override
  String get ui3AllowAccess => 'Zugriff erlauben';

  @override
  String get ui3NoContactMatches => 'Keine Treffer gefunden';

  @override
  String get ui3NoContactMatchesMessage =>
      'Noch keiner deiner Kontakte nutzt diese App. Lade sie ein!';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count Kontakte durchsucht';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return '$count Treffer in deinen Kontakten gefunden';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'In Kontakten: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Dieses Foto löschen?';

  @override
  String get ui3InviteLink => 'Einladungslink';

  @override
  String get ui3ShareJoinLink => 'Beitrittslink für diesen Raum teilen';

  @override
  String get ui3ShareRoomReference =>
      'Raumverweis mit eingeladenen Mitgliedern teilen';

  @override
  String get ui3ScanToJoinGroup =>
      'Scannen, um dieser Gruppe direkt beizutreten';

  @override
  String get ui3ScanToShareRoomReference =>
      'Scannen, um diesen Raumverweis mit eingeladenen Mitgliedern zu teilen';

  @override
  String get ui3InviteLinkLoadFailed =>
      'Einladungslink konnte nicht geladen werden';

  @override
  String get ui3InviteLinkCopied => 'Einladungslink kopiert';

  @override
  String get ui3ChannelCategoryOptional => 'Kategorie (optional)';

  @override
  String get ui3ChannelCategoryHint => 'Ankündigungen / Produkt / Support';

  @override
  String get ui3DescriptionOptional => 'Beschreibung (optional)';

  @override
  String get ui3WebhookEnable => 'Webhook-Automatisierung aktivieren';

  @override
  String get ui3WebhookEnableDesc =>
      'Sendet Beitritts- und Begrüßungsereignisse an deinen Integrationsendpunkt.';

  @override
  String get ui3WebhookUrl => 'Webhook-URL';

  @override
  String get ui3WebhookSecretOptional => 'Signaturschlüssel (optional)';

  @override
  String get ui3WebhookSecretHint => 'Wird für X-N42-Signature verwendet';

  @override
  String get ui3WebhookNotifyMemberJoined =>
      'Benachrichtigen, wenn ein Mitglied beitritt';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'Benachrichtigen, wenn die Begrüßung gesendet wird';

  @override
  String get ui3WebhookTestSend => 'Test-Webhook senden';

  @override
  String get ui3WebhookTestSending => 'Test-Webhook wird gesendet...';

  @override
  String get ui3WebhookTestSent => 'Test-Webhook erfolgreich gesendet';

  @override
  String get ui3WebhookTestFailed =>
      'Test-Webhook konnte nicht gesendet werden';

  @override
  String get ui3WebhookUrlInvalid =>
      'Die Webhook-URL muss eine öffentliche HTTPS-Adresse sein';

  @override
  String get ui3WebhookSelectEvent =>
      'Wähle mindestens ein Webhook-Ereignis aus';

  @override
  String get ui3SensitiveDataDetection => 'Erkennung sensibler Daten';

  @override
  String get ui3Email => 'E-Mail';

  @override
  String get ui3CreditCard => 'Kreditkarte';

  @override
  String get ui3DetectEmailDesc =>
      'E-Mail-Adressen in Textnachrichten erkennen';

  @override
  String get ui3DetectPhoneDesc =>
      'Telefonnummern und internationale Nummern erkennen';

  @override
  String get ui3DetectCardDesc =>
      'Wahrscheinliche Bank- und Kartennummern erkennen';

  @override
  String get ui3DetectWalletDesc =>
      'Wallet-Adressen im Ethereum-Format erkennen';

  @override
  String get ui3GeneralTopic => 'Allgemein';

  @override
  String get a11yPreviousResult => 'Vorheriges Ergebnis';

  @override
  String get a11yNextResult => 'Nächstes Ergebnis';

  @override
  String get ui3TryDifferentKeywords => 'Versuche andere Suchbegriffe';

  @override
  String ui3FiltersActive(Object count) {
    return 'Aktive Filter: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Aktive Nachrichtenfilter: $count';
  }

  @override
  String get ui3LoadMore => 'Mehr laden';

  @override
  String get ui3MessageFilters => 'Nachrichtenfilter';

  @override
  String get ui3SenderUserId => 'Benutzer-ID des Absenders';

  @override
  String get ui3FilterType => 'Typ';

  @override
  String get ui3FilterAny => 'Alle';

  @override
  String get ui3FilterImage => 'Bild';

  @override
  String get ui3FilterTime => 'Zeit';

  @override
  String get ui3AnyTime => 'Beliebige Zeit';

  @override
  String get ui3OnlyMyMessages => 'Nur meine Nachrichten';

  @override
  String get ui3MediaOnly => 'Nur Medien';

  @override
  String get ui3Apply => 'Anwenden';

  @override
  String get ui3QrStyleClassic => 'Klassisch';

  @override
  String get ui3QrStyleOcean => 'Ozean';

  @override
  String get ui3QrStyleBerry => 'Beere';

  @override
  String get a11yFlashlightOn => 'Taschenlampe einschalten';

  @override
  String get a11yFlashlightOff => 'Taschenlampe ausschalten';

  @override
  String get ui3SocialGraph => 'Sozialer Graph';

  @override
  String get ui3RecommendedConnections => 'Empfohlene Kontakte';

  @override
  String get ui3Portfolio => 'Depot';

  @override
  String get ui3Chains => 'Blockchains';

  @override
  String get ui3Tokens => 'Token';

  @override
  String get ui3NoConnectionsFound => 'Keine Verbindungen gefunden';

  @override
  String get ui3ConnectionsHint =>
      'Verbindungen erscheinen, sobald du On-Chain-Aktivität aufbaust';

  @override
  String get ui3SocialGraphLoadFailed =>
      'Sozialer Graph konnte nicht geladen werden';

  @override
  String get ui3Similarity => 'Ähnlichkeit';

  @override
  String get ui3Breakdown => 'Aufschlüsselung';

  @override
  String get ui3TokenHoldings => 'Token-Bestände';

  @override
  String get ui3NftCollections => 'NFT-Sammlungen';

  @override
  String get ui3ChainUsage => 'Chain-Nutzung';

  @override
  String get ui3Transactions => 'Transaktionen';

  @override
  String get ui3DaoMembership => 'DAO-Mitgliedschaft';

  @override
  String get ui3NotWeighted => 'Nicht gewichtet';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent % (Gewichtung: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Gemeinsame On-Chain-Aktivität';

  @override
  String get ui3SharedTokens => 'Gemeinsame Tokens';

  @override
  String get ui3SharedNftCollections => 'Gemeinsame NFT-Sammlungen';

  @override
  String get ui3SharedChains => 'Gemeinsame Chains';

  @override
  String get ui3NoSharedTokens => 'Keine gemeinsamen Tokens gefunden';

  @override
  String get ui3NoSharedNftCollections =>
      'Keine gemeinsamen NFT-Sammlungen gefunden';

  @override
  String get ui3NoSharedChains => 'Keine gemeinsamen Chains gefunden';

  @override
  String get ui3SimilarityFailed => 'Ähnlichkeit konnte nicht berechnet werden';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +$count weitere';
  }

  @override
  String get a11yGovernance => 'Governance-Bereich';

  @override
  String get ui3CommunityLink => 'Community-Link';

  @override
  String get ui3CommunityQrCode => 'Community-QR-Code';

  @override
  String get ui3CommunityQrSubtitle =>
      'Scannen, um der Community beizutreten und ihre Kanäle zu entdecken';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Community-Link konnte nicht geladen werden';

  @override
  String get ui3CommunityLinkCopied => 'Community-Link kopiert';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name wird aus dieser Community entfernt.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name wird entfernt und kann nicht erneut beitreten.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Melde dich an, um öffentliche Kanäle zu entdecken';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Beitritt zu $name nicht möglich: $error';
  }

  @override
  String get ui3CategoryTech => 'Technik';

  @override
  String get ui3CategorySocial => 'Soziales';

  @override
  String get ui3NoPublicChannels => 'Keine öffentlichen Kanäle gefunden';

  @override
  String get ui3StoriesAndFun => 'Stories & Spaß';

  @override
  String get ui3SearchMusicHint => 'Songs, Künstler oder Freunde suchen';

  @override
  String get ui3ForYou => 'Für dich';

  @override
  String get ui3Liked => 'Gefällt mir';

  @override
  String get ui3NoLikedMusic => 'Noch keine Lieblingsmusik';

  @override
  String get ui3NoMusicStories => 'Noch keine Musik-Stories';

  @override
  String get ui3LikedMusicHint =>
      'Tippe auf das Herz neben einem Song, um ihn hier zu speichern.';

  @override
  String get ui3MusicStoriesHint => 'Musik aus Stories erscheint hier.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · geteilt von $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return '$title kann nicht abgespielt werden: $error';
  }

  @override
  String get a11yPreviousTrack => 'Vorheriger Titel';

  @override
  String get a11yNextTrack => 'Nächster Titel';

  @override
  String get a11yPlay => 'Abspielen';

  @override
  String get a11yPause => 'Pausieren';

  @override
  String get ui3Refresh => 'Aktualisieren';

  @override
  String get ui3NearbyIntroTitle =>
      'Öffentliche Beiträge in der Nähe entdecken';

  @override
  String get ui3NearbyIntroBody =>
      'Dein Standort wird einmalig auf diesem Gerät verwendet, um öffentliche Momente zu sortieren. Er wird weder hochgeladen, übertragen noch anderen angezeigt.';

  @override
  String get ui3UseMyLocation => 'Meinen Standort verwenden';

  @override
  String get ui3NearbyUnavailable => '„In der Nähe“ ist nicht verfügbar';

  @override
  String get ui3NoNearbyPosts => 'Noch keine Beiträge in der Nähe';

  @override
  String get ui3NoNearbyPostsHint =>
      'Öffentliche Momente mit Standort erscheinen hier.';

  @override
  String get ui3NearbyDistanceNote =>
      'Ungefähre Entfernung · nur öffentliche Standortbeiträge';

  @override
  String get ui3PublicLocationPost => 'Öffentlicher Standortbeitrag';

  @override
  String get ui3LocationServicesOff => 'Ortungsdienste sind deaktiviert';

  @override
  String get ui3LocationPermissionDenied =>
      'Standortberechtigung wurde verweigert';

  @override
  String get ui3EnableLocationInSettings =>
      'Aktiviere die Standortberechtigung in den Systemeinstellungen';

  @override
  String get ui3CreateStory => 'Story erstellen';

  @override
  String get ui3CreateStoryDesc => 'Teile einen Text- oder Fotostatus.';

  @override
  String get ui3StoryCamera => 'Story-Kamera';

  @override
  String get ui3StoryCameraDesc => 'Direkt zu Filtern und Fotobearbeitung.';

  @override
  String get ui3MomentsDesc =>
      'Öffne den vollständigen Feed und die Kommentare.';

  @override
  String get ui3MomentCamera => 'Moment-Kamera';

  @override
  String get ui3MomentCameraDesc =>
      'Erstelle einen Beitrag und wähle sofort Medien aus.';

  @override
  String get ui3GamesDesc => 'Starte das integrierte Casual-Game-Center.';

  @override
  String get ui3AvatarStudio => 'Avatar-Studio';

  @override
  String get ui3AvatarStudioDesc =>
      'Dekorationen, NFT-Avatar und Identitäts-Flair.';

  @override
  String get ui3SocialGraphDesc => 'On-Chain-Follows, Fans und Verbindungen.';

  @override
  String get ui3SocialHubHeroTitle => 'Stories, Momente, Spiele und Avatare';

  @override
  String get ui3SocialHubHeroBody =>
      'Alle sozialen Funktionen an einem Ort, statt verstreut über Chat, Profil und Entdecken.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'Social Graph ist in diesem Build nicht konfiguriert';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Verbinde eine Wallet, um deinen Social Graph zu sehen';

  @override
  String get ui3AvatarStudioSignIn =>
      'Für das Avatar-Studio musst du angemeldet sein';

  @override
  String get a11yRemoveImage => 'Bild entfernen';

  @override
  String get a11yBack => 'Zurück';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Transaktion bestätigen';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Eine Mini-App möchte in deinem Namen eine Transaktion senden.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return '$name öffnen?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Öffnen';

  @override
  String get ui3StoryReplySendFailed =>
      'Story-Antwort konnte nicht gesendet werden';

  @override
  String get ui3RedPacketDemoNotice =>
      'Demo-Roter-Umschlag — nur ein Eintrag im Chat, es wird kein echtes On-Chain-Asset übertragen.';

  @override
  String get ui3RedPacketCoverClassic => 'Klassisch Rot';

  @override
  String get ui3RedPacketCoverGolden => 'Gold';

  @override
  String get ui3RedPacketCoverPurple => 'Lila';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Ozeanblau';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Naturgrün';

  @override
  String get ui3RedPacketCoverRosePink => 'Rosé';

  @override
  String get ui3RedPacketHistoryEmpty => 'Noch keine roten Umschläge';

  @override
  String get ui3TransferMerchantQrWithAmount => 'Händler-QR (mit Betrag)';

  @override
  String get ui3TransferMerchantQrTitle => 'Händler-QR';

  @override
  String get ui3TransferOpenAmountHint => 'Für freien Betrag leer lassen';

  @override
  String get ui3FiatRampTitle => 'Krypto kaufen / verkaufen';

  @override
  String get ui3FiatRampBuy => 'Kaufen';

  @override
  String get ui3FiatRampSell => 'Verkaufen';

  @override
  String get ui3FiatRampNotConfigured =>
      'Fiat-On/Off-Ramp ist nicht konfiguriert';

  @override
  String get a11yPointsAddRule => 'Belohnungsregel hinzufügen';

  @override
  String get a11yGovernanceRemoveChoice => 'Option entfernen';

  @override
  String get a11yGovernanceCreateProposal => 'Vorschlag erstellen';

  @override
  String get ui3MiniAppUpdateN42 => 'N42 aktualisieren';

  @override
  String get ui3MiniAppOfficial => 'Offiziell';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count Nutzer';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Hintergrundfarbe $index';
  }

  @override
  String get a11yStoryAdd => 'Story hinzufügen';

  @override
  String get ui3StoryPostFailed => 'Story konnte nicht gepostet werden';

  @override
  String get ui3StoryTapToSelectImage => 'Tippen, um ein Bild auszuwählen';

  @override
  String get ui3StoryChangeImage => 'Ändern';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Ausgewählte Musik kann nicht gelesen werden: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Diese Story löschen?';

  @override
  String get ui3StoryDeleteFailed => 'Story konnte nicht gelöscht werden';

  @override
  String get ui3MomentCreateTitle => 'Moment erstellen';

  @override
  String get ui3MomentContentHint => 'Was denkst du gerade?';

  @override
  String get ui3MomentAddPhotos => 'Fotos hinzufügen';

  @override
  String get ui3MomentAddLocation => 'Standort hinzufügen';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Ausgewählte Medien ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Alle entfernen';

  @override
  String get ui3MomentClearMediaConfirm =>
      'Alle ausgewählten Fotos/Videos entfernen?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Für alle Freunde sichtbar';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Nur für dich sichtbar';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Auswählen, wer es sehen kann';

  @override
  String get ui3MomentVisibilityExcludedDesc =>
      'Vor bestimmten Freunden verbergen';

  @override
  String get ui3MomentVideos => 'Videobeiträge';

  @override
  String get ui3MomentNoVideos => 'Noch keine Videos';

  @override
  String get a11yCallMinimize => 'Minimieren';

  @override
  String get a11yCallGridView => 'Rasteransicht';

  @override
  String get a11yCallFocusView => 'Fokusansicht';

  @override
  String get ui3CallTools => 'Anruf-Tools';

  @override
  String get ui3CallMeetingTools => 'Meeting-Tools';

  @override
  String get ui3CallToolsSubtitle =>
      'Audio- und Videoqualität anpassen, ohne den Anruf zu verlassen.';

  @override
  String get ui3CallAudioEnhancement => 'Audioverbesserung';

  @override
  String get ui3CallNoiseSuppression => 'Rauschunterdrückung';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Reduziert Tastatur- und Hintergrundgeräusche.';

  @override
  String get ui3CallEchoCancellation => 'Echounterdrückung';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Verhindert, dass Lautsprecherton zurück ins Mikrofon gelangt.';

  @override
  String get ui3CallAutoGainControl => 'Automatische Verstärkung';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Hält die Mikrofonlautstärke stabiler.';

  @override
  String get ui3CallVoiceIsolation => 'Erweiterte Sprachisolierung';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Stärkeres Profil zur Rauschreduzierung verwenden.';

  @override
  String get ui3CallVideoSection => 'Bild';

  @override
  String get ui3CallBackgroundBlur => 'Hintergrund weichzeichnen (Beta)';

  @override
  String get ui3CallBlurDescReady =>
      'Einstellung ist aktiv. Der sichtbare Weichzeichner hängt noch von der Einführung der Videoverarbeitung ab.';

  @override
  String get ui3CallBlurDescSaved =>
      'Weichzeichner-Einstellung gespeichert. Sie wird angewendet, sobald die Kameraverarbeitung verfügbar ist.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Schalte deine Kamera ein, sobald die Hintergrundverarbeitung verfügbar ist.';

  @override
  String get ui3CallRecordingSection => 'Aufnahme';

  @override
  String get ui3CallRecordingDesc =>
      'Zum Speichern von Aufnahmen ist serverseitiges Egress erforderlich.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Anrufeinstellungen konnten nicht aktualisiert werden: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Aufnahme gestartet';

  @override
  String get ui3VoiceRoomNotFound => 'Raum nicht gefunden';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Möchtest du diesen Sprachraum wirklich beenden?';

  @override
  String get a11yGameMoveUp => 'Nach oben';

  @override
  String get a11yGameMoveDown => 'Nach unten';

  @override
  String get a11yGameMoveLeft => 'Nach links';

  @override
  String get a11yGameMoveRight => 'Nach rechts';

  @override
  String get a11yGameRotate => 'Drehen';

  @override
  String get a11yGameDrop => 'Fallen lassen';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count Sticker hinzugefügt';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Hinzufügen fehlgeschlagen: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Sticker entfernen';

  @override
  String get ui3StickerRemoveConfirm =>
      'Diesen Sticker aus dem Paket entfernen?';

  @override
  String get ui3StickerRemoveFailed => 'Entfernen fehlgeschlagen';

  @override
  String get ui3StickerRenamePack => 'Paket umbenennen';

  @override
  String get ui3StickerPackName => 'Paketname';

  @override
  String get ui3StickerRenameFailed => 'Umbenennen fehlgeschlagen';

  @override
  String get ui3StickerDeletePack => 'Paket löschen';

  @override
  String get ui3StickerThisPack => 'dieses Paket';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return '„$name“ und alle zugehörigen Sticker löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Löschen fehlgeschlagen';

  @override
  String get ui3StickerPack => 'Sticker-Paket';

  @override
  String get ui3StickerAdding => 'Wird hinzugefügt…';

  @override
  String get ui3StickerAddStickers => 'Sticker hinzufügen';

  @override
  String get ui3StickerPackNotFound => 'Paket nicht gefunden';

  @override
  String get ui3StickerEmptyHint =>
      'Tippe auf „Sticker hinzufügen“, um Bilder hochzuladen';

  @override
  String get ui3StickerNewPack => 'Neues Sticker-Paket';

  @override
  String get ui3StickerCreate => 'Erstellen';

  @override
  String get ui3StickerCreateFailed => 'Paket konnte nicht erstellt werden';

  @override
  String ui3StickerInstalled(Object name) {
    return '„$name“ installiert';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Sticker-Paket entfernen';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return '„$name“ aus deinen Stickern entfernen?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '„$name“ entfernt';
  }

  @override
  String get ui3StickerAiSticker => 'KI-Sticker';

  @override
  String get ui3StickerStoreTab => 'Shop';

  @override
  String get ui3StickerMyStickersTab => 'Meine Sticker';

  @override
  String get ui3StickerNoneFound => 'Keine Sticker gefunden';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'von $author';
  }

  @override
  String get ui3StickerManage => 'Verwalten';

  @override
  String ui3StickerCount(Object count) {
    return '$count Sticker';
  }

  @override
  String get ui3StickerNoneInstalled => 'Keine Sticker installiert';

  @override
  String get ui3StickerGetFromStore => 'Hol dir Sticker im Shop';

  @override
  String get ui3StickerBrowseStore => 'Shop durchsuchen';

  @override
  String get ui3StickerAddedToAi => 'Zu „KI-Sticker“ hinzugefügt';

  @override
  String get ui3StickerAddOneFailed =>
      'Sticker konnte nicht hinzugefügt werden';

  @override
  String get ui3StickerPromptLabel => 'Beschreibe deinen Sticker';

  @override
  String get ui3StickerPromptHint =>
      'z. B. eine fröhliche orange Katze mit Sonnenbrille';

  @override
  String get ui3StickerGenerating => 'Wird generiert…';

  @override
  String get ui3StickerGenerate => 'Generieren';

  @override
  String get ui3StickerAddToStickers => 'Zu Stickern hinzufügen';

  @override
  String get ui3StickerGeneratingPreview => 'Dein Sticker wird generiert…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Beschreibe einen Sticker und tippe auf „Generieren“';
}
