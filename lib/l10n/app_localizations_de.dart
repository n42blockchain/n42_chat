// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get chatModuleInitFailed =>
      'Chat-Modul-Initialisierung fehlgeschlagen';

  @override
  String get checkNetworkRetry =>
      'Bitte überprüfen Sie Ihre Netzwerkverbindung und versuchen Sie es erneut';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get unknownUser => 'Unbekannter Benutzer';

  @override
  String get walletNotConnected => 'Wallet nicht verbunden';

  @override
  String get cannotGetWalletAddress =>
      'Wallet-Adresse kann nicht abgerufen werden';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Zahlungsanfrage: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Anrufdienst nicht initialisiert';

  @override
  String get alreadyInCall => 'Bereits im Gespräch';

  @override
  String get meetingServiceNotInitialized =>
      'Meeting-Dienst nicht initialisiert';

  @override
  String get livekitNotConfigured => 'LiveKit nicht konfiguriert';

  @override
  String get unknownConversation => 'Unbekannte Unterhaltung';

  @override
  String startCallFailed(String error) {
    return 'Anruf starten fehlgeschlagen: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Antworten fehlgeschlagen: $error';
  }

  @override
  String get connectionFailed => 'Verbindung fehlgeschlagen';

  @override
  String get callRejected => 'Anruf abgelehnt';

  @override
  String get noAnswer => 'Keine Antwort';

  @override
  String get invalidLoginResponse => 'Ungültige Anmeldeantwort';

  @override
  String loginFailed(String error) {
    return 'Anmeldung fehlgeschlagen: $error';
  }

  @override
  String get sessionRestoreFailed => 'Sitzungswiederherstellung fehlgeschlagen';

  @override
  String get additionalVerificationRequired =>
      'Zusätzliche Verifizierung erforderlich';

  @override
  String registrationFailed(String error) {
    return 'Registrierung fehlgeschlagen: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Verbindung zum Server nicht möglich: $error';
  }

  @override
  String get wrongUsernamePassword => 'Falscher Benutzername oder Passwort';

  @override
  String get usernameTaken => 'Benutzername bereits vergeben';

  @override
  String get invalidUsernameFormat => 'Ungültiges Benutzernamenformat';

  @override
  String get rateLimitExceeded =>
      'Zu viele Anfragen, bitte versuchen Sie es später erneut';

  @override
  String get loginExpired => 'Anmeldung abgelaufen';

  @override
  String joinMeetingFailed(String error) {
    return 'Meeting beitreten fehlgeschlagen: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Bildschirmfreigabe fehlgeschlagen: $error';
  }

  @override
  String get answer => 'Annehmen';

  @override
  String get decline => 'Ablehnen';

  @override
  String get missedCall => 'Verpasster Anruf';

  @override
  String get callBack => 'Zurückrufen';

  @override
  String get incomingCall => 'Eingehender Anruf';

  @override
  String get missedVideoCall => 'Verpasster Videoanruf';

  @override
  String get missedVoiceCall => 'Verpasster Sprachanruf';

  @override
  String get passkeyNotInitialized => 'Passkey nicht initialisiert';

  @override
  String get googleSignInNotConfigured => 'Google-Anmeldung nicht konfiguriert';

  @override
  String get encryptedMessage => '[Verschlüsselte Nachricht]';

  @override
  String get sticker => '[Sticker]';

  @override
  String get groupCreated => 'Gruppe erstellt';

  @override
  String get groupNameChanged => 'Gruppenname geändert';

  @override
  String get groupAvatarChanged => 'Gruppenbild geändert';

  @override
  String get groupAnnouncementChanged => 'Gruppenankündigung geändert';

  @override
  String get image => '[Bild]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Sprachnachricht]';

  @override
  String get file => '[Datei]';

  @override
  String get location => '[Standort]';

  @override
  String get unknownMessage => '[Unbekannte Nachricht]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName ist der Gruppe beigetreten';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName hat die Gruppe verlassen';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName wurde eingeladen';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName wurde entfernt';
  }

  @override
  String get avatarDataEmpty => 'Avatar-Daten sind leer';

  @override
  String get avatarTooLarge => 'Avatar-Datei zu groß, max. 10MB';

  @override
  String get uploadAvatarFailed => 'Avatar-Upload fehlgeschlagen';

  @override
  String get delete => 'Löschen';

  @override
  String get notLoggedIn => 'Nicht angemeldet';

  @override
  String roomNotExist(String roomId) {
    return 'Raum nicht gefunden: $roomId';
  }

  @override
  String get uploadImageFailed => 'Bild-Upload fehlgeschlagen';

  @override
  String get matrixClientNotInitialized => 'Matrix-Client nicht initialisiert';

  @override
  String get uploadVoiceFailed =>
      'Sprachnachricht-Upload fehlgeschlagen: MXC-URI nicht verfügbar';

  @override
  String get uploadVideoFailed =>
      'Video-Upload fehlgeschlagen: MXC-URI nicht verfügbar';

  @override
  String get uploadFileFailed =>
      'Datei-Upload fehlgeschlagen: MXC-URI nicht verfügbar';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Standort: $lat, $lon';
  }

  @override
  String get myLocation => 'Mein Standort';

  @override
  String get pollEnded => 'Umfrage beendet';

  @override
  String get groupChat => 'Gruppenchat';

  @override
  String get search => 'Suchen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get userCancelled => 'Benutzer hat abgebrochen';

  @override
  String get noData => 'Keine Daten';

  @override
  String get noSearchResults => 'Keine Suchergebnisse';

  @override
  String get tryDifferentKeyword => 'Versuchen Sie ein anderes Stichwort';

  @override
  String get loadFailed => 'Laden fehlgeschlagen';

  @override
  String get checkNetwork => 'Bitte überprüfen Sie Ihre Netzwerkverbindung';

  @override
  String get networkConnectionFailed => 'Netzwerkverbindung fehlgeschlagen';

  @override
  String get checkNetworkSettings =>
      'Bitte überprüfen Sie Ihre Netzwerkeinstellungen';

  @override
  String get messages => 'Nachrichten';

  @override
  String get contacts => 'Kontakte';

  @override
  String get discover => 'Entdecken';

  @override
  String get me => 'Ich';

  @override
  String get voiceLoading =>
      'Sprachnachricht wird geladen, bitte später erneut versuchen';

  @override
  String get voiceToTextFailed => 'Sprache zu Text fehlgeschlagen';

  @override
  String get converting => 'Konvertiere...';

  @override
  String get convertToText => 'In Text';

  @override
  String get convertToTextTitle => 'In Text umwandeln';

  @override
  String get selectEmoji => 'Emoji auswählen';

  @override
  String get frequentlyUsed => 'Häufig verwendet';

  @override
  String get copy => 'Kopieren';

  @override
  String get forward => 'Weiterleiten';

  @override
  String get unfavorite => 'Favorit entfernen';

  @override
  String get favorite => 'Favorit';

  @override
  String get resend => 'Erneut senden';

  @override
  String get recall => 'Zurückrufen';

  @override
  String get multiSelect => 'Mehrfachauswahl';

  @override
  String get quote => 'Zitieren';

  @override
  String get remind => 'Erinnern';

  @override
  String get searchThis => 'Suchen';

  @override
  String get recallMessageConfirm => 'Diese Nachricht zurückrufen?';

  @override
  String get youRecalledMessage => 'Sie haben eine Nachricht zurückgerufen';

  @override
  String get otherRecalledMessage => 'Nachricht zurückgerufen';

  @override
  String get reEdit => 'Bearbeiten';

  @override
  String get copied => 'Kopiert';

  @override
  String get sendMessageHint => 'Nachricht senden';

  @override
  String get microphonePermissionRequired =>
      'Bitte Mikrofonberechtigung erlauben';

  @override
  String startRecordingFailed(String error) {
    return 'Aufnahme starten fehlgeschlagen: $error';
  }

  @override
  String get recordingTooShort => 'Aufnahme zu kurz';

  @override
  String stopRecordingFailed(String error) {
    return 'Aufnahme stoppen fehlgeschlagen: $error';
  }

  @override
  String get releaseToCancel => 'Loslassen zum Abbrechen';

  @override
  String get releaseToSend =>
      'Loslassen zum Senden, nach oben wischen zum Abbrechen';

  @override
  String get holdToTalk => 'Halten zum Sprechen';

  @override
  String get send => 'Senden';

  @override
  String conversationLabel(String roomId) {
    return 'Unterhaltung: $roomId';
  }

  @override
  String contactLabel(String userId) {
    return 'Kontakt: $userId';
  }

  @override
  String get addFriend => 'Freund hinzufügen';

  @override
  String get chatServiceNotConnected => 'Chat-Dienst nicht verbunden';

  @override
  String userNotFoundHint(String query) {
    return 'Benutzer \"$query\" nicht gefunden\n\nTipps:\n• Versuchen Sie die vollständige Benutzer-ID einzugeben, z.B. @benutzername:server.com\n• Überprüfen Sie die Schreibweise des Benutzernamens';
  }

  @override
  String createChatFailed(String error) {
    return 'Chat erstellen fehlgeschlagen: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Suche fehlgeschlagen: $error';
  }

  @override
  String get enterUserIdOrUsername => 'Benutzer-ID oder Benutzernamen eingeben';

  @override
  String get searching => 'Suche...';

  @override
  String get searchUserToChat => 'Benutzer suchen um zu chatten';

  @override
  String get matrixIdExample =>
      'Sie können eine vollständige Matrix-ID eingeben\nz.B. @benutzer:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Benutzer \"$username\" nicht gefunden';
  }

  @override
  String get chat => 'Chat';

  @override
  String get settings => 'Einstellungen';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get login => 'Anmelden';

  @override
  String get createGroup => 'Gruppe erstellen';

  @override
  String developing(String title) {
    return '$title\n(Demnächst verfügbar)';
  }

  @override
  String get error => 'Fehler';

  @override
  String get pageNotFound => 'Seite nicht gefunden';

  @override
  String get backToHome => 'Zurück zur Startseite';

  @override
  String get allRead => 'Alles gelesen';

  @override
  String readCount(int count) {
    return '$count gelesen';
  }

  @override
  String get transfer => 'Überweisung';

  @override
  String get pendingReceipt => 'Ausstehend';

  @override
  String get tapToReceive => 'Tippen zum Empfangen';

  @override
  String get received => 'Empfangen';

  @override
  String get paymentReceived => 'Zahlung empfangen';

  @override
  String get refunded => 'Erstattet';

  @override
  String get expired => 'Abgelaufen';

  @override
  String get redPacketGreeting => 'Beste Wünsche';

  @override
  String get n42RedPacket => 'N42 Rotes Paket';

  @override
  String get goodLuck => 'Viel Glück';

  @override
  String get claimed => 'Eingelöst';

  @override
  String get allClaimed => 'Alle eingelöst';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Liebe';

  @override
  String get animals => 'Tiere';

  @override
  String get food => 'Essen';

  @override
  String get travel => 'Reisen';

  @override
  String get activities => 'Aktivitäten';

  @override
  String get objects => 'Objekte';

  @override
  String get symbols => 'Symbole';

  @override
  String get reply => 'Antworten';

  @override
  String get copiedToClipboard => 'In Zwischenablage kopiert';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get more => 'Mehr';

  @override
  String get selectForwardTarget => 'Empfänger auswählen';

  @override
  String sendCount(int count) {
    return 'Senden ($count)';
  }

  @override
  String get draft => '[Entwurf] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get friendInfo => 'Freund-Info';

  @override
  String get friendInfoDesc =>
      'Bemerkung, Telefon, Tags, Notizen, Fotos hinzufügen und Berechtigungen festlegen.';

  @override
  String get moments => 'Momente';

  @override
  String get sendMessage => 'Nachricht';

  @override
  String get audioVideoCall => 'Audio-/Videoanruf';

  @override
  String get videoChannel => 'Videokanal';

  @override
  String get remark => 'Bemerkung';

  @override
  String get remarkName => 'Bemerkungsname';

  @override
  String get phone => 'Telefon';

  @override
  String get tags => 'Tags';

  @override
  String get notes => 'Notizen';

  @override
  String get photos => 'Fotos';

  @override
  String get permissions => 'Berechtigungen';

  @override
  String get chatMomentsEtc => 'Chat, Momente, Sport, etc.';

  @override
  String get moreInfo => 'Mehr Info';

  @override
  String get commonGroups => 'Gemeinsame Gruppen';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Quelle';

  @override
  String get notificationSettings => 'Benachrichtigungen';

  @override
  String get receiveNotifications =>
      'Neue Nachrichtenbenachrichtigungen erhalten';

  @override
  String get showPreview => 'Nachrichtenvorschau anzeigen';

  @override
  String get showContentInNotification =>
      'Nachrichteninhalt in Benachrichtigungen anzeigen';

  @override
  String get notificationSound => 'Benachrichtigungston';

  @override
  String get playSoundOnMessage => 'Ton bei Nachrichtenempfang abspielen';

  @override
  String get vibrate => 'Vibrieren';

  @override
  String get vibrateOnMessage => 'Bei Nachrichtenempfang vibrieren';

  @override
  String get doNotDisturb => 'Nicht stören';

  @override
  String get dndDescription =>
      'Benachrichtigungen während bestimmter Stunden stumm schalten';

  @override
  String get startTime => 'Startzeit';

  @override
  String get endTime => 'Endzeit';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get about => 'Über';

  @override
  String get logout => 'Abmelden';

  @override
  String get logoutConfirm => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get exit => 'Abmelden';

  @override
  String get save => 'Speichern';

  @override
  String get nickname => 'Spitzname';

  @override
  String get enterNickname => 'Spitzname eingeben';

  @override
  String get signature => 'Signatur';

  @override
  String get addSignature => 'Signatur hinzufügen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String saveFailed(String error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get secureDecentralizedChat => 'Sichere, dezentrale Kommunikation';

  @override
  String get endToEndEncryption => 'Ende-zu-Ende-Verschlüsselung';

  @override
  String get messagesOnlyYouCanSee =>
      'Nachrichten nur für Sie und den Empfänger sichtbar';

  @override
  String get decentralized => 'Dezentral';

  @override
  String get basedOnMatrix => 'Basierend auf dem offenen Matrix-Protokoll';

  @override
  String get walletIntegration => 'Wallet-Integration';

  @override
  String get easyCryptoTransfer => 'Einfache Kryptowährungstransfers';

  @override
  String get register => 'Registrieren';

  @override
  String get agreeTerms => 'Mit der Anmeldung stimmen Sie zu';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get and => 'und';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get serverAddress => 'Serveradresse';

  @override
  String get enterServerAddress => 'Serveradresse eingeben';

  @override
  String get validServerAddress =>
      'Bitte geben Sie eine gültige Serveradresse ein';

  @override
  String connectedTo(String serverName) {
    return 'Verbunden mit $serverName';
  }

  @override
  String get username => 'Benutzername';

  @override
  String get enterUsername => 'Benutzername eingeben';

  @override
  String get password => 'Passwort';

  @override
  String get enterPassword => 'Passwort eingeben';

  @override
  String get registerAccount => 'Registrieren';

  @override
  String get forgotPassword => 'Passwort vergessen';

  @override
  String get otherLoginMethods => 'Andere Anmeldemethoden';

  @override
  String get emailVerification => 'E-Mail-Bestätigungscode';

  @override
  String get enterServerFirst => 'Bitte zuerst Serveradresse eingeben';

  @override
  String get passkeyNeedsServer =>
      'Passkey-Anmeldung erfordert Server-Unterstützung';

  @override
  String googleLoginSuccess(String email) {
    return 'Google-Anmeldung erfolgreich: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google-Anmeldung fehlgeschlagen: $error';
  }

  @override
  String get appleLoginSuccess => 'Apple-Anmeldung erfolgreich';

  @override
  String appleLoginFailed(String error) {
    return 'Apple-Anmeldung fehlgeschlagen: $error';
  }

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get joinN42Chat => 'N42 Chat beitreten und loschatten';

  @override
  String get usernameHint => '3-20 Zeichen, Buchstaben/Zahlen/_';

  @override
  String get usernameMinLength =>
      'Benutzername muss mindestens 3 Zeichen haben';

  @override
  String get usernameMaxLength => 'Benutzername darf maximal 20 Zeichen haben';

  @override
  String get usernameFormat =>
      'Benutzername darf nur Buchstaben, Zahlen und Unterstriche enthalten';

  @override
  String get passwordHint => 'Min. 8 Zeichen';

  @override
  String get passwordMinLength => 'Passwort muss mindestens 8 Zeichen haben';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get reEnterPassword => 'Passwort erneut eingeben';

  @override
  String get passwordsNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get inviteCode => 'Einladungscode (integriert)';

  @override
  String get filled => 'Ausgefüllt';

  @override
  String get enterInviteCode => 'Einladungscode eingeben';

  @override
  String get inviteCodeHint =>
      'Einladungscode ist integriert, normalerweise keine Änderung nötig';

  @override
  String get agreeTermsFirst =>
      'Bitte lesen und akzeptieren Sie zuerst die Nutzungsbedingungen und Datenschutzrichtlinie';

  @override
  String get iAgree => 'Ich habe gelesen und stimme zu';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto?';

  @override
  String get loginNow => 'Jetzt anmelden';

  @override
  String get whoCanSee => 'Wer kann sehen';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Status';

  @override
  String get lastSeen => 'Zuletzt gesehen';

  @override
  String get messageSettings => 'Nachrichten';

  @override
  String get allowStrangerMessage => 'Nachrichten von Fremden erlauben';

  @override
  String get receiveNonContact => 'Nachrichten von Nicht-Kontakten empfangen';

  @override
  String get readReceipts => 'Lesebestätigungen';

  @override
  String get letOthersKnowRead =>
      'Anderen mitteilen, dass Sie ihre Nachrichten gelesen haben';

  @override
  String get typingStatus => 'Tippstatus';

  @override
  String get letOthersKnowTyping => 'Anderen mitteilen, dass Sie tippen';

  @override
  String get everyone => 'Alle';

  @override
  String get contactsOnly => 'Nur Kontakte';

  @override
  String get nobody => 'Niemand';

  @override
  String whoCanSeeItem(String title) {
    return 'Wer kann $title sehen';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get checkUpdate => 'Nach Updates suchen';

  @override
  String get openSourceLicenses => 'Open-Source-Lizenzen';

  @override
  String get feedback => 'Feedback';

  @override
  String get builtOnMatrix => 'Basiert auf Matrix-Protokoll';

  @override
  String get loading => 'Laden...';

  @override
  String get noConversations => 'Keine Unterhaltungen';

  @override
  String get tapToChat => 'Tippen Sie oben rechts um zu chatten';

  @override
  String get startGroup => 'Gruppenchat starten';

  @override
  String get scan => 'Scannen';

  @override
  String get payment => 'Zahlung';

  @override
  String featureComingSoon(String feature) {
    return '$feature demnächst verfügbar';
  }

  @override
  String get markAsRead => 'Als gelesen markieren';

  @override
  String get unmute => 'Stummschaltung aufheben';

  @override
  String get mute => 'Stummschalten';

  @override
  String get unpin => 'Lösen';

  @override
  String get pin => 'Anheften';

  @override
  String get deleteConversation => 'Unterhaltung löschen';

  @override
  String deleteConversationConfirm(String name) {
    return 'Unterhaltung mit \"$name\" löschen?';
  }

  @override
  String get noContacts => 'Keine Kontakte';

  @override
  String get addFriendsToChat => 'Freunde hinzufügen um zu chatten';

  @override
  String get contactNotFound => 'Kontakt nicht gefunden';

  @override
  String get tryOtherKeywords =>
      'Andere Stichwörter oder globale Suche versuchen';

  @override
  String get searchResults => 'Suchergebnisse';

  @override
  String get newFriends => 'Neue Freunde';

  @override
  String get chatOnlyFriends => 'Nur-Chat-Freunde';

  @override
  String get officialAccounts => 'Offizielle Konten';

  @override
  String get serviceAccounts => 'Service-Konten';

  @override
  String get enterpriseContacts => 'Unternehmenskontakte';

  @override
  String contactsCount(int count) {
    return '$count Kontakte';
  }

  @override
  String get recommendToFriend => 'Kontakt teilen';

  @override
  String get setRemark => 'Bemerkung festlegen';

  @override
  String get addToHome => 'Zum Startbildschirm hinzufügen';

  @override
  String get sendingCard => 'Kontaktkarte wird gesendet...';

  @override
  String get contactCard => '[Kontaktkarte]';

  @override
  String cardSent(String contact, String friend) {
    return '${contact}s Karte an $friend gesendet';
  }

  @override
  String recommendFailed(String error) {
    return 'Empfehlung fehlgeschlagen: $error';
  }

  @override
  String get enterRemark => 'Bemerkung eingeben';

  @override
  String remarkSet(String remark) {
    return 'Bemerkung gesetzt auf: $remark';
  }

  @override
  String get openingChat => 'Chat wird geöffnet...';

  @override
  String openChatFailed(String error) {
    return 'Chat öffnen fehlgeschlagen: $error';
  }

  @override
  String get addContact => 'Kontakt hinzufügen';

  @override
  String get enterUserId => 'Benutzer-ID eingeben';

  @override
  String get noFriendRequests => 'Keine Freundschaftsanfragen';

  @override
  String get accept => 'Annehmen';

  @override
  String get reject => 'Ablehnen';

  @override
  String acceptedRequest(String name) {
    return 'Freundschaftsanfrage von $name angenommen';
  }

  @override
  String rejectedRequest(String name) {
    return 'Freundschaftsanfrage von $name abgelehnt';
  }

  @override
  String get noGroups => 'Keine Gruppen';

  @override
  String get creatingGroup => 'Gruppenerstellung demnächst verfügbar...';

  @override
  String get selectFriendToRecommend => 'Freund zum Empfehlen auswählen';

  @override
  String get searchContacts => 'Kontakte suchen';

  @override
  String get noContactsFound => 'Keine Kontakte gefunden';

  @override
  String get yesterday => 'Gestern';

  @override
  String get monday => 'Mo';

  @override
  String get tuesday => 'Di';

  @override
  String get wednesday => 'Mi';

  @override
  String get thursday => 'Do';

  @override
  String get friday => 'Fr';

  @override
  String get saturday => 'Sa';

  @override
  String get sunday => 'So';

  @override
  String get justNow => 'Gerade eben';

  @override
  String minutesAgo(int count) {
    return 'vor $count Min';
  }

  @override
  String hoursAgo(int count) {
    return 'vor $count Std';
  }

  @override
  String daysAgo(int count) {
    return 'vor $count T';
  }

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String minutesAgoOnline(int count) {
    return 'Online vor $count Min';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Online vor $count Std';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Online vor $count T';
  }

  @override
  String get searchContactsGroupsMessages =>
      'Kontakte, Gruppen, Nachrichten suchen';

  @override
  String get searchError => 'Suchfehler';

  @override
  String get searchHint => 'Kontakte, Gruppen und Nachrichten suchen';

  @override
  String get enterKeyword => 'Stichwörter zum Suchen eingeben';

  @override
  String get searchHistory => 'Suchverlauf';

  @override
  String get clear => 'Löschen';

  @override
  String noResultsFor(String query) {
    return 'Keine Ergebnisse für \"$query\"';
  }

  @override
  String get all => 'Alle';

  @override
  String get groups => 'Gruppen';

  @override
  String get noResults => 'Keine Ergebnisse';

  @override
  String get groupInfo => 'Gruppeninfo';

  @override
  String groupMembers(int count) {
    return 'Mitglieder ($count)';
  }

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String get owner => 'Eigentümer';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Einladen';

  @override
  String get groupAnnouncement => 'Gruppenankündigung';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get groupDescription => 'Gruppenbeschreibung';

  @override
  String get publicGroup => 'Öffentliche Gruppe';

  @override
  String get allowSearchJoin => 'Anderen erlauben zu suchen und beizutreten';

  @override
  String get clearChatHistory => 'Chatverlauf löschen';

  @override
  String get dissolveGroup => 'Gruppe auflösen';

  @override
  String get leaveGroup => 'Gruppe verlassen';

  @override
  String get changeGroupName => 'Gruppennamen ändern';

  @override
  String get enterGroupName => 'Gruppenname eingeben';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get changeGroupDescription => 'Gruppenbeschreibung ändern';

  @override
  String get enterGroupDescription => 'Gruppenbeschreibung eingeben';

  @override
  String get editAnnouncement => 'Ankündigung bearbeiten';

  @override
  String get enterAnnouncement => 'Ankündigung eingeben';

  @override
  String get publish => 'Veröffentlichen';

  @override
  String get clearHistoryConfirm =>
      'Gesamten Chatverlauf löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get clearAction => 'Löschen';

  @override
  String get chatHistoryCleared => 'Chatverlauf gelöscht';

  @override
  String leaveGroupConfirm(String name) {
    return '\"$name\" verlassen?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return '\"$name\" auflösen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get dissolve => 'Auflösen';

  @override
  String get groupQrCode => 'Gruppen-QR-Code';

  @override
  String get searchChatHistory => 'Chatverlauf durchsuchen';

  @override
  String get groupIdCopied => 'Gruppen-ID kopiert';

  @override
  String tapCopyGroupId(int count) {
    return '$count Mitglieder · Tippen um Gruppen-ID zu kopieren';
  }

  @override
  String featureInDevelopment(Object feature) {
    return '$feature in Entwicklung...';
  }

  @override
  String get receiverAddress => 'Empfängeradresse';

  @override
  String get enterOrPasteAddress => 'Wallet-Adresse eingeben oder einfügen';

  @override
  String get selectToken => 'Token auswählen';

  @override
  String get transferAmount => 'Überweisungsbetrag';

  @override
  String get available => 'Verfügbar';

  @override
  String get allAmount => 'Alles';

  @override
  String get memoOptional => 'Memo (optional)';

  @override
  String get addMemo => 'Memo hinzufügen';

  @override
  String get confirmTransfer => 'Überweisung bestätigen';

  @override
  String get invalidAddress =>
      'Bitte geben Sie eine gültige Empfängeradresse ein';

  @override
  String get invalidAmount => 'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get selectTokenPlease => 'Bitte wählen Sie einen Token';

  @override
  String get addressVerified => 'Adresse verifiziert';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Verfügbar: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Scanfunktion in Entwicklung...';

  @override
  String get enterAmount => 'Betrag eingeben';

  @override
  String get redPacketCountMin => 'Mindestens 1 rotes Paket erforderlich';

  @override
  String get viewRedPacketDetails => 'Rotes-Paket-Details anzeigen';

  @override
  String get enterTransferAmount => 'Überweisungsbetrag eingeben';

  @override
  String get transferTo => 'Überweisen an';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get receiveTransfer => 'Überweisung erhalten';

  @override
  String fromSender(String name, Object senderName) {
    return 'Von $senderName';
  }

  @override
  String get confirmReceive => 'Empfang bestätigen';

  @override
  String get groupProfile => 'Gruppeninfo';

  @override
  String get viewProfile => 'Profil anzeigen';

  @override
  String get removeMember => 'Aus Gruppe entfernen';

  @override
  String removeMemberConfirm(String name) {
    return '\"$name\" aus der Gruppe entfernen?';
  }

  @override
  String get remove => 'Entfernen';

  @override
  String get clearStatus => 'Status löschen';

  @override
  String get clearStatusConfirm => 'Aktuellen Status löschen?';

  @override
  String get statusCleared => 'Status gelöscht';

  @override
  String statusSet(String result) {
    return 'Status gesetzt auf: $result';
  }

  @override
  String get userNotExist => 'Benutzer existiert nicht';

  @override
  String get userIdCopied => 'Benutzer-ID kopiert';

  @override
  String get voiceCallInDevelopment => 'Sprachanruf in Entwicklung...';

  @override
  String get report => 'Melden';

  @override
  String get reportInDevelopment => 'Meldefunktion in Entwicklung...';

  @override
  String get shareCard => 'Karte teilen';

  @override
  String get shareInDevelopment => 'Teilenfunktion in Entwicklung...';

  @override
  String get qrCode => 'QR-Code';

  @override
  String get qrCodeInDevelopment => 'QR-Code-Funktion in Entwicklung...';

  @override
  String get avatarUpdated => 'Avatar aktualisiert';

  @override
  String selectImageFailed(String error) {
    return 'Bildauswahl fehlgeschlagen: $error';
  }

  @override
  String get changeName => 'Namen ändern';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String genderSet(String gender) {
    return 'Geschlecht gesetzt auf: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Region gesetzt auf: $region';
  }

  @override
  String get setPatText => 'Antippen-Text festlegen';

  @override
  String get changeSignature => 'Signatur ändern';

  @override
  String ringtoneSet(String result) {
    return 'Klingelton gesetzt auf: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature in Entwicklung...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Adresse speichern fehlgeschlagen: $error';
  }

  @override
  String get myAddress => 'Meine Adresse';

  @override
  String get addNew => 'Hinzufügen';

  @override
  String get addAddress => 'Adresse hinzufügen';

  @override
  String get addressAdded => 'Adresse hinzugefügt';

  @override
  String get addressUpdated => 'Adresse aktualisiert';

  @override
  String get deleteAddress => 'Adresse löschen';

  @override
  String get deleteAddressConfirm => 'Diese Adresse löschen?';

  @override
  String get addressDeleted => 'Adresse gelöscht';

  @override
  String get setDefaultAddress => 'Als Standard festlegen';

  @override
  String get fillCompleteInfo => 'Bitte alle Felder ausfüllen';

  @override
  String saveInvoiceFailed(String error) {
    return 'Rechnung speichern fehlgeschlagen: $error';
  }

  @override
  String get myInvoices => 'Meine Rechnungen';

  @override
  String get addInvoice => 'Rechnung hinzufügen';

  @override
  String get invoiceAdded => 'Rechnung hinzugefügt';

  @override
  String get invoiceUpdated => 'Rechnung aktualisiert';

  @override
  String get deleteInvoice => 'Rechnung löschen';

  @override
  String get deleteInvoiceConfirm => 'Diese Rechnung löschen?';

  @override
  String get invoiceDeleted => 'Rechnung gelöscht';

  @override
  String get invoiceType => 'Rechnungstyp: ';

  @override
  String get personal => 'Persönlich';

  @override
  String get enterprise => 'Unternehmen';

  @override
  String get setDefaultInvoice => 'Als Standard festlegen';

  @override
  String get enterTaxId => 'Steuernummer eingeben';

  @override
  String get vibrateMode => 'Vibrationsmodus';

  @override
  String get silentMode => 'Lautlosmodus';

  @override
  String playing(String ringtoneName) {
    return 'Spielt ab: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Abspielen fehlgeschlagen: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Bitte Gruppenname eingeben';

  @override
  String get selectAtLeastOne => 'Bitte mindestens ein Mitglied auswählen';

  @override
  String get fillStatus => 'Status schreiben';

  @override
  String get fileNotExist => 'Datei existiert nicht';

  @override
  String sendFailed(String error) {
    return 'Senden fehlgeschlagen: $error';
  }

  @override
  String get cannotOpenBrowser => 'Browser kann nicht geöffnet werden';

  @override
  String selectFileFailed(String error) {
    return 'Dateiauswahl fehlgeschlagen: $error';
  }

  @override
  String get enterMusicLink => 'Musik-Link eingeben';

  @override
  String get enterValidLink => 'Bitte geben Sie einen gültigen Link ein';

  @override
  String get enterPollQuestion => 'Umfragefrage eingeben';

  @override
  String get minTwoOptions => 'Mindestens 2 Optionen erforderlich';

  @override
  String get crossDeviceEnabled => 'Geräteübergreifende Signierung aktiviert';

  @override
  String get crossDeviceSet =>
      'Geräteübergreifende Signierung erfolgreich eingerichtet';

  @override
  String setupFailed(String error) {
    return 'Einrichtung fehlgeschlagen: $error';
  }

  @override
  String get receiveAmount => 'Empfangsbetrag';

  @override
  String get enterValidAmount => 'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get addressCopied => 'Adresse kopiert';

  @override
  String openItem(String content) {
    return 'Öffnen: $content';
  }

  @override
  String get newNoteComingSoon => 'Neue-Notiz-Funktion demnächst verfügbar';

  @override
  String get addLinkComingSoon =>
      'Link-hinzufügen-Funktion demnächst verfügbar';

  @override
  String get deleted => 'Gelöscht';

  @override
  String get shareComingSoon => 'Teilenfunktion demnächst verfügbar';

  @override
  String get saveComingSoon => 'Speicherfunktion demnächst verfügbar';

  @override
  String get moreStylesComingSoon => 'Weitere Stile demnächst verfügbar';

  @override
  String get wallet => 'Wallet';

  @override
  String get walletArea => 'Wallet-Bereich';

  @override
  String get recording => 'Aufnahme';

  @override
  String get invalidVideoUrl => 'Ungültige Video-URL';

  @override
  String get downloadFile => 'Datei herunterladen';

  @override
  String get clearChatHistoryTitle => 'Chatverlauf löschen';

  @override
  String get cannotUndo => 'Dies kann nicht rückgängig gemacht werden';

  @override
  String get videoCall => 'Videoanruf';

  @override
  String get voiceCall => 'Sprachanruf';

  @override
  String get leaveMeeting => 'Meeting verlassen';

  @override
  String get chatDetails => 'Chat-Details';

  @override
  String get viewAllGroupMembers => 'Alle Mitglieder anzeigen';

  @override
  String get groupName => 'Gruppenname';

  @override
  String get groupNameUpdated => 'Gruppenname aktualisiert';

  @override
  String get updateFailed => 'Aktualisierung fehlgeschlagen';

  @override
  String get noPermissionToModify => 'Sie haben keine Berechtigung zu ändern';

  @override
  String get groupManagement => 'Gruppenverwaltung';

  @override
  String get myNicknameInGroup => 'Mein Spitzname in der Gruppe';

  @override
  String get pinChat => 'Chat anheften';

  @override
  String get strongReminder => 'Starke Erinnerung';

  @override
  String get setChatBackground => 'Chat-Hintergrund festlegen';

  @override
  String get unknownFile => 'Unbekannte Datei';

  @override
  String get download => 'Herunterladen';

  @override
  String get invalidLocation => 'Ungültiger Standort';

  @override
  String get address => 'Adresse';

  @override
  String get latitude => 'Breitengrad';

  @override
  String get longitude => 'Längengrad';

  @override
  String get close => 'Schließen';

  @override
  String get tapToCancel => 'Tippen zum Abbrechen';

  @override
  String captureFailed(Object error) {
    return 'Aufnahme fehlgeschlagen: $error';
  }

  @override
  String get processingVideo => 'Video wird verarbeitet...';

  @override
  String get videoFileNotExist => 'Videodatei existiert nicht';

  @override
  String get videoDataEmpty => 'Videodaten sind leer';

  @override
  String get videoTooLarge => 'Videogröße darf 100MB nicht überschreiten';

  @override
  String get sendingVideo => 'Video wird gesendet...';

  @override
  String sendVideoFailed(Object error) {
    return 'Video senden fehlgeschlagen: $error';
  }

  @override
  String get imageFileNotExist => 'Bilddatei existiert nicht';

  @override
  String get imageDataEmpty => 'Bilddaten sind leer';

  @override
  String get sendingImage => 'Bild wird gesendet...';

  @override
  String sendImageFailed(Object error) {
    return 'Bild senden fehlgeschlagen: $error';
  }

  @override
  String get sendLocation => 'Standort senden';

  @override
  String get selectLocationAndSend => 'Standort auswählen und senden';

  @override
  String get shareRealTimeLocation => 'Echtzeit-Standort teilen';

  @override
  String get shareLocationForOneHour =>
      'Echtzeit-Standort 1 Stunde mit Freund teilen';

  @override
  String get locationSent => 'Standort gesendet';

  @override
  String get selectMessages => 'Nachrichten auswählen';

  @override
  String selectedCount(int count) {
    return '$count ausgewählt';
  }

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String groupChatCount(int count) {
    return 'Gruppenchat ($count)';
  }

  @override
  String get privateChat => 'Privater Chat';

  @override
  String get noMessages => 'Keine Nachrichten';

  @override
  String get sendFirstMessage => 'Erste Nachricht senden um zu chatten';

  @override
  String get encryptionNotice =>
      'Dieser Chat ist Ende-zu-Ende-verschlüsselt. Nur Sie und der Empfänger können die Nachrichten lesen.';

  @override
  String replyTo(String name) {
    return 'Antworten an $name';
  }

  @override
  String get multiForward => 'Weiterleiten';

  @override
  String get collect => 'Sammeln';

  @override
  String get noMembers => 'Keine Mitglieder';

  @override
  String get memberNotFound => 'Mitglied nicht gefunden';

  @override
  String get voiceFileNotExist => 'Sprachdatei existiert nicht';

  @override
  String get voiceFileEmpty => 'Sprachdatei ist leer';

  @override
  String get sendingVoice => 'Sprachnachricht wird gesendet...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Sprachnachricht senden fehlgeschlagen: $error';
  }

  @override
  String get messageCopied => 'Nachricht kopiert';

  @override
  String get messageForwarded => 'Nachricht weitergeleitet';

  @override
  String forwardFailed(Object error) {
    return 'Weiterleiten fehlgeschlagen: $error';
  }

  @override
  String get unfavorited => 'Aus Favoriten entfernt';

  @override
  String get favorited => 'Zu Favoriten hinzugefügt';

  @override
  String get reactionAdded => 'Reaktion hinzugefügt';

  @override
  String get failedMessageDeleted => 'Fehlgeschlagene Nachricht gelöscht';

  @override
  String get deleteMessages => 'Nachrichten löschen';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Möchten Sie wirklich $count Nachrichten löschen?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Hinweis: $count Nachrichten sind von anderen, können nur lokal gelöscht werden.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count Nachrichten von Ihnen werden zurückgerufen.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return '$count Nachrichten zurückgerufen, $localCount lokal gelöscht';
  }

  @override
  String recalledMessages(Object count) {
    return '$count Nachrichten zurückgerufen';
  }

  @override
  String deletedLocally(Object count) {
    return '$count Nachrichten gelöscht (lokal)';
  }

  @override
  String forwardedCount(Object count) {
    return '$count Nachrichten weitergeleitet';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Weiterleiten abgeschlossen: $success erfolgreich, $failed fehlgeschlagen';
  }

  @override
  String get remindOnlyInGroup =>
      'Erinnerungsfunktion nur im Gruppenchat verfügbar';

  @override
  String get onlyTextSearchable =>
      'Nur Textnachrichten können durchsucht werden';

  @override
  String searchFor(Object text) {
    return 'Suche \"$text\"';
  }

  @override
  String get baiduSearch => 'Baidu-Suche';

  @override
  String get googleSearch => 'Google-Suche';

  @override
  String get bingSearch => 'Bing-Suche';

  @override
  String get calling => 'Anrufen...';

  @override
  String get connecting => 'Verbinden...';

  @override
  String get ringing => 'Klingelt...';

  @override
  String get inCall => 'Im Gespräch';

  @override
  String collectMessages(Object count) {
    return '$count Nachrichten gesammelt';
  }

  @override
  String get voted => 'Abgestimmt';

  @override
  String get voteChanged => 'Stimme geändert';

  @override
  String get voteRemoved => 'Stimme entfernt';

  @override
  String get endPoll => 'Umfrage beenden';

  @override
  String get endPollConfirm =>
      'Möchten Sie diese Umfrage wirklich beenden? Nach dem Beenden können keine Stimmen mehr abgegeben werden.';

  @override
  String memberCount(int count) {
    return '$count Mitglieder';
  }

  @override
  String get videoChannels => 'Kanäle';

  @override
  String get live => 'Live';

  @override
  String get listen => 'Hören';

  @override
  String get watch => 'Ansehen';

  @override
  String get searchDiscover => 'Suchen';

  @override
  String get nearbyPeople => 'In der Nähe';

  @override
  String get games => 'Spiele';

  @override
  String get miniPrograms => 'Mini-Programme';

  @override
  String done(int count) {
    return 'Fertig($count)';
  }

  @override
  String get services => 'Dienste';

  @override
  String get favorites => 'Favoriten';

  @override
  String get ordersAndCards => 'Bestellungen & Karten';

  @override
  String get stickers => 'Sticker';

  @override
  String statusSetTo(String status) {
    return 'Status gesetzt auf: $status';
  }

  @override
  String get avatarUploadFailed => 'Avatar-Upload fehlgeschlagen';

  @override
  String get personalProfile => 'Persönliches Profil';

  @override
  String get name => 'Name';

  @override
  String get gender => 'Geschlecht';

  @override
  String get region => 'Region';

  @override
  String get myQrCode => 'Mein QR-Code';

  @override
  String get poke => 'Anstupsen';

  @override
  String get ringtone => 'Klingelton';

  @override
  String get defaultRingtone => 'Standard-Klingelton';

  @override
  String get myAddresses => 'Meine Adressen';

  @override
  String genderSetTo(String gender) {
    return 'Geschlecht gesetzt auf: $gender';
  }

  @override
  String get selectRegion => 'Region auswählen';

  @override
  String get selectCity => 'Stadt auswählen';

  @override
  String regionSetTo(String region) {
    return 'Region gesetzt auf: $region';
  }

  @override
  String get setPoke => 'Anstupsen festlegen';

  @override
  String get friendPokedMe => 'Freund hat mich angestupst';

  @override
  String get enterPokeSuffix =>
      'Anstupsen-Suffix eingeben, z.B.: auf die Schulter';

  @override
  String get example => 'Beispiel';

  @override
  String get onTheShoulder => ' auf die Schulter';

  @override
  String get pokeCleared => 'Anstupsen gelöscht';

  @override
  String pokeSetTo(String suffix) {
    return 'Anstupsen gesetzt auf: hat mich angestupst$suffix';
  }

  @override
  String get editSignature => 'Signatur bearbeiten';

  @override
  String get introduceYourself => 'Ein Satz um sich vorzustellen';

  @override
  String get signatureCleared => 'Signatur gelöscht';

  @override
  String get signatureUpdated => 'Signatur aktualisiert';

  @override
  String get scanToAddFriend =>
      'QR-Code scannen um mich als Freund hinzuzufügen';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Klingelton gesetzt auf: $ringtone';
  }

  @override
  String get confirmDissolveGroup => 'Möchten Sie wirklich auflösen';

  @override
  String get enterValidServerAddress =>
      'Bitte geben Sie eine gültige Serveradresse ein';

  @override
  String get emailOtp => 'E-Mail-OTP';

  @override
  String get enterServerAddressFirst => 'Bitte zuerst Serveradresse eingeben';

  @override
  String get passkeyRequiresServer =>
      'Passkey-Anmeldung erfordert Server-Unterstützung';

  @override
  String get loginAgreement => 'Mit der Anmeldung stimmen Sie zu ';

  @override
  String get pleaseAgreeToTerms =>
      'Bitte lesen und akzeptieren Sie die Nutzungsbedingungen und Datenschutzrichtlinie';

  @override
  String get registerFailed => 'Registrierung fehlgeschlagen';

  @override
  String get reenterPassword => 'Passwort erneut eingeben';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get inviteCodeBuiltIn => 'Einladungscode (Integriert)';

  @override
  String get inviteCodeBuiltInNote =>
      'Einladungscode ist integriert, normalerweise keine Änderung nötig';

  @override
  String get iHaveReadAndAgree => 'Ich habe gelesen und stimme zu ';

  @override
  String get startGroupChat => 'Gruppenchat starten';

  @override
  String get addFriends => 'Freunde hinzufügen';

  @override
  String get paymentAndCollection => 'Zahlung';

  @override
  String messagesWithCount(int count) {
    return 'Nachrichten($count)';
  }

  @override
  String contactCount(int count) {
    return '$count Kontakte';
  }

  @override
  String get addToHomeScreen => 'Zum Startbildschirm hinzufügen';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return '${contact}s Karte an $recipient empfohlen';
  }

  @override
  String get enterRemarkName => 'Bemerkungsname eingeben';

  @override
  String remarkSetTo(String remark) {
    return 'Bemerkung gesetzt auf: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Freundschaftsanfrage von $name angenommen';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Freundschaftsanfrage von $name abgelehnt';
  }

  @override
  String get groupInvites => 'Gruppeneinladungen';

  @override
  String get myGroups => 'Meine Gruppen';

  @override
  String get invitedToJoinGroup => 'Zur Gruppe eingeladen';

  @override
  String get confirmLeaveGroup => 'Möchten Sie wirklich verlassen';

  @override
  String get leave => 'Verlassen';

  @override
  String get saveMedia => 'Speichern';

  @override
  String get recallThisMessage => 'Diese Nachricht zurückrufen?';

  @override
  String get messageRecalled => 'Nachricht zurückgerufen';

  @override
  String get savedToGallery => 'In Galerie gespeichert';

  @override
  String get failedToSave => 'Speichern fehlgeschlagen';

  @override
  String get saving => 'Speichern...';

  @override
  String get share => 'Teilen';

  @override
  String get saveToGallery => 'In Galerie speichern';

  @override
  String get downloadFailed => 'Download fehlgeschlagen';

  @override
  String get noMediaUrl => 'Keine Medien-URL verfügbar';

  @override
  String get shareFailed => 'Teilen fehlgeschlagen';

  @override
  String get failedToLoadImage => 'Bild laden fehlgeschlagen';

  @override
  String get failedToLoadMoreMessages =>
      'Mehr Nachrichten laden fehlgeschlagen';

  @override
  String get failedToSend => 'Senden fehlgeschlagen';

  @override
  String get failedToSendImage => 'Bild senden fehlgeschlagen';

  @override
  String get failedToSendVoice => 'Sprachnachricht senden fehlgeschlagen';

  @override
  String get failedToSendFile => 'Datei senden fehlgeschlagen';

  @override
  String get failedToSendVideo => 'Video senden fehlgeschlagen';

  @override
  String get failedToSendLocation => 'Standort senden fehlgeschlagen';

  @override
  String get failedToResend => 'Erneut senden fehlgeschlagen';

  @override
  String get failedToRecall => 'Zurückrufen fehlgeschlagen';

  @override
  String get failedToReply => 'Antworten fehlgeschlagen';

  @override
  String get failedToAddReaction => 'Reaktion hinzufügen fehlgeschlagen';

  @override
  String get failedToSendPoll => 'Umfrage senden fehlgeschlagen';

  @override
  String get failedToVote => 'Abstimmen fehlgeschlagen';

  @override
  String get failedToLoadMessages => 'Nachrichten laden fehlgeschlagen';

  @override
  String get callFeatureComingSoon =>
      'Sprach- und Videoanruf-Funktion demnächst verfügbar';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Rote Pakete und Überweisungen können nicht weitergeleitet werden';

  @override
  String get videoRecordingFailed =>
      'Videoaufnahme fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get redPacket => 'Rotes Paket';

  @override
  String get music => 'Musik';

  @override
  String get coupon => 'Gutschein';

  @override
  String get gift => 'Geschenk';

  @override
  String get poll => 'Umfrage';

  @override
  String get text => 'Text';

  @override
  String get link => 'Link';

  @override
  String get note => 'Notiz';

  @override
  String get myNotes => 'Meine Notizen';

  @override
  String get today => 'Heute';

  @override
  String daysAgoText(int count) {
    return 'vor $count Tagen';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day.$month.';
  }

  @override
  String get noFavorites => 'Noch keine Favoriten';

  @override
  String get longPressToFavorite =>
      'Nachricht lange drücken um zu favorisieren';

  @override
  String get newNote => 'Neue Notiz';

  @override
  String get favoriteLink => 'Link favorisieren';

  @override
  String get editTags => 'Tags bearbeiten';

  @override
  String get deleteFavorite => 'Favorit löschen';

  @override
  String get deleteFavoriteConfirm =>
      'Möchten Sie diesen Favoriten wirklich löschen?';

  @override
  String get noSearchResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get sendRedPacket => 'Rotes Paket senden';

  @override
  String get amount => 'Betrag';

  @override
  String get redPacketCover => 'Rotes-Paket-Hülle';

  @override
  String get redPacketType => 'Rotes-Paket-Typ';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'Glücks';

  @override
  String get redPacketCount => 'Rote-Pakete-Anzahl';

  @override
  String get pieces => 'Stück';

  @override
  String get putMoneyInRedPacket => 'Geld ins rote Paket legen';

  @override
  String get redPacketRefundNotice =>
      'Nicht eingelöste rote Pakete werden nach 24 Stunden erstattet';

  @override
  String get openRedPacket => 'Öffnen';

  @override
  String get redPacketAllClaimed => 'Rotes Paket vollständig eingelöst';

  @override
  String get redPacketExpired => 'Rotes Paket abgelaufen';

  @override
  String get addTransferNote => 'Überweisungsnotiz hinzufügen';

  @override
  String get yuan => 'CNY';

  @override
  String get savedToChangeCanTransfer =>
      'Im Guthaben gespeichert, direkte Überweisung möglich';

  @override
  String get replyWithEmoji => 'Mit diesem Emoji antworten';

  @override
  String get claimedYourRedPacket => 'hat Ihr';

  @override
  String get claimedRedPacket => 'eingelöst';

  @override
  String get otherTyping => 'tippt...';

  @override
  String get processing => 'Verarbeiten...';

  @override
  String get transferCancelled => 'Überweisung abgebrochen';

  @override
  String get transferFailed => 'Überweisung fehlgeschlagen';

  @override
  String get creatingPaymentRequest => 'Zahlungsanfrage wird erstellt...';

  @override
  String get processingPayment => 'Zahlung wird verarbeitet...';

  @override
  String get paymentFailed => 'Zahlung fehlgeschlagen';

  @override
  String get clickRetry => 'Tippen um erneut zu versuchen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get editRemark => 'Bemerkung bearbeiten';

  @override
  String get setPermissions => 'Berechtigungen festlegen';

  @override
  String get recommendToFriends => 'Freunden empfehlen';

  @override
  String get setStarFriend => 'Als Stern-Freund festlegen';

  @override
  String get addToBlacklist => 'Zur Sperrliste hinzufügen';

  @override
  String get complain => 'Melden';

  @override
  String get deleteContact => 'Kontakt löschen';

  @override
  String deleteContactConfirm(String name) {
    return 'Möchten Sie $name wirklich löschen?';
  }

  @override
  String get transferTitle => 'Überweisung';

  @override
  String get receiverAddressLabel => 'Empfängeradresse';

  @override
  String get selectTokenLabel => 'Token auswählen';

  @override
  String get transferAmountLabel => 'Überweisungsbetrag';

  @override
  String get memoLabel => 'Memo (optional)';

  @override
  String get enterOrPasteAddressHint => 'Wallet-Adresse eingeben oder einfügen';

  @override
  String get scanInDevelopment => 'Scanfunktion in Entwicklung...';

  @override
  String get availableLabel => 'Verfügbar';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Verfügbar: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Memo hinzufügen';

  @override
  String get receiveTitle => 'Empfangen';

  @override
  String get walletNotConnectedTitle => 'Wallet nicht verbunden';

  @override
  String get connectWalletFirst => 'Bitte zuerst Wallet verbinden';

  @override
  String get sendPaymentRequest => 'Zahlungsanfrage senden';

  @override
  String get qrCodeGenerateFailed => 'QR-Code-Generierung fehlgeschlagen';

  @override
  String get scanQrToPayMe => 'QR-Code scannen um mich zu bezahlen';

  @override
  String get myWalletAddress => 'Meine Wallet-Adresse';

  @override
  String get createPaymentRequest => 'Zahlungsanfrage erstellen';

  @override
  String get selectTokenHint => 'Token auswählen';

  @override
  String get amountLabel => 'Betrag';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get sendRequestButton => 'Anfrage senden';

  @override
  String get allReadReceipt => 'Alle gelesen';

  @override
  String readCountReceipt(int count) {
    return '$count gelesen';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Beste Wünsche';

  @override
  String senderRedPacket(String name) {
    return '${name}s Rotes Paket';
  }

  @override
  String get allButton => 'Alles';

  @override
  String get enterValidAddress => 'Bitte geben Sie eine gültige Adresse ein';

  @override
  String get pleaseSelectToken => 'Bitte wählen Sie einen Token';

  @override
  String get receivedTransfer => 'Überweisung erhalten';

  @override
  String get selectForwardRecipient => 'Weiterleitungsempfänger auswählen';

  @override
  String get emojiFaces => 'Gesichter';

  @override
  String get emojiHearts => 'Herzen';

  @override
  String get emojiAnimals => 'Tiere';

  @override
  String get emojiFood => 'Essen';

  @override
  String get emojiTransport => 'Transport';

  @override
  String get emojiActivities => 'Aktivitäten';

  @override
  String get emojiObjects => 'Objekte';

  @override
  String get emojiSymbols => 'Symbole';

  @override
  String get transferProcessing => 'Überweisung wird verarbeitet...';

  @override
  String senderSentRedPacket(String name) {
    return '$name hat ein rotes Paket gesendet';
  }

  @override
  String get savedToBalance =>
      'Im Guthaben gespeichert, direkte Überweisung möglich';

  @override
  String get redPacketExpiredOrEmpty => 'Rotes Paket abgelaufen/alle eingelöst';

  @override
  String get scanFeatureComingSoon => 'Scanfunktion demnächst verfügbar...';

  @override
  String get setAsStarred => 'Als Favorit festlegen';

  @override
  String get addToBlocklist => 'Zur Sperrliste hinzufügen';

  @override
  String get claimedYour => ' hat Ihr ';

  @override
  String get claimedText => ' eingelöst ';

  @override
  String userTyping(String name) {
    return '$name tippt...';
  }

  @override
  String get typing => 'Tippt...';

  @override
  String get waitingToReceive => 'Wartet auf Empfang';

  @override
  String get tapToClaim => 'Tippen zum Einlösen';

  @override
  String get hasBeenReceived => 'Wurde empfangen';

  @override
  String get getLucky => 'Viel Glück';

  @override
  String get cameraStartFailed => 'Kamera konnte nicht gestartet werden';

  @override
  String get unknownError => 'Unbekannter Fehler';

  @override
  String get placeQrCodeInFrame => 'QR-Code zum Scannen im Rahmen platzieren';

  @override
  String get closeManualInput => 'Manuelle Eingabe schließen';

  @override
  String get manualInputUserId => 'Benutzer-ID manuell eingeben';

  @override
  String get add => 'Hinzufügen';

  @override
  String get ringtoneClear => 'Löschen';

  @override
  String get ringtonePhone => 'Telefon';

  @override
  String get ringtoneClassic => 'Klassisch';

  @override
  String get ringtoneSoft => 'Sanft';

  @override
  String get ringtoneVibrate => 'Vibrieren';

  @override
  String get ringtoneSilent => 'Lautlos';

  @override
  String get stop => 'Stopp';

  @override
  String get selectRingtone => 'Klingelton auswählen';

  @override
  String get loadingRingtones => 'Klingeltöne werden geladen...';

  @override
  String get noRingtonesFound => 'Keine Klingeltöne gefunden';

  @override
  String get moodAndThoughts => 'Stimmung & Gedanken';

  @override
  String get statusHappy => 'Glücklich';

  @override
  String get statusCracked => 'Erschüttert';

  @override
  String get statusLucky => 'Glücklich';

  @override
  String get statusSunny => 'Sonnig';

  @override
  String get statusTired => 'Müde';

  @override
  String get statusDaydream => 'Tagtraum';

  @override
  String get statusRushing => 'In Eile';

  @override
  String get statusOverthinking => 'Grübeln';

  @override
  String get statusEnergized => 'Energiegeladen';

  @override
  String get workAndStudy => 'Arbeit & Studium';

  @override
  String get statusWorking => 'Arbeiten';

  @override
  String get statusStudying => 'Lernen';

  @override
  String get statusBusy => 'Beschäftigt';

  @override
  String get statusSlacking => 'Faulenzen';

  @override
  String get statusTraveling => 'Reisen';

  @override
  String get statusGoingHome => 'Nach Hause gehen';

  @override
  String get statusDnd => 'Nicht stören';

  @override
  String get statusHanging => 'Abhängen';

  @override
  String get statusCheckIn => 'Einchecken';

  @override
  String get statusExercising => 'Sport treiben';

  @override
  String get statusCoffee => 'Kaffee';

  @override
  String get statusBubbleTea => 'Bubble Tea';

  @override
  String get statusEating => 'Essen';

  @override
  String get statusParenting => 'Elternzeit';

  @override
  String get statusSavingWorld => 'Welt retten';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Ruhe';

  @override
  String get statusRetreat => 'Rückzug';

  @override
  String get statusHome => 'Zuhause';

  @override
  String get statusSleeping => 'Schlafen';

  @override
  String get statusCatLover => 'Katzenliebhaber';

  @override
  String get statusDogWalking => 'Hund ausführen';

  @override
  String get statusGaming => 'Spielen';

  @override
  String get statusListening => 'Hören';

  @override
  String get setStatus => 'Status festlegen';

  @override
  String get visibleToFriends24h => 'Für Freunde 24 Stunden sichtbar';

  @override
  String get writeStatus => 'Status schreiben';

  @override
  String get enterYourStatus => 'Ihren Status eingeben...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Kameraberechtigung erforderlich um QR-Code zu scannen';

  @override
  String get cameraPermissionDenied =>
      'Kameraberechtigung wurde dauerhaft verweigert. Bitte in den Systemeinstellungen aktivieren.';

  @override
  String get cannotGetCameraPermission =>
      'Kameraberechtigung kann nicht abgerufen werden';

  @override
  String permissionCheckError(String error) {
    return 'Fehler bei Berechtigungsprüfung: $error';
  }

  @override
  String get invalidQrCode => 'Ungültiger QR-Code';

  @override
  String qrCodeProcessFailed(String error) {
    return 'QR-Code-Verarbeitung fehlgeschlagen: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Freund kann nicht hinzugefügt werden: $error';
  }

  @override
  String get scanQrCode => 'QR-Code scannen';

  @override
  String get checkingCameraPermission => 'Kameraberechtigung wird überprüft...';

  @override
  String get needCameraPermission => 'Kameraberechtigung erforderlich';

  @override
  String get retryPermission => 'Erneut versuchen';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get inviteMembers => 'Mitglieder einladen';

  @override
  String inviteCount(int count) {
    return 'Einladen($count)';
  }

  @override
  String get noShippingAddress => 'Keine Lieferadresse';

  @override
  String get defaultLabel => 'Standard';

  @override
  String get editAddress => 'Adresse bearbeiten';

  @override
  String get recipient => 'Empfänger';

  @override
  String get enterRecipientName => 'Empfängername eingeben';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get enterPhoneNumber => 'Telefonnummer eingeben';

  @override
  String get regionHint => 'Bundesland/Stadt/Bezirk';

  @override
  String get detailedAddress => 'Detaillierte Adresse';

  @override
  String get detailedAddressHint => 'Straße, Hausnummer, etc.';

  @override
  String get setAsDefaultAddress => 'Als Standardadresse festlegen';

  @override
  String get pleaseCompleteInfo => 'Bitte alle Felder ausfüllen';

  @override
  String get noInvoice => 'Keine Rechnung';

  @override
  String get company => 'Firma';

  @override
  String get taxNumber => 'Steuernummer';

  @override
  String get editInvoice => 'Rechnung bearbeiten';

  @override
  String get companyName => 'Firmenname';

  @override
  String get enterCompanyName => 'Firmenname eingeben';

  @override
  String get personalName => 'Persönlicher Name';

  @override
  String get enterName => 'Name eingeben';

  @override
  String get taxIdNumber => 'Steuer-ID-Nummer';

  @override
  String get enterTaxIdNumber => 'Steuer-ID-Nummer eingeben';

  @override
  String get bankNameOptional => 'Bankname (Optional)';

  @override
  String get enterBankName => 'Bankname eingeben';

  @override
  String get bankAccountOptional => 'Bankkonto (Optional)';

  @override
  String get enterBankAccount => 'Bankkonto eingeben';

  @override
  String get companyAddressOptional => 'Firmenadresse (Optional)';

  @override
  String get enterCompanyAddress => 'Firmenadresse eingeben';

  @override
  String get companyPhoneOptional => 'Firmentelefon (Optional)';

  @override
  String get enterCompanyPhone => 'Firmentelefon eingeben';

  @override
  String get setAsDefaultInvoice => 'Als Standardrechnung festlegen';

  @override
  String get confirmDeleteAddress =>
      'Möchten Sie diese Adresse wirklich löschen?';

  @override
  String get confirmDeleteInvoice =>
      'Möchten Sie diese Rechnung wirklich löschen?';

  @override
  String get groupOwner => 'Eigentümer';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Mitglieder suchen';

  @override
  String totalMembers(int count) {
    return '$count Mitglieder';
  }

  @override
  String get removeFromGroup => 'Aus Gruppe entfernen';

  @override
  String confirmRemoveMember(String name) {
    return 'Möchten Sie \"$name\" wirklich aus der Gruppe entfernen?';
  }

  @override
  String get setAsAdmin => 'Als Admin festlegen';

  @override
  String get removeAdmin => 'Admin entfernen';

  @override
  String get deleteContactSuccess => 'Kontakt gelöscht';

  @override
  String get unknownSong => 'Unbekanntes Lied';

  @override
  String get unknownArtist => 'Unbekannter Künstler';

  @override
  String get unknownContact => 'Unbekannter Kontakt';

  @override
  String get personalCard => 'Kontaktkarte';

  @override
  String get singleChoice => 'Einzelauswahl';

  @override
  String get multiChoice => 'Mehrfachauswahl';

  @override
  String get ended => 'Beendet';

  @override
  String get endPollButton => 'Umfrage beenden';

  @override
  String get createPoll => 'Umfrage erstellen';

  @override
  String get pollQuestion => 'Umfragefrage';

  @override
  String get pollOptions => 'Umfrageoptionen';

  @override
  String optionPlaceholder(int index) {
    return 'Option $index';
  }

  @override
  String get addOption => 'Option hinzufügen';

  @override
  String get pollSettings => 'Umfrageeinstellungen';

  @override
  String get anonymousPoll => 'Anonyme Umfrage';

  @override
  String get pollHint =>
      'Umfrage wird im Chat angezeigt. Gruppenmitglieder können abstimmen.';

  @override
  String get searchSongOrArtist => 'Lied oder Künstler suchen';

  @override
  String get noSongsFound => 'Keine Lieder gefunden';

  @override
  String get supportedMusicPlatforms =>
      'Unterstützt Musik-Links von NetEase, QQ Music, etc.';

  @override
  String get songNameOptional => 'Liedname (Optional)';

  @override
  String get enterSongName => 'Liedname eingeben';

  @override
  String get artistNameOptional => 'Künstlername (Optional)';

  @override
  String get enterArtistName => 'Künstlername eingeben';

  @override
  String get shareSong => 'Lied teilen';

  @override
  String get realTimeLocationSharing =>
      'Echtzeit-Standortfreigabe in Entwicklung...';

  @override
  String get voiceCallFeatureInDev => 'Sprachanruf-Funktion in Entwicklung...';

  @override
  String get reportFeatureInDev => 'Meldefunktion in Entwicklung...';

  @override
  String get shareFeatureInDev => 'Teilenfunktion in Entwicklung...';

  @override
  String get qrCodeFeatureInDev => 'QR-Code-Funktion in Entwicklung...';

  @override
  String get scanQrToAddMe => 'QR-Code scannen um mich als Freund hinzuzufügen';

  @override
  String get saveToAlbum => 'Im Album speichern';

  @override
  String get changeStyle => 'Stil ändern';

  @override
  String get copyId => 'ID kopieren';

  @override
  String get idCopied => 'ID kopiert';

  @override
  String get shareFeatureComingSoon => 'Teilenfunktion demnächst verfügbar';

  @override
  String get saveFeatureComingSoon => 'Speicherfunktion demnächst verfügbar';

  @override
  String get moreStylesFeatureComingSoon => 'Weitere Stile demnächst verfügbar';

  @override
  String get confirmEndPoll => 'Möchten Sie diese Umfrage wirklich beenden?';

  @override
  String get cannotVoteAfterEnd =>
      'Nach dem Beenden können keine Stimmen mehr abgegeben werden.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Server';

  @override
  String get shareContactCard => 'Kontaktkarte teilen';

  @override
  String get removeFromBlacklist => 'Von Sperrliste entfernen';

  @override
  String get confirmAddBlacklist =>
      'Möchten Sie diesen Benutzer wirklich zur Sperrliste hinzufügen? Sie werden keine Nachrichten mehr von ihm erhalten.';

  @override
  String get confirmRemoveBlacklist =>
      'Möchten Sie diesen Benutzer wirklich von der Sperrliste entfernen?';

  @override
  String get remarkSaved => 'Bemerkung gespeichert';

  @override
  String get remarkCleared => 'Bemerkung gelöscht';

  @override
  String get receive => 'Empfangen';

  @override
  String get pleaseConnectWallet => 'Bitte verbinden Sie zuerst Ihre Wallet';

  @override
  String get sendRequest => 'Anfrage senden';

  @override
  String get pleaseEnterValidAmount =>
      'Bitte geben Sie einen gültigen Betrag ein';

  @override
  String get searchPlaceholder => 'Kontakte, Gruppen, Nachrichten suchen';

  @override
  String get enterKeywordToSearch => 'Stichwort eingeben um zu suchen';

  @override
  String get clearHistory => 'Löschen';

  @override
  String noResultsForQuery(String query) {
    return 'Keine Ergebnisse für \"$query\" gefunden';
  }

  @override
  String get allResults => 'Alle';

  @override
  String get searchInChat => 'Im Chat suchen';

  @override
  String get groupLabel => 'Gruppe';

  @override
  String get messageLabel => 'Nachricht';

  @override
  String get securityTitle => 'Sicherheit';

  @override
  String get keyBackup => 'Schlüsselsicherung';

  @override
  String get backupEncryptionKeys => 'Verschlüsselungsschlüssel sichern';

  @override
  String keysBackedUp(int count) {
    return '$count Schlüssel gesichert';
  }

  @override
  String get backupNotSet => 'Sicherung nicht eingerichtet';

  @override
  String get restoreKeys => 'Schlüssel wiederherstellen';

  @override
  String get restoreKeysFromBackup =>
      'Verschlüsselungsschlüssel aus Sicherung wiederherstellen';

  @override
  String get exportKeys => 'Schlüssel exportieren';

  @override
  String get exportKeysToFile => 'Schlüssel in Datei exportieren';

  @override
  String get loggedInDevices => 'Angemeldete Geräte';

  @override
  String get noOtherDevices => 'Keine anderen Geräte';

  @override
  String get verified => 'Verifiziert';

  @override
  String get unverified => 'Nicht verifiziert';

  @override
  String get advanced => 'Erweitert';

  @override
  String get crossSigning => 'Cross-Signing';

  @override
  String get enabled => 'Aktiviert';

  @override
  String get notEnabled => 'Nicht aktiviert';

  @override
  String get resetEncryption => 'Verschlüsselung zurücksetzen';

  @override
  String get deleteAllEncryptionKeys =>
      'Alle Verschlüsselungsschlüssel löschen';

  @override
  String get encryptionNotSupported => 'Verschlüsselung nicht unterstützt';

  @override
  String get notInitialized => 'Nicht initialisiert';

  @override
  String get backupKeyTitle => 'Schlüssel sichern';

  @override
  String get backupKeyMessage =>
      'Neue Schlüsselsicherung erstellen? Dies hilft Ihnen, verschlüsselte Nachrichten auf einem neuen Gerät wiederherzustellen.';

  @override
  String get backup => 'Sichern';

  @override
  String get restoreKeyTitle => 'Schlüssel wiederherstellen';

  @override
  String get restoreKeyMessage =>
      'Geben Sie Ihr Wiederherstellungspasswort oder Ihren Wiederherstellungsschlüssel ein, um verschlüsselte Nachrichten wiederherzustellen.';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get exportKeyTitle => 'Schlüssel exportieren';

  @override
  String get exportKeyMessage =>
      'Die exportierte Schlüsseldatei enthält alle Ihre Verschlüsselungsschlüssel. Bitte bewahren Sie sie sicher auf.';

  @override
  String get export => 'Exportieren';

  @override
  String deviceIdLabel(String deviceId) {
    return 'Geräte-ID: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Status: Verifiziert';

  @override
  String get deviceStatusUnverified => 'Status: Nicht verifiziert';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Zuletzt aktiv: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Dieses Gerät verifizieren';

  @override
  String get crossSigningAlreadyEnabled =>
      'Cross-Signing ist bereits aktiviert';

  @override
  String get crossSigningSetupSuccess =>
      'Cross-Signing erfolgreich eingerichtet';

  @override
  String get resetEncryptionTitle => 'Verschlüsselung zurücksetzen';

  @override
  String get resetEncryptionWarning =>
      'Warnung: Dies wird alle Ihre Verschlüsselungsschlüssel löschen. Sie werden vorherige verschlüsselte Nachrichten nicht entschlüsseln können. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get leaveMeetingConfirm =>
      'Möchten Sie das Meeting wirklich verlassen?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'hat $name angestupst$suffix';
  }

  @override
  String get noContactsToAdd => 'Keine Kontakte zum Hinzufügen verfügbar';

  @override
  String get addMembers => 'Mitglieder hinzufügen';

  @override
  String invitedMembers(int count) {
    return '$count Mitglieder eingeladen';
  }

  @override
  String inviteFailed(String error) {
    return 'Einladung fehlgeschlagen: $error';
  }

  @override
  String get memberRemoved => 'Mitglied entfernt';

  @override
  String removeFailed(String error) {
    return 'Entfernen fehlgeschlagen: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Nach dem Teilen kann die andere Person Ihren Echtzeit-Standort 1 Stunde lang sehen.';

  @override
  String get startSharing => 'Teilen starten';

  @override
  String get locationServiceNotEnabled => 'Standortdienst ist nicht aktiviert';

  @override
  String get enableLocationService =>
      'Bitte aktivieren Sie den Standortdienst um diese Funktion zu nutzen';

  @override
  String get goToSettings => 'Zu Einstellungen';

  @override
  String get locationPermissionRequired =>
      'Standortberechtigung ist für diese Funktion erforderlich';

  @override
  String get locationPermissionDeniedPermanent =>
      'Standortberechtigung wurde dauerhaft verweigert. Bitte in den Einstellungen aktivieren.';

  @override
  String get locationPermissionDenied => 'Standortberechtigung verweigert';

  @override
  String get gettingLocation => 'Standort wird ermittelt...';

  @override
  String getLocationFailed(String error) {
    return 'Standort ermitteln fehlgeschlagen: $error';
  }

  @override
  String get currentLocation => 'Aktueller Standort';

  @override
  String nearbyPlace(int index) {
    return 'Ort in der Nähe $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Ca. $distance';
  }

  @override
  String get mapPreview => 'Kartenvorschau';

  @override
  String get searchLocation => 'Standort suchen';

  @override
  String redPacketSent(String amount, String token) {
    return '$amount $token rotes Paket gesendet';
  }

  @override
  String get transferDefault => 'Überweisung';

  @override
  String transferSent(String amount, String token) {
    return '$amount $token Überweisung gesendet';
  }

  @override
  String pickFileFailed(String error) {
    return 'Dateiauswahl fehlgeschlagen: $error';
  }

  @override
  String get fileSizeLimit => 'Dateigröße darf 50MB nicht überschreiten';

  @override
  String fileSending(String filename) {
    return 'Datei wird gesendet: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Datei senden fehlgeschlagen: $error';
  }

  @override
  String contactCardSent(String name) {
    return '${name}s Kontaktkarte gesendet';
  }

  @override
  String get favoritesFeature => 'Favoriten';

  @override
  String get couponsFeature => 'Gutscheine';

  @override
  String get giftFeature => 'Geschenk';

  @override
  String sharedMusic(String name) {
    return '$name geteilt';
  }

  @override
  String get endPollTitle => 'Umfrage beenden';

  @override
  String get endPollConfirmMessage =>
      'Möchten Sie diese Umfrage wirklich beenden? Nach dem Beenden wird die Abstimmung geschlossen.';

  @override
  String get pollEndedMessage => 'Umfrage beendet';

  @override
  String get connectingCall => '正在连接...';

  @override
  String get muteCall => 'Stummschalten';

  @override
  String get speakerOff => 'Lautsprecher aus';

  @override
  String get speakerOn => 'Lautsprecher';

  @override
  String get cameraOn => 'Kamera an';

  @override
  String get cameraOff => 'Kamera aus';

  @override
  String get hangUp => 'Auflegen';

  @override
  String get selectForwardTargetTitle => 'Weiterleitungsziel auswählen';

  @override
  String get noForwardableChat => 'Keine Chats zum Weiterleiten verfügbar';

  @override
  String get noMatchingChat => 'Keine passenden Chats gefunden';

  @override
  String get imagePreview => '[Bild]';

  @override
  String get voicePreview => '[Sprachnachricht]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[Datei] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Standort] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Musik] $title';
  }

  @override
  String get messagePreview => '[Nachricht]';

  @override
  String get locationTitle => 'Standort';

  @override
  String get sendButton => 'Senden';

  @override
  String get retryButton => 'Erneut versuchen';

  @override
  String get selectContact => 'Kontakt auswählen';

  @override
  String get searchContactHint => 'Kontakte suchen';

  @override
  String get shareMusic => 'Musik teilen';

  @override
  String get recentPlayed => 'Zuletzt';

  @override
  String get myFavorites => 'Favoriten';

  @override
  String get networkLink => 'Link';

  @override
  String get localFile => 'Lokal';

  @override
  String get musicLinkRequired => 'Musik-Link *';

  @override
  String get pasteMusicLink => 'Musik-Link einfügen';

  @override
  String get enterSongNamePlaceholder => 'Liedname eingeben';

  @override
  String get enterArtistNamePlaceholder => 'Künstlername eingeben';

  @override
  String get shareMusicButton => 'Musik teilen';

  @override
  String get selectLocalAudio => 'Lokale Audiodatei auswählen';

  @override
  String get supportedAudioFormats => 'Unterstützt MP3, M4A, WAV, FLAC, etc.';

  @override
  String get selectFileButton => 'Datei auswählen';

  @override
  String get pleaseEnterMusicLink => 'Bitte Musik-Link eingeben';

  @override
  String get pleaseEnterValidLink => 'Bitte geben Sie eine gültige URL ein';

  @override
  String get sharedSong => 'Geteiltes Lied';

  @override
  String get selectMember => 'Mitglied auswählen';

  @override
  String get searchMemberHint => 'Mitglieder suchen';

  @override
  String get noMatchingMembers => 'Keine passenden Mitglieder gefunden';

  @override
  String get unknownMember => 'Unbekannt';

  @override
  String selectedMessagesCount(int count) {
    return '$count Nachrichten ausgewählt';
  }

  @override
  String get searchContactsOrGroups => 'Kontakte oder Gruppen suchen';

  @override
  String get noMatchingConversations =>
      'Keine passenden Unterhaltungen gefunden';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Laden...';

  @override
  String get videoPlaybackFailed => 'Videowiedergabe fehlgeschlagen';

  @override
  String get videoLoadFailed => 'Video laden fehlgeschlagen';

  @override
  String get playerInitFailed => 'Player-Initialisierung fehlgeschlagen';

  @override
  String get createPollTitle => 'Umfrage erstellen';

  @override
  String get submitPoll => 'Absenden';

  @override
  String get pollQuestionLabel => 'Umfragefrage';

  @override
  String get enterPollQuestionHint => 'Bitte Umfragefrage eingeben';

  @override
  String get pollOptionsLabel => 'Umfrageoptionen';

  @override
  String optionHintWithIndex(int index) {
    return 'Option $index';
  }

  @override
  String get addOptionButton => 'Option hinzufügen';

  @override
  String get pollSettingsLabel => 'Umfrageeinstellungen';

  @override
  String get selectionType => 'Auswahltyp';

  @override
  String get singleChoiceLabel => 'Einzelauswahl';

  @override
  String get multiChoiceLabel => 'Mehrfachauswahl';

  @override
  String get anonymousPollSwitch => 'Anonyme Umfrage';

  @override
  String get pleaseEnterQuestion => 'Bitte Umfragefrage eingeben';

  @override
  String get atLeastTwoOptions => 'Mindestens 2 Optionen erforderlich';

  @override
  String confirmWithCount(int count) {
    return 'Bestätigen ($count)';
  }

  @override
  String get emailVerificationTitle => 'E-Mail-Verifizierung';

  @override
  String get enterValidEmailAddress =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String verificationCodeSentTo(String email) {
    return 'Bestätigungscode gesendet an $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Code senden fehlgeschlagen: $error';
  }

  @override
  String get verificationSuccess => 'Verifizierung erfolgreich';

  @override
  String get verificationFailed => 'Verifizierung fehlgeschlagen';

  @override
  String verificationCodeError(String error) {
    return 'Verifizierungscode-Fehler: $error';
  }

  @override
  String get enterVerificationCode => 'Bestätigungscode eingeben';

  @override
  String get enterYourEmail => 'E-Mail eingeben';

  @override
  String weSentCodeTo(String email) {
    return 'Wir haben einen 6-stelligen Code an\n$email gesendet';
  }

  @override
  String get enterEmailForCode =>
      'Geben Sie Ihre E-Mail-Adresse ein, wir senden einen Bestätigungscode';

  @override
  String get sendVerificationCode => 'Bestätigungscode senden';

  @override
  String get resendVerificationCode => 'Bestätigungscode erneut senden';

  @override
  String canResendAfter(int seconds) {
    return 'Erneut senden nach $seconds Sekunden';
  }

  @override
  String get changeEmail => 'E-Mail ändern';

  @override
  String get addToContacts => 'Zu Kontakten hinzufügen';

  @override
  String get addingToContacts => 'Hinzufügen...';

  @override
  String get addedToContacts => 'Zu Kontakten hinzugefügt';

  @override
  String addFailedWithError(String error) {
    return 'Hinzufügen fehlgeschlagen: $error';
  }

  @override
  String get addPhone => 'Telefon hinzufügen';

  @override
  String get addTag => 'Tags hinzufügen';

  @override
  String get addText => 'Text hinzufügen';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String groupCountLabel(int count) {
    return '$count Gruppen';
  }

  @override
  String get addedViaSearch => 'Über Suche hinzugefügt';

  @override
  String get addTime => 'Zeit hinzufügen';

  @override
  String get doneButton => 'Fertig';

  @override
  String get waitingForParticipants => 'Warten auf Teilnehmer...';

  @override
  String participantMe(String name) {
    return '$name (Ich)';
  }

  @override
  String get sharingLabel => 'Teilen';

  @override
  String screenSharingBy(String name) {
    return '$name teilt Bildschirm';
  }

  @override
  String participantCount(int count) {
    return '$count Teilnehmer';
  }

  @override
  String get muteLabel => 'Stummschalten';

  @override
  String get unmuteLabel => 'Stummschaltung aufheben';

  @override
  String get turnOffVideo => 'Video ausschalten';

  @override
  String get turnOnVideo => 'Video einschalten';

  @override
  String get shareScreen => 'Bildschirm teilen';

  @override
  String get stopSharing => 'Teilen beenden';

  @override
  String get switchCameraLabel => 'Wechseln';

  @override
  String get leaveLabel => 'Verlassen';

  @override
  String get participantsLabel => 'Teilnehmer';

  @override
  String get joiningMeeting => 'Meeting beitreten...';
}
