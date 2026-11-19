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
  String authLoginFailed(Object error) {
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
      'L\'autorizzazione al microfono è stata negata. Abilitalo nelle impostazioni di sistema per utilizzare i messaggi vocali.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Impossibile avviare la registrazione: $error';
  }

  @override
  String get commonRecordingTooShort => 'Registrazione troppo breve';

  @override
  String commonStopRecordingFailed(Object error) {
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
  String get commonChat => 'Chatta';

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
  String get chatReadAloud => 'Leggi ad alta voce';

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
  String contactN42Id(Object id) {
    return 'ID N42: $id';
  }

  @override
  String get profileN42IdTitle => 'ID N42';

  @override
  String get profileN42Bean => 'Fagiolo N42';

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
  String get profileNickname => 'Soprannome';

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
  String profileSaveFailed(Object error) {
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
  String get authAnd => ' e ';

  @override
  String get authPrivacyPolicy => 'Informativa sulla privacy';

  @override
  String get authServerAddress => 'Indirizzo server';

  @override
  String get authEnterServerAddress => 'Inserisci indirizzo server';

  @override
  String authConnectedTo(Object serverName) {
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
  String get authPassword => 'Parola d\'ordine';

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
  String commonFeatureComingSoon(Object feature) {
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
  String conversationDeleteConversationConfirm(Object name) {
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
  String get contactChatOnlyFriends => 'Amici solo chat';

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
  String get commonFileLabel => 'Archivio';

  @override
  String get commonLocationLabel => 'Posizione';

  @override
  String contactRecommendFailed(Object error) {
    return 'Raccomandazione fallita: $error';
  }

  @override
  String get profileEnterRemark => 'Inserisci nota';

  @override
  String get contactOpeningChat => 'Apertura chat...';

  @override
  String contactOpenChatFailed(Object error) {
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
  String get profileOnline => 'In linea';

  @override
  String get profileOffline => 'Non in linea';

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
  String commonGroupMembers(Object count) {
    return 'Membri ($count)';
  }

  @override
  String get groupMembersTitle => 'Membri del gruppo';

  @override
  String get groupViewAll => 'Vedi tutti';

  @override
  String get groupOwner => 'Proprietario';

  @override
  String get groupAdmin => 'Ammin';

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
  String transferAvailableBalance(Object balance, Object symbol) {
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
  String commonFromSender(String name) {
    return 'Da $name';
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
  String get profileQrCode => 'Codice QR';

  @override
  String get profileAvatarUpdated => 'Avatar aggiornato';

  @override
  String commonSelectImageFailed(Object error) {
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
  String profileSaveAddressFailed(Object error) {
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
  String profileSaveInvoiceFailed(Object error) {
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
  String favoriteOpenItem(Object content) {
    return 'Apri: $content';
  }

  @override
  String get favoriteDeleted => 'Eliminato';

  @override
  String get profileWallet => 'Portafoglio';

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
  String commonFeatureInDevelopment(Object feature) {
    return 'La funzionalità $feature è in sviluppo…';
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
  String get authRegistrationDisabled =>
      'La registrazione su questo server è disabilitata. Contatta il suo amministratore per abilitarla.';

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
  String get chatFailedToLoadImage => 'Caricamento immagine fallito';

  @override
  String get chatVideoRecordingFailed =>
      'Registrazione video fallita. Riprova.';

  @override
  String get profileRedPacket => 'Busta rossa';

  @override
  String get commonMusic => 'Musica';

  @override
  String get commonCoupon => 'Buono';

  @override
  String get commonGift => 'Regalo';

  @override
  String get commonPoll => 'Sondaggio';

  @override
  String get favoriteText => 'Testo';

  @override
  String get favoriteLinkLabel => 'Collegamento';

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
  String get profileOk => 'Va bene';

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
  String get commonGroupAdmin => 'Ammin';

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
  String get searchClearHistoryConfirm =>
      'Cancellare tutte le ricerche recenti?';

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
  String get settingsDeleteAccountTitle => 'Elimina account';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Disattiva questo account Matrix e pulisci i relativi dati di chat locali';

  @override
  String get settingsDeleteAccountExplanation =>
      'Questa azione richiede la disattivazione permanente dell’account Matrix. Dopo la conferma del server, l’app rimuove la sessione di chat locale e le chiavi di crittografia di questo account quando è sicuro farlo. Gli altri account e il portafoglio vengono mantenuti. La federazione e le regole di conservazione dei server possono limitare la cancellazione dei dati.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Password Matrix, se richiesta';

  @override
  String get settingsDeleteAccountServerErase =>
      'Richiedi la cancellazione dei dati sul server';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Chiedi a questo homeserver di cancellare i dati dell’account, dove supportato. Potrebbero rimanere copie su altri server o soggette a obblighi di conservazione.';

  @override
  String get settingsDeleteAccountChooseStage =>
      'Verifica questo account Matrix';

  @override
  String get settingsDeleteAccountUsePassword => 'Usa la password Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'Continua nel browser';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Torna dalla verifica Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Il ritorno dal browser non conferma l’eliminazione. Controlla la richiesta originale con il server Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'Controlla con il server';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'Il server Matrix non ha confermato l’eliminazione dell’account.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Pulizia locale dell’account in sospeso';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Controlla la pulizia di un account Matrix disattivato in precedenza';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Impossibile leggere i record di pulizia in sospeso. Tocca per riprovare.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'L’account Matrix è stato disattivato, ma la pulizia locale è ancora in sospeso. Gli altri account restano disponibili.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'La gestione dell’account è stata aperta nel browser. L’eliminazione non è stata confermata in questa app, quindi la sessione di chat resta disponibile.';

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
  String get settingsBackupSuccess =>
      'Backup delle chiavi riuscito correttamente';

  @override
  String get settingsBackupFailed => 'Backup non riuscito';

  @override
  String get settingsRecoveryKey => 'Chiave di ripristino';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Salva questa chiave di ripristino in un luogo sicuro. Ne avrai bisogno per ripristinare i tuoi messaggi crittografati su un nuovo dispositivo.';

  @override
  String get settingsRecoveryKeySaved => 'L\'ho salvato';

  @override
  String get settingsRestoreSuccess => 'Chiavi ripristinate correttamente';

  @override
  String get settingsRestoreEmpty =>
      'Nessuna chiave dei messaggi trovata in questo backup.';

  @override
  String settingsRestoreSessions(int count) {
    return 'Ripristinate $count sessioni di chiavi. I messaggi senza chiavi potrebbero rimanere crittografati.';
  }

  @override
  String get settingsRestoreFailed => 'Ripristino non riuscito';

  @override
  String get settingsPassword => 'Parola d\'ordine';

  @override
  String get settingsEnterRecoveryKey => 'Inserisci la chiave di ripristino';

  @override
  String get settingsEnterPassword => 'Inserisci la password';

  @override
  String get settingsExportSuccess =>
      'Chiavi esportate correttamente nel backup del server';

  @override
  String get settingsExportNeedBackupFirst =>
      'Crea prima un backup della chiave';

  @override
  String get settingsExportFailed => 'Esportazione non riuscita';

  @override
  String get settingsResetSuccess =>
      'Reimpostazione della crittografia riuscita';

  @override
  String get settingsResetFailed => 'Reimpostazione non riuscita';

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
  String get chatNetworkLink => 'Collegamento';

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
  String get chatNoMediaUrlAvailable => 'URL multimediale non disponibile';

  @override
  String chatDownloadFailed(String code) {
    return 'Download fallito: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Link musicale';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Le buste rosse e i trasferimenti non possono essere inoltrati';

  @override
  String commonShareFailed(String error) {
    return 'Condivisione fallita: $error';
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
  String groupMemberCountClickToCopy(Object count) {
    return '$count membri, fai clic per copiare l\'ID del gruppo';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Non hai il permesso di modificare il nome del gruppo';

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
  String get settingsTranslation => 'Traduzione';

  @override
  String get settingsTranslateTextTo => 'Traduci il testo in';

  @override
  String get settingsTranslateDescription =>
      'Seleziona la lingua in cui desideri che i messaggi vengano tradotti.';

  @override
  String get settingsAutoTranslate =>
      'Traduci automaticamente i messaggi ricevuti';

  @override
  String get settingsAutoTranslateDescription =>
      'Traduci automaticamente i messaggi ricevuti in chat nella lingua selezionata.';

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
  String get authPasskeyLabel => 'Chiave di accesso';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'mela';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Questo server non ha configurato provider di accesso SSO';

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
  String get contactCreateTag => 'Crea etichetta';

  @override
  String get contactEnterTagName => 'Inserisci il nome dell\'etichetta';

  @override
  String get contactEditTag => 'Modifica etichetta';

  @override
  String get contactDeleteTag => 'Elimina etichetta';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Sei sicuro di voler eliminare il tag \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'Nessun tag ancora';

  @override
  String get contactFriendPermissions => 'Permessi degli amici';

  @override
  String get contactSetChatOnly => 'Imposta come Solo chat';

  @override
  String get contactChatOnlyDesc =>
      'Puoi chattare solo con te, gli altri contenuti saranno nascosti';

  @override
  String get contactHideMyMoments => 'Nascondi i miei momenti';

  @override
  String get contactHideMyMomentsDesc =>
      'Questo amico non può vedere i miei Momenti';

  @override
  String get contactHideTheirMoments => 'Nascondi i loro momenti';

  @override
  String get contactHideTheirMomentsDesc =>
      'Non vedere i Momenti di questo amico';

  @override
  String get contactHideMyStatus => 'Nascondi il mio stato';

  @override
  String get contactHideMyStatusDesc =>
      'Questo amico non può vedere i miei aggiornamenti di stato';

  @override
  String get contactNoChatOnlyFriends => 'Nessun amico solo in chat';

  @override
  String get contactNoOfficialAccounts => 'Nessun account ufficiale';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Segui gli account ufficiali per ricevere gli ultimi aggiornamenti';

  @override
  String get contactNoServiceAccounts => 'Nessun account di servizio';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Iscriviti agli account di servizio per servizi convenienti';

  @override
  String get contactNoEnterpriseContacts => 'Nessun contatto aziendale';

  @override
  String get contactEnterpriseContactsDesc =>
      'I contatti aziendali verranno visualizzati qui';

  @override
  String get profileCardPack => 'Pacchetto di carte';

  @override
  String get profileOrders => 'Ordini';

  @override
  String get profileNoOrders => 'Nessun ordine';

  @override
  String get profileOrdersDesc => 'I tuoi ordini verranno visualizzati qui';

  @override
  String get profileNoCards => 'Nessuna carta';

  @override
  String get profileCardsDesc => 'Le tue carte verranno visualizzate qui';

  @override
  String get favoriteEnterTagsHint => 'Inserisci i tag separati da virgole';

  @override
  String get favoriteTagsUpdated => 'Tag aggiornati';

  @override
  String get favoriteForwardedContent => 'Contenuto inoltrato';

  @override
  String get favoriteEnterNoteContent => 'Inserisci il contenuto della nota';

  @override
  String get favoriteNoteAdded => 'Nota aggiunta';

  @override
  String get favoriteLinkTitle => 'Titolo del collegamento';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Collegamento aggiunto';

  @override
  String get contactPhotoAdded => 'Foto aggiunta';

  @override
  String get contactEnterPhone => 'Inserisci il numero di telefono';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Conversazione: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Contatto: $userId';
  }

  @override
  String get commonDiscover => 'Scopri';

  @override
  String commonDeveloping(Object title) {
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
  String get settingsFontSizeStandard => 'Norma';

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
  String get discoverLive => 'Vivi';

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
  String get groupVisibilityUpdated => 'Visibilità del gruppo aggiornata';

  @override
  String get groupChannelCreated => 'Canale creato';

  @override
  String get groupChannelUpdated => 'Canale aggiornato';

  @override
  String get groupChannelDeleted => 'Canale eliminato';

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
  String callJoinMeetingFailed(Object error) {
    return 'Impossibile partecipare alla riunione: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Condivisione schermo fallita: $error';
  }

  @override
  String get profileN42BeanTitle => 'Fagiolo N42';

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
  String profilePlayFailed(Object ringtoneName) {
    return 'Riproduzione fallita: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return 'In riproduzione: $ringtoneName';
  }

  @override
  String get profileStop => 'Fermati';

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
  String commonReadCount(Object count) {
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
  String get securityDeviceIdRequired => 'L\'ID del dispositivo è obbligatorio';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Impossibile avviare la verifica: $error';
  }

  @override
  String get securityVerificationFailed => 'Verifica non riuscita';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Verifica non riuscita: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Verifica rifiutata: l\'emoji non corrisponde';

  @override
  String get securityWaitingForDeviceAccept =>
      'In attesa che l\'altro dispositivo accetti...';

  @override
  String get securityVerifyDevice => 'Verifica questo dispositivo';

  @override
  String get securityConfirmEmojiMatch =>
      'Conferma che le emoji seguenti siano visualizzate su entrambi i dispositivi, nello stesso ordine';

  @override
  String get securityEmojiDontMatch => 'Non corrispondono';

  @override
  String get securityEmojiMatch => 'Corrispondono';

  @override
  String get securityWaitingForDeviceConfirm =>
      'In attesa della conferma dell\'altro dispositivo...';

  @override
  String get securityVerificationSuccess => 'Verifica riuscita!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Questo dispositivo è ora verificato e affidabile.';

  @override
  String get securityCompareEmoji =>
      'Confronta le emoji su entrambi i dispositivi';

  @override
  String get securityCompareNumbers =>
      'Confronta i numeri su entrambi i dispositivi';

  @override
  String get commonTryAgain => 'Riprova';

  @override
  String get commonDone => 'Fatto';

  @override
  String get chatExportTitle => 'Esporta chat';

  @override
  String get chatExportSuccess => 'Esportazione riuscita';

  @override
  String chatExportFailed(String error) {
    return 'Esportazione non riuscita: $error';
  }

  @override
  String get chatExportFormat => 'Formato di esportazione';

  @override
  String get chatExportHtmlDesc =>
      'Leggibile in qualsiasi browser con layout in stile';

  @override
  String get chatExportJsonDesc =>
      'Formato dati strutturati leggibile dalla macchina';

  @override
  String get chatExportDateRange => 'Intervallo di date';

  @override
  String get chatExportAll => 'Tutti i messaggi';

  @override
  String get chatExportLastWeek => 'Ultimi 7 giorni';

  @override
  String get chatExportLastMonth => 'Il mese scorso';

  @override
  String get chatExportLast3Months => 'Ultimi 3 mesi';

  @override
  String get chatExportMessageCount => 'Messaggi da esportare';

  @override
  String get chatExportButton => 'Esporta e condividi';

  @override
  String get chatMediaGallery => 'Galleria multimediale';

  @override
  String get chatExportHistory => 'Esporta cronologia chat';

  @override
  String get pdfLoadFailed => 'Impossibile caricare il PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'Tutto';

  @override
  String get mediaImages => 'Immagini';

  @override
  String get mediaVideos => 'Video';

  @override
  String get mediaFiles => 'File';

  @override
  String get mediaAudio => 'Audio';

  @override
  String mediaItemsCount(int count) {
    return 'Articoli $count';
  }

  @override
  String get mediaNoMediaFound => 'Nessun supporto trovato';

  @override
  String get spacesTitle => 'Comunità';

  @override
  String get spacesCreate => 'Crea comunità';

  @override
  String get spacesJoined => 'Iscritto';

  @override
  String get spacesDiscover => 'Scopri';

  @override
  String get spacesNoJoined => 'Nessuna comunità si è ancora unita';

  @override
  String get spacesExplore => 'Esplora le comunità';

  @override
  String get spacesNoPublic => 'Nessuna comunità pubblica trovata';

  @override
  String get spacesJoin => 'Partecipa';

  @override
  String get spacesSubSpaces => 'Sottocomunità';

  @override
  String get spacesChannels => 'Canali';

  @override
  String spacesMembersCount(int count) {
    return 'Membri $count';
  }

  @override
  String get spacesPublic => 'Pubblico';

  @override
  String get spacesPrivate => 'Privato';

  @override
  String get spacesSuggested => 'Suggerito';

  @override
  String spacesChannelsCount(int count) {
    return 'Canali $count';
  }

  @override
  String get callInCallChat => 'Chat durante la chiamata';

  @override
  String callMessagesCount(int count) {
    return 'Messaggi $count';
  }

  @override
  String get callNoMessagesYet =>
      'Nessun messaggio ancora.\nInvia un messaggio per iniziare.';

  @override
  String get callTypeMessage => 'Digita un messaggio...';

  @override
  String get callYouSender => 'Tu';

  @override
  String get callChatLabel => 'Chatta';

  @override
  String get chatEdited => 'Modificato';

  @override
  String get chatEditHistory => 'Modifica cronologia';

  @override
  String get chatOriginalMessage => 'Originale';

  @override
  String chatEditedAt(String time) {
    return 'Modificato in $time';
  }

  @override
  String get chatViewOnce => 'Visualizza una volta';

  @override
  String get chatViewOncePhoto => 'Visualizza una volta la foto';

  @override
  String get chatViewOnceVideo => 'Guarda una volta il video';

  @override
  String get chatViewOnceViewed => 'Visualizzato';

  @override
  String get chatViewOnceExpired => 'Scaduto';

  @override
  String get chatViewOnceTap => 'Tocca per visualizzare';

  @override
  String get chatAutoFaceBlur => 'Sfocatura automatica del volto';

  @override
  String get chatAutoFaceBlurDesc =>
      'Sfoca automaticamente i volti quando invii foto';

  @override
  String get threadReplyInThread => 'Rispondi nel thread';

  @override
  String threadReplies(int count) {
    return '$count risponde';
  }

  @override
  String get threadReply => '1 risposta';

  @override
  String threadLatestReply(String preview) {
    return 'Ultimo: $preview';
  }

  @override
  String get threadTitle => 'Filo';

  @override
  String get threadReplyPlaceholder => 'Rispondi nel thread...';

  @override
  String threadParticipants(int count) {
    return 'Partecipanti $count';
  }

  @override
  String get voiceRoomTitle => 'Stanza della voce';

  @override
  String get voiceRoomCreate => 'Crea stanza vocale';

  @override
  String get voiceRoomJoin => 'Partecipa';

  @override
  String get voiceRoomLeave => 'Lascia';

  @override
  String get voiceRoomEnd => 'Fine stanza';

  @override
  String get voiceRoomRaiseHand => 'Alza la mano';

  @override
  String get voiceRoomLowerHand => 'Mano inferiore';

  @override
  String get voiceRoomMute => 'Muto';

  @override
  String get voiceRoomUnmute => 'Riattiva';

  @override
  String get voiceRoomHost => 'Ospite';

  @override
  String get voiceRoomSpeakers => 'Altoparlanti';

  @override
  String get voiceRoomListeners => 'Ascoltatori';

  @override
  String get voiceRoomLive => 'VIVI';

  @override
  String get voiceRoomEnded => 'Finito';

  @override
  String get voiceRoomScheduled => 'Programmato';

  @override
  String get voiceRoomApprove => 'Approvare';

  @override
  String get voiceRoomDemote => 'Passa all\'ascoltatore';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name ha alzato la mano';
  }

  @override
  String get voiceRoomName => 'Nome della stanza';

  @override
  String get voiceRoomTopic => 'Argomento (facoltativo)';

  @override
  String get voiceRoomNoActive => 'Nessuna stanza vocale attiva';

  @override
  String get voiceRoomConnecting => 'Connessione...';

  @override
  String get usernameTitle => 'Nome utente';

  @override
  String get usernameSet => 'Imposta il nome utente';

  @override
  String get usernameChange => 'Cambia nome utente';

  @override
  String get usernamePlaceholder => 'Inserisci il nome utente';

  @override
  String get usernameAvailable => 'Nome utente disponibile';

  @override
  String get usernameUnavailable => 'Nome utente già preso';

  @override
  String get usernameInvalid =>
      '3-30 caratteri, lettere minuscole, numeri, trattino basso. Deve iniziare con una lettera.';

  @override
  String get usernameReserved => 'Questo nome utente è riservato';

  @override
  String get usernameSaved => 'Nome utente salvato';

  @override
  String get usernameSearchHint => 'Cerca per @nomeutente';

  @override
  String get ensName => 'Nome dell\'ENS';

  @override
  String get ensLinked => 'Collegato all\'ENS';

  @override
  String get ensResolving => 'Risoluzione dell\'ENS...';

  @override
  String get ensNotFound => 'Nome ENS non trovato';

  @override
  String get tokenGateTitle => 'Porta dei gettoni';

  @override
  String get tokenGateEnable => 'Abilita token gate';

  @override
  String get tokenGateDisable => 'Disabilita token gate';

  @override
  String get tokenGateAddRule => 'Aggiungi regola';

  @override
  String get tokenGateRemoveRule => 'Rimuovi regola';

  @override
  String get tokenGateContractAddress => 'Indirizzo del contratto';

  @override
  String get tokenGateMinBalance => 'Saldo minimo';

  @override
  String get tokenGateTokenId => 'ID token (ERC-1155)';

  @override
  String get tokenGateChainId => 'Identificativo della catena';

  @override
  String get tokenGateVerifying => 'Verifica delle disponibilità di token...';

  @override
  String get tokenGateVerified => 'Verifica superata';

  @override
  String get tokenGateDenied => 'Non soddisfi i requisiti del token';

  @override
  String get tokenGateOperatorAnd => 'Deve soddisfare TUTTE le regole';

  @override
  String get tokenGateOperatorOr => 'Deve soddisfare QUALSIASI regola';

  @override
  String get tokenGateRuleErc20 => 'Gettone ERC-20';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Multi-token (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Gettone nativo';

  @override
  String get tokenGateSaved => 'Porta token salvata';

  @override
  String get tokenGateEnableDescription =>
      'Richiedi ai membri di conservare i token per aderire';

  @override
  String get tokenGateOperator => 'Logica delle regole';

  @override
  String get tokenGateRules => 'Regole';

  @override
  String get tokenGateSymbol => 'Simbolo (facoltativo)';

  @override
  String get tokenGateChain => 'Catena';

  @override
  String get tokenGateTokenStandard => 'Norma sui gettoni';

  @override
  String get tokenGateDenialMessage => 'Messaggio di rifiuto';

  @override
  String get tokenGateDenialMessageHint =>
      'Messaggio mostrato quando la verifica fallisce';

  @override
  String get tokenGateVerifyTitle => 'Verifica dei token';

  @override
  String get tokenGateVerifyPassed => 'Verifica superata';

  @override
  String get tokenGateVerifyFailed => 'Verifica non riuscita';

  @override
  String get tokenGateRetryVerify => 'Riprova';

  @override
  String get tokenGateRequired => 'Obbligatorio';

  @override
  String get tokenGateYourBalance => 'Il tuo equilibrio';

  @override
  String get tokenGateRulesActive => 'regole attive';

  @override
  String get tokenGateDisabled => 'Disabilitato';

  @override
  String get ensNotBound => 'Non vincolato';

  @override
  String get liveLocation => 'Posizione in tempo reale';

  @override
  String get stopLiveLocation => 'Interrompi la condivisione';

  @override
  String get startLiveLocation => 'Inizia a condividere';

  @override
  String get selectDuration => 'Seleziona Durata';

  @override
  String get groupChatFiles => 'File di chat';

  @override
  String get groupLinks => 'Collegamenti';

  @override
  String get groupNoLinks => 'Nessun collegamento ancora';

  @override
  String get chatBackground => 'Sfondo della chat';

  @override
  String get solidColors => 'Colori solidi';

  @override
  String get gradients => 'Gradienti';

  @override
  String get defaultBackground => 'Predefinito';

  @override
  String get settingsFontSizeSlider => 'Dimensione carattere';

  @override
  String get autoDownload => 'Download automatico';

  @override
  String get images => 'Immagini';

  @override
  String get voice => 'Voce';

  @override
  String get video => 'Video';

  @override
  String get files => 'File';

  @override
  String get mobileData => 'Dati mobili';

  @override
  String get roaming => 'Vagabondaggio';

  @override
  String get storageManagement => 'Stoccaggio';

  @override
  String get totalUsage => 'Utilizzo totale';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Altro';

  @override
  String get clearCache => 'Cancella cache';

  @override
  String get cacheCleared => 'Cache cancellata';

  @override
  String get clearCacheFailed => 'Impossibile svuotare la cache';

  @override
  String get confirmClearCache => 'Cancellare tutti i dati della cache?';

  @override
  String get mapView => 'Visualizzazione mappa';

  @override
  String liveLocationSharingCount(int count) {
    return '$count persone che condividono la posizione';
  }

  @override
  String get minutes15 => '15 minuti';

  @override
  String get minutes30 => '30 minuti';

  @override
  String get hour1 => '1 ora';

  @override
  String get hours8 => '8 ore';

  @override
  String get personalCard => 'Carta personale';

  @override
  String get downloadFailed => 'Download non riuscito';

  @override
  String get locationExpired => 'Scaduto';

  @override
  String secondsRemaining(int count) {
    return '$count secondi';
  }

  @override
  String minutesRemaining(int count) {
    return '$count minuti';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours ore $minutes minuti';
  }

  @override
  String get favoriteMessages => 'Preferiti';

  @override
  String get linksCopied => 'Collegamento copiato';

  @override
  String get noLinksFound => 'Nessun collegamento trovato';

  @override
  String get roomStorageRanking => 'Classifica dello stoccaggio delle stanze';

  @override
  String get downloadComplete => 'Scaricamento completato';

  @override
  String get downloading => 'Download in corso...';

  @override
  String get draftSaved => 'Bozza salvata';

  @override
  String get voiceRecording => 'Registrazione vocale';

  @override
  String get searchLocation => 'Cerca posizione';

  @override
  String get tapToSearch => 'Tocca per cercare';

  @override
  String get settingsThisDevice => 'Questo dispositivo';

  @override
  String get settingsJustNow => 'Proprio adesso';

  @override
  String get settingsDeviceId => 'ID del dispositivo';

  @override
  String get settingsStatus => 'Stato';

  @override
  String get settingsLastActive => 'Ultimo attivo';

  @override
  String get settingsIpAddress => 'Indirizzo IP';

  @override
  String get settingsRenameDevice => 'Rinominare il dispositivo';

  @override
  String get settingsDeviceNameHint => 'Inserisci il nome del dispositivo';

  @override
  String get settingsDeviceRenamed => 'Dispositivo rinominato';

  @override
  String get settingsRenameFailed => 'Rinomina non riuscita';

  @override
  String get settingsRemoteLogout => 'Disconnessione remota';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Sei sicuro di voler uscire da \"$deviceName\"? Questa azione non può essere annullata.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Dispositivo disconnesso';

  @override
  String get settingsLogoutFailed => 'Disconnessione non riuscita';

  @override
  String get settingsLogout => 'Esci';

  @override
  String get settingsVerifyIdentity => 'Verificare l\'identità';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Inserisci la tua password per confermare questa azione.';

  @override
  String get scheduledSendTitle => 'Pianifica il messaggio';

  @override
  String get scheduledSendInOneHour => 'Tra 1 ora';

  @override
  String get scheduledSendTonight => 'Stasera (20:00)';

  @override
  String get scheduledSendTomorrowMorning => 'Domani mattina (9:00)';

  @override
  String get scheduledSendCustom => 'Scegli una data e un\'ora';

  @override
  String get scheduledMessageLabel => 'Programmato';

  @override
  String get scheduledMessageCancel => 'Annulla il messaggio programmato';

  @override
  String get chatLockTitle => 'Blocco chat';

  @override
  String get chatLockEnable => 'Blocca questa chat';

  @override
  String get chatLockDisable => 'Sblocca questa chat';

  @override
  String get chatLockDescription =>
      'Le chat bloccate richiedono la verifica biometrica o PIN per essere aperte';

  @override
  String get chatLockVerifyTitle => 'Chat bloccata';

  @override
  String get chatLockVerifySubtitle => 'Verifica per accedere a questa chat';

  @override
  String get chatLockVerifyFailed => 'Verifica non riuscita';

  @override
  String get chatLockEnabled => 'Chat bloccata';

  @override
  String get chatLockDisabled => 'Chat sbloccata';

  @override
  String get chatLockPinTitle => 'Inserisci il PIN';

  @override
  String get chatLockPinSetTitle => 'Imposta il PIN';

  @override
  String get chatLockPinConfirmTitle => 'Conferma il PIN';

  @override
  String get chatLockPinMismatch => 'Il PIN non corrisponde';

  @override
  String get chatLockUseBiometric => 'Usa la biometria';

  @override
  String get chatLockUsePin => 'Utilizza il PIN';

  @override
  String get mediaEditorUndo => 'Annulla';

  @override
  String get mediaEditorRedo => 'Rifare';

  @override
  String get mediaEditorCrop => 'Ritaglia';

  @override
  String get mediaEditorFilter => 'Filtra';

  @override
  String get mediaEditorDraw => 'Disegna';

  @override
  String get mediaEditorText => 'Testo';

  @override
  String get aiAssistant => 'Assistente AI';

  @override
  String get aiAssistantWelcome =>
      'Ciao! Sono l\'Assistente AI N42. Come posso aiutarla?';

  @override
  String get aiAssistantNotConfigured => 'Servizio AI non configurato';

  @override
  String get aiAssistantSettings => 'Impostazioni dell\'IA';

  @override
  String get aiAssistantClearHistory => 'Cancella la cronologia della chat';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Sei sicuro di voler cancellare tutta la cronologia chat dell\'IA?';

  @override
  String get aiAssistantStopGenerating => 'Smetti di generare';

  @override
  String get aiAssistantModel => 'Modello';

  @override
  String get aiAssistantTemperature => 'Temperatura';

  @override
  String get aiAssistantMaxTokens => 'Token massimi';

  @override
  String get aiAssistantContextWindow => 'Finestra di contesto';

  @override
  String get aiAssistantServiceStatus => 'Stato del servizio';

  @override
  String get aiAssistantAvailable => 'Disponibile';

  @override
  String get aiAssistantUnavailable => 'Non disponibile';

  @override
  String get aiSummarize => 'Riepilogo dell\'IA';

  @override
  String aiSummarizeUnread(int count) {
    return 'Riepiloga i messaggi $count non letti';
  }

  @override
  String get aiSummarizeLoading => 'Riassumendo...';

  @override
  String get aiSummarizeError => 'Impossibile riassumere';

  @override
  String get aiRewrite => 'Riscrittura dell\'intelligenza artificiale';

  @override
  String get aiRewriteFormal => 'Formale';

  @override
  String get aiRewriteCasual => 'Casuale';

  @override
  String get aiRewritePlayful => 'Giocoso';

  @override
  String get aiRewriteProfessional => 'Professionale';

  @override
  String get aiRewriteAccept => 'Utilizzare';

  @override
  String get aiRewriteCancel => 'Annulla';

  @override
  String get aiRewriteLoading => 'Riscrittura...';

  @override
  String get aiLinkSummary => 'Riepilogo dell\'IA';

  @override
  String get aiLinkSummaryAnalyzing => 'Analizzando...';

  @override
  String get chatFolderManagement => 'Gestisci cartelle';

  @override
  String get chatFolderSystem => 'Cartelle di sistema';

  @override
  String get chatFolderCustom => 'Cartelle personalizzate';

  @override
  String get chatFolderEmpty => 'Nessuna cartella personalizzata ancora';

  @override
  String get chatFolderCreate => 'Crea cartella';

  @override
  String get chatFolderEdit => 'Modifica cartella';

  @override
  String get chatFolderNameHint => 'Nome della cartella';

  @override
  String get chatFolderAll => 'Tutto';

  @override
  String get chatFolderUnread => 'Non letto';

  @override
  String get chatFolderPersonal => 'Personale';

  @override
  String get chatFolderGroups => 'Gruppi';

  @override
  String get chatFolderChannels => 'Canali';

  @override
  String get chatFolderMuted => 'Disattivato';

  @override
  String get storyAddMusic => 'Aggiungi musica';

  @override
  String get storyChangeMusic => 'Cambia musica';

  @override
  String get storyBackgroundMusic => 'Musica di sottofondo';

  @override
  String get storyMusicPreview => 'Anteprima (max 15s)';

  @override
  String get storyChooseFromDevice => 'Scegli da Dispositivo';

  @override
  String get storyUseThisMusic => 'Usa questa musica';

  @override
  String get authPasskeyNotSupported =>
      'La passkey non è supportata su questo dispositivo';

  @override
  String get authPasskeyRegister => 'Registra la chiave di accesso';

  @override
  String get authPasskeyNoRegistered => 'Nessuna passkey registrata';

  @override
  String get authPasskeyRegisterHint =>
      'Registra una passkey per questo account. L\'accesso con passkey autonomo verrà abilitato in seguito.';

  @override
  String get authPasskeyNameYours => 'Assegna un nome alla tua passkey';

  @override
  String get authPasskeyRegistered => 'Passkey salvata su questo account';

  @override
  String get authPasskeyDeleted => 'Passkey rimossa da questo account';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Eliminare la chiave di accesso \"$name\"? Sarà necessario registrarlo nuovamente prima di utilizzare l\'accesso tramite passkey in un secondo momento.';
  }

  @override
  String get momentVisibilityPublic => 'Pubblico';

  @override
  String get momentVisibilityPrivate => 'Privato';

  @override
  String get momentVisibilityPartial => 'Amici selezionati';

  @override
  String get momentVisibilityExcluded => 'Escludi alcuni amici';

  @override
  String momentUserMoments(String userName) {
    return 'I momenti di $userName';
  }

  @override
  String get momentForwardTo => 'Inoltra a';

  @override
  String get momentForwardSuccess => 'Inoltrato con successo';

  @override
  String get momentSelectFriends => 'Seleziona Amici';

  @override
  String get momentSelectTags => 'Seleziona per tag';

  @override
  String momentSelectedCount(int count) {
    return 'Selezionato ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Nessun momento ancora';

  @override
  String get momentForwardMoment => 'Momento in avanti';

  @override
  String get momentAddComment => 'Aggiungi un commento...';

  @override
  String momentForwardContent(String content) {
    return '[Momento] $content';
  }

  @override
  String get momentDeleteMoment => 'Elimina momento';

  @override
  String get momentDeleteConfirm =>
      'Sei sicuro di voler eliminare questo momento?';

  @override
  String get momentComment => 'Commento';

  @override
  String get momentWriteComment => 'Scrivi un commento...';

  @override
  String get momentLike => 'Mi piace';

  @override
  String get momentUnlike => 'A differenza';

  @override
  String get momentForward => 'Avanti';

  @override
  String get momentDelete => 'Elimina';

  @override
  String get momentReply => 'risposta';

  @override
  String get momentMoment => 'Momento';

  @override
  String momentLikesCount(int count) {
    return 'A $count piace';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count commenti';
  }

  @override
  String get momentNoComments => 'Nessun commento ancora';

  @override
  String get momentFailedToLoad => 'Impossibile caricare l\'immagine';

  @override
  String momentReplyTo(String userName) {
    return 'Rispondi a $userName...';
  }

  @override
  String get momentNoConversations => 'Nessuna conversazione';

  @override
  String get momentJustNow => 'proprio adesso';

  @override
  String momentMinutesAgo(int count) {
    return '${count}m fa';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h fa';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}d fa';
  }

  @override
  String get chatGroupAnnouncementHint => 'Inserisci l\'annuncio del gruppo';

  @override
  String get chatGroupAnnouncementEmpty => 'Nessun annuncio';

  @override
  String get chatEditNickname => 'Modifica soprannome';

  @override
  String get chatNicknameHint => 'Inserisci il tuo nickname in questo gruppo';

  @override
  String get contactAddPhoneHint => 'Inserisci il numero di telefono';

  @override
  String get contactNotesHint => 'Aggiungi note su questo contatto';

  @override
  String get reportTitle => 'Rapporto';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Molestie';

  @override
  String get reportReasonFraud => 'Frode';

  @override
  String get reportReasonOther => 'Altro';

  @override
  String get reportSubmitted => 'Rapporto inviato';

  @override
  String get reportDescription => 'Descrizione aggiuntiva (facoltativa)';

  @override
  String get qrcodeSaved => 'Codice QR salvato nell\'album';

  @override
  String get chatSendRedPacketInChat =>
      'Per favore invia il pacchetto rosso in chat';

  @override
  String get commonSaveFailed => 'Salvataggio non riuscito';

  @override
  String get reportSelectReason => 'Seleziona un motivo';

  @override
  String get reportUnavailable => 'Accedi per inviare una segnalazione.';

  @override
  String get reportAccountChanged =>
      'L’account è cambiato. Riapri questa segnalazione per inviarla.';

  @override
  String get reportUnsupported =>
      'Questo homeserver non supporta le segnalazioni degli utenti.';

  @override
  String get reportRoomUnsupported =>
      'Questo homeserver non supporta le segnalazioni delle stanze.';

  @override
  String get reportRateLimited => 'Troppe segnalazioni. Riprova più tardi.';

  @override
  String get reportCouldNotSend =>
      'Impossibile inviare la segnalazione. Riprova.';

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
  String get gameBlockDrop => 'Blocca la caduta';

  @override
  String get gameBlockDropDesc => 'Fai cadere e cancella le righe';

  @override
  String get gameMinesweeper => 'Campo minato';

  @override
  String get gameMinesweeperDesc => 'Trova tutte le celle sicure';

  @override
  String get gameMatch3 => 'Partita 3';

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
  String get storyMyStory => 'La mia storia';

  @override
  String get storageSmartCleanup => 'Pulizia intelligente';

  @override
  String get storageOldMediaFiles => 'Vecchi file multimediali';

  @override
  String get storageLargeFiles => 'File di grandi dimensioni';

  @override
  String get storageAppCache => 'Cache dell\'app';

  @override
  String get storageSettings => 'Impostazioni di archiviazione';

  @override
  String get storageAutoCleanup => 'Pulizia automatica';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Pulisci automaticamente i file più vecchi di $days giorni';
  }

  @override
  String get storageCleanupPeriod => 'Periodo di pulizia';

  @override
  String get storagePreserveThumbnails => 'Conserva le miniature';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Conserva le miniature delle immagini durante la pulizia';

  @override
  String get storageWarningHigh =>
      'L\'utilizzo dello spazio di archiviazione è elevato. Prendi in considerazione la possibilità di ripulire i vecchi file.';

  @override
  String get storageWarningCritical =>
      'Lo spazio di archiviazione è estremamente basso. Pulisci per liberare spazio.';

  @override
  String storageFreed(String size, int count) {
    return '$size liberato (file $count)';
  }

  @override
  String storageDays(int days) {
    return '$days giorni';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Visualizza tutte le camere $count';
  }

  @override
  String get storageNoFiles => 'Nessun file trovato';

  @override
  String get storageFilePinned => 'Appuntato';

  @override
  String storageDeleteSelected(int count) {
    return 'Eliminare i file $count selezionati? Possono essere scaricati nuovamente dal server.';
  }

  @override
  String get backupRestore => 'Backup e ripristino';

  @override
  String get backupCreate => 'Crea backup';

  @override
  String get backupCreateDesc =>
      'Esegui il backup delle impostazioni e delle chiavi di crittografia. I messaggi verranno ripristinati dal server dopo il nuovo accesso.';

  @override
  String get backupIncludeKeys => 'Includere chiavi di crittografia';

  @override
  String get backupIncludeKeysDesc =>
      'Necessario per leggere i messaggi crittografati';

  @override
  String get backupPasswordProtect => 'Proteggi con password';

  @override
  String get backupEnterPassword => 'Inserisci la password di backup';

  @override
  String get backupHistory => 'Cronologia del backup';

  @override
  String get backupNoBackups => 'Nessun backup ancora';

  @override
  String get backupRestore2 => 'Ripristina';

  @override
  String get backupDelete => 'Elimina';

  @override
  String get backupDeleteConfirm =>
      'Sei sicuro di voler eliminare questo backup? Questa operazione non può essere annullata.';

  @override
  String get backupRestoreFromFile => 'Ripristina da file';

  @override
  String get backupRestoreFromFileDesc =>
      'Importa un file .n42backup da un altro dispositivo o da un backup precedente.';

  @override
  String get backupChooseFile => 'Scegli File di backup';

  @override
  String get backupRestoring => 'Ripristino...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Backup creato: stanze $rooms, messaggi $messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Impostazioni $settings ripristinate dalle stanze $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Backup non riuscito: $error';
  }

  @override
  String get backupPasswordRequired => 'Questo backup è protetto da password';

  @override
  String get blocGroupNotFound => 'Gruppo non trovato';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Membri $count invitati';
  }

  @override
  String get blocGroupMemberRemoved => 'Membro rimosso';

  @override
  String get blocGroupAdminRemoved => 'Amministratore rimosso';

  @override
  String get blocGroupLeft => 'Lasciato il gruppo';

  @override
  String get blocGroupDisbanded => 'Gruppo sciolto';

  @override
  String get blocGroupJoined => 'Mi sono unito al gruppo';

  @override
  String get blocGroupInviteDeclined => 'Invito rifiutato';

  @override
  String get blocGroupTokenGateUpdated => 'Porta token aggiornata';

  @override
  String get blocTransferProcessing => 'Trasferimento in elaborazione...';

  @override
  String get blocTransferCancelled => 'Trasferimento annullato';

  @override
  String get blocTransferFailed => 'Trasferimento non riuscito';

  @override
  String get blocPaymentProcessing => 'Elaborazione del pagamento...';

  @override
  String get blocPaymentFailed => 'Pagamento non riuscito';

  @override
  String get groupMaxMembers => 'Limite membri';

  @override
  String get groupMaxMembersUnlimited => 'Illimitato';

  @override
  String get groupMaxMembersHint =>
      'Inserisci il limite (lascia vuoto per illimitato)';

  @override
  String get groupMaxMembersUpdated => 'Limite membri aggiornato';

  @override
  String get groupFull => 'Il gruppo è al completo';

  @override
  String get groupChannels => 'Canali tematici';

  @override
  String get groupChannelsEmpty => 'Nessun canale ancora';

  @override
  String get groupChannelsCount => 'canali';

  @override
  String get groupChannelCreate => 'Nuovo canale';

  @override
  String get groupChannelName => 'Nome del canale';

  @override
  String get groupChannelTopic => 'Argomento del canale (facoltativo)';

  @override
  String get groupChannelDelete => 'Elimina canale';

  @override
  String get groupChannelDeleteConfirm =>
      'Eliminare questo canale? Tutti i messaggi andranno persi.';

  @override
  String get groupBotSettings => 'Impostazioni del bot';

  @override
  String get groupBotEnabled => 'Abilita Bot';

  @override
  String get groupBotWelcomeMessage => 'Modello di messaggio di benvenuto';

  @override
  String get groupBotWelcomeHint =>
      'Utilizza \"nome\" come segnaposto per il nome del nuovo membro';

  @override
  String get groupBotConfigUpdated => 'Impostazioni del bot aggiornate';

  @override
  String get groupContentFilter => 'Filtro contenuti';

  @override
  String get groupContentFilterEnabled => 'Abilita filtro parole chiave';

  @override
  String get groupContentFilterReplace => 'Sostituisci con ***';

  @override
  String get groupContentFilterHide => 'Nascondi messaggio';

  @override
  String get groupContentFilterAddWord => 'Aggiungi parola chiave';

  @override
  String get groupContentFilterUpdated => 'Filtro contenuti aggiornato';

  @override
  String get chatSlashCommands => 'Comandi';

  @override
  String get chatCommandPoll => '/poll: crea un sondaggio';

  @override
  String get chatCommandAnnounce => '/announce: invia un annuncio';

  @override
  String get chatCommandWelcome =>
      '/welcome — Imposta il messaggio di benvenuto';

  @override
  String get chatReportMessage => 'Rapporto';

  @override
  String get chatReportReason => 'Motivo della segnalazione';

  @override
  String get chatReportSpam => 'Spam';

  @override
  String get chatReportHarassment => 'Molestie';

  @override
  String get chatReportInappropriate => 'Contenuti inappropriati';

  @override
  String get chatReportOther => 'Altro';

  @override
  String get chatReportSuccess => 'Rapporto inviato';

  @override
  String get spacesName => 'Nome della comunità';

  @override
  String get spacesNameHint => 'ad es. Commercianti di criptovalute';

  @override
  String get spacesNameRequired => 'Il nome è obbligatorio';

  @override
  String get spacesDescription => 'Descrizione';

  @override
  String get spacesDescriptionHint => 'Di cosa tratta questa comunità?';

  @override
  String get spacesType => 'Tipo di comunità';

  @override
  String get spacesPublicDesc => 'Chiunque può scoprire e partecipare';

  @override
  String get spacesPrivateDesc => 'Possono partecipare solo i membri invitati';

  @override
  String get spacesNotFound => 'Comunità non trovata';

  @override
  String get spacesSearch => 'Cerca comunità...';

  @override
  String get spacesMembers => 'Membri';

  @override
  String get spacesNoChannels => 'Nessun canale ancora';

  @override
  String get spacesLeave => 'Lascia la comunità';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Sei sicuro di voler lasciare \"$name\"?';
  }

  @override
  String get spacesDelete => 'Elimina comunità';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Ciò eliminerà permanentemente \"$name\" e tutti i suoi canali. Questa azione non può essere annullata.';
  }

  @override
  String get spacesCreateChannel => 'Aggiungi canale';

  @override
  String get spacesChannelName => 'Nome del canale';

  @override
  String get spacesChannelTopic => 'Argomento (facoltativo)';

  @override
  String get spacesDeleteChannel => 'Elimina canale';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Sei sicuro di voler eliminare \"#$name\"?';
  }

  @override
  String get spacesEditName => 'Modifica nome';

  @override
  String get spacesEditDescription => 'Modifica descrizione';

  @override
  String spacesViewAllMembers(int count) {
    return 'Visualizza tutti i membri $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Calcia $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Divieto $name';
  }

  @override
  String get spacesPromoteAdmin => 'Promuovi ad amministratore';

  @override
  String get spacesDemoteAdmin => 'Rimuovi amministratore';

  @override
  String get spacesInviteMember => 'Invita membro';

  @override
  String get spacesInviteMemberUserId =>
      'ID utente (ad esempio @user:server.com)';

  @override
  String get spacesSave => 'Salva';

  @override
  String get settingsScreenshotProtection => 'Protezione degli screenshot';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Impedisci screenshot e registrazione dello schermo';

  @override
  String get chatSelfDestructTimer => 'Autodistruzione';

  @override
  String get chatTimerPickerTitle => 'Temporizzatore di autodistruzione';

  @override
  String get chatTimerOff => 'Spento';

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
      'Questo indirizzo di portafoglio non ha ancora un account N42. Puoi condividere con loro il tuo link di invito N42 per iniziare.';

  @override
  String get web3ShareInvite => 'Condividi invito';

  @override
  String get nftPickerTitle => 'Seleziona avatar NFT';

  @override
  String get nftPickerTabPopular => 'Popolari';

  @override
  String get nftPickerTabCustom => 'Personalizzato';

  @override
  String get nftPickerChain => 'Catena';

  @override
  String get nftPickerContract => 'Indirizzo del contratto';

  @override
  String get nftPickerTokenId => 'Identificativo del gettone';

  @override
  String get nftPickerVerifyOwnership => 'Verifica proprietà e anteprima';

  @override
  String get nftPickerUseAsAvatar => 'Usa come avatar';

  @override
  String get nftPickerPreview => 'Anteprima';

  @override
  String get nftPickerNotOwned => 'Non possiedi questo NFT';

  @override
  String get nftPickerInvalidTokenId => 'ID token non valido';

  @override
  String get nftPickerEnterBoth =>
      'Inserisci l\'indirizzo del contratto e l\'ID del token';

  @override
  String get nftPickerInfoTitle => 'Avatar NFT — Verificato on-chain';

  @override
  String get nftPickerInfoDesc =>
      'Associa un NFT che possiedi come avatar. Chiunque può verificare la proprietà sulla catena. Visualizzato con un anello d\'oro su N42.';

  @override
  String get nftPickerPopularCollections => 'Collezioni popolari';

  @override
  String get nftPickerWalletHint =>
      'Connetti il tuo wallet N42 per scoprire automaticamente i tuoi NFT su 236+ chain.';

  @override
  String get profileBindNftAvatar => 'Associa l\'avatar NFT';

  @override
  String get profileChangeAvatar => 'Cambia avatar';

  @override
  String get groupTopics => 'Argomenti';

  @override
  String get groupTopicsEmpty => 'Nessun argomento ancora';

  @override
  String get syncInProgress =>
      'Sincronizzazione della cronologia dei messaggi...';

  @override
  String get recoveryKeyReminderTitle => 'Proteggi i tuoi messaggi';

  @override
  String get recoveryKeyReminderDesc =>
      'Crea una chiave di ripristino per sincronizzare in modo sicuro i messaggi crittografati su tutti i dispositivi';

  @override
  String get recoveryKeySetupNow => 'Configura ora';

  @override
  String get recoveryKeyRemindLater => 'Ricordamelo più tardi';

  @override
  String get channelReadOnly =>
      'Solo gli amministratori possono pubblicare in questo canale';

  @override
  String get channelSubscribers => 'abbonati';

  @override
  String get channelVerified => 'Canale verificato';

  @override
  String get redPacketHistory => 'Storia del pacchetto rosso';

  @override
  String get redPacketSent => 'Inviato';

  @override
  String get redPacketReceived => 'Ricevuto';

  @override
  String get redPacketExpired => 'Scaduto';

  @override
  String get redPacketClaimed => 'Reclamato';

  @override
  String get redPacketInsufficientBalance => 'Equilibrio insufficiente';

  @override
  String selfDestructCountdown(String time) {
    return 'Autodistruzione in $time';
  }

  @override
  String get messageDestroyed => 'Messaggio distrutto';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Autorizzazione negata: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'Cos\'è la tassa sul gas?';

  @override
  String get aiSuggestionDefi => 'Guida per principianti alla DeFi';

  @override
  String get aiSuggestionSecurity =>
      'Come verificare la sicurezza del contratto';

  @override
  String get aiSuggestionBridge => 'Collegamento a catena incrociata';

  @override
  String get channelDiscoverTitle => 'Scopri i canali';

  @override
  String get channelDiscoverSearch => 'Cerca canali...';

  @override
  String get channelJoin => 'Partecipa';

  @override
  String get channelJoined => 'Iscritto';

  @override
  String get channelCategory => 'Categoria';

  @override
  String slowModeCooldown(int seconds) {
    return 'Modalità lenta: attendere ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Copia indirizzo';

  @override
  String get addressSendMessage => 'Invia messaggio';

  @override
  String get addressViewProfile => 'Visualizza profilo';

  @override
  String get sendToAddress => 'Invia all\'indirizzo del portafoglio';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Impossibile inviare il codice di verifica';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Questo server non supporta la reimpostazione della password e-mail';

  @override
  String get blocAuthResetPasswordFailed =>
      'Impossibile reimpostare la password';

  @override
  String get blocAuthChangePasswordFailed =>
      'Impossibile modificare la password';

  @override
  String get blocAuthOldPasswordWrong => 'Password attuale errata';

  @override
  String get blocAuthLoginCancelled => 'Accesso annullato';

  @override
  String get blocAuthGoogleLoginFailed => 'Accesso a Google non riuscito';

  @override
  String get blocAuthAppleLoginFailed => 'Accesso Apple non riuscito';

  @override
  String get blocAuthSsoLoginFailed => 'Accesso SSO non riuscito';

  @override
  String get blocAuthFacebookLoginFailed => 'Accesso a Facebook non riuscito';

  @override
  String get blocAuthTwitterLoginFailed => 'Accesso a Twitter non riuscito';

  @override
  String get blocAuthWeChatLoginFailed => 'Accesso a WeChat non riuscito';

  @override
  String get blocAuthWeChatNotConfigured => 'Accesso WeChat non configurato';

  @override
  String get blocAuthWeChatNotInstalled => 'Installa prima WeChat';

  @override
  String get blocAuthPasswordWrong => 'Password errata';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Questa email è già associata a un altro account';

  @override
  String get blocAuthChangeEmailFailed => 'Impossibile modificare l\'e-mail';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'Il codice di verifica non è corretto o è scaduto';

  @override
  String get blocAuthSessionExpired =>
      'Sessione scaduta, effettua nuovamente l\'accesso';

  @override
  String get blocAuthSessionIncomplete =>
      'Dati della sessione incompleti, effettua nuovamente l\'accesso';

  @override
  String get chatReadingMode => 'Modalità lettura';

  @override
  String get groupPoints => 'Punti';

  @override
  String get settingsPrivacySecurity => 'Privacy e sicurezza';

  @override
  String get settingsSystemAccounts => 'Sistema e account';

  @override
  String get settingsNotificationPrivacy => 'Privacy delle notifiche';

  @override
  String get settingsSenderOnly => 'Mostra solo il mittente';

  @override
  String get settingsHiddenNotification => 'Nascondi mittente e messaggio';

  @override
  String get settingsSmartFilter => 'Filtro intelligente';

  @override
  String get settingsEmailVerificationSent => 'Email di verifica inviata';

  @override
  String get settingsEmailLinkInstructions =>
      'Apri il link di verifica nella tua email, poi torna qui e conferma.';

  @override
  String get settingsSendVerificationEmail => 'Invia email di verifica';

  @override
  String get chatLogoutKeyWarning =>
      'Esegui il backup delle chiavi di crittografia prima di uscire, altrimenti potresti perdere l’accesso ai messaggi crittografati.';

  @override
  String get settingsBiometricUnavailable =>
      'Autenticazione biometrica non disponibile. Controlla la configurazione e le autorizzazioni nelle impostazioni del dispositivo.';

  @override
  String get chatEncryptionNotReady =>
      'La connessione sicura non è pronta. Messaggio non inviato. Controlla la connessione e la verifica dei dispositivi di entrambi gli account, quindi riprova.';

  @override
  String get contactRequestPending => 'In attesa di accettazione';

  @override
  String get chatFriendRequestPending =>
      'L’amicizia non è confermata. Controlla Contatti > Nuovi amici prima di inviare messaggi.';

  @override
  String contactPhotoCount(int count) {
    return '$count foto';
  }

  @override
  String get videoPublish => 'Pubblica video';

  @override
  String get videoGoLive => 'Avvia diretta';

  @override
  String get videoSelect => 'Seleziona video';

  @override
  String get videoLiveUnavailable =>
      'La trasmissione in diretta non è disponibile';

  @override
  String get qrcodeAlbum => 'Album';

  @override
  String get settingsSwitchAccount => 'Cambia account';

  @override
  String get chatFilterUnread => 'Non letti';

  @override
  String get chatFilterEmpty => 'Nessuna conversazione in questo filtro';

  @override
  String get accountAdd => 'Aggiungi account';

  @override
  String get accountCurrent => 'Account attuale';

  @override
  String get accountSwitching => 'Cambio account…';

  @override
  String get accountSwitchFailed =>
      'Impossibile cambiare account. Riprova o aggiungi l’account per accedere di nuovo.';

  @override
  String get accountSessionsHint =>
      'Cambia account qui per mantenere separati i messaggi e la sessione sicura di ogni account.';

  @override
  String get accountNoSaved => 'Nessun account salvato';

  @override
  String get contactRequestSent => 'Richiesta inviata';

  @override
  String get contactRequestsIncoming => 'Richieste ricevute';

  @override
  String get contactRequestsOutgoing => 'Richieste inviate';

  @override
  String get contactRequestHint =>
      'Potrai chattare e chiamare dopo che la richiesta sarà accettata.';

  @override
  String get callReturnToCall => 'Torna alla chiamata';

  @override
  String get chatMessageSending => 'Invio in corso';

  @override
  String get chatMessageSent => 'Inviato';

  @override
  String get chatMessageDelivered => 'Consegnato';

  @override
  String get chatMessageRead => 'Letto';

  @override
  String get chatMessageFailed => 'Non inviato. Tocca per riprovare.';

  @override
  String get chatMessageUnavailable =>
      'Messaggio non disponibile su questo dispositivo. Tocca per vedere le opzioni di recupero.';

  @override
  String get contactStarredFriends => 'Contatti preferiti';

  @override
  String get chatRecipientKeysMissing =>
      'Questo contatto non ha una sessione crittografata disponibile. Chiedigli di accedere e aprire l’app, poi riprova. Per cambiare account usa «Cambia account» invece di disconnetterti.';

  @override
  String get chatSwitchForMessaging =>
      'Vuoi cambiare account? Usa «Cambia account» per conservare messaggi e sessioni sicure. Disconnettersi revoca questo dispositivo e può rendere illeggibili i messaggi crittografati in arrivo.';

  @override
  String get aiServiceUnavailable =>
      'I riepiloghi IA non sono al momento disponibili. Riprova quando il servizio sarà nuovamente accessibile.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Riepiloga $count messaggi recenti';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined partecipanti · $invited invitati';
  }

  @override
  String contactPendingCount(int count) {
    return '$count richieste in sospeso';
  }

  @override
  String get chatDraftLabel => 'Bozza';

  @override
  String get contactIndexLabel => 'Indice contatti';

  @override
  String get transferAssetUnavailable =>
      'La risorsa di pagamento non è disponibile';

  @override
  String get transferPaymentRequestUnavailable =>
      'La richiesta di pagamento non è disponibile';

  @override
  String get chatCatchUp => 'Recupera aggiornamenti';

  @override
  String get chatCatchUpMentions => 'Menzioni';

  @override
  String get chatCatchUpReplies => 'Risposte ai miei messaggi';

  @override
  String get chatCatchUpPinned => 'Messaggi fissati';

  @override
  String get chatCatchUpScope =>
      'Le menzioni e le risposte si basano sui messaggi caricati, inclusi quelli già letti. Carica messaggi più vecchi per trovare le risposte precedenti.';

  @override
  String get chatCatchUpLoadMore => 'Carica messaggi più vecchi';

  @override
  String get chatActionPreview => 'Controlla il suggerimento per il calendario';

  @override
  String get chatActionPrivacy =>
      'Dopo la conferma, solo il titolo e l’ora indicati qui sotto saranno condivisi con l’app Calendario. Controlla il fuso orario. L’account del calendario potrebbe sincronizzare questo evento.';

  @override
  String get chatActionTitle => 'Evento della chat';

  @override
  String get chatActionSuggestion => 'Suggerimento per il calendario';

  @override
  String get chatUnreadAttention => 'Menzioni e risposte non lette';

  @override
  String get chatScanAgain => 'Cerca di nuovo';

  @override
  String get chatUnreadScope =>
      'Esamina la cronologia del server fino al tuo indicatore di lettura. Apri una conversazione per leggerla; aggiorna per ricostruire i risultati.';

  @override
  String get chatScanIncomplete =>
      'Incompleto: cronologia, decrittazione o indicatore di lettura non disponibili. Riprova dopo la sincronizzazione.';

  @override
  String get chatHistoryShare => 'Condividi la cronologia selezionata';

  @override
  String get chatHistoryExplanation =>
      'Solo per amministratori. Seleziona testo semplice e una chat diretta crittografata esistente con un membro che è entrato nel gruppo. La condivisione crea messaggi di controllo visibili nel gruppo.';

  @override
  String get chatHistoryEnable => 'Abilita condivisione';

  @override
  String get chatHistoryDisable => 'Disabilita condivisione';

  @override
  String get chatHistoryPolicy =>
      'Regole di condivisione della cronologia del gruppo';

  @override
  String get chatHistoryPolicyDetail =>
      'Solo gli amministratori possono condividere. L’attivazione limita anche la visibilità della cronologia del gruppo agli eventi successivi all’ingresso. Imposta qui sotto i limiti dei messaggi di testo e conferma.';

  @override
  String get chatHistoryPolicySaved => 'Regole salvate';

  @override
  String get chatHistoryRecipient =>
      'Conversazione crittografata del destinatario';

  @override
  String get chatHistoryReview => 'Controlla i messaggi selezionati';

  @override
  String get chatHistoryMessages => 'messaggi';

  @override
  String get chatHistoryConfirmDetail =>
      'Prima di condividere, conferma il destinatario, ciascun messaggio e la relativa ora. Un risultato non riuscito o sconosciuto potrebbe aver già inviato contenuti: verificane l’esito prima di continuare.';

  @override
  String get chatHistoryCompleted =>
      'Cronologia selezionata inviata e controllo del gruppo confermato';

  @override
  String get chatHistoryPending =>
      'In sospeso: verifica l’esito, quindi conferma nuovamente per continuare. Gli invii con esito sconosciuto non vengono mai ripetuti.';

  @override
  String get chatHistoryReconcile => 'Verifica l’esito dell’invio';

  @override
  String get chatHistoryFailed =>
      'Impossibile completare. Controlla i diritti di amministratore, le regole del gruppo, la crittografia, l’appartenenza del destinatario e la selezione. Se l’invio è iniziato, verificane l’esito.';

  @override
  String get chatDeviceActions => 'Azioni sul dispositivo';

  @override
  String get chatDeviceActionsReview =>
      'Dopo la conferma, solo questo messaggio viene fornito ai suggerimenti di azioni del sistema sul dispositivo. Scegli un’azione per aprire Calendario, Promemoria o Mappe.';

  @override
  String get chatHistoryMaxMessages => 'Limite di messaggi (1–50)';

  @override
  String get chatHistoryMaxHours =>
      'Intervallo della cronologia in ore (1–720)';

  @override
  String get chatNotifyAll => 'Tutti i messaggi';

  @override
  String get chatNotifyAllDescription =>
      'Notifica ogni nuovo messaggio in questa chat';

  @override
  String get chatNotifyMentions => 'Solo menzioni';

  @override
  String get chatNotifyMentionsDescription =>
      'Notifica solo quando vieni menzionato o viene usato @room';

  @override
  String get chatNotifyMutedDescription =>
      'Disattiva le notifiche di questa chat su tutti i dispositivi';

  @override
  String get scheduledMessagesTitle => 'Messaggi programmati';

  @override
  String get scheduledMessagesEmpty => 'Nessun messaggio programmato';

  @override
  String get scheduledMessagesHint =>
      'Tieni premuto Invia, Foto, File, una GIF o un adesivo per programmare un messaggio.';

  @override
  String get scheduledMessageCancelled => 'Messaggio programmato annullato';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Creato: $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Consegna non confermata';

  @override
  String get scheduledRecoveryCopy => 'Salva copia di recupero';

  @override
  String get scheduledRecoveryCopyHint =>
      'Salvata su questo dispositivo senza modificare o inviare messaggi. L’anteprima mostra fino a 8.000 caratteri.';

  @override
  String get scheduledRecoveryCopies => 'Copie di recupero';

  @override
  String get scheduledRecoveryReset => 'Reimposta coda danneggiata';

  @override
  String get scheduledRecoveryResetHint =>
      'Una copia esatta è salvata su questo dispositivo. Reimpostare tutti i messaggi programmati di questo account? Alcuni potrebbero essere già stati inviati. Copie e allegati vengono conservati. Nulla sarà reinviato.';

  @override
  String get scheduledRecoveryExportHint =>
      'Questo file contiene testo delle bozze e dati dell’account non crittografati. Gli allegati non sono inclusi. Scegli una destinazione attendibile.';

  @override
  String get scheduledRecoveryImport => 'Importa copia di recupero';

  @override
  String get scheduledRecoveryImportHint =>
      'Salva questa anteprima solo come copia di recupero. Nessun messaggio verrà programmato o inviato. Gli allegati non sono inclusi. L’autore del file non è verificato.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Aggiungi il testo alla bozza attuale per controllarlo. Non verrà inviato nulla. Allegati, menzioni e timer non verranno ripristinati. Verifica se questo messaggio è già stato consegnato.';

  @override
  String get backupRecoverLegacyArchive =>
      'Recupera la cronologia locale precedente';

  @override
  String get backupLegacyArchiveWarning =>
      'Il proprietario di questa cronologia non è verificato. Copia solo le tue stanze nell’account qui sotto. L’originale viene conservato.';

  @override
  String get backupOlderFiles => 'File di backup precedenti';

  @override
  String get backupOlderFilesWarning =>
      'Questi file potrebbero appartenere a un altro account. Seleziona un file per verificarne contenuto e proprietario prima del ripristino.';

  @override
  String get stickerImportTitle => 'Importa pacchetto di adesivi';

  @override
  String get stickerImportLinkHint => 'Link al pacchetto di adesivi Matrix';

  @override
  String get stickerImportPreview => 'Anteprima';

  @override
  String get stickerImportUnavailable =>
      'Questo pacchetto non è disponibile o non hai accesso.';

  @override
  String get stickerImportCopyNotice =>
      'Aggiungi una copia privata di questo pacchetto. Le immagini e i metadati non sono crittografati end-to-end.';

  @override
  String get stickerImportFailed =>
      'Impossibile aggiungere questo pacchetto. Riprova.';

  @override
  String get stickerImportAccountChanged =>
      'L’account è cambiato o la sessione è scaduta. Riapri l’importazione degli adesivi.';

  @override
  String get stickerPackSourceRoom => 'Chat di origine';

  @override
  String get stickerPackImages => 'Immagini';

  @override
  String get stickerPublishNotice =>
      'Pubblica questo pacchetto nel gruppo selezionato. Le immagini e i metadati non sono crittografati end-to-end. Chi può leggere lo stato del gruppo potrebbe accedervi.';

  @override
  String get stickerPublishFailed =>
      'La pubblicazione non è stata confermata. Controlla il gruppo prima di riprovare.';

  @override
  String get stickerPublishReceiptMissing =>
      'Pubblicato, ma il link non è stato salvato. Condividilo o copialo prima di lasciare questa pagina.';

  @override
  String get stickerSubscribe => 'Iscriviti agli aggiornamenti';

  @override
  String get stickerSubscribeNotice =>
      'Segui le modifiche future degli amministratori del pacchetto. Immagini e metadati non sono crittografati end-to-end. Puoi annullare l’iscrizione in seguito; questa azione non ti unisce alla chat di origine.';

  @override
  String get stickerSubscriptions => 'Iscrizioni agli adesivi';

  @override
  String get stickerUnsubscribe => 'Annulla iscrizione';

  @override
  String get stickerSubscriptionsEmpty => 'Nessuna iscrizione agli adesivi';

  @override
  String get chatAttachmentEvent => 'Evento';

  @override
  String get chatRecentMedia => 'Foto e video recenti';

  @override
  String get chatRecentMediaLoadFailed =>
      'Impossibile caricare i contenuti recenti';

  @override
  String get chatRecentMediaPermission =>
      'È necessario l’accesso alle foto per mostrare i contenuti recenti';

  @override
  String get chatRecentMediaEmpty => 'Nessuna foto o video recente';

  @override
  String get chatRecentPhoto => 'Foto recente';

  @override
  String get chatRecentVideo => 'Video recente';

  @override
  String get chatAttachmentTip => 'Mancia';

  @override
  String get chatAttachmentWhiteboard => 'Lavagna';

  @override
  String get chatAttachmentVideoNote => 'Videomessaggio';

  @override
  String get chatAttachmentCode => 'Codice';

  @override
  String get chatAttachmentShop => 'Negozio';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Limite di selezione: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Stasera ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Domani mattina ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Scorri in fondo';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Inserisci un messaggio prima di programmarlo';

  @override
  String get ui3SendCode => 'Invia codice';

  @override
  String get ui3CodeLanguage => 'Linguaggio';

  @override
  String get ui3PasteCodeHere => 'Incolla il codice qui';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Promemoria impostato · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => 'Impossibile creare la busta rossa';

  @override
  String get ui3SendTip => 'Invia una mancia';

  @override
  String get ui3TokenLabel => 'Criptovaluta';

  @override
  String get ui3NoteOptional => 'Nota (facoltativa)';

  @override
  String ui3TipFailed(String error) {
    return 'Mancia non riuscita: $error';
  }

  @override
  String get ui3GiftNftTitle => 'Regala un NFT';

  @override
  String get ui3TokenId => 'ID del token';

  @override
  String ui3NftGiftFailed(String error) {
    return 'Regalo NFT non riuscito: $error';
  }

  @override
  String get ui3AiAgentSubtitle =>
      'Descrivi un\'attività, apri la mini app giusta';

  @override
  String get ui3GiftNft => 'Regala NFT';

  @override
  String get ui3GiftNftSubtitle => 'Invia un NFT a questo contatto';

  @override
  String get ui3MiniAppUnavailable => 'La mini app non è disponibile';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'Impossibile inviare $count elementi multimediali selezionati';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Invia foto e video in un formato adatto alla chat';

  @override
  String get ui3OriginalImages => 'Immagini originali';

  @override
  String get ui3OriginalImagesSubtitle => 'Invia foto non compresse come file';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename programmato per $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Invio immagine originale: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Immagine originale programmata: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Pagamento già inviato';

  @override
  String get ui3PaymentProcessing => 'Pagamento in elaborazione';

  @override
  String ui3ChainStatus(String status) {
    return 'Stato on-chain: $status';
  }

  @override
  String get ui3NotChecked => 'Non verificato';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Confermato: $confirmations / $required blocchi';
  }

  @override
  String get ui3CopyTxHash => 'Copia hash della transazione';

  @override
  String get ui3VerifyAgain => 'Verifica di nuovo';

  @override
  String get ui3VerifyOnChain => 'Verifica on-chain';

  @override
  String get ui3TransferMissingChainDetails =>
      'Questo trasferimento non include i dettagli esatti di chain e asset.';

  @override
  String get ui3ReceiptPending => 'In attesa on-chain';

  @override
  String get ui3ReceiptConfirmed => 'Confermato';

  @override
  String get ui3ReceiptFailed => 'Fallito on-chain';

  @override
  String get ui3ReceiptMismatch =>
      'I dettagli della transazione non corrispondono';

  @override
  String get ui3ReceiptUnsupported => 'Verifica on-chain non supportata';

  @override
  String get ui3ReceiptUnavailable => 'Verifica non disponibile';

  @override
  String get ui3OpenOrSave => 'Apri / Salva';

  @override
  String get ui3UnableToOpenFile => 'Impossibile aprire questo file.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'Riscrittura con IA non riuscita: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Condividere i messaggi con l\'IA?';

  @override
  String get ui3AiShareMessagesBody =>
      'Seleziona i messaggi che l\'IA può usare per questa risposta. Questa autorizzazione per una singola richiesta scade dopo due minuti. Chiudendo Risposta rapida i risultati in sospeso vengono annullati. Non consente pagamenti né esportazioni.';

  @override
  String get ui3OtherParticipant => 'Interlocutore';

  @override
  String get ui3ShareSelected => 'Condividi selezionati';

  @override
  String get ui3BotCommandError => 'Errore del comando';

  @override
  String get ui3BotUnknownCommand => 'Comando sconosciuto';

  @override
  String get ui3BotTypeHelp => 'Digita /help per vedere i comandi disponibili.';

  @override
  String get ui3FilesMediaLinks => 'File, media e link';

  @override
  String get ui3ChatStorage => 'Spazio della chat';

  @override
  String get ui3EncryptionKeysDevices => 'Chiavi di crittografia e dispositivi';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'Il servizio di crittografia non è ancora disponibile';

  @override
  String get ui3ExportLoadingHistory =>
      'Caricamento di altra cronologia chat per l\'esportazione...';

  @override
  String get ui3ExportTxtDesc =>
      'Trascrizione in testo semplice per note, backup o verifiche di conformità';

  @override
  String get ui3ExportCustomRange => 'Intervallo personalizzato';

  @override
  String get ui3ExportStart => 'Inizio';

  @override
  String get ui3ExportEnd => 'Fine';

  @override
  String get ui3ExportSelectDate => 'Seleziona data';

  @override
  String get ui3FolderFilterUnreadOnly => 'Solo non letti';

  @override
  String get ui3FolderFilterMutedOnly => 'Solo silenziati';

  @override
  String get ui3FolderFilterNoDms => 'Senza messaggi diretti';

  @override
  String get ui3FolderFilterNoGroups => 'Senza gruppi';

  @override
  String get ui3FolderFilterNoChannels => 'Senza canali';

  @override
  String get ui3FolderFilterAllChats => 'Tutte le chat';

  @override
  String get ui3Create => 'Crea';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Eliminare la cartella \"$name\"?';
  }

  @override
  String get a11yDecreaseTextSize => 'Riduci dimensione testo';

  @override
  String get a11yIncreaseTextSize => 'Aumenta dimensione testo';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes min di lettura';
  }

  @override
  String get ui3TipOnChain => 'Registrato on-chain ✓';

  @override
  String get ui3ViewSource => 'Visualizza sorgente';

  @override
  String get a11yPreviousPage => 'Pagina precedente';

  @override
  String get a11yNextPage => 'Pagina successiva';

  @override
  String get ui3OpenExternalLinkTitle => 'Aprire il link esterno?';

  @override
  String get ui3Open => 'Apri';

  @override
  String get ui3UnableToOpenLink => 'Impossibile aprire questo link.';

  @override
  String get ui3ImageUnavailable => 'Immagine non disponibile';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Carica immagine da $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Riprova immagine da $host';
  }

  @override
  String get ui3TranslatedByN42 => 'Tradotto da N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Traduzione da $language a cura di N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Cancellare la lavagna?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Tutti i tratti verranno rimossi per tutti. L\'operazione non può essere annullata.';

  @override
  String get ui3WhiteboardLive => 'Lavagna · In diretta';

  @override
  String get a11yPenColor => 'Colore penna';

  @override
  String get ui3AiDescribeOcr => 'Descrizione IA / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Impossibile visualizzare l\'anteprima di questo documento in modo sicuro. Controlla la connessione e le dimensioni del file (max 2 MB).';

  @override
  String get ui3AiConsentMessage =>
      'Seleziona i messaggi che l\'IA può usare per questo riepilogo. Questa autorizzazione per una singola richiesta scade dopo due minuti. Non consente pagamenti né esportazioni.';

  @override
  String get ui3AiSuggestedReplies => 'Risposte suggerite';

  @override
  String get ui3AiGeneratingSuggestions => 'Generazione dei suggerimenti...';

  @override
  String get ui3StickersEmpty => 'Ancora nessuno sticker';

  @override
  String get ui3StickersGet => 'Ottieni sticker';

  @override
  String get a11yFormatBold => 'Grassetto';

  @override
  String get a11yFormatItalic => 'Corsivo';

  @override
  String get a11yFormatStrikethrough => 'Barrato';

  @override
  String get a11yFormatInlineCode => 'Codice in linea';

  @override
  String get a11yFormatCodeBlock => 'Blocco di codice';

  @override
  String get a11yFormatChecklistItem => 'Elemento checklist';

  @override
  String get a11yFormatBulletList => 'Elenco puntato';

  @override
  String get a11yFormatNumberedList => 'Elenco numerato';

  @override
  String get a11yFormatLink => 'Collegamento';

  @override
  String get a11yFormatTable => 'Tabella';

  @override
  String get a11yFormatMeetingTemplate => 'Modello riunione';

  @override
  String get a11yEmojiSmileys => 'Faccine e persone';

  @override
  String get a11yEmojiHearts => 'Cuori';

  @override
  String get a11yEmojiAnimals => 'Animali e natura';

  @override
  String get a11yEmojiFood => 'Cibo e bevande';

  @override
  String get a11yEmojiTravel => 'Viaggi e luoghi';

  @override
  String get a11yEmojiActivities => 'Attività';

  @override
  String get a11yEmojiObjects => 'Oggetti';

  @override
  String get a11yEmojiSymbols => 'Simboli';

  @override
  String get ui3FrequentlyUsed => 'Usati di frequente';

  @override
  String get ui3NoEditHistory => 'Nessuna cronologia modifiche';

  @override
  String get ui3EventNew => 'Nuovo evento';

  @override
  String get ui3EventTitleLabel => 'Titolo';

  @override
  String get ui3EventLocationOptional => 'Luogo (facoltativo)';

  @override
  String get ui3EventDescriptionOptional => 'Descrizione (facoltativa)';

  @override
  String get ui3EventSend => 'Invia evento';

  @override
  String get ui3EventTitleRequired => 'Il titolo è obbligatorio';

  @override
  String get ui3EventEndAfterStart =>
      'L\'ora di fine deve essere successiva all\'inizio';

  @override
  String get ui3MiniAppAgentIntro =>
      'Descrivi cosa vuoi fare: aprirò la mini app giusta.';

  @override
  String get ui3MiniAppAgentExample => 'es. scambia ETH in USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Nessuna mini app corrispondente. Prova a riformulare.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Apri $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Supporta link di brani da NetEase Cloud Music, QQ Music, Kugou, Kuwo e altri';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'Segna una risposta corretta non vuota';

  @override
  String get ui3PollQuizMode => 'Modalità quiz';

  @override
  String get ui3PollAnswerExplanationHint =>
      'Spiegazione della risposta (facoltativa)';

  @override
  String get a11yCorrectAnswer => 'Risposta corretta';

  @override
  String get ui3AiSuggestions => 'Suggerimenti IA';

  @override
  String get a11yPaste => 'Incolla';

  @override
  String get a11yRefresh => 'Aggiorna';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Conserva questa chiave in un luogo sicuro. È l\'unico modo per recuperare i messaggi crittografati se perdi l\'accesso a tutti i dispositivi.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Salvato: $path';
  }

  @override
  String get ui3UnknownAccount => 'Account sconosciuto';

  @override
  String get ui3UnknownHomeserver => 'Homeserver sconosciuto';

  @override
  String get ui3ImportRecoveryKey => 'Importa chiave di recupero';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Inserisci o incolla la chiave di recupero per ripristinare le chiavi delle stanze della cronologia dei messaggi crittografati.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Account: $account\\nServer principale: $homeserver';
  }

  @override
  String get ui3Import => 'Importa';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Formato della chiave di recupero non valido';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return 'Ripristinate $restored chiavi su $total. $failed chiavi non riuscite. Controlla account, rete e backup, quindi riprova. Parte della cronologia potrebbe rimanere illeggibile.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return 'Ripristinate correttamente $restored chiavi su $total';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Importazione non riuscita: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Registrazione passkey non riuscita: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'La mia passkey';

  @override
  String get ui3PasskeyNameHint => 'es. iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Impossibile eliminare la passkey';

  @override
  String get ui3TwoFactorAuth => 'Autenticazione a due fattori';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'Attiva: richiesto il codice dell\'app di autenticazione';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Disattiva: proteggi con un\'app di autenticazione (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Mostra chiave di recupero';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Mostra la chiave di recupero per il backup';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Ripristina i messaggi con una chiave di recupero';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Impossibile creare la chiave di recupero';

  @override
  String get ui3TotpIncorrectCode => 'Codice errato, riprova';

  @override
  String get ui3TwoFactorEnabled => 'Autenticazione a due fattori attivata';

  @override
  String get ui3TwoFactorDisabled => 'Autenticazione a due fattori disattivata';

  @override
  String get ui3TwoFactorTurnOffTitle =>
      'Disattivare l\'autenticazione a due fattori?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'L\'app di autenticazione non sarà più richiesta. Potrai configurarla di nuovo in seguito con una nuova chiave.';

  @override
  String get ui3TurnOff => 'Disattiva';

  @override
  String get ui3TwoFactorTotpTitle => 'Due fattori (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'L\'autenticazione a due fattori è attiva';

  @override
  String get ui3TwoFactorCodeRequired =>
      'È richiesto un codice dall\'app di autenticazione.';

  @override
  String get ui3TotpStepScan =>
      '1. Scansiona questo codice QR con un\'app di autenticazione (Google Authenticator, Authy, 1Password…) oppure inserisci la chiave manualmente.';

  @override
  String get ui3TotpKeyCopied => 'Chiave copiata';

  @override
  String get ui3TotpStepConfirm =>
      '2. Inserisci il codice a 6 cifre per confermare.';

  @override
  String get ui3Enable => 'Attiva';

  @override
  String get ui3BackupSettingsDesc =>
      'Esegui il backup delle impostazioni chat locali. I messaggi verranno ripristinati dal server dopo un nuovo accesso.';

  @override
  String get ui3BackupKeysSeparate =>
      'Le chiavi di crittografia sono gestite separatamente';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Usa Sicurezza > Chiave di recupero per eseguire il backup dell\'accesso ai messaggi crittografati.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms stanze  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Importa un file .n42backup da un altro dispositivo o da un backup precedente. Le chiavi di crittografia vengono ripristinate separatamente con la chiave di recupero.';

  @override
  String get ui3UsernameSessionRequired =>
      'Il nome utente richiede una sessione attiva';

  @override
  String get ui3SecuritySessionRequired =>
      'Le impostazioni di sicurezza richiedono una sessione attiva';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'Gli account collegati richiedono una sessione attiva';

  @override
  String get ui3SystemAccounts => 'Sistema e account';

  @override
  String get ui3AccountIdentity => 'Account e identità';

  @override
  String get ui3Accounts => 'Account';

  @override
  String get ui3DevicesSessions => 'Dispositivi e sessioni';

  @override
  String get ui3Integrations => 'Integrazioni';

  @override
  String get ui3ConnectedAccounts => 'Account collegati';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Integrazioni con Telegram, WhatsApp, Discord e bridge API';

  @override
  String get ui3SystemOverview => 'Panoramica del sistema';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count account',
      one: '1 account',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dispositivi',
      one: '1 dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Crittografia end-to-end, protezione screenshot e controllo proxy';

  @override
  String get ui3ConversationPrivacy => 'Privacy delle conversazioni';

  @override
  String get ui3NetworkPrivacy => 'Privacy di rete';

  @override
  String get ui3IdentityPrivacy => 'Privacy dell\'identità';

  @override
  String get ui3EncryptionKeyBackup => 'Crittografia e backup chiavi';

  @override
  String get ui3DevicesVerification => 'Dispositivi e verifica';

  @override
  String get ui3ChipE2eeDefault => 'E2EE predefinita';

  @override
  String get ui3ChipManualE2ee => 'E2EE manuale';

  @override
  String get ui3ChipSelfDestruct => 'Autodistruzione';

  @override
  String get ui3ChipScreenshotGuard => 'Protezione screenshot';

  @override
  String get ui3ChipIpProxy => 'IP / server proxy';

  @override
  String get ui3ChipLinkPreviewsOff => 'Anteprime link disattivate';

  @override
  String get ui3ChipPublicHandle => 'Nome utente pubblico';

  @override
  String get a11yShowPassword => 'Mostra password';

  @override
  String get a11yHidePassword => 'Nascondi password';

  @override
  String get a11yCheckServer => 'Verifica server';

  @override
  String get ui3AuthAnonymousRegistration => 'Registrazione anonima';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Crea un account senza collegare telefono o email. Verrà generato automaticamente un nome utente.';

  @override
  String get ui3AuthAnonymousModeOn => 'La modalità anonima è attiva';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'L’app creerà per te un nome utente Matrix casuale. Potrai accedere in seguito con l’account e la password generati.';

  @override
  String get ui3AuthChooseLoginMethod => 'Scegli il metodo di accesso';

  @override
  String get ui3AuthSsoOpenFailed =>
      'Impossibile aprire la pagina di accesso SSO';

  @override
  String get ui3AuthWalletUnavailable => 'Il wallet non è disponibile';

  @override
  String get ui3ProfileSubscriptions => 'Abbonamenti';

  @override
  String get ui3ProfileBuySellCrypto => 'Compra / vendi cripto';

  @override
  String get ui3ProfileOnDeviceAi => 'IA sul dispositivo';

  @override
  String get ui3ProfileSetAUsername => 'Imposta un nome utente';

  @override
  String get ui3ProfileAvatarStudio => 'Studio avatar';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'Avatar NFT / Decorazioni';

  @override
  String get ui3ProfileCustomize => 'Personalizza';

  @override
  String get ui3ProfileQrSubtitle =>
      'Scansiona per aprire questo profilo o avviare una chat';

  @override
  String get ui3PrivacyHardening => 'Rafforzamento della privacy';

  @override
  String get ui3HidePhoneNumber => 'Nascondi numero di telefono';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Maschera i numeri di telefono collegati nelle schermate del profilo su questo dispositivo';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'Crittografa le nuove chat per impostazione predefinita';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Avvia nuove chat dirette e stanze private con E2EE attiva';

  @override
  String get ui3PrivateChatMode => 'Modalità chat privata';

  @override
  String get ui3PrivateChatModeDesc =>
      'Blocca temporaneamente gli screenshot durante la visualizzazione di chat private o crittografate';

  @override
  String get ui3DefaultSelfDestructTimer =>
      'Timer di autodistruzione predefinito';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Applica un timer di autodistruzione predefinito ai nuovi messaggi inviati';

  @override
  String get ui3LinkPreviews => 'Anteprime dei link';

  @override
  String get ui3LinkPreviewsDesc =>
      'Recupera titoli, descrizioni e miniature quando i messaggi contengono URL';

  @override
  String get ui3IpAddressProtection => 'Protezione indirizzo IP';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Instrada le richieste Matrix e delle anteprime dei link tramite il proxy HTTP per la privacy configurato, se disponibile';

  @override
  String get ui3UseTorProxy => 'Usa proxy HTTP Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Usa un endpoint proxy HTTP locale come Privoxy su 127.0.0.1:8118. Il routing Tor nativo tramite SOCKS5 non è supportato qui.';

  @override
  String get ui3CustomProxy => 'Proxy personalizzato';

  @override
  String get ui3CustomProxyDesc =>
      'Usa un proxy HTTP o HTTPS personalizzato per il traffico Matrix e le anteprime dei link';

  @override
  String get ui3ProxyEndpoint => 'Indirizzo proxy';

  @override
  String get ui3ProxyEndpointDesc =>
      'Indirizzo proxy HTTP/HTTPS (SOCKS non supportato)';

  @override
  String get ui3InvalidEndpoint => 'Indirizzo non valido';

  @override
  String get ui3CustomProxyStaysOff =>
      'Il proxy personalizzato resta disattivato finché non imposti un indirizzo valido';

  @override
  String get ui3NotificationFilterNote =>
      'Le regole prioritarie notificano sempre (ignorando silenzioso, solo menzioni e Non disturbare). Le parole chiave silenziate sopprimono le notifiche.';

  @override
  String get ui3PriorityKeywords => 'Parole chiave prioritarie';

  @override
  String get ui3PriorityKeywordHint => 'es. urgente';

  @override
  String get ui3MutedKeywords => 'Parole chiave silenziate';

  @override
  String get ui3MutedKeywordHint => 'es. spam';

  @override
  String get ui3PrioritySenders => 'Mittenti prioritari';

  @override
  String get ui3CaseSensitive => 'Distingui maiuscole/minuscole';

  @override
  String get ui3None => 'Nessuna';

  @override
  String get ui3SmartReplyTranslation => 'Traduzione risposte intelligenti';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Traduci automaticamente i tuoi messaggi nella lingua del destinatario prima dell’invio.';

  @override
  String get ui3FromPhotos => 'Da Foto';

  @override
  String get ui3ChangePhoto => 'Cambia foto';

  @override
  String get ui3RoamingUsesMobileData =>
      'Il roaming segue le regole dei dati mobili';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'Il rilevamento del roaming non è ancora disponibile, quindi per ora il roaming segue le impostazioni di download automatico dei dati mobili.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Eliminare \"$content\"?';
  }

  @override
  String get ui3ResetToDefaults => 'Ripristina predefiniti';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Verranno rimosse tutte le risposte rapide personalizzate e ripristinate quelle predefinite. Continuare?';

  @override
  String get ui3LocalLlmUnavailable => 'Non supportato su questo dispositivo';

  @override
  String get ui3LocalLlmNotDownloaded => 'Modello non scaricato';

  @override
  String get ui3LocalLlmReady => 'Pronto (sul dispositivo)';

  @override
  String get ui3LocalLlmDescription =>
      'Se attive e pronte, le funzioni di IA (riepilogo, riscrittura, traduzione, risposte) vengono eseguite interamente sul dispositivo: i dati non lasciano mai il telefono. Altrimenti usano il provider cloud.';

  @override
  String get ui3UseOnDeviceAi => 'Usa IA sul dispositivo';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'Preferisci l’inferenza locale quando è pronta';

  @override
  String get ui3DownloadModel => 'Scarica modello';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'L’inferenza sul dispositivo richiede il runtime nativo (Android MediaPipe / iOS Core ML). Si attiverà automaticamente quando il gestore della piattaforma sarà disponibile.';

  @override
  String get ui3PhotoAvatar => 'Avatar con foto';

  @override
  String get ui3AvatarStyles => 'Stili avatar';

  @override
  String get ui3AvatarStylesDesc =>
      'Usa un unico selettore di decorazioni per profilo e punti di accesso all’avatar.';

  @override
  String get ui3ReplaceNftAvatar => 'Sostituisci avatar NFT';

  @override
  String get ui3NftAvatarDesc => 'Usa un collezionabile on-chain come avatar.';

  @override
  String get ui3UsePhotoAvatar => 'Usa avatar con foto';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Mantieni l’avatar caricato e rimuovi il collegamento NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Stile avatar impostato su: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'Avatar NFT aggiornato';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Tornato all’avatar con foto';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Accedi per vedere la cronologia delle buste rosse';

  @override
  String get ui3RedPacketActive => 'Attive';

  @override
  String get ui3RedPacketCompleted => 'Completate';

  @override
  String get ui3CardsAndPasses => 'Carte e pass';

  @override
  String get ui3CardsAndPassesDesc =>
      'Carte del wallet, coupon e pass sono gestiti dall’app principale.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'Il pacchetto carte richiede l’app principale';

  @override
  String get ui3OpenCardPack => 'Apri pacchetto carte';

  @override
  String get ui3UnableToOpenChat =>
      'Impossibile aprire una chat con questo contatto';

  @override
  String get ui3WalletManagedInMainApp =>
      'Il wallet è gestito nell’app principale';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Piani';
  }

  @override
  String get ui3NewPlan => 'Nuovo piano';

  @override
  String get ui3MySubscriptions => 'I miei abbonamenti';

  @override
  String get ui3AvailablePlans => 'Piani disponibili';

  @override
  String get ui3NoPlansYet =>
      'Nessun piano · tocca “Nuovo piano” per crearne uno';

  @override
  String ui3DaysLeft(Object days) {
    return '$days g rimasti';
  }

  @override
  String get ui3SubscriptionCancelled => 'Annullato';

  @override
  String get ui3AutoRenewOn => 'Rinnovo automatico: attivo';

  @override
  String get ui3AutoRenewOff => 'Rinnovo automatico: disattivo';

  @override
  String get ui3CancelSubscriptionTitle => 'Annullare l’abbonamento?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Il tuo abbonamento a $name resterà attivo fino alla scadenza e non verrà rinnovato.';
  }

  @override
  String get ui3Subscribe => 'Abbonati';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Abbonamento a $name attivato';
  }

  @override
  String get ui3PlanPriceLabel => 'Prezzo (es. 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Descrizione (facoltativa)';

  @override
  String get ui3PlanBenefitsLabel => 'Vantaggi (separati da virgole)';

  @override
  String get ui3PlanPeriod => 'Periodo:';

  @override
  String get ui3Monthly => 'Mensile';

  @override
  String get ui3Yearly => 'Annuale';

  @override
  String get ui3SaveRemarkFailed => 'Impossibile salvare la nota';

  @override
  String get ui3CopyLink => 'Copia link';

  @override
  String get ui3Connect => 'Connettiti';

  @override
  String get ui3CommonTokens => 'Token in comune';

  @override
  String get ui3SharedNfts => 'NFT in comune';

  @override
  String get ui3TransactionHistory => 'Cronologia transazioni';

  @override
  String get ui3CommonDaos => 'DAO in comune';

  @override
  String get ui3SameChains => 'Stesse chain';

  @override
  String get ui3ChatInitFailed => 'Inizializzazione della chat non riuscita';

  @override
  String get ui3CheckNetworkRetry =>
      'Controlla la connessione di rete e riprova';

  @override
  String get ui3FromContacts => 'Dai contatti';

  @override
  String get ui3FindFriendsFromContacts =>
      'Trova amici nei contatti del telefono';

  @override
  String get ui3EnsOrDomain => 'ENS / Dominio';

  @override
  String get ui3LoadingContacts => 'Caricamento contatti...';

  @override
  String get ui3ContactsPermissionRequired =>
      'Autorizzazione contatti richiesta';

  @override
  String get ui3ContactsPermissionMessage =>
      'Per trovare amici tra i contatti, consenti l\'accesso ai contatti.';

  @override
  String get ui3AllowAccess => 'Consenti accesso';

  @override
  String get ui3NoContactMatches => 'Nessuna corrispondenza trovata';

  @override
  String get ui3NoContactMatchesMessage =>
      'Nessuno dei tuoi contatti usa ancora questa app. Invitali a unirsi!';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count contatti analizzati';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'Trovate $count corrispondenze nei tuoi contatti';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'Nei contatti: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Eliminare questa foto?';

  @override
  String get ui3InviteLink => 'Link di invito';

  @override
  String get ui3ShareJoinLink =>
      'Condividi un link per entrare in questa stanza';

  @override
  String get ui3ShareRoomReference =>
      'Condividi un riferimento alla stanza con i membri invitati';

  @override
  String get ui3ScanToJoinGroup =>
      'Scansiona per entrare direttamente nel gruppo';

  @override
  String get ui3ScanToShareRoomReference =>
      'Scansiona per condividere il riferimento a questa stanza con i membri invitati';

  @override
  String get ui3InviteLinkLoadFailed =>
      'Impossibile caricare il link di invito';

  @override
  String get ui3InviteLinkCopied => 'Link di invito copiato';

  @override
  String get ui3ChannelCategoryOptional => 'Categoria (facoltativa)';

  @override
  String get ui3ChannelCategoryHint => 'Annunci / Prodotto / Assistenza';

  @override
  String get ui3DescriptionOptional => 'Descrizione (facoltativa)';

  @override
  String get ui3WebhookEnable => 'Abilita automazione webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'Invia gli eventi di ingresso membri e benvenuto al tuo endpoint di integrazione.';

  @override
  String get ui3WebhookUrl => 'URL del webhook';

  @override
  String get ui3WebhookSecretOptional => 'Segreto di firma (facoltativo)';

  @override
  String get ui3WebhookSecretHint => 'Usato per X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => 'Notifica quando entra un membro';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'Notifica quando viene inviato il benvenuto';

  @override
  String get ui3WebhookTestSend => 'Invia webhook di prova';

  @override
  String get ui3WebhookTestSending => 'Invio del webhook di prova...';

  @override
  String get ui3WebhookTestSent => 'Webhook di prova inviato correttamente';

  @override
  String get ui3WebhookTestFailed => 'Impossibile inviare il webhook di prova';

  @override
  String get ui3WebhookUrlInvalid =>
      'L\'URL del webhook deve essere un indirizzo HTTPS pubblico';

  @override
  String get ui3WebhookSelectEvent => 'Seleziona almeno un evento webhook';

  @override
  String get ui3SensitiveDataDetection => 'Rilevamento dati sensibili';

  @override
  String get ui3Email => 'E-mail';

  @override
  String get ui3CreditCard => 'Carta di credito';

  @override
  String get ui3DetectEmailDesc =>
      'Rileva indirizzi e-mail nei messaggi di testo';

  @override
  String get ui3DetectPhoneDesc =>
      'Rileva numeri di telefono e numeri internazionali';

  @override
  String get ui3DetectCardDesc => 'Rileva possibili numeri bancari e di carta';

  @override
  String get ui3DetectWalletDesc => 'Rileva indirizzi wallet in stile Ethereum';

  @override
  String get ui3GeneralTopic => 'Generale';

  @override
  String get a11yPreviousResult => 'Risultato precedente';

  @override
  String get a11yNextResult => 'Risultato successivo';

  @override
  String get ui3TryDifferentKeywords => 'Prova con altre parole chiave';

  @override
  String ui3FiltersActive(Object count) {
    return 'Filtri attivi: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Filtri messaggi attivi: $count';
  }

  @override
  String get ui3LoadMore => 'Carica altro';

  @override
  String get ui3MessageFilters => 'Filtri messaggi';

  @override
  String get ui3SenderUserId => 'ID utente del mittente';

  @override
  String get ui3FilterType => 'Tipo';

  @override
  String get ui3FilterAny => 'Qualsiasi';

  @override
  String get ui3FilterImage => 'Immagine';

  @override
  String get ui3FilterTime => 'Data';

  @override
  String get ui3AnyTime => 'Qualsiasi data';

  @override
  String get ui3OnlyMyMessages => 'Solo i miei messaggi';

  @override
  String get ui3MediaOnly => 'Solo contenuti multimediali';

  @override
  String get ui3Apply => 'Applica';

  @override
  String get ui3QrStyleClassic => 'Classico';

  @override
  String get ui3QrStyleOcean => 'Oceano';

  @override
  String get ui3QrStyleBerry => 'Bacca';

  @override
  String get a11yFlashlightOn => 'Accendi torcia';

  @override
  String get a11yFlashlightOff => 'Spegni torcia';

  @override
  String get ui3SocialGraph => 'Grafo sociale';

  @override
  String get ui3RecommendedConnections => 'Connessioni consigliate';

  @override
  String get ui3Portfolio => 'Portafoglio';

  @override
  String get ui3Chains => 'Catene';

  @override
  String get ui3Tokens => 'Token';

  @override
  String get ui3NoConnectionsFound => 'Nessuna connessione trovata';

  @override
  String get ui3ConnectionsHint =>
      'Le connessioni compaiono man mano che cresce la tua attività on-chain';

  @override
  String get ui3SocialGraphLoadFailed =>
      'Impossibile caricare il grafo sociale';

  @override
  String get ui3Similarity => 'Somiglianza';

  @override
  String get ui3Breakdown => 'Dettaglio';

  @override
  String get ui3TokenHoldings => 'Token posseduti';

  @override
  String get ui3NftCollections => 'Collezioni NFT';

  @override
  String get ui3ChainUsage => 'Utilizzo delle chain';

  @override
  String get ui3Transactions => 'Transazioni';

  @override
  String get ui3DaoMembership => 'Iscrizione a DAO';

  @override
  String get ui3NotWeighted => 'Non ponderato';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (peso: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Attività on-chain in comune';

  @override
  String get ui3SharedTokens => 'Token in comune';

  @override
  String get ui3SharedNftCollections => 'Collezioni NFT in comune';

  @override
  String get ui3SharedChains => 'Chain in comune';

  @override
  String get ui3NoSharedTokens => 'Nessun token in comune trovato';

  @override
  String get ui3NoSharedNftCollections =>
      'Nessuna collezione NFT in comune trovata';

  @override
  String get ui3NoSharedChains => 'Nessuna chain in comune trovata';

  @override
  String get ui3SimilarityFailed => 'Impossibile calcolare la somiglianza';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +altri $count';
  }

  @override
  String get a11yGovernance => 'Governo';

  @override
  String get ui3CommunityLink => 'Link della community';

  @override
  String get ui3CommunityQrCode => 'Codice QR della community';

  @override
  String get ui3CommunityQrSubtitle =>
      'Scansiona per unirti a questa community e sfogliarne i canali';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Impossibile caricare il link della community';

  @override
  String get ui3CommunityLinkCopied => 'Link della community copiato';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name verrà rimosso da questa community.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name verrà rimosso e non potrà più unirsi.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Accedi per scoprire i canali pubblici';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Impossibile unirsi a $name: $error';
  }

  @override
  String get ui3CategoryTech => 'Tecnologia';

  @override
  String get ui3CategorySocial => 'Sociale';

  @override
  String get ui3NoPublicChannels => 'Nessun canale pubblico trovato';

  @override
  String get ui3StoriesAndFun => 'Storie e divertimento';

  @override
  String get ui3SearchMusicHint => 'Cerca brani, artisti o amici';

  @override
  String get ui3ForYou => 'Per te';

  @override
  String get ui3Liked => 'Preferiti';

  @override
  String get ui3NoLikedMusic => 'Nessun brano tra i preferiti';

  @override
  String get ui3NoMusicStories => 'Nessuna storia musicale';

  @override
  String get ui3LikedMusicHint =>
      'Tocca il cuore accanto a un brano per salvarlo qui.';

  @override
  String get ui3MusicStoriesHint =>
      'La musica condivisa nelle storie apparirà qui.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · condiviso da $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Impossibile riprodurre $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'Brano precedente';

  @override
  String get a11yNextTrack => 'Brano successivo';

  @override
  String get a11yPlay => 'Riproduci';

  @override
  String get a11yPause => 'Metti in pausa';

  @override
  String get ui3Refresh => 'Aggiorna';

  @override
  String get ui3NearbyIntroTitle => 'Scopri i post pubblici nelle vicinanze';

  @override
  String get ui3NearbyIntroBody =>
      'La tua posizione viene usata una sola volta su questo dispositivo per ordinare i Momenti pubblici. Non viene caricata, trasmessa né mostrata ad altri.';

  @override
  String get ui3UseMyLocation => 'Usa la mia posizione';

  @override
  String get ui3NearbyUnavailable => 'Nelle vicinanze non è disponibile';

  @override
  String get ui3NoNearbyPosts => 'Nessun post nelle vicinanze';

  @override
  String get ui3NoNearbyPostsHint =>
      'I Momenti pubblici con posizione appariranno qui.';

  @override
  String get ui3NearbyDistanceNote =>
      'Distanza approssimativa · solo post pubblici con posizione';

  @override
  String get ui3PublicLocationPost => 'Post pubblico con posizione';

  @override
  String get ui3LocationServicesOff =>
      'I servizi di localizzazione sono disattivati';

  @override
  String get ui3LocationPermissionDenied =>
      'Autorizzazione alla posizione negata';

  @override
  String get ui3EnableLocationInSettings =>
      'Attiva l\'autorizzazione alla posizione nelle impostazioni di sistema';

  @override
  String get ui3CreateStory => 'Crea storia';

  @override
  String get ui3CreateStoryDesc => 'Pubblica uno stato di testo o foto.';

  @override
  String get ui3StoryCamera => 'Fotocamera storie';

  @override
  String get ui3StoryCameraDesc => 'Vai subito a filtri e modifica foto.';

  @override
  String get ui3MomentsDesc => 'Apri il feed completo e i commenti.';

  @override
  String get ui3MomentCamera => 'Fotocamera Momenti';

  @override
  String get ui3MomentCameraDesc =>
      'Crea un post e scegli subito i contenuti multimediali.';

  @override
  String get ui3GamesDesc => 'Avvia il centro giochi casual integrato.';

  @override
  String get ui3AvatarStudio => 'Studio avatar';

  @override
  String get ui3AvatarStudioDesc =>
      'Decorazioni, avatar NFT e tocchi di identità.';

  @override
  String get ui3SocialGraphDesc => 'Follow, fan e connessioni on-chain.';

  @override
  String get ui3SocialHubHeroTitle => 'Storie, momenti, giochi e avatar';

  @override
  String get ui3SocialHubHeroBody =>
      'Tutte le funzioni social in un unico posto, invece che sparse tra chat, profilo e scopri.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'Il grafo social non è configurato in questa build';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Collega un wallet per vedere il tuo grafo social';

  @override
  String get ui3AvatarStudioSignIn => 'Lo studio avatar richiede l\'accesso';

  @override
  String get a11yRemoveImage => 'Rimuovi immagine';

  @override
  String get a11yBack => 'Indietro';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Conferma transazione';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Una mini app chiede di inviare una transazione per tuo conto.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Aprire $name?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Apri';

  @override
  String get ui3StoryReplySendFailed =>
      'Impossibile inviare la risposta alla storia';

  @override
  String get ui3RedPacketDemoNotice =>
      'Busta rossa demo: solo un record nella chat, nessun asset on-chain reale viene trasferito.';

  @override
  String get ui3RedPacketCoverClassic => 'Rosso classico';

  @override
  String get ui3RedPacketCoverGolden => 'Dorato';

  @override
  String get ui3RedPacketCoverPurple => 'Viola';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Blu oceano';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Verde natura';

  @override
  String get ui3RedPacketCoverRosePink => 'Rosa cipria';

  @override
  String get ui3RedPacketHistoryEmpty => 'Nessuna busta rossa';

  @override
  String get ui3TransferMerchantQrWithAmount => 'QR esercente (con importo)';

  @override
  String get ui3TransferMerchantQrTitle => 'QR esercente';

  @override
  String get ui3TransferOpenAmountHint => 'Lascia vuoto per un importo libero';

  @override
  String get ui3FiatRampTitle => 'Compra / vendi cripto';

  @override
  String get ui3FiatRampBuy => 'Compra';

  @override
  String get ui3FiatRampSell => 'Vendi';

  @override
  String get ui3FiatRampNotConfigured => 'On/off-ramp fiat non configurato';

  @override
  String get a11yPointsAddRule => 'Aggiungi regola premio';

  @override
  String get a11yGovernanceRemoveChoice => 'Rimuovi opzione';

  @override
  String get a11yGovernanceCreateProposal => 'Crea proposta';

  @override
  String get ui3MiniAppUpdateN42 => 'Aggiorna N42';

  @override
  String get ui3MiniAppOfficial => 'Ufficiale';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count utenti';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Colore di sfondo $index';
  }

  @override
  String get a11yStoryAdd => 'Aggiungi storia';

  @override
  String get ui3StoryPostFailed => 'Impossibile pubblicare la storia';

  @override
  String get ui3StoryTapToSelectImage => 'Tocca per selezionare un\'immagine';

  @override
  String get ui3StoryChangeImage => 'Cambia';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Impossibile leggere la musica selezionata: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Eliminare questa storia?';

  @override
  String get ui3StoryDeleteFailed => 'Impossibile eliminare la storia';

  @override
  String get ui3MomentCreateTitle => 'Crea momento';

  @override
  String get ui3MomentContentHint => 'A cosa stai pensando?';

  @override
  String get ui3MomentAddPhotos => 'Aggiungi foto';

  @override
  String get ui3MomentAddLocation => 'Aggiungi posizione';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Contenuti selezionati ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Cancella tutto';

  @override
  String get ui3MomentClearMediaConfirm =>
      'Rimuovere tutte le foto/i video selezionati?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Visibile a tutti gli amici';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Visibile solo a te';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Scegli chi può vedere';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Nascondi ad amici specifici';

  @override
  String get ui3MomentVideos => 'Video';

  @override
  String get ui3MomentNoVideos => 'Ancora nessun video';

  @override
  String get a11yCallMinimize => 'Riduci a icona';

  @override
  String get a11yCallGridView => 'Vista a griglia';

  @override
  String get a11yCallFocusView => 'Vista in primo piano';

  @override
  String get ui3CallTools => 'Strumenti di chiamata';

  @override
  String get ui3CallMeetingTools => 'Strumenti riunione';

  @override
  String get ui3CallToolsSubtitle =>
      'Regola la qualità audio e video senza uscire dalla chiamata.';

  @override
  String get ui3CallAudioEnhancement => 'Miglioramento audio';

  @override
  String get ui3CallNoiseSuppression => 'Soppressione del rumore';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Riduce il rumore della tastiera e di sottofondo.';

  @override
  String get ui3CallEchoCancellation => 'Cancellazione dell\'eco';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Impedisce che l\'audio dell\'altoparlante rientri nel microfono.';

  @override
  String get ui3CallAutoGainControl => 'Controllo automatico del guadagno';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Mantiene più stabile il volume del microfono.';

  @override
  String get ui3CallVoiceIsolation => 'Isolamento vocale avanzato';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Usa un profilo di riduzione del rumore più incisivo.';

  @override
  String get ui3CallVideoSection => 'Impostazioni video';

  @override
  String get ui3CallBackgroundBlur => 'Sfocatura sfondo (beta)';

  @override
  String get ui3CallBlurDescReady =>
      'Preferenza attiva. La sfocatura effettiva dipende ancora dal rilascio del processore video.';

  @override
  String get ui3CallBlurDescSaved =>
      'La preferenza di sfocatura è salvata e verrà applicata quando l\'elaborazione della fotocamera sarà disponibile.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Attiva la fotocamera quando l\'elaborazione dello sfondo sarà disponibile.';

  @override
  String get ui3CallRecordingSection => 'Registrazione';

  @override
  String get ui3CallRecordingDesc =>
      'Richiede l\'egress lato server per poter salvare le registrazioni.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Impossibile aggiornare le impostazioni di chiamata: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Registrazione avviata';

  @override
  String get ui3VoiceRoomNotFound => 'Stanza non trovata';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Vuoi davvero terminare questa stanza vocale?';

  @override
  String get a11yGameMoveUp => 'Sposta in alto';

  @override
  String get a11yGameMoveDown => 'Sposta in basso';

  @override
  String get a11yGameMoveLeft => 'Sposta a sinistra';

  @override
  String get a11yGameMoveRight => 'Sposta a destra';

  @override
  String get a11yGameRotate => 'Ruota';

  @override
  String get a11yGameDrop => 'Lascia cadere';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count sticker aggiunti';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Aggiunta non riuscita: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Rimuovi sticker';

  @override
  String get ui3StickerRemoveConfirm =>
      'Rimuovere questo sticker dal pacchetto?';

  @override
  String get ui3StickerRemoveFailed => 'Rimozione non riuscita';

  @override
  String get ui3StickerRenamePack => 'Rinomina pacchetto';

  @override
  String get ui3StickerPackName => 'Nome del pacchetto';

  @override
  String get ui3StickerRenameFailed => 'Impossibile rinominare';

  @override
  String get ui3StickerDeletePack => 'Elimina pacchetto';

  @override
  String get ui3StickerThisPack => 'questo pacchetto';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Eliminare \"$name\" e tutti i suoi sticker? L\'operazione non può essere annullata.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Eliminazione non riuscita';

  @override
  String get ui3StickerPack => 'Pacchetto di sticker';

  @override
  String get ui3StickerAdding => 'Aggiunta…';

  @override
  String get ui3StickerAddStickers => 'Aggiungi sticker';

  @override
  String get ui3StickerPackNotFound => 'Pacchetto non trovato';

  @override
  String get ui3StickerEmptyHint =>
      'Tocca \"Aggiungi sticker\" per caricare immagini';

  @override
  String get ui3StickerNewPack => 'Nuovo pacchetto di sticker';

  @override
  String get ui3StickerCreate => 'Crea';

  @override
  String get ui3StickerCreateFailed => 'Impossibile creare il pacchetto';

  @override
  String ui3StickerInstalled(Object name) {
    return '\"$name\" installato';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Rimuovi pacchetto di sticker';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Rimuovere \"$name\" dai tuoi sticker?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '\"$name\" rimosso';
  }

  @override
  String get ui3StickerAiSticker => 'Sticker IA';

  @override
  String get ui3StickerStoreTab => 'Negozio';

  @override
  String get ui3StickerMyStickersTab => 'I miei sticker';

  @override
  String get ui3StickerNoneFound => 'Nessuno sticker trovato';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'di $author';
  }

  @override
  String get ui3StickerManage => 'Gestisci';

  @override
  String ui3StickerCount(Object count) {
    return '$count sticker';
  }

  @override
  String get ui3StickerNoneInstalled => 'Nessuno sticker installato';

  @override
  String get ui3StickerGetFromStore => 'Scarica sticker dal negozio';

  @override
  String get ui3StickerBrowseStore => 'Esplora negozio';

  @override
  String get ui3StickerAddedToAi => 'Aggiunto a \"Sticker IA\"';

  @override
  String get ui3StickerAddOneFailed => 'Impossibile aggiungere lo sticker';

  @override
  String get ui3StickerPromptLabel => 'Descrivi il tuo sticker';

  @override
  String get ui3StickerPromptHint =>
      'es. un gatto arancione felice con gli occhiali da sole';

  @override
  String get ui3StickerGenerating => 'Generazione…';

  @override
  String get ui3StickerGenerate => 'Genera';

  @override
  String get ui3StickerAddToStickers => 'Aggiungi agli sticker';

  @override
  String get ui3StickerGeneratingPreview => 'Generazione dello sticker…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Descrivi uno sticker e tocca \"Genera\"';
}
