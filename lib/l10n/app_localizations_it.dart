// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class SIt extends S {
  SIt([String locale = 'it']) : super(locale);

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonUnknownUser => 'Utente sconosciuto';

  @override
  String get transferWalletNotConnected => 'Wallet non connesso';

  @override
  String get chatCallServiceNotInitialized =>
      'Servizio chiamate non inizializzato';

  @override
  String authLoginFailed(String error) {
    return 'Login fallito: $error';
  }

  @override
  String get chatCallBack => 'Richiama';

  @override
  String get chatMissedVideoCall => 'Videochiamata persa';

  @override
  String get chatMissedVoiceCall => 'Chiamata vocale persa';

  @override
  String get chatCallNotAnswered => 'Senza risposta';

  @override
  String get chatCallDurationLabel => 'Durata della chiamata';

  @override
  String get chatVoiceCallCancelled => 'Chiamata vocale annullata';

  @override
  String get chatVideoCallCancelled => 'Videochiamata annullata';

  @override
  String get commonImage => '[Immagine]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Vocale]';

  @override
  String get commonFile => '[File]';

  @override
  String get chatLocation => '[Posizione]';

  @override
  String get chatUnknownMessage => '[Messaggio sconosciuto]';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get chatDeleteThisMessage => 'Eliminare questo messaggio?';

  @override
  String get chatMessageDeleted => 'Messaggio eliminato';

  @override
  String get profileNotLoggedIn => 'Non connesso';

  @override
  String get chatMyLocation => 'La mia posizione';

  @override
  String get commonGroupChat => 'Chat di gruppo';

  @override
  String get commonSearch => 'Cerca';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonLoadFailed => 'Caricamento fallito';

  @override
  String get commonMessages => 'Messaggi';

  @override
  String get commonContacts => 'Contatti';

  @override
  String get commonMe => 'Io';

  @override
  String get commonVoiceLoading => 'Caricamento vocale, riprova più tardi';

  @override
  String get commonVoiceToTextFailed => 'Conversione vocale fallita';

  @override
  String get commonConvertToText => 'In testo';

  @override
  String get chatCopy => 'Copia';

  @override
  String get commonForward => 'Inoltra';

  @override
  String get commonUnfavorite => 'Rimuovi preferito';

  @override
  String get commonFavorite => 'Preferito';

  @override
  String get settingsResend => 'Rinvia';

  @override
  String get chatRecall => 'Ritira';

  @override
  String get commonQuote => 'Cita';

  @override
  String get commonRemind => 'Menziona';

  @override
  String get chatCopied => 'Copiato';

  @override
  String get storySendMessageHint => 'Scrivi un messaggio';

  @override
  String get commonMicrophonePermissionRequired =>
      'Consenti l\'accesso al microfono';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Impossibile avviare la registrazione: $error';
  }

  @override
  String get commonRecordingTooShort => 'Registrazione troppo breve';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Impossibile interrompere la registrazione: $error';
  }

  @override
  String get chatReleaseToCancel => 'Rilascia per annullare';

  @override
  String get chatReleaseToSend =>
      'Rilascia per inviare, scorri in alto per annullare';

  @override
  String get commonHoldToTalk => 'Tieni premuto per parlare';

  @override
  String get commonSend => 'Invia';

  @override
  String get commonAddFriend => 'Aggiungi amico';

  @override
  String get commonChatServiceNotConnected => 'Servizio chat non connesso';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Utente \"$query\" non trovato\n\nSuggerimenti:\n• Prova a inserire l\'ID utente completo, es. @nomeutente:server.com\n• Controlla l\'ortografia del nome utente';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Impossibile creare la chat: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Ricerca fallita: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Inserisci ID utente o nome utente per cercare';

  @override
  String get contactSearching => 'Ricerca in corso...';

  @override
  String get contactSearchUserToChat => 'Cerca utente per iniziare a chattare';

  @override
  String get contactMatrixIdExample =>
      'Puoi inserire un ID Matrix completo\nes. @utente:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Utente \"$username\" non trovato';
  }

  @override
  String get commonChat => 'Chat';

  @override
  String get commonSettings => 'Impostazioni';

  @override
  String get profileEditProfile => 'Modifica profilo';

  @override
  String get authLogin => 'Accedi';

  @override
  String get commonCreateGroup => 'Crea gruppo';

  @override
  String get chatError => 'Errore';

  @override
  String get commonTransfer => 'Trasferimento';

  @override
  String get commonReceived => 'Ricevuto';

  @override
  String get commonRefunded => 'Rimborsato';

  @override
  String get commonExpired => 'Scaduto';

  @override
  String get chatRedPacketGreeting => 'Auguri';

  @override
  String get commonN42RedPacket => 'Busta rossa N42';

  @override
  String get commonClaimed => 'Riscosso';

  @override
  String get commonAllClaimed => 'Tutto riscosso';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Rispondi';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get chatSelectForwardTarget => 'Seleziona destinatario';

  @override
  String commonSendCount(int count) {
    return 'Invia ($count)';
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
  String get contactFriendInfo => 'Info amico';

  @override
  String get contactFriendInfoDesc =>
      'Aggiungi note, telefono, tag, appunti, foto e imposta permessi.';

  @override
  String get commonMoments => 'Momenti';

  @override
  String get commonSendMessage => 'Messaggio';

  @override
  String get contactAudioVideoCall => 'Chiamata audio/video';

  @override
  String get contactVideoChannel => 'Canale video';

  @override
  String get contactRemark => 'Nota';

  @override
  String get contactRemarkName => 'Nome nota';

  @override
  String get contactPhone => 'Telefono';

  @override
  String get contactTags => 'Tag';

  @override
  String get contactNotes => 'Note';

  @override
  String get contactPhotos => 'Foto';

  @override
  String get contactPermissions => 'Permessi';

  @override
  String get contactChatMomentsEtc => 'Chat, Momenti, Sport, ecc.';

  @override
  String get contactMoreInfo => 'Altre info';

  @override
  String get contactCommonGroups => 'Gruppi in comune';

  @override
  String get contactSource => 'Origine';

  @override
  String get settingsNotificationSettings => 'Notifiche';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsAppearance => 'Aspetto';

  @override
  String get settingsAbout => 'Informazioni';

  @override
  String get commonLogout => 'Esci';

  @override
  String get commonLogoutConfirm => 'Sei sicuro di voler uscire?';

  @override
  String get commonSave => 'Salva';

  @override
  String get profileNickname => 'Nickname';

  @override
  String get profileEnterNickname => 'Inserisci nickname';

  @override
  String get profileSignature => 'Firma';

  @override
  String get profileAddSignature => 'Aggiungi una firma';

  @override
  String get commonTakePhoto => 'Scatta foto';

  @override
  String get profileChooseFromGallery => 'Scegli dalla galleria';

  @override
  String profileSaveFailed(String error) {
    return 'Salvataggio fallito: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Messaggistica sicura e decentralizzata';

  @override
  String get commonEndToEndEncryption => 'Crittografia end-to-end';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Messaggi visibili solo a te e al destinatario';

  @override
  String get authDecentralized => 'Decentralizzato';

  @override
  String get authBasedOnMatrix => 'Basato sul protocollo aperto Matrix';

  @override
  String get authWalletIntegration => 'Integrazione wallet';

  @override
  String get authEasyCryptoTransfer => 'Trasferimenti crypto facili';

  @override
  String get authRegister => 'Registrati';

  @override
  String get authAgreeTerms => 'Accedendo, accetti';

  @override
  String get authTermsOfService => 'Termini di servizio';

  @override
  String get authAnd => 'e';

  @override
  String get authPrivacyPolicy => 'Informativa sulla privacy';

  @override
  String get authServerAddress => 'Indirizzo server';

  @override
  String get authEnterServerAddress => 'Inserisci indirizzo server';

  @override
  String authConnectedTo(String serverName) {
    return 'Connesso a $serverName';
  }

  @override
  String get authUsername => 'Nome utente';

  @override
  String get authEnterUsername => 'Inserisci nome utente';

  @override
  String get authUsernameOrEmail => 'Nome utente o Email';

  @override
  String get authEnterUsernameOrEmail => 'Inserisci nome utente o email';

  @override
  String get authPassword => 'Password';

  @override
  String get authEnterPassword => 'Inserisci password';

  @override
  String get authRegisterAccount => 'Registrati';

  @override
  String get authForgotPassword => 'Password dimenticata';

  @override
  String get authOtherLoginMethods => 'Altri metodi di accesso';

  @override
  String get authCreateAccount => 'Crea account';

  @override
  String get authJoinN42Chat => 'Unisciti a N42 Chat per iniziare a chattare';

  @override
  String get authUsernameHint => '3-20 caratteri, lettere/numeri/_';

  @override
  String get authUsernameMinLength =>
      'Il nome utente deve avere almeno 3 caratteri';

  @override
  String get authUsernameMaxLength =>
      'Il nome utente deve avere massimo 20 caratteri';

  @override
  String get authUsernameFormat =>
      'Il nome utente può contenere solo lettere, numeri e underscore';

  @override
  String get authPasswordHint => 'Minimo 8 caratteri';

  @override
  String get commonPasswordMinLength =>
      'La password deve avere almeno 8 caratteri';

  @override
  String get authConfirmPassword => 'Conferma password';

  @override
  String get authFilled => 'Compilato';

  @override
  String get authEnterInviteCode => 'Inserisci codice invito';

  @override
  String get authAlreadyHaveAccount => 'Hai già un account?';

  @override
  String get authLoginNow => 'Accedi ora';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Stato';

  @override
  String get commonLoading => 'Caricamento...';

  @override
  String get conversationNoConversations => 'Nessuna conversazione';

  @override
  String get conversationTapToChat =>
      'Tocca in alto a destra per iniziare a chattare';

  @override
  String get conversationStartGroup => 'Inizia chat di gruppo';

  @override
  String get commonScan => 'Scansiona';

  @override
  String get commonPayment => 'Pagamento';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature prossimamente';
  }

  @override
  String get conversationMarkAsRead => 'Segna come letto';

  @override
  String get commonUnmute => 'Riattiva';

  @override
  String get commonMute => 'Silenzia';

  @override
  String get conversationUnpin => 'Rimuovi fissato';

  @override
  String get conversationPin => 'Fissa';

  @override
  String get conversationDeleteConversation => 'Elimina conversazione';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Eliminare la conversazione con \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Nessun contatto';

  @override
  String get contactAddFriendsToChat =>
      'Aggiungi amici per iniziare a chattare';

  @override
  String get contactNotFound => 'Contatto non trovato';

  @override
  String get contactTryOtherKeywords =>
      'Prova altre parole chiave o cerca globalmente';

  @override
  String get contactSearchResults => 'Risultati ricerca';

  @override
  String get contactNewFriends => 'Nuovi amici';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Account ufficiali';

  @override
  String get contactServiceAccounts => 'Account di servizio';

  @override
  String get contactEnterpriseContacts => 'Contatti aziendali';

  @override
  String get contactRecommendToFriend => 'Condividi contatto';

  @override
  String get commonSetRemark => 'Imposta nota';

  @override
  String get contactSendingCard => 'Invio scheda contatto...';

  @override
  String get commonFileLabel => 'File';

  @override
  String get commonLocationLabel => 'Posizione';

  @override
  String contactRecommendFailed(String error) {
    return 'Raccomandazione fallita: $error';
  }

  @override
  String get profileEnterRemark => 'Inserisci nota';

  @override
  String get contactOpeningChat => 'Apertura chat...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Impossibile aprire la chat: $error';
  }

  @override
  String get contactAddContact => 'Aggiungi contatto';

  @override
  String get contactEnterUserId => 'Inserisci ID utente';

  @override
  String get contactNoFriendRequests => 'Nessuna richiesta di amicizia';

  @override
  String get commonAccept => 'Accetta';

  @override
  String get commonReject => 'Rifiuta';

  @override
  String get commonNoGroups => 'Nessun gruppo';

  @override
  String get contactSelectFriendToRecommend =>
      'Seleziona un amico a cui raccomandare';

  @override
  String get commonSearchContacts => 'Cerca contatti';

  @override
  String get contactNoContactsFound => 'Nessun contatto trovato';

  @override
  String get favoriteYesterday => 'Ieri';

  @override
  String get chatJustNow => 'Adesso';

  @override
  String get profileOnline => 'Online';

  @override
  String get profileOffline => 'Offline';

  @override
  String get searchContactsGroupsMessages => 'Cerca contatti, gruppi, messaggi';

  @override
  String get searchError => 'Errore ricerca';

  @override
  String get chatSearchHint => 'Cerca contatti, gruppi e messaggi';

  @override
  String get searchHistory => 'Cronologia ricerche';

  @override
  String get commonClear => 'Cancella';

  @override
  String get commonAll => 'Tutto';

  @override
  String get searchGroups => 'Gruppi';

  @override
  String get searchNoResults => 'Nessun risultato';

  @override
  String commonGroupMembers(int count) {
    return 'Membri ($count)';
  }

  @override
  String get groupMembersTitle => 'Membri del gruppo';

  @override
  String get groupViewAll => 'Vedi tutti';

  @override
  String get groupOwner => 'Proprietario';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Invita';

  @override
  String get commonGroupAnnouncement => 'Annuncio gruppo';

  @override
  String get commonNotSet => 'Non impostato';

  @override
  String get groupDescription => 'Descrizione gruppo';

  @override
  String get groupPublicGroup => 'Gruppo pubblico';

  @override
  String get commonClearChatHistory => 'Cancella cronologia chat';

  @override
  String get commonDissolveGroup => 'Sciogli gruppo';

  @override
  String get commonLeaveGroup => 'Lascia gruppo';

  @override
  String get groupChangeGroupName => 'Cambia nome gruppo';

  @override
  String get commonEnterGroupName => 'Inserisci nome gruppo';

  @override
  String get commonConfirm => 'Conferma';

  @override
  String get groupEnterGroupDescription => 'Inserisci descrizione gruppo';

  @override
  String get groupPublish => 'Pubblica';

  @override
  String get chatClearHistoryConfirm =>
      'Cancellare tutta la cronologia chat? Questa azione non può essere annullata.';

  @override
  String get chatClearAction => 'Cancella';

  @override
  String get commonChatHistoryCleared => 'Cronologia chat cancellata';

  @override
  String get commonDissolve => 'Sciogli';

  @override
  String get groupQrCode => 'QR Code gruppo';

  @override
  String get commonSearchChatHistory => 'Cerca nella cronologia chat';

  @override
  String get groupIdCopied => 'ID gruppo copiato';

  @override
  String get transferEnterOrPasteAddress =>
      'Inserisci o incolla indirizzo wallet';

  @override
  String get transferSelectToken => 'Seleziona token';

  @override
  String get commonTransferAmount => 'Importo trasferimento';

  @override
  String get transferAvailable => 'Disponibile';

  @override
  String get transferMemoOptional => 'Nota (opzionale)';

  @override
  String get transferConfirmTransfer => 'Conferma trasferimento';

  @override
  String get transferAddressVerified => 'Indirizzo verificato';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Disponibile: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Inserisci importo';

  @override
  String get commonRedPacketCountMin => 'Almeno 1 busta rossa richiesta';

  @override
  String get commonViewRedPacketDetails => 'Visualizza dettagli busta rossa';

  @override
  String get commonEnterTransferAmount => 'Inserisci importo trasferimento';

  @override
  String get commonTransferTo => 'Trasferisci a';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'Da $senderName';
  }

  @override
  String get commonConfirmReceive => 'Conferma ricezione';

  @override
  String get groupProfile => 'Info gruppo';

  @override
  String get groupRemoveMember => 'Rimuovi dal gruppo';

  @override
  String get commonRemove => 'Rimuovi';

  @override
  String get profileClearStatus => 'Cancella stato';

  @override
  String get profileClearStatusConfirm => 'Cancellare lo stato attuale?';

  @override
  String get profileStatusCleared => 'Stato cancellato';

  @override
  String get profileUserNotExist => 'L\'utente non esiste';

  @override
  String get profileUserIdCopied => 'ID utente copiato';

  @override
  String get commonReport => 'Segnala';

  @override
  String get profileQrCode => 'QR Code';

  @override
  String get profileAvatarUpdated => 'Avatar aggiornato';

  @override
  String commonSelectImageFailed(String error) {
    return 'Selezione immagine fallita: $error';
  }

  @override
  String get profileChangeName => 'Cambia nome';

  @override
  String get profileMale => 'Maschio';

  @override
  String get profileFemale => 'Femmina';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature in sviluppo...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Salvataggio indirizzo fallito: $error';
  }

  @override
  String get profileAddNew => 'Aggiungi';

  @override
  String get profileAddAddress => 'Aggiungi indirizzo';

  @override
  String get profileAddressAdded => 'Indirizzo aggiunto';

  @override
  String get profileAddressUpdated => 'Indirizzo aggiornato';

  @override
  String get profileDeleteAddress => 'Elimina indirizzo';

  @override
  String get profileAddressDeleted => 'Indirizzo eliminato';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Salvataggio fattura fallito: $error';
  }

  @override
  String get profileMyInvoices => 'Le mie fatture';

  @override
  String get profileAddInvoice => 'Aggiungi fattura';

  @override
  String get profileInvoiceAdded => 'Fattura aggiunta';

  @override
  String get profileInvoiceUpdated => 'Fattura aggiornata';

  @override
  String get profileDeleteInvoice => 'Elimina fattura';

  @override
  String get profileInvoiceDeleted => 'Fattura eliminata';

  @override
  String get profilePersonal => 'Personale';

  @override
  String get groupSelectAtLeastOne => 'Seleziona almeno un membro';

  @override
  String get chatFileNotExist => 'Il file non esiste';

  @override
  String chatSendFailed(String error) {
    return 'Invio fallito: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Impossibile aprire il browser';

  @override
  String chatSelectFileFailed(String error) {
    return 'Selezione file fallita: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Configurazione fallita: $error';
  }

  @override
  String get transferEnterValidAmount => 'Inserisci un importo valido';

  @override
  String get commonAddressCopied => 'Indirizzo copiato';

  @override
  String favoriteOpenItem(String content) {
    return 'Apri: $content';
  }

  @override
  String get favoriteDeleted => 'Eliminato';

  @override
  String get profileWallet => 'Wallet';

  @override
  String get chatRecording => 'Registrazione';

  @override
  String get chatInvalidVideoUrl => 'URL video non valido';

  @override
  String get chatDownloadFile => 'Scarica file';

  @override
  String get chatClearChatHistoryTitle => 'Cancella cronologia chat';

  @override
  String get chatVideoCall => 'Videochiamata';

  @override
  String get commonVoiceCall => 'Chiamata vocale';

  @override
  String get callLeaveMeeting => 'Lascia riunione';

  @override
  String get chatDetails => 'Dettagli chat';

  @override
  String get chatViewAllGroupMembers => 'Vedi tutti i membri';

  @override
  String get chatGroupName => 'Nome gruppo';

  @override
  String get chatGroupNameUpdated => 'Nome gruppo aggiornato';

  @override
  String get chatUpdateFailed => 'Aggiornamento fallito';

  @override
  String get chatNoPermissionToModify => 'Non hai i permessi per modificare';

  @override
  String get chatGroupManagement => 'Gestione gruppo';

  @override
  String get chatMyNicknameInGroup => 'Il mio nickname nel gruppo';

  @override
  String get chatPinChat => 'Fissa chat';

  @override
  String get chatStrongReminder => 'Promemoria importante';

  @override
  String get chatSetChatBackground => 'Imposta sfondo chat';

  @override
  String get chatUnknownFile => 'File sconosciuto';

  @override
  String get chatDownload => 'Scarica';

  @override
  String get chatInvalidLocation => 'Posizione non valida';

  @override
  String get chatTapToCancel => 'Tocca per annullare';

  @override
  String chatCaptureFailed(Object error) {
    return 'Cattura fallita: $error';
  }

  @override
  String get chatProcessingVideo => 'Elaborazione video...';

  @override
  String get chatVideoFileNotExist => 'Il file video non esiste';

  @override
  String get chatVideoDataEmpty => 'I dati video sono vuoti';

  @override
  String get chatVideoTooLarge => 'Il video non può superare 100MB';

  @override
  String get chatSendingVideo => 'Invio video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Invio video fallito: $error';
  }

  @override
  String get chatImageFileNotExist => 'Il file immagine non esiste';

  @override
  String get commonImageDataEmpty => 'I dati immagine sono vuoti';

  @override
  String get chatSendingImage => 'Invio immagine...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Invio immagine fallito: $error';
  }

  @override
  String get chatSendLocation => 'Invia posizione';

  @override
  String get chatSelectLocationAndSend => 'Seleziona posizione e invia';

  @override
  String get chatShareRealTimeLocation => 'Condividi posizione in tempo reale';

  @override
  String get chatShareLocationForOneHour =>
      'Condividi posizione in tempo reale con l\'amico per 1 ora';

  @override
  String get chatLocationSent => 'Posizione inviata';

  @override
  String get chatSelectMessages => 'Seleziona messaggi';

  @override
  String chatSelectedCount(int count) {
    return 'Selezionati $count';
  }

  @override
  String get chatSelectAll => 'Seleziona tutto';

  @override
  String chatGroupChatCount(int count) {
    return 'Chat di gruppo ($count)';
  }

  @override
  String get chatPrivateChat => 'Chat privata';

  @override
  String get chatNoMessages => 'Nessun messaggio';

  @override
  String get chatSendFirstMessage =>
      'Invia il primo messaggio per iniziare a chattare';

  @override
  String get chatEncryptionNotice =>
      'Questa chat è crittografata end-to-end. Solo tu e il destinatario potete leggere i messaggi.';

  @override
  String get chatMultiForward => 'Inoltra';

  @override
  String get chatCollect => 'Salva';

  @override
  String get chatNoMembers => 'Nessun membro';

  @override
  String get chatMemberNotFound => 'Membro non trovato';

  @override
  String get chatVoiceFileNotExist => 'Il file vocale non esiste';

  @override
  String get chatVoiceFileEmpty => 'Il file vocale è vuoto';

  @override
  String get chatSendingVoice => 'Invio vocale...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Invio vocale fallito: $error';
  }

  @override
  String get chatMessageForwarded => 'Messaggio inoltrato';

  @override
  String chatForwardFailed(Object error) {
    return 'Inoltro fallito: $error';
  }

  @override
  String get chatUnfavorited => 'Rimosso dai preferiti';

  @override
  String get chatFavorited => 'Aggiunto ai preferiti';

  @override
  String get chatReactionAdded => 'Reazione aggiunta';

  @override
  String get chatReactionRemoved => 'Reazione rimossa';

  @override
  String get chatFailedMessageDeleted => 'Messaggio fallito eliminato';

  @override
  String get chatDeleteMessages => 'Elimina messaggi';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Sei sicuro di voler eliminare $count messaggi?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Nota: $count messaggi sono di altri e saranno eliminati solo per te.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count messaggi tuoi verranno ritirati per tutti.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Ritirati $count messaggi, $localCount eliminati solo per te';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Ritirati $count messaggi';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count messaggi eliminati solo per te';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Inoltrati $count messaggi';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Inoltro completato: $success riusciti, $failed falliti';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'La funzione menziona è disponibile solo nelle chat di gruppo';

  @override
  String get chatOnlyTextSearchable =>
      'Solo i messaggi di testo possono essere cercati';

  @override
  String chatSearchFor(Object text) {
    return 'Cerca \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Cerca su Baidu';

  @override
  String get chatGoogleSearch => 'Cerca su Google';

  @override
  String get chatBingSearch => 'Cerca su Bing';

  @override
  String get chatCalling => 'Chiamata in corso...';

  @override
  String get chatRinging => 'Squillando...';

  @override
  String get chatInCall => 'In chiamata';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Funzionalità in sviluppo...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Salvati $count messaggi';
  }

  @override
  String commonMemberCount(int count) {
    return '$count membri';
  }

  @override
  String groupDone(int count) {
    return 'Fatto($count)';
  }

  @override
  String get profileServices => 'Servizi';

  @override
  String get commonFavorites => 'Preferiti';

  @override
  String get profileOrdersAndCards => 'Ordini e carte';

  @override
  String get profileStickers => 'Sticker';

  @override
  String profileStatusSetTo(String status) {
    return 'Stato impostato: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Caricamento avatar fallito';

  @override
  String get profilePersonalProfile => 'Profilo personale';

  @override
  String get profileName => 'Nome';

  @override
  String get profileGender => 'Genere';

  @override
  String get profileRegion => 'Regione';

  @override
  String get commonMyQrCode => 'Il mio QR Code';

  @override
  String get profilePoke => 'Tocco';

  @override
  String get profileRingtone => 'Suoneria';

  @override
  String get profileDefaultRingtone => 'Suoneria predefinita';

  @override
  String get profileMyAddresses => 'I miei indirizzi';

  @override
  String profileGenderSetTo(String gender) {
    return 'Genere impostato: $gender';
  }

  @override
  String get profileSelectRegion => 'Seleziona regione';

  @override
  String get profileSelectCity => 'Seleziona città';

  @override
  String profileRegionSetTo(String region) {
    return 'Regione impostata: $region';
  }

  @override
  String get profileSetPoke => 'Imposta tocco';

  @override
  String get profileFriendPokedMe => 'L\'amico mi ha toccato';

  @override
  String get profileExample => 'Esempio';

  @override
  String get profileOnTheShoulder => ' sulla spalla';

  @override
  String get profilePokeCleared => 'Tocco cancellato';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Tocco impostato: mi ha toccato$suffix';
  }

  @override
  String get profileEditSignature => 'Modifica firma';

  @override
  String get profileIntroduceYourself => 'Una frase per presentarti';

  @override
  String get profileSignatureCleared => 'Firma cancellata';

  @override
  String get profileSignatureUpdated => 'Firma aggiornata';

  @override
  String get profileScanToAddFriend =>
      'Scansiona il QR code qui sopra per aggiungermi come amico';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Suoneria impostata: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Sei sicuro di voler sciogliere \"$name\"? Questa azione non può essere annullata.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Inserisci un indirizzo server valido';

  @override
  String get authEmailOtp => 'OTP email';

  @override
  String get authEnterServerAddressFirst =>
      'Inserisci prima l\'indirizzo del server';

  @override
  String get authPasskeyRequiresServer =>
      'L\'accesso con passkey richiede supporto del server';

  @override
  String get authLoginAgreement => 'Accedendo, accetti ';

  @override
  String get authPleaseAgreeToTerms =>
      'Leggi e accetta i Termini di servizio e l\'Informativa sulla privacy';

  @override
  String get authRegisterFailed => 'Registrazione fallita';

  @override
  String get commonReenterPassword => 'Reinserisci password';

  @override
  String get commonPasswordsDoNotMatch => 'Le password non coincidono';

  @override
  String get authInviteCodeBuiltIn => 'Codice invito (integrato)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Il codice invito è integrato, solitamente non serve modificarlo';

  @override
  String get authIHaveReadAndAgree => 'Ho letto e accetto ';

  @override
  String get mainStartGroupChat => 'Inizia chat di gruppo';

  @override
  String get mainAddFriends => 'Aggiungi amici';

  @override
  String get mainPaymentAndCollection => 'Pagamento';

  @override
  String contactCount(int count) {
    return '$count contatti';
  }

  @override
  String get contactAddToHomeScreen => 'Aggiungi alla home';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Scheda di $contact raccomandata a $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Inserisci nome nota';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Nota impostata: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Accettata richiesta di amicizia di $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Rifiutata richiesta di amicizia di $name';
  }

  @override
  String get commonGroupInvites => 'Inviti gruppo';

  @override
  String commonMyGroups(int count) {
    return 'I miei gruppi ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Invitato a unirsi al gruppo';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Sei sicuro di voler lasciare \"$name\"?';
  }

  @override
  String get commonLeave => 'Lascia';

  @override
  String get commonRecallThisMessage => 'Ritirare questo messaggio?';

  @override
  String get commonSavedToGallery => 'Salvato nella galleria';

  @override
  String get commonFailedToSave => 'Salvataggio fallito';

  @override
  String get chatSaving => 'Salvataggio...';

  @override
  String get commonShare => 'Condividi';

  @override
  String get chatSaveToGallery => 'Salva nella galleria';

  @override
  String chatDownloadFailed(String code) {
    return 'Download fallito: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Condivisione fallita: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Caricamento immagine fallito';

  @override
  String get chatVideoRecordingFailed =>
      'Registrazione video fallita. Riprova.';

  @override
  String get profileRedPacket => 'Busta rossa';

  @override
  String get commonMusic => 'Musica';

  @override
  String get commonCoupon => 'Coupon';

  @override
  String get commonGift => 'Regalo';

  @override
  String get commonPoll => 'Sondaggio';

  @override
  String get favoriteText => 'Testo';

  @override
  String get favoriteLinkLabel => 'Link';

  @override
  String get favoriteNote => 'Nota';

  @override
  String get favoriteMyNotes => 'Le mie note';

  @override
  String get favoriteToday => 'Oggi';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count giorni fa';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Nessun preferito';

  @override
  String get favoriteLongPressToFavorite =>
      'Tieni premuto un messaggio per aggiungerlo ai preferiti';

  @override
  String get favoriteNewNote => 'Nuova nota';

  @override
  String get favoriteLink => 'Link preferito';

  @override
  String get favoriteEditTags => 'Modifica tag';

  @override
  String get favoriteDeleteFavorite => 'Elimina preferito';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Sei sicuro di voler eliminare questo preferito?';

  @override
  String get favoriteNoSearchResultsFound => 'Nessun risultato trovato';

  @override
  String get commonSendRedPacket => 'Invia busta rossa';

  @override
  String get transferAmount => 'Importo';

  @override
  String get commonRedPacketCover => 'Copertina busta rossa';

  @override
  String get commonRedPacketType => 'Tipo busta rossa';

  @override
  String get commonNormalRedPacket => 'Normale';

  @override
  String get commonLuckyRedPacket => 'Fortunato';

  @override
  String get commonRedPacketCount => 'Numero buste rosse';

  @override
  String get commonPieces => 'pezzi';

  @override
  String get commonPutMoneyInRedPacket => 'Metti soldi nella busta rossa';

  @override
  String get commonRedPacketRefundNotice =>
      'Le buste rosse non riscosse verranno rimborsate dopo 24 ore';

  @override
  String get commonOpenRedPacket => 'Apri';

  @override
  String get commonRedPacketAllClaimed => 'Busta rossa completamente riscossa';

  @override
  String get commonRedPacketExpired => 'Busta rossa scaduta';

  @override
  String get commonAddTransferNote => 'Aggiungi nota trasferimento';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'Rispondi con questa emoji';

  @override
  String get contactEditRemark => 'Modifica nota';

  @override
  String get contactSetPermissions => 'Imposta permessi';

  @override
  String get profileAddToBlacklist => 'Aggiungi alla lista nera';

  @override
  String get contactDeleteContact => 'Elimina contatto';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Sei sicuro di voler eliminare $name?';
  }

  @override
  String get transferTitle => 'Trasferimento';

  @override
  String get transferReceiverAddressLabel => 'Indirizzo destinatario';

  @override
  String get transferSelectTokenLabel => 'Seleziona token';

  @override
  String get transferAmountLabel => 'Importo trasferimento';

  @override
  String get transferMemoLabel => 'Nota (opzionale)';

  @override
  String get transferAddMemoHint => 'Aggiungi una nota';

  @override
  String get transferSendPaymentRequest => 'Invia richiesta pagamento';

  @override
  String get transferQrCodeGenerateFailed => 'Generazione QR code fallita';

  @override
  String get transferScanQrToPayMe => 'Scansiona il QR code per pagarmi';

  @override
  String get transferMyWalletAddress => 'Il mio indirizzo wallet';

  @override
  String get transferCreatePaymentRequest => 'Crea richiesta pagamento';

  @override
  String profileN42IdLabel(String id) {
    return 'ID N42: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Auguri';

  @override
  String commonSenderRedPacket(String name) {
    return 'Busta rossa di $name';
  }

  @override
  String get transferEnterValidAddress => 'Inserisci un indirizzo valido';

  @override
  String get transferPleaseSelectToken => 'Seleziona un token';

  @override
  String get commonReceivedTransfer => 'Trasferimento ricevuto';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name ha inviato una busta rossa';
  }

  @override
  String get commonSavedToBalance =>
      'Salvato nel saldo, puoi trasferire direttamente';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Busta rossa scaduta/completamente riscossa';

  @override
  String get transferScanFeatureComingSoon => 'Funzione scansione in arrivo...';

  @override
  String get contactSetAsStarred => 'Imposta come preferito';

  @override
  String get contactAddToBlocklist => 'Aggiungi alla lista bloccati';

  @override
  String get commonClaimedYour => ' ha riscosso la tua ';

  @override
  String get commonClaimedText => ' ha riscosso ';

  @override
  String commonUserTyping(String name) {
    return '$name sta scrivendo...';
  }

  @override
  String get commonTyping => 'Sta scrivendo...';

  @override
  String get commonWaitingToReceive => 'In attesa di ricevere';

  @override
  String get commonTapToClaim => 'Tocca per riscuotere';

  @override
  String get commonHasBeenReceived => 'È stato ricevuto';

  @override
  String get commonGetLucky => 'Buona fortuna';

  @override
  String get qrcodeCameraStartFailed => 'Avvio fotocamera fallito';

  @override
  String get qrcodeUnknownError => 'Errore sconosciuto';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Posiziona il QR code nel riquadro per scansionare';

  @override
  String get qrcodeCloseManualInput => 'Chiudi inserimento manuale';

  @override
  String get qrcodeManualInputUserId => 'Inserimento manuale ID utente';

  @override
  String get commonAdd => 'Aggiungi';

  @override
  String get profileSetStatus => 'Imposta stato';

  @override
  String get profileVisibleToFriends24h => 'Visibile agli amici per 24 ore';

  @override
  String get profileWriteStatus => 'Scrivi stato';

  @override
  String get profileEnterYourStatus => 'Inserisci il tuo stato...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Permesso fotocamera richiesto per scansionare QR code';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Permesso fotocamera negato permanentemente. Abilitalo nelle impostazioni di sistema.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Errore verifica permesso: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'QR code non valido';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Impossibile aggiungere amico: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Scansiona QR Code';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Verifica permesso fotocamera...';

  @override
  String get qrcodeNeedCameraPermission => 'Permesso fotocamera richiesto';

  @override
  String get qrcodeRetryPermission => 'Riprova';

  @override
  String get qrcodeOpenSettings => 'Apri impostazioni';

  @override
  String get groupInviteMembers => 'Invita membri';

  @override
  String groupInviteCount(int count) {
    return 'Invita($count)';
  }

  @override
  String get profileNoShippingAddress => 'Nessun indirizzo di spedizione';

  @override
  String get profileDefaultLabel => 'Predefinito';

  @override
  String get profileNoInvoice => 'Nessuna fattura';

  @override
  String get profileCompany => 'Azienda';

  @override
  String get profileTaxNumber => 'Partita IVA';

  @override
  String get profileConfirmDeleteAddress =>
      'Sei sicuro di voler eliminare questo indirizzo?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Sei sicuro di voler eliminare questa fattura?';

  @override
  String get commonGroupOwner => 'Proprietario';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Cerca membri';

  @override
  String groupTotalMembers(int count) {
    return '$count membri';
  }

  @override
  String get chatRemoveFromGroup => 'Rimuovi dal gruppo';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Sei sicuro di voler rimuovere \"$name\" dal gruppo?';
  }

  @override
  String get chatUnknownSong => 'Brano sconosciuto';

  @override
  String get chatUnknownArtist => 'Artista sconosciuto';

  @override
  String get chatUnknownContact => 'Contatto sconosciuto';

  @override
  String get chatPersonalCard => 'Scheda contatto';

  @override
  String get chatSingleChoice => 'Singola';

  @override
  String get chatMultiChoice => 'Multipla';

  @override
  String get chatEnded => 'Terminato';

  @override
  String get chatEndPollButton => 'Termina sondaggio';

  @override
  String get chatPollHint =>
      'Il sondaggio verrà visualizzato nella chat. I membri del gruppo possono votare.';

  @override
  String get chatSearchSongOrArtist => 'Cerca brano o artista';

  @override
  String get chatNoSongsFound => 'Nessun brano trovato';

  @override
  String get chatSongNameOptional => 'Nome brano (opzionale)';

  @override
  String get chatEnterSongName => 'Inserisci nome brano';

  @override
  String get chatArtistNameOptional => 'Nome artista (opzionale)';

  @override
  String get chatEnterArtistName => 'Inserisci nome artista';

  @override
  String get chatRealTimeLocationSharing =>
      'Condivisione posizione in tempo reale in sviluppo...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Funzione chiamata vocale in sviluppo...';

  @override
  String get profileReportFeatureInDev =>
      'Funzione segnalazione in sviluppo...';

  @override
  String get profileShareFeatureInDev => 'Funzione condivisione in sviluppo...';

  @override
  String get profileQrCodeFeatureInDev => 'Funzione QR code in sviluppo...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Scansiona il QR code qui sopra per aggiungermi come amico';

  @override
  String get qrcodeSaveToAlbum => 'Salva nell\'album';

  @override
  String get qrcodeChangeStyle => 'Cambia stile';

  @override
  String get qrcodeCopyId => 'Copia ID';

  @override
  String get qrcodeIdCopied => 'ID copiato';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'Altri stili in arrivo';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Server';

  @override
  String get profileShareContactCard => 'Condividi scheda contatto';

  @override
  String get profileRemoveFromBlacklist => 'Rimuovi dalla lista nera';

  @override
  String get profileConfirmAddBlacklist =>
      'Sei sicuro di voler aggiungere questo utente alla lista nera? Non riceverai più messaggi da lui.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Sei sicuro di voler rimuovere questo utente dalla lista nera?';

  @override
  String get profileRemarkSaved => 'Nota salvata';

  @override
  String get profileRemarkCleared => 'Nota cancellata';

  @override
  String get transferReceive => 'Ricevi';

  @override
  String get transferPleaseConnectWallet => 'Connetti prima il tuo wallet';

  @override
  String get transferSendRequest => 'Invia richiesta';

  @override
  String get transferPleaseEnterValidAmount => 'Inserisci un importo valido';

  @override
  String get searchPlaceholder => 'Cerca contatti, gruppi, messaggi';

  @override
  String get searchEnterKeywordToSearch =>
      'Inserisci parola chiave per cercare';

  @override
  String get searchClearHistory => 'Cancella';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Nessun risultato per \"$query\"';
  }

  @override
  String get searchAllResults => 'Tutto';

  @override
  String get searchInChat => 'Cerca nella chat';

  @override
  String get searchContactLabel => 'Contatto';

  @override
  String get searchGroupLabel => 'Gruppo';

  @override
  String get searchConversationLabel => 'Conversazione';

  @override
  String get searchMessageLabel => 'Messaggio';

  @override
  String get settingsSecurityTitle => 'Sicurezza';

  @override
  String get settingsKeyBackup => 'Backup chiavi';

  @override
  String get settingsBackupEncryptionKeys => 'Backup chiavi di crittografia';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count chiavi salvate';
  }

  @override
  String get settingsBackupNotSet => 'Backup non configurato';

  @override
  String get settingsRestoreKeys => 'Ripristina chiavi';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Ripristina chiavi di crittografia dal backup';

  @override
  String get settingsExportKeys => 'Esporta chiavi';

  @override
  String get settingsExportKeysToFile => 'Esporta chiavi in un file';

  @override
  String get settingsLoggedInDevices => 'Dispositivi connessi';

  @override
  String get settingsNoOtherDevices => 'Nessun altro dispositivo';

  @override
  String get settingsVerified => 'Verificato';

  @override
  String get settingsUnverified => 'Non verificato';

  @override
  String get settingsAdvanced => 'Avanzate';

  @override
  String get settingsCrossSigning => 'Cross-signing';

  @override
  String get settingsEnabled => 'Abilitato';

  @override
  String get settingsNotEnabled => 'Non abilitato';

  @override
  String get settingsResetEncryption => 'Reimposta crittografia';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Elimina tutte le chiavi di crittografia';

  @override
  String get settingsEncryptionNotSupported => 'Crittografia non supportata';

  @override
  String get settingsNotInitialized => 'Non inizializzato';

  @override
  String get settingsBackupKeyTitle => 'Backup chiavi';

  @override
  String get settingsBackupKeyMessage =>
      'Creare un nuovo backup chiavi? Questo ti aiuterà a ripristinare i messaggi crittografati su un nuovo dispositivo.';

  @override
  String get settingsBackup => 'Backup';

  @override
  String get settingsRestoreKeyTitle => 'Ripristina chiavi';

  @override
  String get settingsRestoreKeyMessage =>
      'Inserisci la password di recupero o la chiave di recupero per ripristinare i messaggi crittografati.';

  @override
  String get settingsRestore => 'Ripristina';

  @override
  String get settingsExportKeyTitle => 'Esporta chiavi';

  @override
  String get settingsExportKeyMessage =>
      'Il file chiavi esportato contiene tutte le tue chiavi di crittografia. Conservalo al sicuro.';

  @override
  String get settingsExport => 'Esporta';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID dispositivo: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Stato: Verificato';

  @override
  String get settingsDeviceStatusUnverified => 'Stato: Non verificato';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Ultimo accesso: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Verifica questo dispositivo';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Cross-signing già abilitato';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Configurazione cross-signing riuscita';

  @override
  String get settingsResetEncryptionTitle => 'Reimposta crittografia';

  @override
  String get settingsResetEncryptionWarning =>
      'Attenzione: Questo eliminerà tutte le tue chiavi di crittografia. Non potrai decifrare i messaggi crittografati precedenti. Questa azione non può essere annullata.';

  @override
  String get settingsReset => 'Reimposta';

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
      'Sei sicuro di voler lasciare la riunione?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'ha toccato $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Nessun contatto disponibile da aggiungere';

  @override
  String get chatAddMembers => 'Aggiungi membri';

  @override
  String chatInvitedMembers(int count) {
    return 'Invitati $count membri';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Invito fallito: $error';
  }

  @override
  String get chatMemberRemoved => 'Membro rimosso';

  @override
  String chatRemoveFailed(String error) {
    return 'Rimozione fallita: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Dopo la condivisione, l\'altra persona potrà vedere la tua posizione in tempo reale per 1 ora.';

  @override
  String get chatStartSharing => 'Inizia condivisione';

  @override
  String get chatLocationServiceNotEnabled =>
      'Servizio di localizzazione non abilitato';

  @override
  String get chatEnableLocationService =>
      'Abilita il servizio di localizzazione per usare questa funzione';

  @override
  String get chatGoToSettings => 'Vai alle impostazioni';

  @override
  String get chatLocationPermissionRequired =>
      'Permesso di localizzazione richiesto per questa funzione';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Permesso di localizzazione negato permanentemente. Abilitalo nelle impostazioni.';

  @override
  String get chatLocationPermissionDenied =>
      'Permesso di localizzazione negato';

  @override
  String get chatGettingLocation => 'Ottenimento posizione...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Impossibile ottenere la posizione: $error';
  }

  @override
  String get chatMapPreview => 'Anteprima mappa';

  @override
  String get chatSearchLocation => 'Cerca posizione';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Inviata busta rossa di $amount $token';
  }

  @override
  String get chatTransferDefault => 'Trasferimento';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Inviato trasferimento di $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Selezione file fallita: $error';
  }

  @override
  String get chatFileSizeLimit => 'Il file non può superare 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Invio file: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Invio file fallito: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Inviata scheda contatto di $name';
  }

  @override
  String get chatFavoritesFeature => 'Preferiti';

  @override
  String get chatCouponsFeature => 'Coupon';

  @override
  String get chatGiftFeature => 'Regalo';

  @override
  String chatSharedMusic(String name) {
    return 'Condiviso $name';
  }

  @override
  String get chatEndPollTitle => 'Termina sondaggio';

  @override
  String get chatEndPollConfirmMessage =>
      'Sei sicuro di voler terminare questo sondaggio? Le votazioni verranno chiuse.';

  @override
  String get chatPollEndedMessage => 'Sondaggio terminato';

  @override
  String get chatConnectingCall => 'Connessione in corso...';

  @override
  String get chatMuteCall => 'Silenzia';

  @override
  String get chatSpeakerOff => 'Altoparlante spento';

  @override
  String get chatSpeakerOn => 'Altoparlante';

  @override
  String get chatCameraOn => 'Fotocamera accesa';

  @override
  String get chatCameraOff => 'Fotocamera spenta';

  @override
  String get chatHangUp => 'Termina';

  @override
  String get chatSelectForwardTargetTitle => 'Seleziona destinatario inoltro';

  @override
  String get chatNoForwardableChat => 'Nessuna chat disponibile per l\'inoltro';

  @override
  String get chatNoMatchingChat => 'Nessuna chat corrispondente trovata';

  @override
  String get chatLocationTitle => 'Posizione';

  @override
  String get chatSendButton => 'Invia';

  @override
  String get chatRetryButton => 'Riprova';

  @override
  String get chatSearchContactHint => 'Cerca contatti';

  @override
  String get chatShareMusic => 'Condividi musica';

  @override
  String get chatRecentPlayed => 'Recenti';

  @override
  String get chatMyFavorites => 'Preferiti';

  @override
  String get chatNetworkLink => 'Link';

  @override
  String get chatLocalFile => 'Locale';

  @override
  String get chatPasteMusicLink => 'Incolla link musicale';

  @override
  String get chatShareMusicButton => 'Condividi musica';

  @override
  String get chatSelectLocalAudio => 'Seleziona file audio locale';

  @override
  String get chatSupportedAudioFormats => 'Supporta MP3, M4A, WAV, FLAC, ecc.';

  @override
  String get chatSelectFileButton => 'Seleziona file';

  @override
  String get chatPleaseEnterMusicLink => 'Inserisci link musicale';

  @override
  String get chatPleaseEnterValidLink => 'Inserisci un URL valido';

  @override
  String get chatSharedSong => 'Brano condiviso';

  @override
  String get chatSelectMember => 'Seleziona membro';

  @override
  String get chatSearchMemberHint => 'Cerca membri';

  @override
  String get chatNoMatchingMembers => 'Nessun membro corrispondente trovato';

  @override
  String get commonUnknownMember => 'Sconosciuto';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Selezionati $count messaggi';
  }

  @override
  String get chatSearchContactsOrGroups => 'Cerca contatti o gruppi';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Caricamento...';

  @override
  String get chatVideoLoadFailed => 'Caricamento video fallito';

  @override
  String get chatPlayerInitFailed => 'Inizializzazione player fallita';

  @override
  String get chatCreatePollTitle => 'Crea sondaggio';

  @override
  String get chatSubmitPoll => 'Invia';

  @override
  String get chatPollQuestionLabel => 'Domanda sondaggio';

  @override
  String get chatEnterPollQuestionHint => 'Inserisci domanda sondaggio';

  @override
  String get chatPollOptionsLabel => 'Opzioni sondaggio';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Opzione $index';
  }

  @override
  String get chatAddOptionButton => 'Aggiungi opzione';

  @override
  String get chatPollSettingsLabel => 'Impostazioni sondaggio';

  @override
  String get chatSelectionType => 'Tipo selezione';

  @override
  String get chatSingleChoiceLabel => 'Singola';

  @override
  String get chatMultiChoiceLabel => 'Multipla';

  @override
  String get chatAnonymousPollSwitch => 'Sondaggio anonimo';

  @override
  String get chatPleaseEnterQuestion => 'Inserisci domanda sondaggio';

  @override
  String get chatAtLeastTwoOptions => 'Almeno 2 opzioni richieste';

  @override
  String chatConfirmWithCount(int count) {
    return 'Conferma ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Verifica email';

  @override
  String get authEnterValidEmailAddress =>
      'Inserisci un indirizzo email valido';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Codice di verifica inviato a $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Invio codice fallito: $error';
  }

  @override
  String get authVerificationSuccess => 'Verifica riuscita';

  @override
  String get authVerificationFailed => 'Verifica fallita';

  @override
  String authVerificationCodeError(String error) {
    return 'Errore codice di verifica: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Inserisci codice di verifica';

  @override
  String get authEnterYourEmail => 'Inserisci email';

  @override
  String authWeSentCodeTo(String email) {
    return 'Abbiamo inviato un codice a 6 cifre a\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Inserisci il tuo indirizzo email, ti invieremo un codice di verifica';

  @override
  String get commonSendVerificationCode => 'Invia codice di verifica';

  @override
  String get authResendVerificationCode => 'Reinvia codice di verifica';

  @override
  String authCanResendAfter(int seconds) {
    return 'Puoi reinviare tra $seconds secondi';
  }

  @override
  String get commonChangeEmail => 'Cambia email';

  @override
  String get contactAddToContacts => 'Aggiungi ai contatti';

  @override
  String get contactAddingToContacts => 'Aggiungendo...';

  @override
  String get contactAddedToContacts => 'Aggiunto ai contatti';

  @override
  String contactAddFailedWithError(String error) {
    return 'Aggiunta fallita: $error';
  }

  @override
  String get contactAddPhone => 'Aggiungi telefono';

  @override
  String get contactAddTag => 'Aggiungi tag';

  @override
  String get contactAddText => 'Aggiungi testo';

  @override
  String get contactAddPhoto => 'Aggiungi foto';

  @override
  String contactGroupCountLabel(int count) {
    return '$count gruppi';
  }

  @override
  String get contactAddedViaSearch => 'Aggiunto tramite ricerca';

  @override
  String get contactAddTime => 'Aggiungi ora';

  @override
  String get contactDoneButton => 'Fatto';

  @override
  String get callWaitingForParticipants => 'In attesa di partecipanti...';

  @override
  String callParticipantMe(String name) {
    return '$name (Io)';
  }

  @override
  String get callSharingLabel => 'Condivisione';

  @override
  String callScreenSharingBy(String name) {
    return '$name sta condividendo lo schermo';
  }

  @override
  String callParticipantCount(int count) {
    return '$count partecipanti';
  }

  @override
  String get callMuteLabel => 'Silenzia';

  @override
  String get callUnmuteLabel => 'Riattiva';

  @override
  String get callTurnOffVideo => 'Disattiva video';

  @override
  String get callTurnOnVideo => 'Attiva video';

  @override
  String get callShareScreen => 'Condividi schermo';

  @override
  String get callStopSharing => 'Interrompi condivisione';

  @override
  String get callSwitchCameraLabel => 'Cambia';

  @override
  String get callLeaveLabel => 'Lascia';

  @override
  String get callParticipantsLabel => 'Partecipanti';

  @override
  String get callJoiningMeeting => 'Entrando nella riunione...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count voti ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count partecipanti';
  }

  @override
  String get commonTapToRetry => 'Tocca per riprovare';

  @override
  String get chatDefaultRedPacketGreeting => 'Auguri di prosperità e fortuna';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Consenti ad altri di cercare e aderire';

  @override
  String get groupConfirmClearChatHistory =>
      'Sei sicuro di voler cancellare la cronologia chat?';

  @override
  String get groupCreateGroupToChat => 'Crea un gruppo per iniziare a chattare';

  @override
  String get groupEditGroupAnnouncement => 'Modifica annuncio del gruppo';

  @override
  String get groupEditGroupDescription => 'Modifica descrizione del gruppo';

  @override
  String get groupEnterGroupAnnouncement => 'Inserisci l\'annuncio del gruppo';

  @override
  String chatErrorWithMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count membri, fai clic per copiare l\'ID del gruppo';
  }

  @override
  String get chatMusicLinkLabel => 'Link musicale';

  @override
  String get chatNoMediaUrlAvailable => 'URL multimediale non disponibile';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Non hai il permesso di modificare il nome del gruppo';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Le buste rosse e i trasferimenti non possono essere inoltrati';

  @override
  String get authEmailAddress => 'Indirizzo email';

  @override
  String get commonEnterEmailAddress => 'Inserisci l\'indirizzo email';

  @override
  String get authEmailRecoveryHint => 'Usato per il recupero della password';

  @override
  String get commonInvalidEmailFormat => 'Inserisci un indirizzo email valido';

  @override
  String get authOptional => 'Opzionale';

  @override
  String get authResetPassword => 'Ripristina password';

  @override
  String get authEnterRegisteredEmail =>
      'Inserisci l\'indirizzo email con cui ti sei registrato';

  @override
  String get authSendResetCode => 'Invia codice di ripristino';

  @override
  String authResetCodeSent(String email) {
    return 'Codice di ripristino inviato a $email';
  }

  @override
  String get authEnterResetCode => 'Inserisci il codice di ripristino';

  @override
  String get authSetNewPassword => 'Imposta nuova password';

  @override
  String get commonConfirmNewPassword => 'Conferma nuova password';

  @override
  String get commonNewPassword => 'Nuova password';

  @override
  String get authPasswordResetSuccess =>
      'Password ripristinata con successo. Accedi con la tua nuova password.';

  @override
  String get authResetPasswordFailed => 'Ripristino password fallito';

  @override
  String get settingsChangePassword => 'Cambia password';

  @override
  String get settingsCurrentPassword => 'Password attuale';

  @override
  String get settingsEnterCurrentPassword => 'Inserisci la password attuale';

  @override
  String get settingsEnterNewPassword => 'Inserisci la nuova password';

  @override
  String get settingsPasswordChanged =>
      'Password cambiata con successo. Accedi con la tua nuova password.';

  @override
  String get settingsChangePasswordFailed => 'Cambio password fallito';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'La nuova password deve essere diversa dalla password attuale';

  @override
  String get settingsChangePasswordInfo =>
      'Dopo aver cambiato la password, verrai disconnesso e dovrai accedere con la nuova password.';

  @override
  String get settingsPasswordRequirements => 'Requisiti della password:';

  @override
  String get settingsSecurityNote =>
      'Per sicurezza, dovrai riaccedere su tutti i dispositivi dopo aver cambiato la password.';

  @override
  String get settingsSecurity => 'Sicurezza';

  @override
  String get settingsCurrentBoundEmail => 'Email attualmente collegata';

  @override
  String get settingsNewEmailAddress => 'Nuovo indirizzo email';

  @override
  String get settingsEnterNewEmail => 'Inserisci il nuovo indirizzo email';

  @override
  String get settingsVerificationCode => 'Codice di verifica';

  @override
  String get settingsVerificationCodeSent => 'Codice di verifica inviato';

  @override
  String get settingsCodeSentTo => 'Codice di verifica inviato a';

  @override
  String get settingsDidNotReceiveCode => 'Non hai ricevuto il codice?';

  @override
  String get settingsEmailChangedSuccess => 'Email cambiata con successo';

  @override
  String get settingsChangeEmailFailed => 'Cambio email fallito';

  @override
  String get settingsEmailSecurityNote =>
      'La tua email viene usata per il recupero della password. Mantienila al sicuro.';

  @override
  String get commonGoogleLogin => 'Accedi con Google';

  @override
  String get commonAppleLogin => 'Accedi con Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageChanged => 'Lingua cambiata';

  @override
  String get settingsTranslation => '翻译';

  @override
  String get settingsTranslateTextTo => '将文字翻译为';

  @override
  String get settingsTranslateDescription => '选择你希望将消息翻译成的语言。';

  @override
  String get settingsAutoTranslate => '自动翻译聊天中收到的消息';

  @override
  String get settingsAutoTranslateDescription => '自动将聊天中收到的消息翻译为你选择的语言。';

  @override
  String get settingsBiometricLogin => 'Accesso biometrico';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Accedi con $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Accesso biometrico attivato';

  @override
  String get settingsBiometricLoginDisabled => 'Accesso biometrico disattivato';

  @override
  String get settingsEnableBiometricLogin => 'Attiva accesso biometrico';

  @override
  String get settingsBiometricEnabled =>
      'Attivato - Usa biometria per accedere';

  @override
  String get settingsBiometricDisabled => 'Disattivato - Tocca per attivare';

  @override
  String get settingsBiometricNeedRelogin =>
      'Disconnettiti e accedi di nuovo per attivare l\'accesso biometrico';

  @override
  String get authOr => 'OPPURE';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'L\'accesso alla fotocamera è limitato su questo dispositivo';

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
      'Inserisci il suffisso del tocco, es.: sulla spalla';

  @override
  String get groupAlbum => 'Album del gruppo';

  @override
  String get groupFiles => 'File del gruppo';

  @override
  String get groupImages => 'Immagini';

  @override
  String get groupVideos => 'Video';

  @override
  String get groupTotal => 'Totale';

  @override
  String get groupSize => 'Dimensione';

  @override
  String get groupNoMedia => 'Nessun media';

  @override
  String get groupNoMediaDescription =>
      'Nessuna foto o video in questo gruppo ancora';

  @override
  String get groupDocuments => 'Documenti';

  @override
  String get groupNoFiles => 'Nessun file';

  @override
  String get groupNoFilesDescription => 'Nessun file in questo gruppo ancora';

  @override
  String groupDownloadStarted(String filename) {
    return 'Download di $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Nessun gruppo in comune';

  @override
  String get contactNoCommonGroupsDescription => 'Non avete gruppi in comune';

  @override
  String get chatVoiceMessage => 'Vocale';

  @override
  String get chatMessage => 'Messaggio';

  @override
  String get conversationHideChat => 'Nascondi';

  @override
  String get settingsQuickReply => 'Risposta rapida';

  @override
  String get commonTranslate => 'Traduci';

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
    return 'Conversazione: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Contatto: $userId';
  }

  @override
  String get commonDiscover => 'Scopri';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Prossimamente)';
  }

  @override
  String get commonPageNotFound => 'Pagina non trovata';

  @override
  String get commonBackToHome => 'Torna alla home';

  @override
  String get settingsMessageNotifications => 'Notifiche messaggi';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Ricevi notifiche per nuovi messaggi';

  @override
  String get settingsShowMessagePreview => 'Mostra anteprima messaggio';

  @override
  String get settingsShowMessageContentInNotification =>
      'Mostra contenuto del messaggio nelle notifiche';

  @override
  String get settingsNotificationSound => 'Suono notifica';

  @override
  String get settingsPlaySoundOnMessage =>
      'Riproduci suono alla ricezione messaggi';

  @override
  String get commonVibration => 'Vibrazione';

  @override
  String get settingsVibrateOnMessage => 'Vibra alla ricezione messaggi';

  @override
  String get settingsDoNotDisturbMode => 'Non disturbare';

  @override
  String get settingsDoNotDisturbDescription =>
      'Non ricevere notifiche durante il periodo specificato';

  @override
  String get settingsStartTime => 'Ora inizio';

  @override
  String get settingsEndTime => 'Ora fine';

  @override
  String get settingsDeleteQuickReply => 'Elimina risposta rapida';

  @override
  String get settingsEditQuickReply => 'Modifica risposta rapida';

  @override
  String get settingsAddQuickReply => 'Aggiungi risposta rapida';

  @override
  String get settingsManageQuickReplies => 'Gestisci risposte rapide';

  @override
  String get settingsNoQuickReplies => 'Nessuna risposta rapida';

  @override
  String get settingsDefaultQuickReplies =>
      'Verranno mostrate le risposte rapide predefinite';

  @override
  String get settingsWhoCanSee => 'Chi può vedere';

  @override
  String get settingsLastSeen => 'Ultimo accesso';

  @override
  String get settingsHiddenChats => 'Chat nascosti';

  @override
  String get settingsMessagesLabel => 'Messaggi';

  @override
  String get settingsAllowStrangerMessages =>
      'Consenti messaggi da sconosciuti';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Ricevi messaggi da non-contatti';

  @override
  String get settingsReadReceipts => 'Conferme di lettura';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Fai sapere agli altri che hai letto i loro messaggi';

  @override
  String get settingsTypingIndicator => 'Indicatore di digitazione';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Fai sapere agli altri che stai scrivendo';

  @override
  String get settingsEveryone => 'Tutti';

  @override
  String get settingsContactsOnly => 'Solo contatti';

  @override
  String get settingsNobody => 'Nessuno';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Chi può vedere $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Versione $version';
  }

  @override
  String get settingsCheckForUpdates => 'Controlla aggiornamenti';

  @override
  String get settingsOpenSourceLicenses => 'Licenze open source';

  @override
  String get settingsFeedbackAndSuggestions => 'Feedback e suggerimenti';

  @override
  String get settingsBuiltOnMatrix => 'Basato sul protocollo Matrix';

  @override
  String get settingsNoHiddenChats => 'Nessun chat nascosto';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Le chat che nascondi appariranno qui';

  @override
  String get settingsUnhideChat => 'Mostra';

  @override
  String get settingsDarkMode => 'Modalità scura';

  @override
  String get settingsFontSize => 'Dimensione carattere';

  @override
  String get settingsBubbleStyle => 'Stile fumetto';

  @override
  String get settingsFollowSystem => 'Segui sistema';

  @override
  String get settingsAutoSwitchBySystem =>
      'Cambia automaticamente in base alle impostazioni di sistema';

  @override
  String get settingsLightMode => 'Modalità chiara';

  @override
  String get settingsAlwaysUseLightTheme => 'Usa sempre tema chiaro';

  @override
  String get settingsDarkModeOption => 'Modalità scura';

  @override
  String get settingsAlwaysUseDarkTheme => 'Usa sempre tema scuro';

  @override
  String get settingsFontSizeSmall => 'Piccolo';

  @override
  String get settingsFontSizeStandard => 'Standard';

  @override
  String get settingsFontSizeLarge => 'Grande';

  @override
  String get settingsFontSizeExtraLarge => 'Extra grande';

  @override
  String get settingsBubbleStyleWechat => 'Stile WeChat';

  @override
  String get settingsBubbleStyleWechatDesc => 'Stile fumetto classico WeChat';

  @override
  String get settingsBubbleStyleModern => 'Stile moderno';

  @override
  String get settingsBubbleStyleModernDesc => 'Stile fumetto moderno e pulito';

  @override
  String get settingsBubbleStyleClassic => 'Stile classico';

  @override
  String get settingsBubbleStyleClassicDesc => 'Stile fumetto tradizionale';

  @override
  String get discoverVideoChannels => 'Canali';

  @override
  String get discoverLive => 'Live';

  @override
  String get discoverListen => 'Ascolta';

  @override
  String get discoverWatch => 'Guarda';

  @override
  String get discoverSearchDiscover => 'Cerca';

  @override
  String get discoverNearbyPeople => 'Vicino a te';

  @override
  String get discoverGames => 'Giochi';

  @override
  String get discoverMiniPrograms => 'Mini programmi';

  @override
  String get chatAlreadyInCall => 'Già in chiamata';

  @override
  String get commonConnectionFailed => 'Connessione fallita';

  @override
  String get chatCallRejected => 'Chiamata rifiutata';

  @override
  String get chatNoAnswer => 'Nessuna risposta';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get chatSelectContact => 'Seleziona contatto';

  @override
  String get chatVoteRemoved => 'Voto rimosso';

  @override
  String get chatVoteChanged => 'Voto modificato';

  @override
  String get chatVoted => 'Votato';

  @override
  String chatReplyTo(String name) {
    return 'Rispondi a $name';
  }

  @override
  String get chatCurrentLocation => 'Posizione attuale';

  @override
  String chatNearbyPlace(int index) {
    return 'Luogo vicino $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Circa $distance';
  }

  @override
  String get chatAddress => 'Indirizzo';

  @override
  String get chatLatitude => 'Latitudine';

  @override
  String get chatLongitude => 'Longitudine';

  @override
  String get groupDescriptionUpdated => 'Descrizione gruppo aggiornata';

  @override
  String get groupAvatarUpdated => 'Avatar gruppo aggiornato';

  @override
  String get callDecline => 'Rifiuta';

  @override
  String get callAnswer => 'Rispondi';

  @override
  String get callIncomingVideoCall => 'Videochiamata in arrivo';

  @override
  String get callIncomingVoiceCall => 'Chiamata vocale in arrivo';

  @override
  String get callVideoCallInProgress => 'Videochiamata';

  @override
  String get callVoiceCallInProgress => 'Chiamata vocale';

  @override
  String get callReconnectingCall => 'Riconnessione in corso...';

  @override
  String get callEnded => 'Chiamata terminata';

  @override
  String get callFailed => 'Chiamata fallita';

  @override
  String get callLivekitNotConfigured => 'LiveKit non configurato';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Impossibile partecipare alla riunione: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Condivisione schermo fallita: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Nessun N42 Bean';

  @override
  String get profileN42BeanDetails => 'Dettagli N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean è un token per riscattare oggetti virtuali e servizi in N42. Attualmente disponibile per:';

  @override
  String get profileN42BeanFeature1 => 'Sticker e temi esclusivi per membri';

  @override
  String get profileN42BeanFeature2 => 'Personalizzazione bolle di chat';

  @override
  String get profileN42BeanFeature3 =>
      'Personalizzazione copertine buste rosse';

  @override
  String get profileN42BeanFeature4 => 'Badge nickname esclusivo';

  @override
  String get profileN42BeanFeature5 => 'Privilegi chat di gruppo';

  @override
  String get profileN42BeanFeature6 => 'Espansione archiviazione cloud';

  @override
  String get profileN42BeanFeature7 => 'Filtri bellezza videochiamata';

  @override
  String get profileN42BeanFeature8 => 'Personalizzazione sfondo Moments';

  @override
  String get profileN42BeanFeature9 => 'Priorità servizio clienti VIP';

  @override
  String get profileGotIt => 'Ho capito';

  @override
  String get profileNoN42BeanRecords => 'Nessun registro N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Umore e pensieri';

  @override
  String get profileStatusHappy => 'Felice';

  @override
  String get profileStatusCracked => 'A pezzi';

  @override
  String get profileStatusLucky => 'Fortunato';

  @override
  String get profileStatusSunny => 'Solare';

  @override
  String get profileStatusTired => 'Stanco';

  @override
  String get profileStatusDaydream => 'Sognando';

  @override
  String get profileStatusRushing => 'Di fretta';

  @override
  String get profileStatusOverthinking => 'Pensieroso';

  @override
  String get profileStatusEnergized => 'Carico';

  @override
  String get profileWorkAndStudy => 'Lavoro e studio';

  @override
  String get profileStatusWorking => 'Al lavoro';

  @override
  String get profileStatusStudying => 'Studiando';

  @override
  String get profileStatusBusy => 'Occupato';

  @override
  String get profileStatusSlacking => 'Rilassandosi';

  @override
  String get profileStatusTraveling => 'In viaggio';

  @override
  String get profileStatusGoingHome => 'Tornando a casa';

  @override
  String get profileStatusDnd => 'Non disturbare';

  @override
  String get profileActivities => 'Attività';

  @override
  String get profileStatusHanging => 'In giro';

  @override
  String get profileStatusCheckIn => 'Check in';

  @override
  String get profileStatusExercising => 'Allenamento';

  @override
  String get profileStatusCoffee => 'Caffè';

  @override
  String get profileStatusBubbleTea => 'Bubble tea';

  @override
  String get profileStatusEating => 'Mangiando';

  @override
  String get profileStatusParenting => 'Genitori';

  @override
  String get profileStatusSavingWorld => 'Salvando il mondo';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Riposo';

  @override
  String get profileStatusRetreat => 'Ritirata';

  @override
  String get profileStatusHome => 'A casa';

  @override
  String get profileStatusSleeping => 'Dormendo';

  @override
  String get profileStatusCatLover => 'Amante dei gatti';

  @override
  String get profileStatusDogWalking => 'Passeggiata col cane';

  @override
  String get profileStatusGaming => 'Giocando';

  @override
  String get profileStatusListening => 'Ascoltando';

  @override
  String get profileEditAddress => 'Modifica indirizzo';

  @override
  String get profileRecipient => 'Destinatario';

  @override
  String get profileEnterRecipientName => 'Inserisci nome destinatario';

  @override
  String get profilePhoneNumber => 'Numero di telefono';

  @override
  String get profileEnterPhoneNumber => 'Inserisci numero di telefono';

  @override
  String get profileRegionHint => 'Provincia/Città/Distretto';

  @override
  String get profileDetailedAddress => 'Indirizzo dettagliato';

  @override
  String get profileDetailedAddressHint => 'Via, numero civico, ecc.';

  @override
  String get profileSetAsDefaultAddress => 'Imposta come indirizzo predefinito';

  @override
  String get profilePleaseCompleteInfo => 'Compila tutti i campi';

  @override
  String get profileEditInvoice => 'Modifica fattura';

  @override
  String get profileInvoiceType => 'Tipo fattura: ';

  @override
  String get profileCompanyName => 'Nome azienda';

  @override
  String get profilePersonalName => 'Nome personale';

  @override
  String get profileEnterCompanyName => 'Inserisci nome azienda';

  @override
  String get profileEnterName => 'Inserisci nome';

  @override
  String get profileTaxIdNumber => 'Codice fiscale';

  @override
  String get profileEnterTaxIdNumber => 'Inserisci codice fiscale';

  @override
  String get profileBankNameOptional => 'Nome banca (opzionale)';

  @override
  String get profileEnterBankName => 'Inserisci nome banca';

  @override
  String get profileBankAccountOptional => 'Conto bancario (opzionale)';

  @override
  String get profileEnterBankAccount => 'Inserisci conto bancario';

  @override
  String get profileCompanyAddressOptional => 'Indirizzo azienda (opzionale)';

  @override
  String get profileEnterCompanyAddress => 'Inserisci indirizzo azienda';

  @override
  String get profileCompanyPhoneOptional => 'Telefono azienda (opzionale)';

  @override
  String get profileEnterCompanyPhone => 'Inserisci telefono azienda';

  @override
  String get profileSetAsDefaultInvoice => 'Imposta come fattura predefinita';

  @override
  String get profileRingtoneVibrate => 'Vibrazione';

  @override
  String get profileRingtoneSilent => 'Silenzioso';

  @override
  String get profileVibrateMode => 'Modalità vibrazione';

  @override
  String get profileSilentMode => 'Modalità silenziosa';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Riproduzione fallita: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'In riproduzione: $ringtoneName';
  }

  @override
  String get profileStop => 'Stop';

  @override
  String get profileSelectRingtone => 'Seleziona suoneria';

  @override
  String get profileLoadingRingtones => 'Caricamento suonerie...';

  @override
  String get profileNoRingtonesFound => 'Nessuna suoneria trovata';

  @override
  String mainMessagesWithCount(int count) {
    return 'Messaggi($count)';
  }

  @override
  String get storyViewers => 'Visualizzatori';

  @override
  String get storyNoViewers => 'Nessun visualizzatore ancora';

  @override
  String get storyReplyToStory => 'Rispondi alla storia...';

  @override
  String get commonCopiedToClipboard => 'Copiato negli appunti';

  @override
  String get commonMore => 'Altro';

  @override
  String get commonTranslating => 'Traduzione in corso...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Tradotto da $language';
  }

  @override
  String get commonTranslation => 'Traduzione';

  @override
  String get commonTranslationFailed => 'Traduzione fallita';

  @override
  String get commonAllRead => 'Tutto letto';

  @override
  String commonReadCount(int count) {
    return '$count letto';
  }

  @override
  String get commonYouRecalledMessage => 'Hai ritirato un messaggio';

  @override
  String get commonMessageRecalled => 'Messaggio ritirato';

  @override
  String get commonReEdit => 'Modifica';

  @override
  String get commonWalletArea => 'Area wallet';

  @override
  String get callIncomingCall => 'Chiamata in arrivo';

  @override
  String get callMissedCall => 'Chiamata persa';

  @override
  String get groupRemoveAdmin => 'Rimuovi admin';

  @override
  String get chatSelectCurrency => 'Seleziona valuta';

  @override
  String get chatSelectEmoji => 'Seleziona emoji';

  @override
  String get chatSelectRedPacketCover => 'Seleziona copertina';

  @override
  String get groupSetAsAdmin => 'Imposta come admin';

  @override
  String get chatVideoPlaybackFailed => 'Riproduzione video fallita';

  @override
  String get groupViewProfile => 'Visualizza profilo';

  @override
  String get favoriteAddLinkComingSoon => 'Funzione aggiungi link in arrivo';

  @override
  String get favoriteNewNoteComingSoon => 'Funzione nuova nota in arrivo';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Funzione salvataggio in arrivo';

  @override
  String get qrcodeShareFeatureComingSoon => 'Funzione condivisione in arrivo';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Elaborazione QR code fallita: $error';
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
  String get gameCenter => 'Giochi';

  @override
  String get gameHighScore => 'Miglior';

  @override
  String get gameScore => 'Punteggio';

  @override
  String get gameOver => 'Partita finita';

  @override
  String get gamePlayAgain => 'Gioca ancora';

  @override
  String get gameLeaderboard => 'Classifica';

  @override
  String get gamePause => 'In pausa';

  @override
  String get gameResume => 'Tocca per riprendere';

  @override
  String get gameConfirmExit => 'Uscire dal gioco?';

  @override
  String get gameNoScores => 'Nessun punteggio';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Unisci le tessere fino a 2048';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Fai cadere e cancella le righe';

  @override
  String get gameMinesweeper => 'Campo minato';

  @override
  String get gameMinesweeperDesc => 'Trova tutte le celle sicure';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => 'Abbina 3 o più gemme';

  @override
  String get gameMinesweeperEasy => 'Facile';

  @override
  String get gameMinesweeperMedium => 'Medio';

  @override
  String get gameMinesLeft => 'Mine rimaste';

  @override
  String get gameTimeLeft => 'Tempo';

  @override
  String get gameLevel => 'Livello';

  @override
  String get gameNext => 'Prossimo';

  @override
  String get gameBestTime => 'Miglior tempo';

  @override
  String get gameNewRecord => 'Nuovo record!';

  @override
  String get gameLines => 'Righe';

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
  String get onChainNotificationsTitle => 'Eventi on-chain';

  @override
  String get onChainMarkAllRead => 'Segna tutto come letto';

  @override
  String get onChainNoNotifications => 'Nessun evento on-chain ancora';

  @override
  String get onChainNoNotificationsDesc =>
      'Gli eventi dai canali iscritti appariranno qui';

  @override
  String get onChainViewDetails => 'Visualizza dettagli';

  @override
  String get chatCommandHelp => '/help — Mostra tutti i comandi';

  @override
  String get chatCommandPrice => '/price — Ottieni il prezzo del token';

  @override
  String get chatCommandBalance => '/balance — Mostra il saldo del portafoglio';

  @override
  String get chatCommandChains => '/chains — Elenca 236+ reti supportate';

  @override
  String get chatMiniApps => 'App';

  @override
  String get miniAppMarketTitle => 'Mini App';

  @override
  String get miniAppCategoryAll => 'Tutte';

  @override
  String get miniAppSearch => 'Cerca app...';

  @override
  String get miniAppFeatured => 'In evidenza';

  @override
  String get miniAppAllApps => 'Tutte le App';

  @override
  String get miniAppNoResults => 'Nessuna app trovata';

  @override
  String get slideToPayLabel => '→→→  Scorri per confermare';

  @override
  String get slideToPayConfirming => 'Confermando...';

  @override
  String get redPacketBestLuck => 'Miglior fortuna';

  @override
  String get redPacketBestLuckCongrats =>
      'Miglior fortuna! Hai ottenuto di più!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total riscattati';
  }

  @override
  String get redPacketStatsTotal => 'totale';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 Ha ricevuto una busta rossa • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  indirizzo 0x  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'Cerca per ID, wallet o ENS...';

  @override
  String get web3WalletAddress => 'Indirizzo wallet';

  @override
  String get web3AddressCopied => 'Indirizzo copiato';

  @override
  String get web3Copy => 'Copia';

  @override
  String get web3SendMessage => 'Invia messaggio';

  @override
  String get web3SendToWallet => 'Messaggio al wallet';

  @override
  String get web3WalletOnlyHint =>
      'Questo indirizzo non ha ancora un account N42. Il messaggio verrà consegnato quando si unisce.';

  @override
  String get web3NftAvatar => 'Avatar NFT';

  @override
  String get web3ResolveFailed => 'Risoluzione identità fallita';

  @override
  String web3EnsNotFound(String name) {
    return 'Nome ENS \"$name\" non trovato';
  }

  @override
  String get web3NoN42AccountTitle => 'Nessun account N42';

  @override
  String get web3NoN42AccountDesc =>
      'This wallet address has no N42 account yet. You can share your N42 invite link with them to get started.';

  @override
  String get web3ShareInvite => 'Condividi invito';

  @override
  String get nftPickerTitle => 'Seleziona avatar NFT';

  @override
  String get nftPickerTabPopular => 'Popolari';

  @override
  String get nftPickerTabCustom => 'Personalizzato';

  @override
  String get nftPickerChain => 'Chain';

  @override
  String get nftPickerContract => 'Contract Address';

  @override
  String get nftPickerTokenId => 'Token ID';

  @override
  String get nftPickerVerifyOwnership => 'Verifica proprietà e anteprima';

  @override
  String get nftPickerUseAsAvatar => 'Usa come avatar';

  @override
  String get nftPickerPreview => 'Preview';

  @override
  String get nftPickerNotOwned => 'Non possiedi questo NFT';

  @override
  String get nftPickerInvalidTokenId => 'Invalid token ID';

  @override
  String get nftPickerEnterBoth => 'Enter contract address and token ID';

  @override
  String get nftPickerInfoTitle => 'Avatar NFT — Verificato on-chain';

  @override
  String get nftPickerInfoDesc =>
      'Bind an NFT you own as your avatar. Anyone can verify ownership on-chain. Displayed with a gold ring across N42.';

  @override
  String get nftPickerPopularCollections => 'Collezioni popolari';

  @override
  String get nftPickerWalletHint =>
      'Connetti il tuo wallet N42 per scoprire automaticamente i tuoi NFT su 236+ chain.';

  @override
  String get profileBindNftAvatar => 'Bind NFT Avatar';

  @override
  String get profileChangeAvatar => 'Change Avatar';

  @override
  String get groupTopics => 'Topics';

  @override
  String get groupTopicsEmpty => 'No topics yet';

  @override
  String get syncInProgress => 'Syncing message history...';

  @override
  String get recoveryKeyReminderTitle => 'Protect your messages';

  @override
  String get recoveryKeyReminderDesc =>
      'Create a recovery key to securely sync encrypted messages across devices';

  @override
  String get recoveryKeySetupNow => 'Set up now';

  @override
  String get recoveryKeyRemindLater => 'Remind me later';

  @override
  String get channelReadOnly => '仅管理员可在此频道发言';

  @override
  String get channelSubscribers => '订阅者';

  @override
  String get channelVerified => '已认证频道';

  @override
  String get redPacketHistory => '红包记录';

  @override
  String get redPacketSent => '已发出';

  @override
  String get redPacketReceived => '已收到';

  @override
  String get redPacketExpired => '已过期';

  @override
  String get redPacketClaimed => '已领取';

  @override
  String get redPacketInsufficientBalance => '余额不足';

  @override
  String selfDestructCountdown(String time) {
    return '$time 后销毁';
  }

  @override
  String get messageDestroyed => '消息已销毁';

  @override
  String miniAppPermissionDenied(String permission) {
    return '权限不足：$permission';
  }

  @override
  String get aiSuggestionGasFee => '什么是 Gas 费？';

  @override
  String get aiSuggestionDefi => 'DeFi 入门';

  @override
  String get aiSuggestionSecurity => '如何检查合约安全';

  @override
  String get aiSuggestionBridge => '跨链桥接';

  @override
  String get channelDiscoverTitle => '发现频道';

  @override
  String get channelDiscoverSearch => '搜索频道...';

  @override
  String get channelJoin => '加入';

  @override
  String get channelJoined => '已加入';

  @override
  String get channelCategory => '分类';

  @override
  String slowModeCooldown(int seconds) {
    return '慢速模式：请等待 $seconds 秒';
  }

  @override
  String get addressCopyAction => '复制地址';

  @override
  String get addressSendMessage => '发消息';

  @override
  String get addressViewProfile => '查看资料';

  @override
  String get sendToAddress => '通过钱包地址发消息';
}
