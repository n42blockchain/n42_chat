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
}
