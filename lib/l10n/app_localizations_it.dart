// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class SIt extends S {
  SIt([String locale = 'it']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Inizializzazione modulo chat fallita';

  @override
  String get checkNetworkRetry => 'Controlla la connessione di rete e riprova';

  @override
  String get retry => 'Riprova';

  @override
  String get unknownUser => 'Utente sconosciuto';

  @override
  String get walletNotConnected => 'Wallet non connesso';

  @override
  String get cannotGetWalletAddress =>
      'Impossibile ottenere l\'indirizzo del wallet';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Richiesta di pagamento: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Servizio chiamate non inizializzato';

  @override
  String get alreadyInCall => 'Già in chiamata';

  @override
  String get meetingServiceNotInitialized =>
      'Servizio riunioni non inizializzato';

  @override
  String get livekitNotConfigured => 'LiveKit non configurato';

  @override
  String get unknownConversation => 'Conversazione sconosciuta';

  @override
  String startCallFailed(String error) {
    return 'Impossibile avviare la chiamata: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Impossibile rispondere: $error';
  }

  @override
  String get connectionFailed => 'Connessione fallita';

  @override
  String get callRejected => 'Chiamata rifiutata';

  @override
  String get noAnswer => 'Nessuna risposta';

  @override
  String get invalidLoginResponse => 'Risposta di login non valida';

  @override
  String loginFailed(String error) {
    return 'Login fallito: $error';
  }

  @override
  String get sessionRestoreFailed => 'Ripristino sessione fallito';

  @override
  String get additionalVerificationRequired => 'Verifica aggiuntiva richiesta';

  @override
  String registrationFailed(String error) {
    return 'Registrazione fallita: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Impossibile connettersi al server: $error';
  }

  @override
  String get wrongUsernamePassword => 'Nome utente o password errati';

  @override
  String get usernameTaken => 'Nome utente già in uso';

  @override
  String get invalidUsernameFormat => 'Formato nome utente non valido';

  @override
  String get rateLimitExceeded => 'Troppe richieste, riprova più tardi';

  @override
  String get loginExpired => 'Login scaduto';

  @override
  String joinMeetingFailed(String error) {
    return 'Impossibile partecipare alla riunione: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Condivisione schermo fallita: $error';
  }

  @override
  String get answer => 'Rispondi';

  @override
  String get decline => 'Rifiuta';

  @override
  String get missedCall => 'Chiamata persa';

  @override
  String get callBack => 'Richiama';

  @override
  String get incomingCall => 'Chiamata in arrivo';

  @override
  String get missedVideoCall => 'Videochiamata persa';

  @override
  String get missedVoiceCall => 'Chiamata vocale persa';

  @override
  String get voiceCallTitle => '语音通话';

  @override
  String get videoCallTitle => '视频通话';

  @override
  String get callNotAnswered => '对方未接听';

  @override
  String get callDurationLabel => '通话时长';

  @override
  String get voiceCallCancelled => '语音通话已取消';

  @override
  String get videoCallCancelled => '视频通话已取消';

  @override
  String get passkeyNotInitialized => 'Passkey non inizializzata';

  @override
  String get googleSignInNotConfigured => 'Google Sign In non configurato';

  @override
  String get encryptedMessage => '[Messaggio crittografato]';

  @override
  String get sticker => '[Sticker]';

  @override
  String get groupCreated => 'Gruppo creato';

  @override
  String get groupNameChanged => 'Nome gruppo modificato';

  @override
  String get groupAvatarChanged => 'Avatar gruppo modificato';

  @override
  String get groupAnnouncementChanged => 'Annuncio gruppo modificato';

  @override
  String get image => '[Immagine]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Vocale]';

  @override
  String get file => '[File]';

  @override
  String get location => '[Posizione]';

  @override
  String get unknownMessage => '[Messaggio sconosciuto]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName è entrato nel gruppo';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName ha lasciato il gruppo';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName è stato invitato';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName è stato rimosso';
  }

  @override
  String get avatarDataEmpty => 'I dati dell\'avatar sono vuoti';

  @override
  String get avatarTooLarge => 'File avatar troppo grande, max 10MB';

  @override
  String get uploadAvatarFailed => 'Caricamento avatar fallito';

  @override
  String get delete => 'Elimina';

  @override
  String get notLoggedIn => 'Non connesso';

  @override
  String roomNotExist(String roomId) {
    return 'Stanza non trovata: $roomId';
  }

  @override
  String get uploadImageFailed => 'Caricamento immagine fallito';

  @override
  String get matrixClientNotInitialized => 'Client Matrix non inizializzato';

  @override
  String get uploadVoiceFailed =>
      'Caricamento vocale fallito: Impossibile ottenere URI MXC';

  @override
  String get uploadVideoFailed =>
      'Caricamento video fallito: Impossibile ottenere URI MXC';

  @override
  String get uploadFileFailed =>
      'Caricamento file fallito: Impossibile ottenere URI MXC';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Posizione: $lat, $lon';
  }

  @override
  String get myLocation => 'La mia posizione';

  @override
  String get pollEnded => 'Sondaggio terminato';

  @override
  String get groupChat => 'Chat di gruppo';

  @override
  String get search => 'Cerca';

  @override
  String get cancel => 'Annulla';

  @override
  String get userCancelled => 'Annullato dall\'utente';

  @override
  String get noData => 'Nessun dato';

  @override
  String get noSearchResults => 'Nessun risultato';

  @override
  String get tryDifferentKeyword => 'Prova con una parola chiave diversa';

  @override
  String get loadFailed => 'Caricamento fallito';

  @override
  String get checkNetwork => 'Controlla la connessione di rete';

  @override
  String get networkConnectionFailed => 'Connessione di rete fallita';

  @override
  String get checkNetworkSettings => 'Controlla le impostazioni di rete';

  @override
  String get messages => 'Messaggi';

  @override
  String get contacts => 'Contatti';

  @override
  String get discover => 'Scopri';

  @override
  String get me => 'Io';

  @override
  String get voiceLoading => 'Caricamento vocale, riprova più tardi';

  @override
  String get voiceToTextFailed => 'Conversione vocale fallita';

  @override
  String get converting => 'Conversione...';

  @override
  String get convertToText => 'In testo';

  @override
  String get convertToTextTitle => 'Converti in testo';

  @override
  String get selectEmoji => 'Seleziona emoji';

  @override
  String get selectRedPacketCover => 'Seleziona copertina';

  @override
  String get frequentlyUsed => 'Usati di frequente';

  @override
  String get copy => 'Copia';

  @override
  String get forward => 'Inoltra';

  @override
  String get unfavorite => 'Rimuovi preferito';

  @override
  String get favorite => 'Preferito';

  @override
  String get resend => 'Rinvia';

  @override
  String get recall => 'Ritira';

  @override
  String get multiSelect => 'Selezione multipla';

  @override
  String get quote => 'Cita';

  @override
  String get remind => 'Menziona';

  @override
  String get searchThis => 'Cerca';

  @override
  String get recallMessageConfirm => 'Ritirare questo messaggio?';

  @override
  String get youRecalledMessage => 'Hai ritirato un messaggio';

  @override
  String get otherRecalledMessage => 'Messaggio ritirato';

  @override
  String get reEdit => 'Modifica';

  @override
  String get copied => 'Copiato';

  @override
  String get sendMessageHint => 'Scrivi un messaggio';

  @override
  String get microphonePermissionRequired => 'Consenti l\'accesso al microfono';

  @override
  String startRecordingFailed(String error) {
    return 'Impossibile avviare la registrazione: $error';
  }

  @override
  String get recordingTooShort => 'Registrazione troppo breve';

  @override
  String stopRecordingFailed(String error) {
    return 'Impossibile interrompere la registrazione: $error';
  }

  @override
  String get releaseToCancel => 'Rilascia per annullare';

  @override
  String get releaseToSend =>
      'Rilascia per inviare, scorri in alto per annullare';

  @override
  String get holdToTalk => 'Tieni premuto per parlare';

  @override
  String get send => 'Invia';

  @override
  String conversationWithId(String roomId) {
    return 'Conversazione: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Contatto: $userId';
  }

  @override
  String get addFriend => 'Aggiungi amico';

  @override
  String get chatServiceNotConnected => 'Servizio chat non connesso';

  @override
  String userNotFoundHint(String query) {
    return 'Utente \"$query\" non trovato\n\nSuggerimenti:\n• Prova a inserire l\'ID utente completo, es. @nomeutente:server.com\n• Controlla l\'ortografia del nome utente';
  }

  @override
  String createChatFailed(String error) {
    return 'Impossibile creare la chat: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Ricerca fallita: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Inserisci ID utente o nome utente per cercare';

  @override
  String get searching => 'Ricerca in corso...';

  @override
  String get searchUserToChat => 'Cerca utente per iniziare a chattare';

  @override
  String get matrixIdExample =>
      'Puoi inserire un ID Matrix completo\nes. @utente:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Utente \"$username\" non trovato';
  }

  @override
  String get chat => 'Chat';

  @override
  String get settings => 'Impostazioni';

  @override
  String get editProfile => 'Modifica profilo';

  @override
  String get login => 'Accedi';

  @override
  String get createGroup => 'Crea gruppo';

  @override
  String developing(String title) {
    return '$title\n(Prossimamente)';
  }

  @override
  String get error => 'Errore';

  @override
  String get pageNotFound => 'Pagina non trovata';

  @override
  String get backToHome => 'Torna alla home';

  @override
  String get allRead => 'Tutto letto';

  @override
  String readCount(int count) {
    return '$count letto';
  }

  @override
  String get transfer => 'Trasferimento';

  @override
  String get pendingReceipt => 'In attesa';

  @override
  String get tapToReceive => 'Tocca per ricevere';

  @override
  String get received => 'Ricevuto';

  @override
  String get paymentReceived => 'Pagamento ricevuto';

  @override
  String get refunded => 'Rimborsato';

  @override
  String get expired => 'Scaduto';

  @override
  String get redPacketGreeting => 'Auguri';

  @override
  String get n42RedPacket => 'Busta rossa N42';

  @override
  String get goodLuck => 'Buona fortuna';

  @override
  String get claimed => 'Riscosso';

  @override
  String get allClaimed => 'Tutto riscosso';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Amore';

  @override
  String get animals => 'Animali';

  @override
  String get food => 'Cibo';

  @override
  String get travel => 'Viaggi';

  @override
  String get activities => 'Attività';

  @override
  String get objects => 'Oggetti';

  @override
  String get symbols => 'Simboli';

  @override
  String get reply => 'Rispondi';

  @override
  String get copiedToClipboard => 'Copiato negli appunti';

  @override
  String get edit => 'Modifica';

  @override
  String get more => 'Altro';

  @override
  String get selectForwardTarget => 'Seleziona destinatario';

  @override
  String sendCount(int count) {
    return 'Invia ($count)';
  }

  @override
  String get draft => '[Bozza] ';

  @override
  String n42Id(String id) {
    return 'ID N42: $id';
  }

  @override
  String get n42IdTitle => 'ID N42';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Info amico';

  @override
  String get friendInfoDesc =>
      'Aggiungi note, telefono, tag, appunti, foto e imposta permessi.';

  @override
  String get moments => 'Momenti';

  @override
  String get sendMessage => 'Messaggio';

  @override
  String get audioVideoCall => 'Chiamata audio/video';

  @override
  String get videoChannel => 'Canale video';

  @override
  String get remark => 'Nota';

  @override
  String get remarkName => 'Nome nota';

  @override
  String get phone => 'Telefono';

  @override
  String get tags => 'Tag';

  @override
  String get notes => 'Note';

  @override
  String get photos => 'Foto';

  @override
  String get permissions => 'Permessi';

  @override
  String get chatMomentsEtc => 'Chat, Momenti, Sport, ecc.';

  @override
  String get moreInfo => 'Altre info';

  @override
  String get commonGroups => 'Gruppi in comune';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Origine';

  @override
  String get notificationSettings => 'Notifiche';

  @override
  String get receiveNotifications => 'Ricevi notifiche nuovi messaggi';

  @override
  String get showPreview => 'Mostra anteprima messaggi';

  @override
  String get showContentInNotification => 'Mostra contenuto nelle notifiche';

  @override
  String get notificationSound => 'Suono notifica';

  @override
  String get playSoundOnMessage => 'Riproduci suono alla ricezione messaggi';

  @override
  String get vibrate => 'Vibrazione';

  @override
  String get vibrateOnMessage => 'Vibra alla ricezione messaggi';

  @override
  String get doNotDisturb => 'Non disturbare';

  @override
  String get dndDescription => 'Silenzia notifiche durante ore specifiche';

  @override
  String get startTime => 'Ora inizio';

  @override
  String get endTime => 'Ora fine';

  @override
  String get privacy => 'Privacy';

  @override
  String get appearance => 'Aspetto';

  @override
  String get about => 'Informazioni';

  @override
  String get logout => 'Esci';

  @override
  String get logoutConfirm => 'Sei sicuro di voler uscire?';

  @override
  String get exit => 'Esci';

  @override
  String get save => 'Salva';

  @override
  String get nickname => 'Nickname';

  @override
  String get enterNickname => 'Inserisci nickname';

  @override
  String get signature => 'Firma';

  @override
  String get addSignature => 'Aggiungi una firma';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String saveFailed(String error) {
    return 'Salvataggio fallito: $error';
  }

  @override
  String get secureDecentralizedChat =>
      'Messaggistica sicura e decentralizzata';

  @override
  String get endToEndEncryption => 'Crittografia end-to-end';

  @override
  String get messagesOnlyYouCanSee =>
      'Messaggi visibili solo a te e al destinatario';

  @override
  String get decentralized => 'Decentralizzato';

  @override
  String get basedOnMatrix => 'Basato sul protocollo aperto Matrix';

  @override
  String get walletIntegration => 'Integrazione wallet';

  @override
  String get easyCryptoTransfer => 'Trasferimenti crypto facili';

  @override
  String get register => 'Registrati';

  @override
  String get agreeTerms => 'Accedendo, accetti';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get and => 'e';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get serverAddress => 'Indirizzo server';

  @override
  String get enterServerAddress => 'Inserisci indirizzo server';

  @override
  String get validServerAddress => 'Inserisci un indirizzo server valido';

  @override
  String connectedTo(String serverName) {
    return 'Connesso a $serverName';
  }

  @override
  String get username => 'Nome utente';

  @override
  String get enterUsername => 'Inserisci nome utente';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Inserisci password';

  @override
  String get registerAccount => 'Registrati';

  @override
  String get forgotPassword => 'Password dimenticata';

  @override
  String get otherLoginMethods => 'Altri metodi di accesso';

  @override
  String get emailVerification => 'Codice verifica email';

  @override
  String get enterServerFirst => 'Inserisci prima l\'indirizzo del server';

  @override
  String get passkeyNeedsServer =>
      'L\'accesso con passkey richiede supporto del server';

  @override
  String googleLoginSuccess(String email) {
    return 'Accesso Google riuscito: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Accesso Google fallito: $error';
  }

  @override
  String get appleLoginSuccess => 'Accesso Apple riuscito';

  @override
  String appleLoginFailed(String error) {
    return 'Accesso Apple fallito: $error';
  }

  @override
  String get createAccount => 'Crea account';

  @override
  String get joinN42Chat => 'Unisciti a N42 Chat per iniziare a chattare';

  @override
  String get usernameHint => '3-20 caratteri, lettere/numeri/_';

  @override
  String get usernameMinLength =>
      'Il nome utente deve avere almeno 3 caratteri';

  @override
  String get usernameMaxLength =>
      'Il nome utente deve avere massimo 20 caratteri';

  @override
  String get usernameFormat =>
      'Il nome utente può contenere solo lettere, numeri e underscore';

  @override
  String get passwordHint => 'Minimo 8 caratteri';

  @override
  String get passwordMinLength => 'La password deve avere almeno 8 caratteri';

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get reEnterPassword => 'Reinserisci password';

  @override
  String get passwordsNotMatch => 'Le password non coincidono';

  @override
  String get inviteCode => 'Codice invito (integrato)';

  @override
  String get filled => 'Compilato';

  @override
  String get enterInviteCode => 'Inserisci codice invito';

  @override
  String get inviteCodeHint =>
      'Il codice invito è integrato, solitamente non serve modificarlo';

  @override
  String get agreeTermsFirst =>
      'Leggi e accetta prima i termini e l\'informativa sulla privacy';

  @override
  String get iAgree => 'Ho letto e accetto';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get loginNow => 'Accedi ora';

  @override
  String get whoCanSee => 'Chi può vedere';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Stato';

  @override
  String get lastSeen => 'Ultimo accesso';

  @override
  String get messageSettings => 'Messaggi';

  @override
  String get allowStrangerMessage => 'Consenti messaggi da sconosciuti';

  @override
  String get receiveNonContact => 'Ricevi messaggi da non contatti';

  @override
  String get readReceipts => 'Conferme di lettura';

  @override
  String get letOthersKnowRead =>
      'Fai sapere agli altri che hai letto i messaggi';

  @override
  String get typingStatus => 'Stato digitazione';

  @override
  String get letOthersKnowTyping => 'Fai sapere agli altri che stai scrivendo';

  @override
  String get everyone => 'Tutti';

  @override
  String get contactsOnly => 'Solo contatti';

  @override
  String get nobody => 'Nessuno';

  @override
  String whoCanSeeItem(String title) {
    return 'Chi può vedere $title';
  }

  @override
  String version(String version) {
    return 'Versione $version';
  }

  @override
  String get checkUpdate => 'Verifica aggiornamenti';

  @override
  String get openSourceLicenses => 'Licenze open source';

  @override
  String get feedback => 'Feedback';

  @override
  String get builtOnMatrix => 'Basato sul protocollo Matrix';

  @override
  String get loading => 'Caricamento...';

  @override
  String get noConversations => 'Nessuna conversazione';

  @override
  String get tapToChat => 'Tocca in alto a destra per iniziare a chattare';

  @override
  String get startGroup => 'Inizia chat di gruppo';

  @override
  String get scan => 'Scansiona';

  @override
  String get payment => 'Pagamento';

  @override
  String featureComingSoon(String feature) {
    return '$feature prossimamente';
  }

  @override
  String get markAsRead => 'Segna come letto';

  @override
  String get unmute => 'Riattiva';

  @override
  String get mute => 'Silenzia';

  @override
  String get unpin => 'Rimuovi fissato';

  @override
  String get pin => 'Fissa';

  @override
  String get deleteConversation => 'Elimina conversazione';

  @override
  String deleteConversationConfirm(String name) {
    return 'Eliminare la conversazione con \"$name\"?';
  }

  @override
  String get noContacts => 'Nessun contatto';

  @override
  String get addFriendsToChat => 'Aggiungi amici per iniziare a chattare';

  @override
  String get contactNotFound => 'Contatto non trovato';

  @override
  String get tryOtherKeywords =>
      'Prova altre parole chiave o cerca globalmente';

  @override
  String get searchResults => 'Risultati ricerca';

  @override
  String get newFriends => 'Nuovi amici';

  @override
  String get chatOnlyFriends => 'Amici solo chat';

  @override
  String get officialAccounts => 'Account ufficiali';

  @override
  String get serviceAccounts => 'Account di servizio';

  @override
  String get enterpriseContacts => 'Contatti aziendali';

  @override
  String contactsCount(int count) {
    return '$count contatti';
  }

  @override
  String get recommendToFriend => 'Condividi contatto';

  @override
  String get setRemark => 'Imposta nota';

  @override
  String get addToHome => 'Aggiungi alla home';

  @override
  String get sendingCard => 'Invio scheda contatto...';

  @override
  String get contactCard => '[Scheda contatto]';

  @override
  String get fileLabel => 'File';

  @override
  String get locationLabel => 'Posizione';

  @override
  String cardSent(String contact, String friend) {
    return 'Inviata scheda di $contact a $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Raccomandazione fallita: $error';
  }

  @override
  String get enterRemark => 'Inserisci nota';

  @override
  String remarkSet(String remark) {
    return 'Nota impostata: $remark';
  }

  @override
  String get openingChat => 'Apertura chat...';

  @override
  String openChatFailed(String error) {
    return 'Impossibile aprire la chat: $error';
  }

  @override
  String get addContact => 'Aggiungi contatto';

  @override
  String get enterUserId => 'Inserisci ID utente';

  @override
  String get noFriendRequests => 'Nessuna richiesta di amicizia';

  @override
  String get accept => 'Accetta';

  @override
  String get reject => 'Rifiuta';

  @override
  String acceptedRequest(String name) {
    return 'Accettata richiesta di amicizia di $name';
  }

  @override
  String rejectedRequest(String name) {
    return 'Rifiutata richiesta di amicizia di $name';
  }

  @override
  String get noGroups => 'Nessun gruppo';

  @override
  String get creatingGroup => 'Creazione gruppo in arrivo...';

  @override
  String get selectFriendToRecommend => 'Seleziona un amico a cui raccomandare';

  @override
  String get searchContacts => 'Cerca contatti';

  @override
  String get noContactsFound => 'Nessun contatto trovato';

  @override
  String get yesterday => 'Ieri';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mer';

  @override
  String get thursday => 'Gio';

  @override
  String get friday => 'Ven';

  @override
  String get saturday => 'Sab';

  @override
  String get sunday => 'Dom';

  @override
  String get justNow => 'Adesso';

  @override
  String minutesAgo(int count) {
    return '$count min fa';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h fa';
  }

  @override
  String daysAgo(int count) {
    return '${count}g fa';
  }

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String minutesAgoOnline(int count) {
    return 'Online $count min fa';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Online ${count}h fa';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Online ${count}g fa';
  }

  @override
  String get searchContactsGroupsMessages => 'Cerca contatti, gruppi, messaggi';

  @override
  String get searchError => 'Errore ricerca';

  @override
  String get searchHint => 'Cerca contatti, gruppi e messaggi';

  @override
  String get enterKeyword => 'Inserisci parole chiave per cercare';

  @override
  String get searchHistory => 'Cronologia ricerche';

  @override
  String get clear => 'Cancella';

  @override
  String noResultsFor(String query) {
    return 'Nessun risultato per \"$query\"';
  }

  @override
  String get all => 'Tutto';

  @override
  String get groups => 'Gruppi';

  @override
  String get noResults => 'Nessun risultato';

  @override
  String get groupInfo => 'Info gruppo';

  @override
  String groupMembers(int count) {
    return 'Membri ($count)';
  }

  @override
  String get groupMembersTitle => 'Membri del gruppo';

  @override
  String get viewAll => 'Vedi tutti';

  @override
  String get owner => 'Proprietario';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Invita';

  @override
  String get groupAnnouncement => 'Annuncio gruppo';

  @override
  String get notSet => 'Non impostato';

  @override
  String get groupDescription => 'Descrizione gruppo';

  @override
  String get publicGroup => 'Gruppo pubblico';

  @override
  String get allowSearchJoin => 'Consenti ad altri di cercare e unirsi';

  @override
  String get clearChatHistory => 'Cancella cronologia chat';

  @override
  String get dissolveGroup => 'Sciogli gruppo';

  @override
  String get leaveGroup => 'Lascia gruppo';

  @override
  String get changeGroupName => 'Cambia nome gruppo';

  @override
  String get enterGroupName => 'Inserisci nome gruppo';

  @override
  String get confirm => 'Conferma';

  @override
  String get changeGroupDescription => 'Cambia descrizione gruppo';

  @override
  String get enterGroupDescription => 'Inserisci descrizione gruppo';

  @override
  String get editAnnouncement => 'Modifica annuncio';

  @override
  String get enterAnnouncement => 'Inserisci annuncio';

  @override
  String get publish => 'Pubblica';

  @override
  String get clearHistoryConfirm =>
      'Cancellare tutta la cronologia chat? Questa azione non può essere annullata.';

  @override
  String get clearAction => 'Cancella';

  @override
  String get chatHistoryCleared => 'Cronologia chat cancellata';

  @override
  String leaveGroupConfirm(String name) {
    return 'Lasciare \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Sciogliere \"$name\"? Questa azione non può essere annullata.';
  }

  @override
  String get dissolve => 'Sciogli';

  @override
  String get groupQrCode => 'QR Code gruppo';

  @override
  String get searchChatHistory => 'Cerca nella cronologia chat';

  @override
  String get groupIdCopied => 'ID gruppo copiato';

  @override
  String tapCopyGroupId(int count) {
    return '$count membri · Tocca per copiare ID gruppo';
  }

  @override
  String get receiverAddress => 'Indirizzo destinatario';

  @override
  String get enterOrPasteAddress => 'Inserisci o incolla indirizzo wallet';

  @override
  String get selectToken => 'Seleziona token';

  @override
  String get transferAmount => 'Importo trasferimento';

  @override
  String get available => 'Disponibile';

  @override
  String get allAmount => 'Tutto';

  @override
  String get memoOptional => 'Nota (opzionale)';

  @override
  String get addMemo => 'Aggiungi una nota';

  @override
  String get confirmTransfer => 'Conferma trasferimento';

  @override
  String get invalidAddress => 'Inserisci un indirizzo destinatario valido';

  @override
  String get invalidAmount => 'Inserisci un importo valido';

  @override
  String get selectTokenPlease => 'Seleziona un token';

  @override
  String get addressVerified => 'Indirizzo verificato';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Disponibile: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Funzione scansione in sviluppo...';

  @override
  String get enterAmount => 'Inserisci importo';

  @override
  String get redPacketCountMin => 'Almeno 1 busta rossa richiesta';

  @override
  String get viewRedPacketDetails => 'Visualizza dettagli busta rossa';

  @override
  String get enterTransferAmount => 'Inserisci importo trasferimento';

  @override
  String get transferTo => 'Trasferisci a';

  @override
  String get selectCurrency => 'Seleziona valuta';

  @override
  String get receiveTransfer => 'Trasferimento ricevuto';

  @override
  String fromSender(String name, Object senderName) {
    return 'Da $senderName';
  }

  @override
  String get confirmReceive => 'Conferma ricezione';

  @override
  String get groupProfile => 'Info gruppo';

  @override
  String get viewProfile => 'Visualizza profilo';

  @override
  String get removeMember => 'Rimuovi dal gruppo';

  @override
  String removeMemberConfirm(String name) {
    return 'Rimuovere \"$name\" dal gruppo?';
  }

  @override
  String get remove => 'Rimuovi';

  @override
  String get clearStatus => 'Cancella stato';

  @override
  String get clearStatusConfirm => 'Cancellare lo stato attuale?';

  @override
  String get statusCleared => 'Stato cancellato';

  @override
  String statusSet(String result) {
    return 'Stato impostato: $result';
  }

  @override
  String get userNotExist => 'L\'utente non esiste';

  @override
  String get userIdCopied => 'ID utente copiato';

  @override
  String get voiceCallInDevelopment => 'Chiamata vocale in sviluppo...';

  @override
  String get report => 'Segnala';

  @override
  String get reportInDevelopment => 'Funzione segnalazione in sviluppo...';

  @override
  String get shareCard => 'Condividi scheda';

  @override
  String get shareInDevelopment => 'Funzione condivisione in sviluppo...';

  @override
  String get qrCode => 'QR Code';

  @override
  String get qrCodeInDevelopment => 'Funzione QR code in sviluppo...';

  @override
  String get avatarUpdated => 'Avatar aggiornato';

  @override
  String selectImageFailed(String error) {
    return 'Selezione immagine fallita: $error';
  }

  @override
  String get changeName => 'Cambia nome';

  @override
  String get male => 'Maschio';

  @override
  String get female => 'Femmina';

  @override
  String genderSet(String gender) {
    return 'Genere impostato: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Regione impostata: $region';
  }

  @override
  String get setPatText => 'Imposta testo tocco';

  @override
  String get changeSignature => 'Cambia firma';

  @override
  String ringtoneSet(String result) {
    return 'Suoneria impostata: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature in sviluppo...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Salvataggio indirizzo fallito: $error';
  }

  @override
  String get myAddress => 'Il mio indirizzo';

  @override
  String get addNew => 'Aggiungi';

  @override
  String get addAddress => 'Aggiungi indirizzo';

  @override
  String get addressAdded => 'Indirizzo aggiunto';

  @override
  String get addressUpdated => 'Indirizzo aggiornato';

  @override
  String get deleteAddress => 'Elimina indirizzo';

  @override
  String get deleteAddressConfirm => 'Eliminare questo indirizzo?';

  @override
  String get addressDeleted => 'Indirizzo eliminato';

  @override
  String get setDefaultAddress => 'Imposta come predefinito';

  @override
  String get fillCompleteInfo => 'Compila tutti i campi';

  @override
  String saveInvoiceFailed(String error) {
    return 'Salvataggio fattura fallito: $error';
  }

  @override
  String get myInvoices => 'Le mie fatture';

  @override
  String get addInvoice => 'Aggiungi fattura';

  @override
  String get invoiceAdded => 'Fattura aggiunta';

  @override
  String get invoiceUpdated => 'Fattura aggiornata';

  @override
  String get deleteInvoice => 'Elimina fattura';

  @override
  String get deleteInvoiceConfirm => 'Eliminare questa fattura?';

  @override
  String get invoiceDeleted => 'Fattura eliminata';

  @override
  String get invoiceType => 'Tipo fattura: ';

  @override
  String get personal => 'Personale';

  @override
  String get enterprise => 'Aziendale';

  @override
  String get setDefaultInvoice => 'Imposta come predefinita';

  @override
  String get enterTaxId => 'Inserisci codice fiscale';

  @override
  String get vibrateMode => 'Modalità vibrazione';

  @override
  String get silentMode => 'Modalità silenziosa';

  @override
  String playing(String ringtoneName) {
    return 'In riproduzione: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Riproduzione fallita: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Inserisci il nome del gruppo';

  @override
  String get selectAtLeastOne => 'Seleziona almeno un membro';

  @override
  String get fillStatus => 'Scrivi stato';

  @override
  String get fileNotExist => 'Il file non esiste';

  @override
  String sendFailed(String error) {
    return 'Invio fallito: $error';
  }

  @override
  String get cannotOpenBrowser => 'Impossibile aprire il browser';

  @override
  String selectFileFailed(String error) {
    return 'Selezione file fallita: $error';
  }

  @override
  String get enterMusicLink => 'Inserisci link musicale';

  @override
  String get enterValidLink => 'Inserisci un link valido';

  @override
  String get enterPollQuestion => 'Inserisci domanda sondaggio';

  @override
  String get minTwoOptions => 'Almeno 2 opzioni richieste';

  @override
  String get crossDeviceEnabled => 'Firma cross-device abilitata';

  @override
  String get crossDeviceSet => 'Firma cross-device configurata';

  @override
  String setupFailed(String error) {
    return 'Configurazione fallita: $error';
  }

  @override
  String get receiveAmount => 'Importo da ricevere';

  @override
  String get enterValidAmount => 'Inserisci un importo valido';

  @override
  String get addressCopied => 'Indirizzo copiato';

  @override
  String openItem(String content) {
    return 'Apri: $content';
  }

  @override
  String get newNoteComingSoon => 'Funzione nuova nota in arrivo';

  @override
  String get addLinkComingSoon => 'Funzione aggiungi link in arrivo';

  @override
  String get deleted => 'Eliminato';

  @override
  String get shareComingSoon => 'Funzione condivisione in arrivo';

  @override
  String get saveComingSoon => 'Funzione salvataggio in arrivo';

  @override
  String get moreStylesComingSoon => 'Altri stili in arrivo';

  @override
  String get wallet => 'Wallet';

  @override
  String get walletArea => 'Area wallet';

  @override
  String get recording => 'Registrazione';

  @override
  String get invalidVideoUrl => 'URL video non valido';

  @override
  String get downloadFile => 'Scarica file';

  @override
  String get clearChatHistoryTitle => 'Cancella cronologia chat';

  @override
  String get cannotUndo => 'Questa azione non può essere annullata';

  @override
  String get videoCall => 'Videochiamata';

  @override
  String get voiceCall => 'Chiamata vocale';

  @override
  String get leaveMeeting => 'Lascia riunione';

  @override
  String get chatDetails => 'Dettagli chat';

  @override
  String get viewAllGroupMembers => 'Vedi tutti i membri';

  @override
  String get groupName => 'Nome gruppo';

  @override
  String get groupNameUpdated => 'Nome gruppo aggiornato';

  @override
  String get groupDescriptionUpdated => 'Descrizione gruppo aggiornata';

  @override
  String get groupAvatarUpdated => 'Avatar gruppo aggiornato';

  @override
  String get updateFailed => 'Aggiornamento fallito';

  @override
  String get noPermissionToModify => 'Non hai i permessi per modificare';

  @override
  String get groupManagement => 'Gestione gruppo';

  @override
  String get myNicknameInGroup => 'Il mio nickname nel gruppo';

  @override
  String get pinChat => 'Fissa chat';

  @override
  String get strongReminder => 'Promemoria importante';

  @override
  String get setChatBackground => 'Imposta sfondo chat';

  @override
  String get unknownFile => 'File sconosciuto';

  @override
  String get download => 'Scarica';

  @override
  String get invalidLocation => 'Posizione non valida';

  @override
  String get address => 'Indirizzo';

  @override
  String get latitude => 'Latitudine';

  @override
  String get longitude => 'Longitudine';

  @override
  String get close => 'Chiudi';

  @override
  String get tapToCancel => 'Tocca per annullare';

  @override
  String captureFailed(Object error) {
    return 'Cattura fallita: $error';
  }

  @override
  String get processingVideo => 'Elaborazione video...';

  @override
  String get videoFileNotExist => 'Il file video non esiste';

  @override
  String get videoDataEmpty => 'I dati video sono vuoti';

  @override
  String get videoTooLarge => 'Il video non può superare 100MB';

  @override
  String get sendingVideo => 'Invio video...';

  @override
  String sendVideoFailed(Object error) {
    return 'Invio video fallito: $error';
  }

  @override
  String get imageFileNotExist => 'Il file immagine non esiste';

  @override
  String get imageDataEmpty => 'I dati immagine sono vuoti';

  @override
  String get sendingImage => 'Invio immagine...';

  @override
  String sendImageFailed(Object error) {
    return 'Invio immagine fallito: $error';
  }

  @override
  String get sendLocation => 'Invia posizione';

  @override
  String get selectLocationAndSend => 'Seleziona posizione e invia';

  @override
  String get shareRealTimeLocation => 'Condividi posizione in tempo reale';

  @override
  String get shareLocationForOneHour =>
      'Condividi posizione in tempo reale con l\'amico per 1 ora';

  @override
  String get locationSent => 'Posizione inviata';

  @override
  String get selectMessages => 'Seleziona messaggi';

  @override
  String selectedCount(int count) {
    return 'Selezionati $count';
  }

  @override
  String get selectAll => 'Seleziona tutto';

  @override
  String groupChatCount(int count) {
    return 'Chat di gruppo ($count)';
  }

  @override
  String get privateChat => 'Chat privata';

  @override
  String get noMessages => 'Nessun messaggio';

  @override
  String get sendFirstMessage =>
      'Invia il primo messaggio per iniziare a chattare';

  @override
  String get encryptionNotice =>
      'Questa chat è crittografata end-to-end. Solo tu e il destinatario potete leggere i messaggi.';

  @override
  String replyTo(String name) {
    return 'Rispondi a $name';
  }

  @override
  String get multiForward => 'Inoltra';

  @override
  String get collect => 'Salva';

  @override
  String get noMembers => 'Nessun membro';

  @override
  String get memberNotFound => 'Membro non trovato';

  @override
  String get voiceFileNotExist => 'Il file vocale non esiste';

  @override
  String get voiceFileEmpty => 'Il file vocale è vuoto';

  @override
  String get sendingVoice => 'Invio vocale...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Invio vocale fallito: $error';
  }

  @override
  String get messageCopied => 'Messaggio copiato';

  @override
  String get messageForwarded => 'Messaggio inoltrato';

  @override
  String forwardFailed(Object error) {
    return 'Inoltro fallito: $error';
  }

  @override
  String get unfavorited => 'Rimosso dai preferiti';

  @override
  String get favorited => 'Aggiunto ai preferiti';

  @override
  String get reactionAdded => 'Reazione aggiunta';

  @override
  String get reactionRemoved => 'Reazione rimossa';

  @override
  String get failedMessageDeleted => 'Messaggio fallito eliminato';

  @override
  String get deleteMessages => 'Elimina messaggi';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Sei sicuro di voler eliminare $count messaggi?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Nota: $count messaggi sono di altri e saranno eliminati solo per te.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count messaggi tuoi verranno ritirati per tutti.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Ritirati $count messaggi, $localCount eliminati solo per te';
  }

  @override
  String recalledMessages(Object count) {
    return 'Ritirati $count messaggi';
  }

  @override
  String deletedLocally(Object count) {
    return '$count messaggi eliminati solo per te';
  }

  @override
  String forwardedCount(Object count) {
    return 'Inoltrati $count messaggi';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Inoltro completato: $success riusciti, $failed falliti';
  }

  @override
  String get remindOnlyInGroup =>
      'La funzione menziona è disponibile solo nelle chat di gruppo';

  @override
  String get onlyTextSearchable =>
      'Solo i messaggi di testo possono essere cercati';

  @override
  String searchFor(Object text) {
    return 'Cerca \"$text\"';
  }

  @override
  String get baiduSearch => 'Cerca su Baidu';

  @override
  String get googleSearch => 'Cerca su Google';

  @override
  String get bingSearch => 'Cerca su Bing';

  @override
  String get calling => 'Chiamata in corso...';

  @override
  String get connecting => 'Connessione...';

  @override
  String get ringing => 'Squillando...';

  @override
  String get inCall => 'In chiamata';

  @override
  String featureInDevelopment(String feature) {
    return 'Funzionalità in sviluppo...';
  }

  @override
  String collectMessages(Object count) {
    return 'Salvati $count messaggi';
  }

  @override
  String get voted => 'Votato';

  @override
  String get voteChanged => 'Voto modificato';

  @override
  String get voteRemoved => 'Voto rimosso';

  @override
  String get endPoll => 'Termina sondaggio';

  @override
  String get endPollConfirm =>
      'Sei sicuro di voler terminare questo sondaggio? Non sarà più possibile votare.';

  @override
  String memberCount(int count) {
    return '$count membri';
  }

  @override
  String get videoChannels => 'Canali';

  @override
  String get live => 'Live';

  @override
  String get listen => 'Ascolta';

  @override
  String get watch => 'Guarda';

  @override
  String get searchDiscover => 'Cerca';

  @override
  String get nearbyPeople => 'Vicino a te';

  @override
  String get games => 'Giochi';

  @override
  String get miniPrograms => 'Mini programmi';

  @override
  String done(int count) {
    return 'Fatto($count)';
  }

  @override
  String get services => 'Servizi';

  @override
  String get favorites => 'Preferiti';

  @override
  String get ordersAndCards => 'Ordini e carte';

  @override
  String get stickers => 'Sticker';

  @override
  String statusSetTo(String status) {
    return 'Stato impostato: $status';
  }

  @override
  String get avatarUploadFailed => 'Caricamento avatar fallito';

  @override
  String get personalProfile => 'Profilo personale';

  @override
  String get name => 'Nome';

  @override
  String get gender => 'Genere';

  @override
  String get region => 'Regione';

  @override
  String get myQrCode => 'Il mio QR Code';

  @override
  String get poke => 'Tocco';

  @override
  String get ringtone => 'Suoneria';

  @override
  String get defaultRingtone => 'Suoneria predefinita';

  @override
  String get myAddresses => 'I miei indirizzi';

  @override
  String genderSetTo(String gender) {
    return 'Genere impostato: $gender';
  }

  @override
  String get selectRegion => 'Seleziona regione';

  @override
  String get selectCity => 'Seleziona città';

  @override
  String regionSetTo(String region) {
    return 'Regione impostata: $region';
  }

  @override
  String get setPoke => 'Imposta tocco';

  @override
  String get friendPokedMe => 'L\'amico mi ha toccato';

  @override
  String get enterPokeSuffix => 'Inserisci suffisso tocco, es.: sulla spalla';

  @override
  String get example => 'Esempio';

  @override
  String get onTheShoulder => ' sulla spalla';

  @override
  String get pokeCleared => 'Tocco cancellato';

  @override
  String pokeSetTo(String suffix) {
    return 'Tocco impostato: mi ha toccato$suffix';
  }

  @override
  String get editSignature => 'Modifica firma';

  @override
  String get introduceYourself => 'Una frase per presentarti';

  @override
  String get signatureCleared => 'Firma cancellata';

  @override
  String get signatureUpdated => 'Firma aggiornata';

  @override
  String get scanToAddFriend =>
      'Scansiona il QR code qui sopra per aggiungermi come amico';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Suoneria impostata: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Sei sicuro di voler sciogliere \"$name\"? Questa azione non può essere annullata.';
  }

  @override
  String get enterValidServerAddress => 'Inserisci un indirizzo server valido';

  @override
  String get emailOtp => 'OTP email';

  @override
  String get enterServerAddressFirst =>
      'Inserisci prima l\'indirizzo del server';

  @override
  String get passkeyRequiresServer =>
      'L\'accesso con passkey richiede supporto del server';

  @override
  String get loginAgreement => 'Accedendo, accetti ';

  @override
  String get pleaseAgreeToTerms =>
      'Leggi e accetta i Termini di servizio e l\'Informativa sulla privacy';

  @override
  String get registerFailed => 'Registrazione fallita';

  @override
  String get reenterPassword => 'Reinserisci password';

  @override
  String get passwordsDoNotMatch => 'Le password non coincidono';

  @override
  String get inviteCodeBuiltIn => 'Codice invito (integrato)';

  @override
  String get inviteCodeBuiltInNote =>
      'Il codice invito è integrato, solitamente non serve modificarlo';

  @override
  String get iHaveReadAndAgree => 'Ho letto e accetto ';

  @override
  String get startGroupChat => 'Inizia chat di gruppo';

  @override
  String get addFriends => 'Aggiungi amici';

  @override
  String get paymentAndCollection => 'Pagamento';

  @override
  String messagesWithCount(int count) {
    return 'Messaggi($count)';
  }

  @override
  String contactCount(int count) {
    return '$count contatti';
  }

  @override
  String get addToHomeScreen => 'Aggiungi alla home';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Scheda di $contact raccomandata a $recipient';
  }

  @override
  String get enterRemarkName => 'Inserisci nome nota';

  @override
  String remarkSetTo(String remark) {
    return 'Nota impostata: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Accettata richiesta di amicizia di $name';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Rifiutata richiesta di amicizia di $name';
  }

  @override
  String get groupInvites => 'Inviti gruppo';

  @override
  String myGroups(int count) {
    return 'I miei gruppi ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Invitato a unirsi al gruppo';

  @override
  String confirmLeaveGroup(String name) {
    return 'Sei sicuro di voler lasciare \"$name\"?';
  }

  @override
  String get leave => 'Lascia';

  @override
  String get saveMedia => 'Salva';

  @override
  String get recallThisMessage => 'Ritirare questo messaggio?';

  @override
  String get messageRecalled => 'Messaggio ritirato';

  @override
  String get savedToGallery => 'Salvato nella galleria';

  @override
  String get failedToSave => 'Salvataggio fallito';

  @override
  String get saving => 'Salvataggio...';

  @override
  String get share => 'Condividi';

  @override
  String get saveToGallery => 'Salva nella galleria';

  @override
  String downloadFailed(String code) {
    return 'Download fallito: $code';
  }

  @override
  String get noMediaUrl => 'Nessun URL media disponibile';

  @override
  String shareFailed(String error) {
    return 'Condivisione fallita: $error';
  }

  @override
  String get failedToLoadImage => 'Caricamento immagine fallito';

  @override
  String get failedToLoadMoreMessages => 'Caricamento messaggi fallito';

  @override
  String get failedToSend => 'Invio fallito';

  @override
  String get failedToSendImage => 'Invio immagine fallito';

  @override
  String get failedToSendVoice => 'Invio vocale fallito';

  @override
  String get failedToSendFile => 'Invio file fallito';

  @override
  String get failedToSendVideo => 'Invio video fallito';

  @override
  String get failedToSendLocation => 'Invio posizione fallito';

  @override
  String get failedToResend => 'Rinvio fallito';

  @override
  String get failedToRecall => 'Ritiro fallito';

  @override
  String get failedToReply => 'Risposta fallita';

  @override
  String get failedToAddReaction => 'Aggiunta reazione fallita';

  @override
  String get failedToSendPoll => 'Invio sondaggio fallito';

  @override
  String get failedToVote => 'Voto fallito';

  @override
  String get failedToLoadMessages => 'Caricamento messaggi fallito';

  @override
  String get callFeatureComingSoon =>
      'Funzione chiamate vocali e video in arrivo';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Buste rosse e trasferimenti non possono essere inoltrati';

  @override
  String get videoRecordingFailed => 'Registrazione video fallita. Riprova.';

  @override
  String get redPacket => 'Busta rossa';

  @override
  String get music => 'Musica';

  @override
  String get coupon => 'Coupon';

  @override
  String get gift => 'Regalo';

  @override
  String get poll => 'Sondaggio';

  @override
  String get text => 'Testo';

  @override
  String get link => 'Link';

  @override
  String get note => 'Nota';

  @override
  String get myNotes => 'Le mie note';

  @override
  String get today => 'Oggi';

  @override
  String daysAgoText(int count) {
    return '$count giorni fa';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Nessun preferito';

  @override
  String get longPressToFavorite =>
      'Tieni premuto un messaggio per aggiungerlo ai preferiti';

  @override
  String get newNote => 'Nuova nota';

  @override
  String get favoriteLink => 'Link preferito';

  @override
  String get editTags => 'Modifica tag';

  @override
  String get deleteFavorite => 'Elimina preferito';

  @override
  String get deleteFavoriteConfirm =>
      'Sei sicuro di voler eliminare questo preferito?';

  @override
  String get noSearchResultsFound => 'Nessun risultato trovato';

  @override
  String get sendRedPacket => 'Invia busta rossa';

  @override
  String get amount => 'Importo';

  @override
  String get redPacketCover => 'Copertina busta rossa';

  @override
  String get redPacketType => 'Tipo busta rossa';

  @override
  String get normalRedPacket => 'Normale';

  @override
  String get luckyRedPacket => 'Fortunato';

  @override
  String get redPacketCount => 'Numero buste rosse';

  @override
  String get pieces => 'pezzi';

  @override
  String get putMoneyInRedPacket => 'Metti soldi nella busta rossa';

  @override
  String get redPacketRefundNotice =>
      'Le buste rosse non riscosse verranno rimborsate dopo 24 ore';

  @override
  String get openRedPacket => 'Apri';

  @override
  String get redPacketAllClaimed => 'Busta rossa completamente riscossa';

  @override
  String get redPacketExpired => 'Busta rossa scaduta';

  @override
  String get addTransferNote => 'Aggiungi nota trasferimento';

  @override
  String get yuan => 'CNY';

  @override
  String get savedToChangeCanTransfer =>
      'Salvato nel saldo, puoi trasferire direttamente';

  @override
  String get replyWithEmoji => 'Rispondi con questa emoji';

  @override
  String get claimedYourRedPacket => 'ha riscosso la tua';

  @override
  String get claimedRedPacket => 'ha riscosso';

  @override
  String get otherTyping => 'sta scrivendo...';

  @override
  String get processing => 'Elaborazione...';

  @override
  String get transferCancelled => 'Trasferimento annullato';

  @override
  String get transferFailed => 'Trasferimento fallito';

  @override
  String get creatingPaymentRequest => 'Creazione richiesta pagamento...';

  @override
  String get processingPayment => 'Elaborazione pagamento...';

  @override
  String get paymentFailed => 'Pagamento fallito';

  @override
  String get clickRetry => 'Tocca per riprovare';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get editRemark => 'Modifica nota';

  @override
  String get setPermissions => 'Imposta permessi';

  @override
  String get recommendToFriends => 'Raccomanda ad amici';

  @override
  String get setStarFriend => 'Imposta come amico preferito';

  @override
  String get addToBlacklist => 'Aggiungi alla lista nera';

  @override
  String get complain => 'Segnala';

  @override
  String get deleteContact => 'Elimina contatto';

  @override
  String deleteContactConfirm(String name) {
    return 'Sei sicuro di voler eliminare $name?';
  }

  @override
  String get transferTitle => 'Trasferimento';

  @override
  String get receiverAddressLabel => 'Indirizzo destinatario';

  @override
  String get selectTokenLabel => 'Seleziona token';

  @override
  String get transferAmountLabel => 'Importo trasferimento';

  @override
  String get memoLabel => 'Nota (opzionale)';

  @override
  String get enterOrPasteAddressHint => 'Inserisci o incolla indirizzo wallet';

  @override
  String get scanInDevelopment => 'Funzione scansione in sviluppo...';

  @override
  String get availableLabel => 'Disponibile';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Disponibile: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Aggiungi una nota';

  @override
  String get receiveTitle => 'Ricevi';

  @override
  String get walletNotConnectedTitle => 'Wallet non connesso';

  @override
  String get connectWalletFirst => 'Connetti prima il wallet';

  @override
  String get sendPaymentRequest => 'Invia richiesta pagamento';

  @override
  String get qrCodeGenerateFailed => 'Generazione QR code fallita';

  @override
  String get scanQrToPayMe => 'Scansiona il QR code per pagarmi';

  @override
  String get myWalletAddress => 'Il mio indirizzo wallet';

  @override
  String get createPaymentRequest => 'Crea richiesta pagamento';

  @override
  String get selectTokenHint => 'Seleziona token';

  @override
  String get amountLabel => 'Importo';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get sendRequestButton => 'Invia richiesta';

  @override
  String get allReadReceipt => 'Tutto letto';

  @override
  String readCountReceipt(int count) {
    return '$count letto';
  }

  @override
  String n42IdLabel(String id) {
    return 'ID N42: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Auguri';

  @override
  String senderRedPacket(String name) {
    return 'Busta rossa di $name';
  }

  @override
  String get allButton => 'Tutto';

  @override
  String get enterValidAddress => 'Inserisci un indirizzo valido';

  @override
  String get pleaseSelectToken => 'Seleziona un token';

  @override
  String get receivedTransfer => 'Trasferimento ricevuto';

  @override
  String get selectForwardRecipient => 'Seleziona destinatario inoltro';

  @override
  String get emojiFaces => 'Faccine';

  @override
  String get emojiHearts => 'Cuori';

  @override
  String get emojiAnimals => 'Animali';

  @override
  String get emojiFood => 'Cibo';

  @override
  String get emojiTransport => 'Trasporti';

  @override
  String get emojiActivities => 'Attività';

  @override
  String get emojiObjects => 'Oggetti';

  @override
  String get emojiSymbols => 'Simboli';

  @override
  String get transferProcessing => 'Elaborazione trasferimento...';

  @override
  String senderSentRedPacket(String name) {
    return '$name ha inviato una busta rossa';
  }

  @override
  String get savedToBalance =>
      'Salvato nel saldo, puoi trasferire direttamente';

  @override
  String get redPacketExpiredOrEmpty =>
      'Busta rossa scaduta/completamente riscossa';

  @override
  String get scanFeatureComingSoon => 'Funzione scansione in arrivo...';

  @override
  String get setAsStarred => 'Imposta come preferito';

  @override
  String get addToBlocklist => 'Aggiungi alla lista bloccati';

  @override
  String get claimedYour => ' ha riscosso la tua ';

  @override
  String get claimedText => ' ha riscosso ';

  @override
  String userTyping(String name) {
    return '$name sta scrivendo...';
  }

  @override
  String get typing => 'Sta scrivendo...';

  @override
  String get waitingToReceive => 'In attesa di ricevere';

  @override
  String get tapToClaim => 'Tocca per riscuotere';

  @override
  String get hasBeenReceived => 'È stato ricevuto';

  @override
  String get getLucky => 'Buona fortuna';

  @override
  String get cameraStartFailed => 'Avvio fotocamera fallito';

  @override
  String get unknownError => 'Errore sconosciuto';

  @override
  String get placeQrCodeInFrame =>
      'Posiziona il QR code nel riquadro per scansionare';

  @override
  String get closeManualInput => 'Chiudi inserimento manuale';

  @override
  String get manualInputUserId => 'Inserimento manuale ID utente';

  @override
  String get add => 'Aggiungi';

  @override
  String get ringtoneClear => 'Cancella';

  @override
  String get ringtonePhone => 'Telefono';

  @override
  String get ringtoneClassic => 'Classica';

  @override
  String get ringtoneSoft => 'Soft';

  @override
  String get ringtoneVibrate => 'Vibrazione';

  @override
  String get ringtoneSilent => 'Silenzioso';

  @override
  String get stop => 'Stop';

  @override
  String get selectRingtone => 'Seleziona suoneria';

  @override
  String get loadingRingtones => 'Caricamento suonerie...';

  @override
  String get noRingtonesFound => 'Nessuna suoneria trovata';

  @override
  String get moodAndThoughts => 'Umore e pensieri';

  @override
  String get statusHappy => 'Felice';

  @override
  String get statusCracked => 'A pezzi';

  @override
  String get statusLucky => 'Fortunato';

  @override
  String get statusSunny => 'Solare';

  @override
  String get statusTired => 'Stanco';

  @override
  String get statusDaydream => 'Sognando';

  @override
  String get statusRushing => 'Di fretta';

  @override
  String get statusOverthinking => 'Pensieroso';

  @override
  String get statusEnergized => 'Carico';

  @override
  String get workAndStudy => 'Lavoro e studio';

  @override
  String get statusWorking => 'Al lavoro';

  @override
  String get statusStudying => 'Studiando';

  @override
  String get statusBusy => 'Occupato';

  @override
  String get statusSlacking => 'Rilassandosi';

  @override
  String get statusTraveling => 'In viaggio';

  @override
  String get statusGoingHome => 'Tornando a casa';

  @override
  String get statusDnd => 'Non disturbare';

  @override
  String get statusHanging => 'In giro';

  @override
  String get statusCheckIn => 'Check in';

  @override
  String get statusExercising => 'Allenamento';

  @override
  String get statusCoffee => 'Caffè';

  @override
  String get statusBubbleTea => 'Bubble tea';

  @override
  String get statusEating => 'Mangiando';

  @override
  String get statusParenting => 'Genitori';

  @override
  String get statusSavingWorld => 'Salvando il mondo';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Riposo';

  @override
  String get statusRetreat => 'Ritirata';

  @override
  String get statusHome => 'A casa';

  @override
  String get statusSleeping => 'Dormendo';

  @override
  String get statusCatLover => 'Amante dei gatti';

  @override
  String get statusDogWalking => 'Passeggiata col cane';

  @override
  String get statusGaming => 'Giocando';

  @override
  String get statusListening => 'Ascoltando';

  @override
  String get setStatus => 'Imposta stato';

  @override
  String get visibleToFriends24h => 'Visibile agli amici per 24 ore';

  @override
  String get writeStatus => 'Scrivi stato';

  @override
  String get enterYourStatus => 'Inserisci il tuo stato...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Permesso fotocamera richiesto per scansionare QR code';

  @override
  String get cameraPermissionDenied =>
      'Permesso fotocamera negato permanentemente. Abilitalo nelle impostazioni di sistema.';

  @override
  String get cannotGetCameraPermission =>
      'Impossibile ottenere permesso fotocamera';

  @override
  String permissionCheckError(String error) {
    return 'Errore verifica permesso: $error';
  }

  @override
  String get invalidQrCode => 'QR code non valido';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Elaborazione QR code fallita: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Impossibile aggiungere amico: $error';
  }

  @override
  String get scanQrCode => 'Scansiona QR Code';

  @override
  String get checkingCameraPermission => 'Verifica permesso fotocamera...';

  @override
  String get needCameraPermission => 'Permesso fotocamera richiesto';

  @override
  String get retryPermission => 'Riprova';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get inviteMembers => 'Invita membri';

  @override
  String inviteCount(int count) {
    return 'Invita($count)';
  }

  @override
  String get noShippingAddress => 'Nessun indirizzo di spedizione';

  @override
  String get defaultLabel => 'Predefinito';

  @override
  String get editAddress => 'Modifica indirizzo';

  @override
  String get recipient => 'Destinatario';

  @override
  String get enterRecipientName => 'Inserisci nome destinatario';

  @override
  String get phoneNumber => 'Numero di telefono';

  @override
  String get enterPhoneNumber => 'Inserisci numero di telefono';

  @override
  String get regionHint => 'Provincia/Città/Distretto';

  @override
  String get detailedAddress => 'Indirizzo dettagliato';

  @override
  String get detailedAddressHint => 'Via, numero civico, ecc.';

  @override
  String get setAsDefaultAddress => 'Imposta come indirizzo predefinito';

  @override
  String get pleaseCompleteInfo => 'Compila tutti i campi';

  @override
  String get noInvoice => 'Nessuna fattura';

  @override
  String get company => 'Azienda';

  @override
  String get taxNumber => 'Partita IVA';

  @override
  String get editInvoice => 'Modifica fattura';

  @override
  String get companyName => 'Nome azienda';

  @override
  String get enterCompanyName => 'Inserisci nome azienda';

  @override
  String get personalName => 'Nome personale';

  @override
  String get enterName => 'Inserisci nome';

  @override
  String get taxIdNumber => 'Codice fiscale';

  @override
  String get enterTaxIdNumber => 'Inserisci codice fiscale';

  @override
  String get bankNameOptional => 'Nome banca (opzionale)';

  @override
  String get enterBankName => 'Inserisci nome banca';

  @override
  String get bankAccountOptional => 'Conto bancario (opzionale)';

  @override
  String get enterBankAccount => 'Inserisci conto bancario';

  @override
  String get companyAddressOptional => 'Indirizzo azienda (opzionale)';

  @override
  String get enterCompanyAddress => 'Inserisci indirizzo azienda';

  @override
  String get companyPhoneOptional => 'Telefono azienda (opzionale)';

  @override
  String get enterCompanyPhone => 'Inserisci telefono azienda';

  @override
  String get setAsDefaultInvoice => 'Imposta come fattura predefinita';

  @override
  String get confirmDeleteAddress =>
      'Sei sicuro di voler eliminare questo indirizzo?';

  @override
  String get confirmDeleteInvoice =>
      'Sei sicuro di voler eliminare questa fattura?';

  @override
  String get groupOwner => 'Proprietario';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Cerca membri';

  @override
  String totalMembers(int count) {
    return '$count membri';
  }

  @override
  String get removeFromGroup => 'Rimuovi dal gruppo';

  @override
  String confirmRemoveMember(String name) {
    return 'Sei sicuro di voler rimuovere \"$name\" dal gruppo?';
  }

  @override
  String get setAsAdmin => 'Imposta come admin';

  @override
  String get removeAdmin => 'Rimuovi admin';

  @override
  String get deleteContactSuccess => 'Contatto eliminato';

  @override
  String get unknownSong => 'Brano sconosciuto';

  @override
  String get unknownArtist => 'Artista sconosciuto';

  @override
  String get unknownContact => 'Contatto sconosciuto';

  @override
  String get personalCard => 'Scheda contatto';

  @override
  String get singleChoice => 'Singola';

  @override
  String get multiChoice => 'Multipla';

  @override
  String get ended => 'Terminato';

  @override
  String get endPollButton => 'Termina sondaggio';

  @override
  String get createPoll => 'Crea sondaggio';

  @override
  String get pollQuestion => 'Domanda sondaggio';

  @override
  String get pollOptions => 'Opzioni sondaggio';

  @override
  String optionPlaceholder(int index) {
    return 'Opzione $index';
  }

  @override
  String get addOption => 'Aggiungi opzione';

  @override
  String get pollSettings => 'Impostazioni sondaggio';

  @override
  String get anonymousPoll => 'Sondaggio anonimo';

  @override
  String get pollHint =>
      'Il sondaggio verrà visualizzato nella chat. I membri del gruppo possono votare.';

  @override
  String get searchSongOrArtist => 'Cerca brano o artista';

  @override
  String get noSongsFound => 'Nessun brano trovato';

  @override
  String get supportedMusicPlatforms =>
      'Supporta link musicali da NetEase, QQ Music, ecc.';

  @override
  String get songNameOptional => 'Nome brano (opzionale)';

  @override
  String get enterSongName => 'Inserisci nome brano';

  @override
  String get artistNameOptional => 'Nome artista (opzionale)';

  @override
  String get enterArtistName => 'Inserisci nome artista';

  @override
  String get shareSong => 'Condividi brano';

  @override
  String get realTimeLocationSharing =>
      'Condivisione posizione in tempo reale in sviluppo...';

  @override
  String get voiceCallFeatureInDev => 'Funzione chiamata vocale in sviluppo...';

  @override
  String get reportFeatureInDev => 'Funzione segnalazione in sviluppo...';

  @override
  String get shareFeatureInDev => 'Funzione condivisione in sviluppo...';

  @override
  String get qrCodeFeatureInDev => 'Funzione QR code in sviluppo...';

  @override
  String get scanQrToAddMe =>
      'Scansiona il QR code qui sopra per aggiungermi come amico';

  @override
  String get saveToAlbum => 'Salva nell\'album';

  @override
  String get changeStyle => 'Cambia stile';

  @override
  String get copyId => 'Copia ID';

  @override
  String get idCopied => 'ID copiato';

  @override
  String get shareFeatureComingSoon => 'Funzione condivisione in arrivo';

  @override
  String get saveFeatureComingSoon => 'Funzione salvataggio in arrivo';

  @override
  String get moreStylesFeatureComingSoon => 'Altri stili in arrivo';

  @override
  String get confirmEndPoll =>
      'Sei sicuro di voler terminare questo sondaggio?';

  @override
  String get cannotVoteAfterEnd =>
      'Non sarà più possibile votare dopo la chiusura.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Server';

  @override
  String get shareContactCard => 'Condividi scheda contatto';

  @override
  String get removeFromBlacklist => 'Rimuovi dalla lista nera';

  @override
  String get confirmAddBlacklist =>
      'Sei sicuro di voler aggiungere questo utente alla lista nera? Non riceverai più messaggi da lui.';

  @override
  String get confirmRemoveBlacklist =>
      'Sei sicuro di voler rimuovere questo utente dalla lista nera?';

  @override
  String get remarkSaved => 'Nota salvata';

  @override
  String get remarkCleared => 'Nota cancellata';

  @override
  String get receive => 'Ricevi';

  @override
  String get pleaseConnectWallet => 'Connetti prima il tuo wallet';

  @override
  String get sendRequest => 'Invia richiesta';

  @override
  String get pleaseEnterValidAmount => 'Inserisci un importo valido';

  @override
  String get searchPlaceholder => 'Cerca contatti, gruppi, messaggi';

  @override
  String get enterKeywordToSearch => 'Inserisci parola chiave per cercare';

  @override
  String get clearHistory => 'Cancella';

  @override
  String noResultsForQuery(String query) {
    return 'Nessun risultato per \"$query\"';
  }

  @override
  String get allResults => 'Tutto';

  @override
  String get searchInChat => 'Cerca nella chat';

  @override
  String get contactLabel => 'Contatto';

  @override
  String get groupLabel => 'Gruppo';

  @override
  String get conversationLabel => 'Conversazione';

  @override
  String get messageLabel => 'Messaggio';

  @override
  String get securityTitle => 'Sicurezza';

  @override
  String get keyBackup => 'Backup chiavi';

  @override
  String get backupEncryptionKeys => 'Backup chiavi di crittografia';

  @override
  String keysBackedUp(int count) {
    return '$count chiavi salvate';
  }

  @override
  String get backupNotSet => 'Backup non configurato';

  @override
  String get restoreKeys => 'Ripristina chiavi';

  @override
  String get restoreKeysFromBackup =>
      'Ripristina chiavi di crittografia dal backup';

  @override
  String get exportKeys => 'Esporta chiavi';

  @override
  String get exportKeysToFile => 'Esporta chiavi in un file';

  @override
  String get loggedInDevices => 'Dispositivi connessi';

  @override
  String get noOtherDevices => 'Nessun altro dispositivo';

  @override
  String get verified => 'Verificato';

  @override
  String get unverified => 'Non verificato';

  @override
  String get advanced => 'Avanzate';

  @override
  String get crossSigning => 'Cross-signing';

  @override
  String get enabled => 'Abilitato';

  @override
  String get notEnabled => 'Non abilitato';

  @override
  String get resetEncryption => 'Reimposta crittografia';

  @override
  String get deleteAllEncryptionKeys =>
      'Elimina tutte le chiavi di crittografia';

  @override
  String get encryptionNotSupported => 'Crittografia non supportata';

  @override
  String get notInitialized => 'Non inizializzato';

  @override
  String get backupKeyTitle => 'Backup chiavi';

  @override
  String get backupKeyMessage =>
      'Creare un nuovo backup chiavi? Questo ti aiuterà a ripristinare i messaggi crittografati su un nuovo dispositivo.';

  @override
  String get backup => 'Backup';

  @override
  String get restoreKeyTitle => 'Ripristina chiavi';

  @override
  String get restoreKeyMessage =>
      'Inserisci la password di recupero o la chiave di recupero per ripristinare i messaggi crittografati.';

  @override
  String get restore => 'Ripristina';

  @override
  String get exportKeyTitle => 'Esporta chiavi';

  @override
  String get exportKeyMessage =>
      'Il file chiavi esportato contiene tutte le tue chiavi di crittografia. Conservalo al sicuro.';

  @override
  String get export => 'Esporta';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID dispositivo: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Stato: Verificato';

  @override
  String get deviceStatusUnverified => 'Stato: Non verificato';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Ultimo accesso: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Verifica questo dispositivo';

  @override
  String get crossSigningAlreadyEnabled => 'Cross-signing già abilitato';

  @override
  String get crossSigningSetupSuccess =>
      'Configurazione cross-signing riuscita';

  @override
  String get resetEncryptionTitle => 'Reimposta crittografia';

  @override
  String get resetEncryptionWarning =>
      'Attenzione: Questo eliminerà tutte le tue chiavi di crittografia. Non potrai decifrare i messaggi crittografati precedenti. Questa azione non può essere annullata.';

  @override
  String get reset => 'Reimposta';

  @override
  String get leaveMeetingConfirm => 'Sei sicuro di voler lasciare la riunione?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'ha toccato $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Nessun contatto disponibile da aggiungere';

  @override
  String get addMembers => 'Aggiungi membri';

  @override
  String invitedMembers(int count) {
    return 'Invitati $count membri';
  }

  @override
  String inviteFailed(String error) {
    return 'Invito fallito: $error';
  }

  @override
  String get memberRemoved => 'Membro rimosso';

  @override
  String removeFailed(String error) {
    return 'Rimozione fallita: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Dopo la condivisione, l\'altra persona potrà vedere la tua posizione in tempo reale per 1 ora.';

  @override
  String get startSharing => 'Inizia condivisione';

  @override
  String get locationServiceNotEnabled =>
      'Servizio di localizzazione non abilitato';

  @override
  String get enableLocationService =>
      'Abilita il servizio di localizzazione per usare questa funzione';

  @override
  String get goToSettings => 'Vai alle impostazioni';

  @override
  String get locationPermissionRequired =>
      'Permesso di localizzazione richiesto per questa funzione';

  @override
  String get locationPermissionDeniedPermanent =>
      'Permesso di localizzazione negato permanentemente. Abilitalo nelle impostazioni.';

  @override
  String get locationPermissionDenied => 'Permesso di localizzazione negato';

  @override
  String get gettingLocation => 'Ottenimento posizione...';

  @override
  String getLocationFailed(String error) {
    return 'Impossibile ottenere la posizione: $error';
  }

  @override
  String get currentLocation => 'Posizione attuale';

  @override
  String nearbyPlace(int index) {
    return 'Luogo vicino $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Circa $distance';
  }

  @override
  String get mapPreview => 'Anteprima mappa';

  @override
  String get searchLocation => 'Cerca posizione';

  @override
  String redPacketSent(String amount, String token) {
    return 'Inviata busta rossa di $amount $token';
  }

  @override
  String get transferDefault => 'Trasferimento';

  @override
  String transferSent(String amount, String token) {
    return 'Inviato trasferimento di $amount $token';
  }

  @override
  String pickFileFailed(String error) {
    return 'Selezione file fallita: $error';
  }

  @override
  String get fileSizeLimit => 'Il file non può superare 50MB';

  @override
  String fileSending(String filename) {
    return 'Invio file: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Invio file fallito: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Inviata scheda contatto di $name';
  }

  @override
  String get favoritesFeature => 'Preferiti';

  @override
  String get couponsFeature => 'Coupon';

  @override
  String get giftFeature => 'Regalo';

  @override
  String sharedMusic(String name) {
    return 'Condiviso $name';
  }

  @override
  String get endPollTitle => 'Termina sondaggio';

  @override
  String get endPollConfirmMessage =>
      'Sei sicuro di voler terminare questo sondaggio? Le votazioni verranno chiuse.';

  @override
  String get pollEndedMessage => 'Sondaggio terminato';

  @override
  String get connectingCall => 'Connessione in corso...';

  @override
  String get muteCall => 'Silenzia';

  @override
  String get speakerOff => 'Altoparlante spento';

  @override
  String get speakerOn => 'Altoparlante';

  @override
  String get cameraOn => 'Fotocamera accesa';

  @override
  String get cameraOff => 'Fotocamera spenta';

  @override
  String get hangUp => 'Termina';

  @override
  String get selectForwardTargetTitle => 'Seleziona destinatario inoltro';

  @override
  String get noForwardableChat => 'Nessuna chat disponibile per l\'inoltro';

  @override
  String get noMatchingChat => 'Nessuna chat corrispondente trovata';

  @override
  String get imagePreview => '[Immagine]';

  @override
  String get voicePreview => '[Vocale]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[File] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Posizione] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Musica] $title';
  }

  @override
  String get messagePreview => '[Messaggio]';

  @override
  String get locationTitle => 'Posizione';

  @override
  String get sendButton => 'Invia';

  @override
  String get retryButton => 'Riprova';

  @override
  String get selectContact => 'Seleziona contatto';

  @override
  String get searchContactHint => 'Cerca contatti';

  @override
  String get shareMusic => 'Condividi musica';

  @override
  String get recentPlayed => 'Recenti';

  @override
  String get myFavorites => 'Preferiti';

  @override
  String get networkLink => 'Link';

  @override
  String get localFile => 'Locale';

  @override
  String get musicLinkRequired => 'Link musicale *';

  @override
  String get pasteMusicLink => 'Incolla link musicale';

  @override
  String get enterSongNamePlaceholder => 'Inserisci nome brano';

  @override
  String get enterArtistNamePlaceholder => 'Inserisci nome artista';

  @override
  String get shareMusicButton => 'Condividi musica';

  @override
  String get selectLocalAudio => 'Seleziona file audio locale';

  @override
  String get supportedAudioFormats => 'Supporta MP3, M4A, WAV, FLAC, ecc.';

  @override
  String get selectFileButton => 'Seleziona file';

  @override
  String get pleaseEnterMusicLink => 'Inserisci link musicale';

  @override
  String get pleaseEnterValidLink => 'Inserisci un URL valido';

  @override
  String get sharedSong => 'Brano condiviso';

  @override
  String get selectMember => 'Seleziona membro';

  @override
  String get searchMemberHint => 'Cerca membri';

  @override
  String get noMatchingMembers => 'Nessun membro corrispondente trovato';

  @override
  String get unknownMember => 'Sconosciuto';

  @override
  String selectedMessagesCount(int count) {
    return 'Selezionati $count messaggi';
  }

  @override
  String get searchContactsOrGroups => 'Cerca contatti o gruppi';

  @override
  String get noMatchingConversations =>
      'Nessuna conversazione corrispondente trovata';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Caricamento...';

  @override
  String get videoPlaybackFailed => 'Riproduzione video fallita';

  @override
  String get videoLoadFailed => 'Caricamento video fallito';

  @override
  String get playerInitFailed => 'Inizializzazione player fallita';

  @override
  String get createPollTitle => 'Crea sondaggio';

  @override
  String get submitPoll => 'Invia';

  @override
  String get pollQuestionLabel => 'Domanda sondaggio';

  @override
  String get enterPollQuestionHint => 'Inserisci domanda sondaggio';

  @override
  String get pollOptionsLabel => 'Opzioni sondaggio';

  @override
  String optionHintWithIndex(int index) {
    return 'Opzione $index';
  }

  @override
  String get addOptionButton => 'Aggiungi opzione';

  @override
  String get pollSettingsLabel => 'Impostazioni sondaggio';

  @override
  String get selectionType => 'Tipo selezione';

  @override
  String get singleChoiceLabel => 'Singola';

  @override
  String get multiChoiceLabel => 'Multipla';

  @override
  String get anonymousPollSwitch => 'Sondaggio anonimo';

  @override
  String get pleaseEnterQuestion => 'Inserisci domanda sondaggio';

  @override
  String get atLeastTwoOptions => 'Almeno 2 opzioni richieste';

  @override
  String confirmWithCount(int count) {
    return 'Conferma ($count)';
  }

  @override
  String get emailVerificationTitle => 'Verifica email';

  @override
  String get enterValidEmailAddress => 'Inserisci un indirizzo email valido';

  @override
  String verificationCodeSentTo(String email) {
    return 'Codice di verifica inviato a $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Invio codice fallito: $error';
  }

  @override
  String get verificationSuccess => 'Verifica riuscita';

  @override
  String get verificationFailed => 'Verifica fallita';

  @override
  String verificationCodeError(String error) {
    return 'Errore codice di verifica: $error';
  }

  @override
  String get enterVerificationCode => 'Inserisci codice di verifica';

  @override
  String get enterYourEmail => 'Inserisci email';

  @override
  String weSentCodeTo(String email) {
    return 'Abbiamo inviato un codice a 6 cifre a\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Inserisci il tuo indirizzo email, ti invieremo un codice di verifica';

  @override
  String get sendVerificationCode => 'Invia codice di verifica';

  @override
  String get resendVerificationCode => 'Reinvia codice di verifica';

  @override
  String canResendAfter(int seconds) {
    return 'Puoi reinviare tra $seconds secondi';
  }

  @override
  String get changeEmail => 'Cambia email';

  @override
  String get addToContacts => 'Aggiungi ai contatti';

  @override
  String get addingToContacts => 'Aggiungendo...';

  @override
  String get addedToContacts => 'Aggiunto ai contatti';

  @override
  String addFailedWithError(String error) {
    return 'Aggiunta fallita: $error';
  }

  @override
  String get addPhone => 'Aggiungi telefono';

  @override
  String get addTag => 'Aggiungi tag';

  @override
  String get addText => 'Aggiungi testo';

  @override
  String get addPhoto => 'Aggiungi foto';

  @override
  String groupCountLabel(int count) {
    return '$count gruppi';
  }

  @override
  String get addedViaSearch => 'Aggiunto tramite ricerca';

  @override
  String get addTime => 'Aggiungi ora';

  @override
  String get doneButton => 'Fatto';

  @override
  String get waitingForParticipants => 'In attesa di partecipanti...';

  @override
  String participantMe(String name) {
    return '$name (Io)';
  }

  @override
  String get sharingLabel => 'Condivisione';

  @override
  String screenSharingBy(String name) {
    return '$name sta condividendo lo schermo';
  }

  @override
  String participantCount(int count) {
    return '$count partecipanti';
  }

  @override
  String get muteLabel => 'Silenzia';

  @override
  String get unmuteLabel => 'Riattiva';

  @override
  String get turnOffVideo => 'Disattiva video';

  @override
  String get turnOnVideo => 'Attiva video';

  @override
  String get shareScreen => 'Condividi schermo';

  @override
  String get stopSharing => 'Interrompi condivisione';

  @override
  String get switchCameraLabel => 'Cambia';

  @override
  String get leaveLabel => 'Lascia';

  @override
  String get participantsLabel => 'Partecipanti';

  @override
  String get joiningMeeting => 'Entrando nella riunione...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count voti ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count partecipanti';
  }

  @override
  String get tapToRetry => 'Tocca per riprovare';

  @override
  String get noConversationsToForward => 'Nessuna conversazione da inoltrare';

  @override
  String get defaultRedPacketGreeting => 'Auguri di prosperità e fortuna';

  @override
  String get emojiCategoryFace => 'Faccine';

  @override
  String get emojiCategoryHeart => 'Cuori';

  @override
  String get emojiCategoryAnimal => 'Animali';

  @override
  String get emojiCategoryFood => 'Cibo';

  @override
  String get emojiCategoryTransport => 'Trasporti';

  @override
  String get emojiCategoryActivity => 'Attività';

  @override
  String get emojiCategoryObject => 'Oggetti';

  @override
  String get emojiCategorySymbol => 'Simboli';

  @override
  String get allowOthersToSearchAndJoin =>
      'Consenti ad altri di cercare e aderire';

  @override
  String get allowStrangerMessages => 'Consenti messaggi da sconosciuti';

  @override
  String get alwaysUseDarkTheme => 'Usa sempre tema scuro';

  @override
  String get alwaysUseLightTheme => 'Usa sempre tema chiaro';

  @override
  String get autoSwitchBySystem =>
      'Cambia automaticamente in base alle impostazioni di sistema';

  @override
  String get bubbleStyle => 'Stile fumetto';

  @override
  String get bubbleStyleClassic => 'Stile classico';

  @override
  String get bubbleStyleClassicDesc => 'Stile fumetto tradizionale';

  @override
  String get bubbleStyleModern => 'Stile moderno';

  @override
  String get bubbleStyleModernDesc => 'Stile fumetto moderno e pulito';

  @override
  String get bubbleStyleWechat => 'Stile WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Stile fumetto classico WeChat';

  @override
  String get callEnded => 'Chiamata terminata';

  @override
  String get callFailed => 'Chiamata fallita';

  @override
  String get checkForUpdates => 'Controlla aggiornamenti';

  @override
  String get confirmClearChatHistory =>
      'Sei sicuro di voler cancellare la cronologia chat?';

  @override
  String get createGroupToChat => 'Crea un gruppo per iniziare a chattare';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get darkModeOption => 'Modalità scura';

  @override
  String get doNotDisturbDescription =>
      'Non ricevere notifiche durante il periodo specificato';

  @override
  String get doNotDisturbMode => 'Non disturbare';

  @override
  String get editGroupAnnouncement => 'Modifica annuncio del gruppo';

  @override
  String get editGroupDescription => 'Modifica descrizione del gruppo';

  @override
  String get enterGroupAnnouncement => 'Inserisci l\'annuncio del gruppo';

  @override
  String errorWithMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Feedback e suggerimenti';

  @override
  String get followSystem => 'Segui sistema';

  @override
  String get fontSize => 'Dimensione carattere';

  @override
  String get fontSizeExtraLarge => 'Extra grande';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeSmall => 'Piccolo';

  @override
  String get fontSizeStandard => 'Standard';

  @override
  String get incomingVideoCall => 'Videochiamata in arrivo';

  @override
  String get incomingVoiceCall => 'Chiamata vocale in arrivo';

  @override
  String get letOthersKnowYouRead =>
      'Fai sapere agli altri che hai letto i loro messaggi';

  @override
  String get letOthersKnowYouTyping =>
      'Fai sapere agli altri che stai scrivendo';

  @override
  String get lightMode => 'Modalità chiara';

  @override
  String memberCountClickToCopy(int count) {
    return '$count membri, fai clic per copiare l\'ID del gruppo';
  }

  @override
  String get messageNotifications => 'Notifiche messaggi';

  @override
  String get messagesLabel => 'Messaggi';

  @override
  String get musicLinkLabel => 'Link musicale';

  @override
  String get noMediaUrlAvailable => 'URL multimediale non disponibile';

  @override
  String get noPermissionToEditGroupName =>
      'Non hai il permesso di modificare il nome del gruppo';

  @override
  String get receiveMessagesFromNonContacts =>
      'Ricevi messaggi da non-contatti';

  @override
  String get receiveNewMessageNotifications =>
      'Ricevi notifiche per nuovi messaggi';

  @override
  String get reconnectingCall => 'Riconnessione in corso...';

  @override
  String get redPacketTransferCannotForward =>
      'Le buste rosse e i trasferimenti non possono essere inoltrati';

  @override
  String get showMessageContentInNotification =>
      'Mostra contenuto del messaggio nelle notifiche';

  @override
  String get showMessagePreview => 'Mostra anteprima messaggio';

  @override
  String get typingIndicator => 'Indicatore di digitazione';

  @override
  String versionInfo(String version) {
    return 'Versione $version';
  }

  @override
  String get vibration => 'Vibrazione';

  @override
  String get videoCallInProgress => 'Videochiamata';

  @override
  String get voiceCallInProgress => 'Chiamata vocale';

  @override
  String whoCanSeeTitle(String title) {
    return 'Chi può vedere $title';
  }

  @override
  String get emailAddress => 'Indirizzo email';

  @override
  String get enterEmailAddress => 'Inserisci l\'indirizzo email';

  @override
  String get emailRecoveryHint => 'Usato per il recupero della password';

  @override
  String get invalidEmailFormat => 'Inserisci un indirizzo email valido';

  @override
  String get optional => 'Opzionale';

  @override
  String get resetPassword => 'Ripristina password';

  @override
  String get resetPasswordTitle => 'Ripristina la tua password';

  @override
  String get enterRegisteredEmail =>
      'Inserisci l\'indirizzo email con cui ti sei registrato';

  @override
  String get sendResetCode => 'Invia codice di ripristino';

  @override
  String resetCodeSent(String email) {
    return 'Codice di ripristino inviato a $email';
  }

  @override
  String get enterResetCode => 'Inserisci il codice di ripristino';

  @override
  String get setNewPassword => 'Imposta nuova password';

  @override
  String get confirmNewPassword => 'Conferma nuova password';

  @override
  String get newPassword => 'Nuova password';

  @override
  String get passwordResetSuccess =>
      'Password ripristinata con successo. Accedi con la tua nuova password.';

  @override
  String get resetPasswordFailed => 'Ripristino password fallito';

  @override
  String get changePassword => 'Cambia password';

  @override
  String get currentPassword => 'Password attuale';

  @override
  String get enterCurrentPassword => 'Inserisci la password attuale';

  @override
  String get enterNewPassword => 'Inserisci la nuova password';

  @override
  String get passwordChanged =>
      'Password cambiata con successo. Accedi con la tua nuova password.';

  @override
  String get changePasswordFailed => 'Cambio password fallito';

  @override
  String get incorrectCurrentPassword => 'Password attuale errata';

  @override
  String get newPasswordMustBeDifferent =>
      'La nuova password deve essere diversa dalla password attuale';

  @override
  String get changePasswordInfo =>
      'Dopo aver cambiato la password, verrai disconnesso e dovrai accedere con la nuova password.';

  @override
  String get passwordRequirements => 'Requisiti della password:';

  @override
  String get securityNote =>
      'Per sicurezza, dovrai riaccedere su tutti i dispositivi dopo aver cambiato la password.';

  @override
  String get security => 'Sicurezza';

  @override
  String get currentBoundEmail => 'Email attualmente collegata';

  @override
  String get newEmailAddress => 'Nuovo indirizzo email';

  @override
  String get enterNewEmail => 'Inserisci il nuovo indirizzo email';

  @override
  String get verificationCode => 'Codice di verifica';

  @override
  String get verificationCodeSent => 'Codice di verifica inviato';

  @override
  String get codeSentTo => 'Codice di verifica inviato a';

  @override
  String get didNotReceiveCode => 'Non hai ricevuto il codice?';

  @override
  String get emailChangedSuccess => 'Email cambiata con successo';

  @override
  String get changeEmailFailed => 'Cambio email fallito';

  @override
  String get emailSecurityNote =>
      'La tua email viene usata per il recupero della password. Mantienila al sicuro.';

  @override
  String get googleLogin => 'Accedi con Google';

  @override
  String get appleLogin => 'Accedi con Apple';

  @override
  String get facebookLogin => 'Accedi con Facebook';

  @override
  String get twitterLogin => 'Accedi con Twitter';

  @override
  String get wechatLogin => 'Accedi con WeChat';

  @override
  String get wechat => 'WeChat';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get wechatNotInstalled => 'Installa prima WeChat';

  @override
  String get wechatLoginFailed => 'Accesso WeChat non riuscito';

  @override
  String get facebookLoginFailed => 'Accesso Facebook non riuscito';

  @override
  String get twitterLoginFailed => 'Accesso Twitter non riuscito';

  @override
  String get twitterNotConfigured => 'Accesso Twitter non configurato';

  @override
  String get socialLoginCancelled => 'Accesso annullato';

  @override
  String get socialLoginFailed => 'Accesso social fallito';

  @override
  String get language => 'Lingua';

  @override
  String get languageChanged => 'Lingua cambiata';

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
  String get n42BeanDetails => 'Dettagli N42 Bean';

  @override
  String get noN42Bean => 'Nessun N42 Bean';

  @override
  String get n42BeanDescription =>
      'N42 Bean è un token per riscattare oggetti virtuali e servizi in N42. Attualmente disponibile per:';

  @override
  String get n42BeanFeature1 => 'Sticker e temi esclusivi per membri';

  @override
  String get n42BeanFeature2 => 'Personalizzazione bolle di chat';

  @override
  String get n42BeanFeature3 => 'Personalizzazione copertine buste rosse';

  @override
  String get n42BeanFeature4 => 'Badge nickname esclusivo';

  @override
  String get n42BeanFeature5 => 'Privilegi chat di gruppo';

  @override
  String get n42BeanFeature6 => 'Espansione archiviazione cloud';

  @override
  String get n42BeanFeature7 => 'Filtri bellezza videochiamata';

  @override
  String get n42BeanFeature8 => 'Personalizzazione sfondo Moments';

  @override
  String get n42BeanFeature9 => 'Priorità servizio clienti VIP';

  @override
  String get gotIt => 'Ho capito';

  @override
  String get noN42BeanRecords => 'Nessun registro N42 Bean';

  @override
  String get cameraPermissionRestricted =>
      'L\'accesso alla fotocamera è limitato su questo dispositivo';

  @override
  String get passkeyLabel => 'Passkey';

  @override
  String get googleLabel => 'Google';

  @override
  String get appleLabel => 'Apple';

  @override
  String get ssoLabel => 'SSO';

  @override
  String get amountHintZero => '0.00';

  @override
  String get matrixIdHint => '@username:server.com';

  @override
  String get serverAddressHint => 'https://m.si46.world';

  @override
  String get emailExampleHint => 'example@email.com';

  @override
  String get verificationCodePlaceholder => '------';

  @override
  String get enterPokeSuffixHint => '输入戳一戳后缀，例如：的肩膀';
}
