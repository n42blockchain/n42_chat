// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get chatModuleInitFailed =>
      'Echec de l\'initialisation du module de chat';

  @override
  String get checkNetworkRetry =>
      'Veuillez verifier votre connexion reseau et reessayer';

  @override
  String get retry => 'Reessayer';

  @override
  String get unknownUser => 'Utilisateur inconnu';

  @override
  String get walletNotConnected => 'Portefeuille non connecte';

  @override
  String get cannotGetWalletAddress =>
      'Impossible d\'obtenir l\'adresse du portefeuille';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Demande de paiement : $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Service d\'appel non initialise';

  @override
  String get alreadyInCall => 'Deja en appel';

  @override
  String get meetingServiceNotInitialized =>
      'Service de reunion non initialise';

  @override
  String get livekitNotConfigured => 'LiveKit non configure';

  @override
  String get unknownConversation => 'Conversation inconnue';

  @override
  String startCallFailed(String error) {
    return 'Echec du demarrage de l\'appel : $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Echec de la reponse : $error';
  }

  @override
  String get connectionFailed => 'Echec de la connexion';

  @override
  String get callRejected => 'Appel refuse';

  @override
  String get noAnswer => 'Pas de reponse';

  @override
  String get invalidLoginResponse => 'Reponse de connexion invalide';

  @override
  String loginFailed(String error) {
    return 'Echec de la connexion : $error';
  }

  @override
  String get sessionRestoreFailed => 'Echec de la restauration de session';

  @override
  String get additionalVerificationRequired =>
      'Verification supplementaire requise';

  @override
  String registrationFailed(String error) {
    return 'Echec de l\'inscription : $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Impossible de se connecter au serveur : $error';
  }

  @override
  String get wrongUsernamePassword =>
      'Nom d\'utilisateur ou mot de passe incorrect';

  @override
  String get usernameTaken => 'Nom d\'utilisateur deja pris';

  @override
  String get invalidUsernameFormat => 'Format de nom d\'utilisateur invalide';

  @override
  String get rateLimitExceeded =>
      'Trop de demandes, veuillez reessayer plus tard';

  @override
  String get loginExpired => 'Session expiree';

  @override
  String joinMeetingFailed(String error) {
    return 'Echec de la participation a la reunion : $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Echec du partage d\'ecran : $error';
  }

  @override
  String get answer => 'Repondre';

  @override
  String get decline => 'Refuser';

  @override
  String get missedCall => 'Appel manque';

  @override
  String get callBack => 'Rappeler';

  @override
  String get incomingCall => 'Appel entrant';

  @override
  String get missedVideoCall => 'Appel video manque';

  @override
  String get missedVoiceCall => 'Appel vocal manque';

  @override
  String get passkeyNotInitialized => 'Cle d\'acces non initialisee';

  @override
  String get googleSignInNotConfigured => 'Connexion Google non configuree';

  @override
  String get encryptedMessage => '[Message chiffre]';

  @override
  String get sticker => '[Autocollant]';

  @override
  String get groupCreated => 'Groupe cree';

  @override
  String get groupNameChanged => 'Nom du groupe modifie';

  @override
  String get groupAvatarChanged => 'Avatar du groupe modifie';

  @override
  String get groupAnnouncementChanged => 'Annonce du groupe modifiee';

  @override
  String get image => '[Image]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Message vocal]';

  @override
  String get file => '[Fichier]';

  @override
  String get location => '[Position]';

  @override
  String get unknownMessage => '[Message inconnu]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName a rejoint le groupe';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName a quitte le groupe';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName a ete invite';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName a ete retire';
  }

  @override
  String get avatarDataEmpty => 'Les donnees de l\'avatar sont vides';

  @override
  String get avatarTooLarge => 'Fichier avatar trop volumineux, max 10 Mo';

  @override
  String get uploadAvatarFailed => 'Echec du telechargement de l\'avatar';

  @override
  String get delete => 'Supprimer';

  @override
  String get notLoggedIn => 'Non connecte';

  @override
  String roomNotExist(String roomId) {
    return 'Salon introuvable : $roomId';
  }

  @override
  String get uploadImageFailed => 'Echec du telechargement de l\'image';

  @override
  String get matrixClientNotInitialized => 'Client Matrix non initialise';

  @override
  String get uploadVoiceFailed =>
      'Echec du telechargement vocal : Impossible d\'obtenir l\'URI MXC';

  @override
  String get uploadVideoFailed =>
      'Echec du telechargement video : Impossible d\'obtenir l\'URI MXC';

  @override
  String get uploadFileFailed =>
      'Echec du telechargement du fichier : Impossible d\'obtenir l\'URI MXC';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Position : $lat, $lon';
  }

  @override
  String get myLocation => 'Ma position';

  @override
  String get pollEnded => 'Sondage termine';

  @override
  String get groupChat => 'Discussion de groupe';

  @override
  String get search => 'Rechercher';

  @override
  String get cancel => 'Annuler';

  @override
  String get userCancelled => 'Annule par l\'utilisateur';

  @override
  String get noData => 'Aucune donnee';

  @override
  String get noSearchResults => 'Aucun resultat de recherche';

  @override
  String get tryDifferentKeyword => 'Essayez un autre mot-cle';

  @override
  String get loadFailed => 'Echec du chargement';

  @override
  String get checkNetwork => 'Veuillez verifier votre connexion reseau';

  @override
  String get networkConnectionFailed => 'Echec de la connexion reseau';

  @override
  String get checkNetworkSettings => 'Veuillez verifier vos parametres reseau';

  @override
  String get messages => 'Messages';

  @override
  String get contacts => 'Contacts';

  @override
  String get discover => 'Decouvrir';

  @override
  String get me => 'Moi';

  @override
  String get voiceLoading => 'Chargement vocal, veuillez reessayer plus tard';

  @override
  String get voiceToTextFailed => 'Echec de la conversion vocale en texte';

  @override
  String get converting => 'Conversion en cours...';

  @override
  String get convertToText => 'En texte';

  @override
  String get convertToTextTitle => 'Convertir en texte';

  @override
  String get selectEmoji => 'Choisir un emoji';

  @override
  String get frequentlyUsed => 'Frequemment utilises';

  @override
  String get copy => 'Copier';

  @override
  String get forward => 'Transferer';

  @override
  String get unfavorite => 'Retirer des favoris';

  @override
  String get favorite => 'Ajouter aux favoris';

  @override
  String get resend => 'Renvoyer';

  @override
  String get recall => 'Rappeler';

  @override
  String get multiSelect => 'Selection multiple';

  @override
  String get quote => 'Citer';

  @override
  String get remind => 'Mentionner';

  @override
  String get searchThis => 'Rechercher';

  @override
  String get recallMessageConfirm => 'Rappeler ce message ?';

  @override
  String get youRecalledMessage => 'Vous avez rappele un message';

  @override
  String get otherRecalledMessage => 'Message rappele';

  @override
  String get reEdit => 'Reediter';

  @override
  String get copied => 'Copie';

  @override
  String get sendMessageHint => 'Envoyer un message';

  @override
  String get microphonePermissionRequired =>
      'Veuillez autoriser l\'acces au microphone';

  @override
  String startRecordingFailed(String error) {
    return 'Echec du demarrage de l\'enregistrement : $error';
  }

  @override
  String get recordingTooShort => 'Enregistrement trop court';

  @override
  String stopRecordingFailed(String error) {
    return 'Echec de l\'arret de l\'enregistrement : $error';
  }

  @override
  String get releaseToCancel => 'Relacher pour annuler';

  @override
  String get releaseToSend =>
      'Relacher pour envoyer, glisser vers le haut pour annuler';

  @override
  String get holdToTalk => 'Maintenir pour parler';

  @override
  String get send => 'Envoyer';

  @override
  String conversationWithId(String roomId) {
    return 'Conversation : $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Contact : $userId';
  }

  @override
  String get addFriend => 'Ajouter un ami';

  @override
  String get chatServiceNotConnected => 'Service de chat non connecte';

  @override
  String userNotFoundHint(String query) {
    return 'Utilisateur \"$query\" introuvable\n\nConseils :\n- Essayez de saisir l\'identifiant complet, ex. @utilisateur:serveur.com\n- Verifiez l\'orthographe du nom d\'utilisateur';
  }

  @override
  String createChatFailed(String error) {
    return 'Echec de la creation du chat : $error';
  }

  @override
  String searchFailed(String error) {
    return 'Echec de la recherche : $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Entrez l\'identifiant ou le nom d\'utilisateur pour rechercher';

  @override
  String get searching => 'Recherche en cours...';

  @override
  String get searchUserToChat =>
      'Rechercher un utilisateur pour commencer a discuter';

  @override
  String get matrixIdExample =>
      'Vous pouvez entrer un identifiant Matrix complet\nex. @utilisateur:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Utilisateur \"$username\" introuvable';
  }

  @override
  String get chat => 'Discussion';

  @override
  String get settings => 'Parametres';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get login => 'Se connecter';

  @override
  String get createGroup => 'Creer un groupe';

  @override
  String developing(String title) {
    return '$title\n(Bientot disponible)';
  }

  @override
  String get error => 'Erreur';

  @override
  String get pageNotFound => 'Page introuvable';

  @override
  String get backToHome => 'Retour a l\'accueil';

  @override
  String get allRead => 'Tout lu';

  @override
  String readCount(int count) {
    return '$count lu(s)';
  }

  @override
  String get transfer => 'Transfert';

  @override
  String get pendingReceipt => 'En attente';

  @override
  String get tapToReceive => 'Appuyer pour recevoir';

  @override
  String get received => 'Recu';

  @override
  String get paymentReceived => 'Paiement recu';

  @override
  String get refunded => 'Rembourse';

  @override
  String get expired => 'Expire';

  @override
  String get redPacketGreeting => 'Meilleurs voeux';

  @override
  String get n42RedPacket => 'Enveloppe rouge N42';

  @override
  String get goodLuck => 'Bonne chance';

  @override
  String get claimed => 'Reclame';

  @override
  String get allClaimed => 'Tout reclame';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Amour';

  @override
  String get animals => 'Animaux';

  @override
  String get food => 'Nourriture';

  @override
  String get travel => 'Voyage';

  @override
  String get activities => 'Activites';

  @override
  String get objects => 'Objets';

  @override
  String get symbols => 'Symboles';

  @override
  String get reply => 'Repondre';

  @override
  String get copiedToClipboard => 'Copie dans le presse-papiers';

  @override
  String get edit => 'Modifier';

  @override
  String get more => 'Plus';

  @override
  String get selectForwardTarget => 'Choisir le destinataire';

  @override
  String sendCount(int count) {
    return 'Envoyer ($count)';
  }

  @override
  String get draft => '[Brouillon] ';

  @override
  String n42Id(String id) {
    return 'ID N42 : $id';
  }

  @override
  String get n42IdTitle => 'ID N42';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Infos de l\'ami';

  @override
  String get friendInfoDesc =>
      'Ajouter une remarque, telephone, tags, notes, photos et definir les permissions.';

  @override
  String get moments => 'Moments';

  @override
  String get sendMessage => 'Message';

  @override
  String get audioVideoCall => 'Appel audio/video';

  @override
  String get videoChannel => 'Canal video';

  @override
  String get remark => 'Remarque';

  @override
  String get remarkName => 'Nom de remarque';

  @override
  String get phone => 'Telephone';

  @override
  String get tags => 'Tags';

  @override
  String get notes => 'Notes';

  @override
  String get photos => 'Photos';

  @override
  String get permissions => 'Permissions';

  @override
  String get chatMomentsEtc => 'Chat, Moments, Sports, etc.';

  @override
  String get moreInfo => 'Plus d\'infos';

  @override
  String get commonGroups => 'Groupes en commun';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Source';

  @override
  String get notificationSettings => 'Notifications';

  @override
  String get receiveNotifications =>
      'Recevoir les notifications de nouveaux messages';

  @override
  String get showPreview => 'Afficher l\'apercu du message';

  @override
  String get showContentInNotification =>
      'Afficher le contenu du message dans les notifications';

  @override
  String get notificationSound => 'Son de notification';

  @override
  String get playSoundOnMessage => 'Jouer un son a la reception des messages';

  @override
  String get vibrate => 'Vibrer';

  @override
  String get vibrateOnMessage => 'Vibrer a la reception des messages';

  @override
  String get doNotDisturb => 'Ne pas deranger';

  @override
  String get dndDescription =>
      'Couper les notifications pendant les heures specifiees';

  @override
  String get startTime => 'Heure de debut';

  @override
  String get endTime => 'Heure de fin';

  @override
  String get privacy => 'Confidentialite';

  @override
  String get appearance => 'Apparence';

  @override
  String get about => 'A propos';

  @override
  String get logout => 'Se deconnecter';

  @override
  String get logoutConfirm => 'Etes-vous sur de vouloir vous deconnecter ?';

  @override
  String get exit => 'Se deconnecter';

  @override
  String get save => 'Enregistrer';

  @override
  String get nickname => 'Surnom';

  @override
  String get enterNickname => 'Entrez un surnom';

  @override
  String get signature => 'Signature';

  @override
  String get addSignature => 'Ajouter une signature';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String saveFailed(String error) {
    return 'Echec de l\'enregistrement : $error';
  }

  @override
  String get secureDecentralizedChat => 'Messagerie securisee et decentralisee';

  @override
  String get endToEndEncryption => 'Chiffrement de bout en bout';

  @override
  String get messagesOnlyYouCanSee =>
      'Messages visibles uniquement par vous et le destinataire';

  @override
  String get decentralized => 'Decentralise';

  @override
  String get basedOnMatrix => 'Base sur le protocole ouvert Matrix';

  @override
  String get walletIntegration => 'Integration du portefeuille';

  @override
  String get easyCryptoTransfer => 'Transferts de crypto-monnaie faciles';

  @override
  String get register => 'S\'inscrire';

  @override
  String get agreeTerms => 'En vous connectant, vous acceptez';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get and => 'et';

  @override
  String get privacyPolicy => 'Politique de confidentialite';

  @override
  String get serverAddress => 'Adresse du serveur';

  @override
  String get enterServerAddress => 'Entrez l\'adresse du serveur';

  @override
  String get validServerAddress =>
      'Veuillez entrer une adresse de serveur valide';

  @override
  String connectedTo(String serverName) {
    return 'Connecte a $serverName';
  }

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get enterUsername => 'Entrez le nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get enterPassword => 'Entrez le mot de passe';

  @override
  String get registerAccount => 'S\'inscrire';

  @override
  String get forgotPassword => 'Mot de passe oublie';

  @override
  String get otherLoginMethods => 'Autres methodes de connexion';

  @override
  String get emailVerification => 'Code de verification par e-mail';

  @override
  String get enterServerFirst =>
      'Veuillez d\'abord entrer l\'adresse du serveur';

  @override
  String get passkeyNeedsServer =>
      'La connexion par cle d\'acces necessite le support du serveur';

  @override
  String googleLoginSuccess(String email) {
    return 'Connexion Google reussie : $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Echec de la connexion Google : $error';
  }

  @override
  String get appleLoginSuccess => 'Connexion Apple reussie';

  @override
  String appleLoginFailed(String error) {
    return 'Echec de la connexion Apple : $error';
  }

  @override
  String get createAccount => 'Creer un compte';

  @override
  String get joinN42Chat => 'Rejoignez N42 Chat pour commencer a discuter';

  @override
  String get usernameHint => '3-20 caracteres, lettres/chiffres/_';

  @override
  String get usernameMinLength =>
      'Le nom d\'utilisateur doit comporter au moins 3 caracteres';

  @override
  String get usernameMaxLength =>
      'Le nom d\'utilisateur doit comporter au maximum 20 caracteres';

  @override
  String get usernameFormat =>
      'Le nom d\'utilisateur ne peut contenir que des lettres, des chiffres et des traits de soulignement';

  @override
  String get passwordHint => 'Min 8 caracteres';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit comporter au moins 8 caracteres';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get reEnterPassword => 'Ressaisir le mot de passe';

  @override
  String get passwordsNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get inviteCode => 'Code d\'invitation (integre)';

  @override
  String get filled => 'Rempli';

  @override
  String get enterInviteCode => 'Entrez le code d\'invitation';

  @override
  String get inviteCodeHint =>
      'Le code d\'invitation est integre, generalement pas besoin de modifier';

  @override
  String get agreeTermsFirst =>
      'Veuillez d\'abord lire et accepter les conditions et la politique de confidentialite';

  @override
  String get iAgree => 'J\'ai lu et j\'accepte';

  @override
  String get alreadyHaveAccount => 'Vous avez deja un compte ?';

  @override
  String get loginNow => 'Se connecter maintenant';

  @override
  String get whoCanSee => 'Qui peut voir';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Statut';

  @override
  String get lastSeen => 'Derniere connexion';

  @override
  String get messageSettings => 'Messages';

  @override
  String get allowStrangerMessage => 'Autoriser les messages des inconnus';

  @override
  String get receiveNonContact => 'Recevoir les messages des non-contacts';

  @override
  String get readReceipts => 'Accusess de lecture';

  @override
  String get letOthersKnowRead =>
      'Informer les autres que vous avez lu leurs messages';

  @override
  String get typingStatus => 'Statut de saisie';

  @override
  String get letOthersKnowTyping =>
      'Informer les autres que vous etes en train d\'ecrire';

  @override
  String get everyone => 'Tout le monde';

  @override
  String get contactsOnly => 'Contacts uniquement';

  @override
  String get nobody => 'Personne';

  @override
  String whoCanSeeItem(String title) {
    return 'Qui peut voir $title';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get checkUpdate => 'Rechercher des mises a jour';

  @override
  String get openSourceLicenses => 'Licences open source';

  @override
  String get feedback => 'Commentaires';

  @override
  String get builtOnMatrix => 'Base sur le protocole Matrix';

  @override
  String get loading => 'Chargement...';

  @override
  String get noConversations => 'Aucune conversation';

  @override
  String get tapToChat => 'Appuyez en haut a droite pour commencer a discuter';

  @override
  String get startGroup => 'Demarrer une discussion de groupe';

  @override
  String get scan => 'Scanner';

  @override
  String get payment => 'Paiement';

  @override
  String featureComingSoon(String feature) {
    return '$feature bientot disponible';
  }

  @override
  String get markAsRead => 'Marquer comme lu';

  @override
  String get unmute => 'Reactiver le son';

  @override
  String get mute => 'Couper le son';

  @override
  String get unpin => 'Desepingler';

  @override
  String get pin => 'Epingler';

  @override
  String get deleteConversation => 'Supprimer la conversation';

  @override
  String deleteConversationConfirm(String name) {
    return 'Supprimer la conversation avec \"$name\" ?';
  }

  @override
  String get noContacts => 'Aucun contact';

  @override
  String get addFriendsToChat => 'Ajoutez des amis pour commencer a discuter';

  @override
  String get contactNotFound => 'Contact introuvable';

  @override
  String get tryOtherKeywords =>
      'Essayez d\'autres mots-cles ou une recherche globale';

  @override
  String get searchResults => 'Resultats de la recherche';

  @override
  String get newFriends => 'Nouveaux amis';

  @override
  String get chatOnlyFriends => 'Amis de chat uniquement';

  @override
  String get officialAccounts => 'Comptes officiels';

  @override
  String get serviceAccounts => 'Comptes de service';

  @override
  String get enterpriseContacts => 'Contacts entreprise';

  @override
  String contactsCount(int count) {
    return '$count contacts';
  }

  @override
  String get recommendToFriend => 'Partager le contact';

  @override
  String get setRemark => 'Definir une remarque';

  @override
  String get addToHome => 'Ajouter a l\'ecran d\'accueil';

  @override
  String get sendingCard => 'Envoi de la carte de contact...';

  @override
  String get contactCard => '[Carte de contact]';

  @override
  String get fileLabel => 'Fichier';

  @override
  String get locationLabel => 'Position';

  @override
  String cardSent(String contact, String friend) {
    return 'Carte de $contact envoyee a $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Echec de la recommandation : $error';
  }

  @override
  String get enterRemark => 'Entrez une remarque';

  @override
  String remarkSet(String remark) {
    return 'Remarque definie : $remark';
  }

  @override
  String get openingChat => 'Ouverture du chat...';

  @override
  String openChatFailed(String error) {
    return 'Echec de l\'ouverture du chat : $error';
  }

  @override
  String get addContact => 'Ajouter un contact';

  @override
  String get enterUserId => 'Entrez l\'identifiant utilisateur';

  @override
  String get noFriendRequests => 'Aucune demande d\'ami';

  @override
  String get accept => 'Accepter';

  @override
  String get reject => 'Refuser';

  @override
  String acceptedRequest(String name) {
    return 'Demande d\'ami de $name acceptee';
  }

  @override
  String rejectedRequest(String name) {
    return 'Demande d\'ami de $name refusee';
  }

  @override
  String get noGroups => 'Aucun groupe';

  @override
  String get creatingGroup => 'Creation de groupe bientot disponible...';

  @override
  String get selectFriendToRecommend => 'Selectionnez un ami a qui recommander';

  @override
  String get searchContacts => 'Rechercher des contacts';

  @override
  String get noContactsFound => 'Aucun contact trouve';

  @override
  String get yesterday => 'Hier';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mer';

  @override
  String get thursday => 'Jeu';

  @override
  String get friday => 'Ven';

  @override
  String get saturday => 'Sam';

  @override
  String get sunday => 'Dim';

  @override
  String get justNow => 'A l\'instant';

  @override
  String minutesAgo(int count) {
    return 'Il y a $count min';
  }

  @override
  String hoursAgo(int count) {
    return 'Il y a ${count}h';
  }

  @override
  String daysAgo(int count) {
    return 'Il y a ${count}j';
  }

  @override
  String get online => 'En ligne';

  @override
  String get offline => 'Hors ligne';

  @override
  String minutesAgoOnline(int count) {
    return 'En ligne il y a $count min';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'En ligne il y a ${count}h';
  }

  @override
  String daysAgoOnline(int count) {
    return 'En ligne il y a ${count}j';
  }

  @override
  String get searchContactsGroupsMessages =>
      'Rechercher contacts, groupes, messages';

  @override
  String get searchError => 'Erreur de recherche';

  @override
  String get searchHint => 'Rechercher contacts, groupes et messages';

  @override
  String get enterKeyword => 'Entrez des mots-cles pour rechercher';

  @override
  String get searchHistory => 'Historique de recherche';

  @override
  String get clear => 'Effacer';

  @override
  String noResultsFor(String query) {
    return 'Aucun resultat pour \"$query\"';
  }

  @override
  String get all => 'Tout';

  @override
  String get groups => 'Groupes';

  @override
  String get noResults => 'Aucun resultat';

  @override
  String get groupInfo => 'Infos du groupe';

  @override
  String groupMembers(int count) {
    return 'Membres ($count)';
  }

  @override
  String get groupMembersTitle => 'Membres du groupe';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get owner => 'Proprietaire';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Inviter';

  @override
  String get groupAnnouncement => 'Annonce du groupe';

  @override
  String get notSet => 'Non defini';

  @override
  String get groupDescription => 'Description du groupe';

  @override
  String get publicGroup => 'Groupe public';

  @override
  String get allowSearchJoin =>
      'Permettre aux autres de rechercher et rejoindre';

  @override
  String get clearChatHistory => 'Effacer l\'historique du chat';

  @override
  String get dissolveGroup => 'Dissoudre le groupe';

  @override
  String get leaveGroup => 'Quitter le groupe';

  @override
  String get changeGroupName => 'Changer le nom du groupe';

  @override
  String get enterGroupName => 'Entrez le nom du groupe';

  @override
  String get confirm => 'Confirmer';

  @override
  String get changeGroupDescription => 'Changer la description du groupe';

  @override
  String get enterGroupDescription => 'Entrez la description du groupe';

  @override
  String get editAnnouncement => 'Modifier l\'annonce';

  @override
  String get enterAnnouncement => 'Entrez l\'annonce';

  @override
  String get publish => 'Publier';

  @override
  String get clearHistoryConfirm =>
      'Effacer tout l\'historique du chat ? Cette action est irreversible.';

  @override
  String get clearAction => 'Effacer';

  @override
  String get chatHistoryCleared => 'Historique du chat efface';

  @override
  String leaveGroupConfirm(String name) {
    return 'Quitter \"$name\" ?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Dissoudre \"$name\" ? Cette action est irreversible.';
  }

  @override
  String get dissolve => 'Dissoudre';

  @override
  String get groupQrCode => 'Code QR du groupe';

  @override
  String get searchChatHistory => 'Rechercher dans l\'historique du chat';

  @override
  String get groupIdCopied => 'ID du groupe copie';

  @override
  String tapCopyGroupId(int count) {
    return '$count membres - Appuyez pour copier l\'ID du groupe';
  }

  @override
  String get receiverAddress => 'Adresse du destinataire';

  @override
  String get enterOrPasteAddress =>
      'Entrez ou collez l\'adresse du portefeuille';

  @override
  String get selectToken => 'Selectionner un jeton';

  @override
  String get transferAmount => 'Montant du transfert';

  @override
  String get available => 'Disponible';

  @override
  String get allAmount => 'Tout';

  @override
  String get memoOptional => 'Memo (facultatif)';

  @override
  String get addMemo => 'Ajouter un memo';

  @override
  String get confirmTransfer => 'Confirmer le transfert';

  @override
  String get invalidAddress =>
      'Veuillez entrer une adresse de destinataire valide';

  @override
  String get invalidAmount => 'Veuillez entrer un montant valide';

  @override
  String get selectTokenPlease => 'Veuillez selectionner un jeton';

  @override
  String get addressVerified => 'Adresse verifiee';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Disponible : $balance $symbol';
  }

  @override
  String get scanningInDevelopment =>
      'Fonctionnalite de scan en developpement...';

  @override
  String get enterAmount => 'Entrez le montant';

  @override
  String get redPacketCountMin => 'Au moins 1 enveloppe rouge requise';

  @override
  String get viewRedPacketDetails => 'Voir les details de l\'enveloppe rouge';

  @override
  String get enterTransferAmount => 'Entrez le montant du transfert';

  @override
  String get transferTo => 'Transferer a';

  @override
  String get selectCurrency => 'Selectionner la devise';

  @override
  String get receiveTransfer => 'Transfert recu';

  @override
  String fromSender(String name, Object senderName) {
    return 'De $senderName';
  }

  @override
  String get confirmReceive => 'Confirmer la reception';

  @override
  String get groupProfile => 'Infos du groupe';

  @override
  String get viewProfile => 'Voir le profil';

  @override
  String get removeMember => 'Retirer du groupe';

  @override
  String removeMemberConfirm(String name) {
    return 'Retirer \"$name\" du groupe ?';
  }

  @override
  String get remove => 'Retirer';

  @override
  String get clearStatus => 'Effacer le statut';

  @override
  String get clearStatusConfirm => 'Effacer le statut actuel ?';

  @override
  String get statusCleared => 'Statut efface';

  @override
  String statusSet(String result) {
    return 'Statut defini : $result';
  }

  @override
  String get userNotExist => 'L\'utilisateur n\'existe pas';

  @override
  String get userIdCopied => 'ID utilisateur copie';

  @override
  String get voiceCallInDevelopment => 'Appel vocal en developpement...';

  @override
  String get report => 'Signaler';

  @override
  String get reportInDevelopment =>
      'Fonctionnalite de signalement en developpement...';

  @override
  String get shareCard => 'Partager la carte';

  @override
  String get shareInDevelopment =>
      'Fonctionnalite de partage en developpement...';

  @override
  String get qrCode => 'Code QR';

  @override
  String get qrCodeInDevelopment =>
      'Fonctionnalite de code QR en developpement...';

  @override
  String get avatarUpdated => 'Avatar mis a jour';

  @override
  String selectImageFailed(String error) {
    return 'Echec de la selection de l\'image : $error';
  }

  @override
  String get changeName => 'Changer le nom';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String genderSet(String gender) {
    return 'Genre defini : $gender';
  }

  @override
  String regionSet(String region) {
    return 'Region definie : $region';
  }

  @override
  String get setPatText => 'Definir le texte de tapotement';

  @override
  String get changeSignature => 'Changer la signature';

  @override
  String ringtoneSet(String result) {
    return 'Sonnerie definie : $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature en developpement...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Echec de l\'enregistrement de l\'adresse : $error';
  }

  @override
  String get myAddress => 'Mon adresse';

  @override
  String get addNew => 'Ajouter';

  @override
  String get addAddress => 'Ajouter une adresse';

  @override
  String get addressAdded => 'Adresse ajoutee';

  @override
  String get addressUpdated => 'Adresse mise a jour';

  @override
  String get deleteAddress => 'Supprimer l\'adresse';

  @override
  String get deleteAddressConfirm => 'Supprimer cette adresse ?';

  @override
  String get addressDeleted => 'Adresse supprimee';

  @override
  String get setDefaultAddress => 'Definir par defaut';

  @override
  String get fillCompleteInfo => 'Veuillez remplir tous les champs';

  @override
  String saveInvoiceFailed(String error) {
    return 'Echec de l\'enregistrement de la facture : $error';
  }

  @override
  String get myInvoices => 'Mes factures';

  @override
  String get addInvoice => 'Ajouter une facture';

  @override
  String get invoiceAdded => 'Facture ajoutee';

  @override
  String get invoiceUpdated => 'Facture mise a jour';

  @override
  String get deleteInvoice => 'Supprimer la facture';

  @override
  String get deleteInvoiceConfirm => 'Supprimer cette facture ?';

  @override
  String get invoiceDeleted => 'Facture supprimee';

  @override
  String get invoiceType => 'Type de facture : ';

  @override
  String get personal => 'Personnel';

  @override
  String get enterprise => 'Entreprise';

  @override
  String get setDefaultInvoice => 'Definir par defaut';

  @override
  String get enterTaxId => 'Entrez le numero de TVA';

  @override
  String get vibrateMode => 'Mode vibration';

  @override
  String get silentMode => 'Mode silencieux';

  @override
  String playing(String ringtoneName) {
    return 'Lecture : $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Echec de la lecture : $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Veuillez entrer le nom du groupe';

  @override
  String get selectAtLeastOne => 'Veuillez selectionner au moins un membre';

  @override
  String get fillStatus => 'Ecrire le statut';

  @override
  String get fileNotExist => 'Le fichier n\'existe pas';

  @override
  String sendFailed(String error) {
    return 'Echec de l\'envoi : $error';
  }

  @override
  String get cannotOpenBrowser => 'Impossible d\'ouvrir le navigateur';

  @override
  String selectFileFailed(String error) {
    return 'Echec de la selection du fichier : $error';
  }

  @override
  String get enterMusicLink => 'Entrez le lien musical';

  @override
  String get enterValidLink => 'Veuillez entrer un lien valide';

  @override
  String get enterPollQuestion => 'Entrez la question du sondage';

  @override
  String get minTwoOptions => 'Au moins 2 options requises';

  @override
  String get crossDeviceEnabled => 'Signature multi-appareils activee';

  @override
  String get crossDeviceSet =>
      'Signature multi-appareils configuree avec succes';

  @override
  String setupFailed(String error) {
    return 'Echec de la configuration : $error';
  }

  @override
  String get receiveAmount => 'Montant a recevoir';

  @override
  String get enterValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get addressCopied => 'Adresse copiee';

  @override
  String openItem(String content) {
    return 'Ouvrir : $content';
  }

  @override
  String get newNoteComingSoon => 'Nouvelle note bientot disponible';

  @override
  String get addLinkComingSoon => 'Ajout de lien bientot disponible';

  @override
  String get deleted => 'Supprime';

  @override
  String get shareComingSoon => 'Partage bientot disponible';

  @override
  String get saveComingSoon => 'Enregistrement bientot disponible';

  @override
  String get moreStylesComingSoon => 'Plus de styles bientot disponibles';

  @override
  String get wallet => 'Portefeuille';

  @override
  String get walletArea => 'Zone portefeuille';

  @override
  String get recording => 'Enregistrement';

  @override
  String get invalidVideoUrl => 'URL video invalide';

  @override
  String get downloadFile => 'Telecharger le fichier';

  @override
  String get clearChatHistoryTitle => 'Effacer l\'historique du chat';

  @override
  String get cannotUndo => 'Cette action est irreversible';

  @override
  String get videoCall => 'Appel video';

  @override
  String get voiceCall => 'Appel vocal';

  @override
  String get leaveMeeting => 'Quitter la reunion';

  @override
  String get chatDetails => 'Details du chat';

  @override
  String get viewAllGroupMembers => 'Voir tous les membres';

  @override
  String get groupName => 'Nom du groupe';

  @override
  String get groupNameUpdated => 'Nom du groupe mis a jour';

  @override
  String get updateFailed => 'Echec de la mise a jour';

  @override
  String get noPermissionToModify =>
      'Vous n\'avez pas la permission de modifier';

  @override
  String get groupManagement => 'Gestion du groupe';

  @override
  String get myNicknameInGroup => 'Mon surnom dans le groupe';

  @override
  String get pinChat => 'Epingler le chat';

  @override
  String get strongReminder => 'Rappel important';

  @override
  String get setChatBackground => 'Definir l\'arriere-plan du chat';

  @override
  String get unknownFile => 'Fichier inconnu';

  @override
  String get download => 'Telecharger';

  @override
  String get invalidLocation => 'Position invalide';

  @override
  String get address => 'Adresse';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get close => 'Fermer';

  @override
  String get tapToCancel => 'Appuyez pour annuler';

  @override
  String captureFailed(Object error) {
    return 'Echec de la capture : $error';
  }

  @override
  String get processingVideo => 'Traitement de la video...';

  @override
  String get videoFileNotExist => 'Le fichier video n\'existe pas';

  @override
  String get videoDataEmpty => 'Les donnees video sont vides';

  @override
  String get videoTooLarge =>
      'La taille de la video ne peut pas depasser 100 Mo';

  @override
  String get sendingVideo => 'Envoi de la video...';

  @override
  String sendVideoFailed(Object error) {
    return 'Echec de l\'envoi de la video : $error';
  }

  @override
  String get imageFileNotExist => 'Le fichier image n\'existe pas';

  @override
  String get imageDataEmpty => 'Les donnees de l\'image sont vides';

  @override
  String get sendingImage => 'Envoi de l\'image...';

  @override
  String sendImageFailed(Object error) {
    return 'Echec de l\'envoi de l\'image : $error';
  }

  @override
  String get sendLocation => 'Envoyer la position';

  @override
  String get selectLocationAndSend => 'Selectionner la position et envoyer';

  @override
  String get shareRealTimeLocation => 'Partager la position en temps reel';

  @override
  String get shareLocationForOneHour =>
      'Partager la position en temps reel avec un ami pendant 1 heure';

  @override
  String get locationSent => 'Position envoyee';

  @override
  String get selectMessages => 'Selectionner les messages';

  @override
  String selectedCount(int count) {
    return '$count selectionne(s)';
  }

  @override
  String get selectAll => 'Tout selectionner';

  @override
  String groupChatCount(int count) {
    return 'Discussion de groupe ($count)';
  }

  @override
  String get privateChat => 'Discussion privee';

  @override
  String get noMessages => 'Aucun message';

  @override
  String get sendFirstMessage =>
      'Envoyez le premier message pour commencer a discuter';

  @override
  String get encryptionNotice =>
      'Cette conversation est chiffree de bout en bout. Seuls vous et le destinataire pouvez lire les messages.';

  @override
  String replyTo(String name) {
    return 'Repondre a $name';
  }

  @override
  String get multiForward => 'Transferer';

  @override
  String get collect => 'Collecter';

  @override
  String get noMembers => 'Aucun membre';

  @override
  String get memberNotFound => 'Membre introuvable';

  @override
  String get voiceFileNotExist => 'Le fichier vocal n\'existe pas';

  @override
  String get voiceFileEmpty => 'Le fichier vocal est vide';

  @override
  String get sendingVoice => 'Envoi du message vocal...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Echec de l\'envoi du message vocal : $error';
  }

  @override
  String get messageCopied => 'Message copie';

  @override
  String get messageForwarded => 'Message transfere';

  @override
  String forwardFailed(Object error) {
    return 'Echec du transfert : $error';
  }

  @override
  String get unfavorited => 'Retire des favoris';

  @override
  String get favorited => 'Ajoute aux favoris';

  @override
  String get reactionAdded => 'Reaction ajoutee';

  @override
  String get failedMessageDeleted => 'Message echoue supprime';

  @override
  String get deleteMessages => 'Supprimer les messages';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Etes-vous sur de vouloir supprimer $count messages ?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Remarque : $count messages proviennent d\'autres personnes, ne peuvent etre supprimes que localement.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count messages de votre part seront rappeles.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return '$count messages rappeles, $localCount supprimes localement';
  }

  @override
  String recalledMessages(Object count) {
    return '$count messages rappeles';
  }

  @override
  String deletedLocally(Object count) {
    return '$count messages supprimes (localement)';
  }

  @override
  String forwardedCount(Object count) {
    return '$count messages transferes';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Transfert termine : $success reussi(s), $failed echoue(s)';
  }

  @override
  String get remindOnlyInGroup =>
      'La fonctionnalite de rappel n\'est disponible que dans les discussions de groupe';

  @override
  String get onlyTextSearchable =>
      'Seuls les messages texte peuvent etre recherches';

  @override
  String searchFor(Object text) {
    return 'Rechercher \"$text\"';
  }

  @override
  String get baiduSearch => 'Recherche Baidu';

  @override
  String get googleSearch => 'Recherche Google';

  @override
  String get bingSearch => 'Recherche Bing';

  @override
  String get calling => 'Appel en cours...';

  @override
  String get connecting => 'Connexion en cours...';

  @override
  String get ringing => 'Sonnerie...';

  @override
  String get inCall => 'En appel';

  @override
  String featureInDevelopment(String feature) {
    return '$feature en cours de developpement...';
  }

  @override
  String collectMessages(Object count) {
    return '$count messages collectes';
  }

  @override
  String get voted => 'Vote';

  @override
  String get voteChanged => 'Vote modifie';

  @override
  String get voteRemoved => 'Vote retire';

  @override
  String get endPoll => 'Terminer le sondage';

  @override
  String get endPollConfirm =>
      'Etes-vous sur de vouloir terminer ce sondage ? Aucun vote ne pourra etre effectue apres.';

  @override
  String memberCount(int count) {
    return '$count membres';
  }

  @override
  String get videoChannels => 'Chaines';

  @override
  String get live => 'Direct';

  @override
  String get listen => 'Ecouter';

  @override
  String get watch => 'Regarder';

  @override
  String get searchDiscover => 'Rechercher';

  @override
  String get nearbyPeople => 'A proximite';

  @override
  String get games => 'Jeux';

  @override
  String get miniPrograms => 'Mini programmes';

  @override
  String done(int count) {
    return 'Termine($count)';
  }

  @override
  String get services => 'Services';

  @override
  String get favorites => 'Favoris';

  @override
  String get ordersAndCards => 'Commandes et cartes';

  @override
  String get stickers => 'Autocollants';

  @override
  String statusSetTo(String status) {
    return 'Statut defini : $status';
  }

  @override
  String get avatarUploadFailed => 'Echec du telechargement de l\'avatar';

  @override
  String get personalProfile => 'Profil personnel';

  @override
  String get name => 'Nom';

  @override
  String get gender => 'Genre';

  @override
  String get region => 'Region';

  @override
  String get myQrCode => 'Mon code QR';

  @override
  String get poke => 'Tapotement';

  @override
  String get ringtone => 'Sonnerie';

  @override
  String get defaultRingtone => 'Sonnerie par defaut';

  @override
  String get myAddresses => 'Mes adresses';

  @override
  String genderSetTo(String gender) {
    return 'Genre defini : $gender';
  }

  @override
  String get selectRegion => 'Selectionner la region';

  @override
  String get selectCity => 'Selectionner la ville';

  @override
  String regionSetTo(String region) {
    return 'Region definie : $region';
  }

  @override
  String get setPoke => 'Definir le tapotement';

  @override
  String get friendPokedMe => 'Mon ami m\'a tapote';

  @override
  String get enterPokeSuffix =>
      'Entrez le suffixe de tapotement, ex. : sur l\'epaule';

  @override
  String get example => 'Exemple';

  @override
  String get onTheShoulder => ' sur l\'epaule';

  @override
  String get pokeCleared => 'Tapotement efface';

  @override
  String pokeSetTo(String suffix) {
    return 'Tapotement defini : m\'a tapote$suffix';
  }

  @override
  String get editSignature => 'Modifier la signature';

  @override
  String get introduceYourself => 'Une phrase pour vous presenter';

  @override
  String get signatureCleared => 'Signature effacee';

  @override
  String get signatureUpdated => 'Signature mise a jour';

  @override
  String get scanToAddFriend =>
      'Scannez le code QR ci-dessus pour m\'ajouter comme ami';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Sonnerie definie : $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Êtes-vous sûr de vouloir dissoudre « $name » ? Cette action est irréversible.';
  }

  @override
  String get enterValidServerAddress =>
      'Veuillez entrer une adresse de serveur valide';

  @override
  String get emailOtp => 'OTP par e-mail';

  @override
  String get enterServerAddressFirst =>
      'Veuillez d\'abord entrer l\'adresse du serveur';

  @override
  String get passkeyRequiresServer =>
      'La connexion par cle d\'acces necessite le support du serveur';

  @override
  String get loginAgreement => 'En vous connectant, vous acceptez ';

  @override
  String get pleaseAgreeToTerms =>
      'Veuillez lire et accepter les conditions d\'utilisation et la politique de confidentialite';

  @override
  String get registerFailed => 'Echec de l\'inscription';

  @override
  String get reenterPassword => 'Ressaisir le mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get inviteCodeBuiltIn => 'Code d\'invitation (integre)';

  @override
  String get inviteCodeBuiltInNote =>
      'Le code d\'invitation est integre, generalement pas besoin de modifier';

  @override
  String get iHaveReadAndAgree => 'J\'ai lu et j\'accepte ';

  @override
  String get startGroupChat => 'Demarrer une discussion de groupe';

  @override
  String get addFriends => 'Ajouter des amis';

  @override
  String get paymentAndCollection => 'Paiement';

  @override
  String messagesWithCount(int count) {
    return 'Messages($count)';
  }

  @override
  String contactCount(int count) {
    return '$count contacts';
  }

  @override
  String get addToHomeScreen => 'Ajouter a l\'ecran d\'accueil';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Carte de $contact recommandee a $recipient';
  }

  @override
  String get enterRemarkName => 'Entrez le nom de remarque';

  @override
  String remarkSetTo(String remark) {
    return 'Remarque definie : $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Demande d\'ami de $name acceptee';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Demande d\'ami de $name refusee';
  }

  @override
  String get groupInvites => 'Invitations de groupe';

  @override
  String myGroups(int count) {
    return 'Mes groupes ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Invite a rejoindre le groupe';

  @override
  String confirmLeaveGroup(String name) {
    return 'Êtes-vous sûr de vouloir quitter « $name » ?';
  }

  @override
  String get leave => 'Quitter';

  @override
  String get saveMedia => 'Enregistrer';

  @override
  String get recallThisMessage => 'Rappeler ce message ?';

  @override
  String get messageRecalled => 'Message rappele';

  @override
  String get savedToGallery => 'Enregistre dans la galerie';

  @override
  String get failedToSave => 'Echec de l\'enregistrement';

  @override
  String get saving => 'Enregistrement...';

  @override
  String get share => 'Partager';

  @override
  String get saveToGallery => 'Enregistrer dans la galerie';

  @override
  String downloadFailed(String code) {
    return 'Échec du téléchargement : $code';
  }

  @override
  String get noMediaUrl => 'Aucune URL media disponible';

  @override
  String shareFailed(String error) {
    return 'Échec du partage : $error';
  }

  @override
  String get failedToLoadImage => 'Echec du chargement de l\'image';

  @override
  String get failedToLoadMoreMessages =>
      'Echec du chargement de plus de messages';

  @override
  String get failedToSend => 'Echec de l\'envoi';

  @override
  String get failedToSendImage => 'Echec de l\'envoi de l\'image';

  @override
  String get failedToSendVoice => 'Echec de l\'envoi du message vocal';

  @override
  String get failedToSendFile => 'Echec de l\'envoi du fichier';

  @override
  String get failedToSendVideo => 'Echec de l\'envoi de la video';

  @override
  String get failedToSendLocation => 'Echec de l\'envoi de la position';

  @override
  String get failedToResend => 'Echec du renvoi';

  @override
  String get failedToRecall => 'Echec du rappel';

  @override
  String get failedToReply => 'Echec de la reponse';

  @override
  String get failedToAddReaction => 'Echec de l\'ajout de la reaction';

  @override
  String get failedToSendPoll => 'Echec de l\'envoi du sondage';

  @override
  String get failedToVote => 'Echec du vote';

  @override
  String get failedToLoadMessages => 'Echec du chargement des messages';

  @override
  String get callFeatureComingSoon =>
      'Fonctionnalite d\'appel vocal et video bientot disponible';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Les enveloppes rouges et les transferts ne peuvent pas etre transferes';

  @override
  String get videoRecordingFailed =>
      'Echec de l\'enregistrement video. Veuillez reessayer.';

  @override
  String get redPacket => 'Enveloppe rouge';

  @override
  String get music => 'Musique';

  @override
  String get coupon => 'Coupon';

  @override
  String get gift => 'Cadeau';

  @override
  String get poll => 'Sondage';

  @override
  String get text => 'Texte';

  @override
  String get link => 'Lien';

  @override
  String get note => 'Note';

  @override
  String get myNotes => 'Mes notes';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String daysAgoText(int count) {
    return 'Il y a $count jours';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Pas encore de favoris';

  @override
  String get longPressToFavorite =>
      'Appuyez longuement sur un message pour l\'ajouter aux favoris';

  @override
  String get newNote => 'Nouvelle note';

  @override
  String get favoriteLink => 'Lien favori';

  @override
  String get editTags => 'Modifier les tags';

  @override
  String get deleteFavorite => 'Supprimer le favori';

  @override
  String get deleteFavoriteConfirm =>
      'Etes-vous sur de vouloir supprimer ce favori ?';

  @override
  String get noSearchResultsFound => 'Aucun resultat trouve';

  @override
  String get sendRedPacket => 'Envoyer une enveloppe rouge';

  @override
  String get amount => 'Montant';

  @override
  String get redPacketCover => 'Couverture de l\'enveloppe rouge';

  @override
  String get redPacketType => 'Type d\'enveloppe rouge';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'Chance';

  @override
  String get redPacketCount => 'Nombre d\'enveloppes rouges';

  @override
  String get pieces => 'pieces';

  @override
  String get putMoneyInRedPacket =>
      'Mettre de l\'argent dans l\'enveloppe rouge';

  @override
  String get redPacketRefundNotice =>
      'Les enveloppes rouges non reclamees seront remboursees apres 24 heures';

  @override
  String get openRedPacket => 'Ouvrir';

  @override
  String get redPacketAllClaimed => 'Enveloppe rouge entierement reclamee';

  @override
  String get redPacketExpired => 'Enveloppe rouge expiree';

  @override
  String get addTransferNote => 'Ajouter une note de transfert';

  @override
  String get yuan => 'EUR';

  @override
  String get savedToChangeCanTransfer =>
      'Enregistre dans le solde, transfert direct possible';

  @override
  String get replyWithEmoji => 'Repondre avec cet emoji';

  @override
  String get claimedYourRedPacket => 'a reclame votre';

  @override
  String get claimedRedPacket => 'a reclame';

  @override
  String get otherTyping => 'en train d\'ecrire...';

  @override
  String get processing => 'Traitement en cours...';

  @override
  String get transferCancelled => 'Transfert annule';

  @override
  String get transferFailed => 'Echec du transfert';

  @override
  String get creatingPaymentRequest => 'Creation de la demande de paiement...';

  @override
  String get processingPayment => 'Traitement du paiement...';

  @override
  String get paymentFailed => 'Echec du paiement';

  @override
  String get clickRetry => 'Appuyez pour reessayer';

  @override
  String get settingsTitle => 'Parametres';

  @override
  String get editRemark => 'Modifier la remarque';

  @override
  String get setPermissions => 'Definir les permissions';

  @override
  String get recommendToFriends => 'Recommander a des amis';

  @override
  String get setStarFriend => 'Definir comme ami favori';

  @override
  String get addToBlacklist => 'Ajouter a la liste noire';

  @override
  String get complain => 'Signaler';

  @override
  String get deleteContact => 'Supprimer le contact';

  @override
  String deleteContactConfirm(String name) {
    return 'Etes-vous sur de vouloir supprimer $name ?';
  }

  @override
  String get transferTitle => 'Transfert';

  @override
  String get receiverAddressLabel => 'Adresse du destinataire';

  @override
  String get selectTokenLabel => 'Selectionner un jeton';

  @override
  String get transferAmountLabel => 'Montant du transfert';

  @override
  String get memoLabel => 'Memo (facultatif)';

  @override
  String get enterOrPasteAddressHint =>
      'Entrez ou collez l\'adresse du portefeuille';

  @override
  String get scanInDevelopment => 'Fonctionnalite de scan en developpement...';

  @override
  String get availableLabel => 'Disponible';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Disponible : $balance $symbol';
  }

  @override
  String get addMemoHint => 'Ajouter un memo';

  @override
  String get receiveTitle => 'Recevoir';

  @override
  String get walletNotConnectedTitle => 'Portefeuille non connecte';

  @override
  String get connectWalletFirst =>
      'Veuillez d\'abord connecter votre portefeuille';

  @override
  String get sendPaymentRequest => 'Envoyer une demande de paiement';

  @override
  String get qrCodeGenerateFailed => 'Echec de la generation du code QR';

  @override
  String get scanQrToPayMe => 'Scannez le code QR pour me payer';

  @override
  String get myWalletAddress => 'Adresse de mon portefeuille';

  @override
  String get createPaymentRequest => 'Creer une demande de paiement';

  @override
  String get selectTokenHint => 'Selectionner un jeton';

  @override
  String get amountLabel => 'Montant';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get sendRequestButton => 'Envoyer la demande';

  @override
  String get allReadReceipt => 'Tout lu';

  @override
  String readCountReceipt(int count) {
    return '$count lu(s)';
  }

  @override
  String n42IdLabel(String id) {
    return 'ID N42 : $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Meilleurs voeux';

  @override
  String senderRedPacket(String name) {
    return 'Enveloppe rouge de $name';
  }

  @override
  String get allButton => 'Tout';

  @override
  String get enterValidAddress => 'Veuillez entrer une adresse valide';

  @override
  String get pleaseSelectToken => 'Veuillez selectionner un jeton';

  @override
  String get receivedTransfer => 'Transfert recu';

  @override
  String get selectForwardRecipient =>
      'Selectionner le destinataire du transfert';

  @override
  String get emojiFaces => 'Visages';

  @override
  String get emojiHearts => 'Coeurs';

  @override
  String get emojiAnimals => 'Animaux';

  @override
  String get emojiFood => 'Nourriture';

  @override
  String get emojiTransport => 'Transport';

  @override
  String get emojiActivities => 'Activites';

  @override
  String get emojiObjects => 'Objets';

  @override
  String get emojiSymbols => 'Symboles';

  @override
  String get transferProcessing => 'Traitement du transfert...';

  @override
  String senderSentRedPacket(String name) {
    return '$name a envoye une enveloppe rouge';
  }

  @override
  String get savedToBalance =>
      'Enregistre dans le solde, transfert direct possible';

  @override
  String get redPacketExpiredOrEmpty =>
      'Enveloppe rouge expiree/entierement reclamee';

  @override
  String get scanFeatureComingSoon =>
      'Fonctionnalite de scan bientot disponible...';

  @override
  String get setAsStarred => 'Definir comme favori';

  @override
  String get addToBlocklist => 'Ajouter a la liste de blocage';

  @override
  String get claimedYour => ' a reclame votre ';

  @override
  String get claimedText => ' a reclame ';

  @override
  String userTyping(String name) {
    return '$name est en train d\'ecrire...';
  }

  @override
  String get typing => 'En train d\'ecrire...';

  @override
  String get waitingToReceive => 'En attente de reception';

  @override
  String get tapToClaim => 'Appuyez pour reclamer';

  @override
  String get hasBeenReceived => 'A ete recu';

  @override
  String get getLucky => 'Bonne chance';

  @override
  String get cameraStartFailed => 'Echec du demarrage de la camera';

  @override
  String get unknownError => 'Erreur inconnue';

  @override
  String get placeQrCodeInFrame =>
      'Placez le code QR dans le cadre pour scanner';

  @override
  String get closeManualInput => 'Fermer la saisie manuelle';

  @override
  String get manualInputUserId => 'Saisie manuelle de l\'ID utilisateur';

  @override
  String get add => 'Ajouter';

  @override
  String get ringtoneClear => 'Effacer';

  @override
  String get ringtonePhone => 'Telephone';

  @override
  String get ringtoneClassic => 'Classique';

  @override
  String get ringtoneSoft => 'Doux';

  @override
  String get ringtoneVibrate => 'Vibration';

  @override
  String get ringtoneSilent => 'Silencieux';

  @override
  String get stop => 'Arreter';

  @override
  String get selectRingtone => 'Selectionner la sonnerie';

  @override
  String get loadingRingtones => 'Chargement des sonneries...';

  @override
  String get noRingtonesFound => 'Aucune sonnerie trouvee';

  @override
  String get moodAndThoughts => 'Humeur et pensees';

  @override
  String get statusHappy => 'Heureux';

  @override
  String get statusCracked => 'Brise';

  @override
  String get statusLucky => 'Chanceux';

  @override
  String get statusSunny => 'Ensoleille';

  @override
  String get statusTired => 'Fatigue';

  @override
  String get statusDaydream => 'Reverie';

  @override
  String get statusRushing => 'Presse';

  @override
  String get statusOverthinking => 'Trop reflechir';

  @override
  String get statusEnergized => 'Energise';

  @override
  String get workAndStudy => 'Travail et etudes';

  @override
  String get statusWorking => 'Au travail';

  @override
  String get statusStudying => 'En etudes';

  @override
  String get statusBusy => 'Occupe';

  @override
  String get statusSlacking => 'Au repos';

  @override
  String get statusTraveling => 'En voyage';

  @override
  String get statusGoingHome => 'Rentrer a la maison';

  @override
  String get statusDnd => 'Ne pas deranger';

  @override
  String get statusHanging => 'Sortie';

  @override
  String get statusCheckIn => 'Enregistrement';

  @override
  String get statusExercising => 'Exercice';

  @override
  String get statusCoffee => 'Cafe';

  @override
  String get statusBubbleTea => 'The a bulles';

  @override
  String get statusEating => 'Manger';

  @override
  String get statusParenting => 'Parentalite';

  @override
  String get statusSavingWorld => 'Sauver le monde';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Repos';

  @override
  String get statusRetreat => 'Retraite';

  @override
  String get statusHome => 'A la maison';

  @override
  String get statusSleeping => 'Dormir';

  @override
  String get statusCatLover => 'Amateur de chats';

  @override
  String get statusDogWalking => 'Promener le chien';

  @override
  String get statusGaming => 'Jouer';

  @override
  String get statusListening => 'Ecouter';

  @override
  String get setStatus => 'Definir le statut';

  @override
  String get visibleToFriends24h => 'Visible par les amis pendant 24 heures';

  @override
  String get writeStatus => 'Ecrire le statut';

  @override
  String get enterYourStatus => 'Entrez votre statut...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'L\'autorisation de la camera est requise pour scanner le code QR';

  @override
  String get cameraPermissionDenied =>
      'L\'autorisation de la camera a ete refusee definitivement. Veuillez l\'activer dans les parametres systeme.';

  @override
  String get cannotGetCameraPermission =>
      'Impossible d\'obtenir l\'autorisation de la camera';

  @override
  String permissionCheckError(String error) {
    return 'Erreur lors de la verification de l\'autorisation : $error';
  }

  @override
  String get invalidQrCode => 'Code QR invalide';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Echec du traitement du code QR : $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Impossible d\'ajouter l\'ami : $error';
  }

  @override
  String get scanQrCode => 'Scanner le code QR';

  @override
  String get checkingCameraPermission =>
      'Verification de l\'autorisation de la camera...';

  @override
  String get needCameraPermission => 'Autorisation de la camera requise';

  @override
  String get retryPermission => 'Reessayer';

  @override
  String get openSettings => 'Ouvrir les parametres';

  @override
  String get inviteMembers => 'Inviter des membres';

  @override
  String inviteCount(int count) {
    return 'Inviter($count)';
  }

  @override
  String get noShippingAddress => 'Pas d\'adresse de livraison';

  @override
  String get defaultLabel => 'Par defaut';

  @override
  String get editAddress => 'Modifier l\'adresse';

  @override
  String get recipient => 'Destinataire';

  @override
  String get enterRecipientName => 'Entrez le nom du destinataire';

  @override
  String get phoneNumber => 'Numero de telephone';

  @override
  String get enterPhoneNumber => 'Entrez le numero de telephone';

  @override
  String get regionHint => 'Region/Departement/Ville';

  @override
  String get detailedAddress => 'Adresse detaillee';

  @override
  String get detailedAddressHint => 'Rue, numero de batiment, etc.';

  @override
  String get setAsDefaultAddress => 'Definir comme adresse par defaut';

  @override
  String get pleaseCompleteInfo => 'Veuillez completer tous les champs';

  @override
  String get noInvoice => 'Pas de facture';

  @override
  String get company => 'Entreprise';

  @override
  String get taxNumber => 'Numero de TVA';

  @override
  String get editInvoice => 'Modifier la facture';

  @override
  String get companyName => 'Nom de l\'entreprise';

  @override
  String get enterCompanyName => 'Entrez le nom de l\'entreprise';

  @override
  String get personalName => 'Nom personnel';

  @override
  String get enterName => 'Entrez le nom';

  @override
  String get taxIdNumber => 'Numero d\'identification fiscale';

  @override
  String get enterTaxIdNumber => 'Entrez le numero d\'identification fiscale';

  @override
  String get bankNameOptional => 'Nom de la banque (facultatif)';

  @override
  String get enterBankName => 'Entrez le nom de la banque';

  @override
  String get bankAccountOptional => 'Compte bancaire (facultatif)';

  @override
  String get enterBankAccount => 'Entrez le compte bancaire';

  @override
  String get companyAddressOptional => 'Adresse de l\'entreprise (facultatif)';

  @override
  String get enterCompanyAddress => 'Entrez l\'adresse de l\'entreprise';

  @override
  String get companyPhoneOptional => 'Telephone de l\'entreprise (facultatif)';

  @override
  String get enterCompanyPhone => 'Entrez le telephone de l\'entreprise';

  @override
  String get setAsDefaultInvoice => 'Definir comme facture par defaut';

  @override
  String get confirmDeleteAddress =>
      'Etes-vous sur de vouloir supprimer cette adresse ?';

  @override
  String get confirmDeleteInvoice =>
      'Etes-vous sur de vouloir supprimer cette facture ?';

  @override
  String get groupOwner => 'Proprietaire';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Rechercher des membres';

  @override
  String totalMembers(int count) {
    return '$count membres';
  }

  @override
  String get removeFromGroup => 'Retirer du groupe';

  @override
  String confirmRemoveMember(String name) {
    return 'Etes-vous sur de vouloir retirer \"$name\" du groupe ?';
  }

  @override
  String get setAsAdmin => 'Definir comme admin';

  @override
  String get removeAdmin => 'Retirer admin';

  @override
  String get deleteContactSuccess => 'Contact supprime';

  @override
  String get unknownSong => 'Chanson inconnue';

  @override
  String get unknownArtist => 'Artiste inconnu';

  @override
  String get unknownContact => 'Contact inconnu';

  @override
  String get personalCard => 'Carte de contact';

  @override
  String get singleChoice => 'Choix unique';

  @override
  String get multiChoice => 'Choix multiple';

  @override
  String get ended => 'Termine';

  @override
  String get endPollButton => 'Terminer le sondage';

  @override
  String get createPoll => 'Creer un sondage';

  @override
  String get pollQuestion => 'Question du sondage';

  @override
  String get pollOptions => 'Options du sondage';

  @override
  String optionPlaceholder(int index) {
    return 'Option $index';
  }

  @override
  String get addOption => 'Ajouter une option';

  @override
  String get pollSettings => 'Parametres du sondage';

  @override
  String get anonymousPoll => 'Sondage anonyme';

  @override
  String get pollHint =>
      'Le sondage sera affiche dans le chat. Les membres du groupe peuvent voter.';

  @override
  String get searchSongOrArtist => 'Rechercher une chanson ou un artiste';

  @override
  String get noSongsFound => 'Aucune chanson trouvee';

  @override
  String get supportedMusicPlatforms =>
      'Supporte les liens musicaux de NetEase, QQ Music, etc.';

  @override
  String get songNameOptional => 'Nom de la chanson (facultatif)';

  @override
  String get enterSongName => 'Entrez le nom de la chanson';

  @override
  String get artistNameOptional => 'Nom de l\'artiste (facultatif)';

  @override
  String get enterArtistName => 'Entrez le nom de l\'artiste';

  @override
  String get shareSong => 'Partager la chanson';

  @override
  String get realTimeLocationSharing =>
      'Partage de position en temps reel en developpement...';

  @override
  String get voiceCallFeatureInDev =>
      'Fonctionnalite d\'appel vocal en developpement...';

  @override
  String get reportFeatureInDev =>
      'Fonctionnalite de signalement en developpement...';

  @override
  String get shareFeatureInDev =>
      'Fonctionnalite de partage en developpement...';

  @override
  String get qrCodeFeatureInDev =>
      'Fonctionnalite de code QR en developpement...';

  @override
  String get scanQrToAddMe =>
      'Scannez le code QR ci-dessus pour m\'ajouter comme ami';

  @override
  String get saveToAlbum => 'Enregistrer dans l\'album';

  @override
  String get changeStyle => 'Changer le style';

  @override
  String get copyId => 'Copier l\'ID';

  @override
  String get idCopied => 'ID copie';

  @override
  String get shareFeatureComingSoon =>
      'Fonctionnalite de partage bientot disponible';

  @override
  String get saveFeatureComingSoon =>
      'Fonctionnalite d\'enregistrement bientot disponible';

  @override
  String get moreStylesFeatureComingSoon =>
      'Plus de styles bientot disponibles';

  @override
  String get confirmEndPoll => 'Etes-vous sur de vouloir terminer ce sondage ?';

  @override
  String get cannotVoteAfterEnd =>
      'Aucun vote ne pourra etre effectue apres la fin.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Serveur';

  @override
  String get shareContactCard => 'Partager la carte de contact';

  @override
  String get removeFromBlacklist => 'Retirer de la liste noire';

  @override
  String get confirmAddBlacklist =>
      'Etes-vous sur de vouloir ajouter cet utilisateur a la liste noire ? Vous ne recevrez plus ses messages.';

  @override
  String get confirmRemoveBlacklist =>
      'Etes-vous sur de vouloir retirer cet utilisateur de la liste noire ?';

  @override
  String get remarkSaved => 'Remarque enregistree';

  @override
  String get remarkCleared => 'Remarque effacee';

  @override
  String get receive => 'Recevoir';

  @override
  String get pleaseConnectWallet =>
      'Veuillez d\'abord connecter votre portefeuille';

  @override
  String get sendRequest => 'Envoyer la demande';

  @override
  String get pleaseEnterValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get searchPlaceholder => 'Rechercher contacts, groupes, messages';

  @override
  String get enterKeywordToSearch =>
      'Entrez un mot-cle pour commencer la recherche';

  @override
  String get clearHistory => 'Effacer';

  @override
  String noResultsForQuery(String query) {
    return 'Aucun resultat trouve pour \"$query\"';
  }

  @override
  String get allResults => 'Tout';

  @override
  String get searchInChat => 'Rechercher dans le chat';

  @override
  String get contactLabel => 'Contact';

  @override
  String get groupLabel => 'Groupe';

  @override
  String get conversationLabel => 'Conversation';

  @override
  String get messageLabel => 'Message';

  @override
  String get securityTitle => 'Securite';

  @override
  String get keyBackup => 'Sauvegarde des cles';

  @override
  String get backupEncryptionKeys => 'Sauvegarder les cles de chiffrement';

  @override
  String keysBackedUp(int count) {
    return '$count cles sauvegardees';
  }

  @override
  String get backupNotSet => 'Sauvegarde non configuree';

  @override
  String get restoreKeys => 'Restaurer les cles';

  @override
  String get restoreKeysFromBackup =>
      'Restaurer les cles de chiffrement depuis la sauvegarde';

  @override
  String get exportKeys => 'Exporter les cles';

  @override
  String get exportKeysToFile => 'Exporter les cles vers un fichier';

  @override
  String get loggedInDevices => 'Appareils connectes';

  @override
  String get noOtherDevices => 'Pas d\'autres appareils';

  @override
  String get verified => 'Verifie';

  @override
  String get unverified => 'Non verifie';

  @override
  String get advanced => 'Avance';

  @override
  String get crossSigning => 'Signature croisee';

  @override
  String get enabled => 'Active';

  @override
  String get notEnabled => 'Non active';

  @override
  String get resetEncryption => 'Reinitialiser le chiffrement';

  @override
  String get deleteAllEncryptionKeys =>
      'Supprimer toutes les cles de chiffrement';

  @override
  String get encryptionNotSupported => 'Chiffrement non supporte';

  @override
  String get notInitialized => 'Non initialise';

  @override
  String get backupKeyTitle => 'Sauvegarder les cles';

  @override
  String get backupKeyMessage =>
      'Creer une nouvelle sauvegarde de cles ? Cela vous aidera a restaurer les messages chiffres sur un nouvel appareil.';

  @override
  String get backup => 'Sauvegarder';

  @override
  String get restoreKeyTitle => 'Restaurer les cles';

  @override
  String get restoreKeyMessage =>
      'Entrez votre mot de passe de recuperation ou votre cle de recuperation pour restaurer les messages chiffres.';

  @override
  String get restore => 'Restaurer';

  @override
  String get exportKeyTitle => 'Exporter les cles';

  @override
  String get exportKeyMessage =>
      'Le fichier de cles exporte contient toutes vos cles de chiffrement. Veuillez le garder en securite.';

  @override
  String get export => 'Exporter';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID de l\'appareil : $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Statut : Verifie';

  @override
  String get deviceStatusUnverified => 'Statut : Non verifie';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Derniere activite : $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Verifier cet appareil';

  @override
  String get crossSigningAlreadyEnabled =>
      'La signature croisee est deja activee';

  @override
  String get crossSigningSetupSuccess =>
      'Configuration de la signature croisee reussie';

  @override
  String get resetEncryptionTitle => 'Reinitialiser le chiffrement';

  @override
  String get resetEncryptionWarning =>
      'Attention : Cela supprimera toutes vos cles de chiffrement. Vous ne pourrez plus dechiffrer les messages chiffres precedents. Cette action est irreversible.';

  @override
  String get reset => 'Reinitialiser';

  @override
  String get leaveMeetingConfirm =>
      'Etes-vous sur de vouloir quitter la reunion ?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'a tapote $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Aucun contact disponible a ajouter';

  @override
  String get addMembers => 'Ajouter des membres';

  @override
  String invitedMembers(int count) {
    return '$count membres invites';
  }

  @override
  String inviteFailed(String error) {
    return 'Echec de l\'invitation : $error';
  }

  @override
  String get memberRemoved => 'Membre retire';

  @override
  String removeFailed(String error) {
    return 'Echec du retrait : $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Apres le partage, l\'autre partie peut voir votre position en temps reel pendant 1 heure.';

  @override
  String get startSharing => 'Commencer le partage';

  @override
  String get locationServiceNotEnabled =>
      'Le service de localisation n\'est pas active';

  @override
  String get enableLocationService =>
      'Veuillez activer le service de localisation pour utiliser cette fonctionnalite';

  @override
  String get goToSettings => 'Aller aux parametres';

  @override
  String get locationPermissionRequired =>
      'L\'autorisation de localisation est requise pour cette fonctionnalite';

  @override
  String get locationPermissionDeniedPermanent =>
      'L\'autorisation de localisation a ete refusee definitivement. Veuillez l\'activer dans les parametres.';

  @override
  String get locationPermissionDenied => 'Autorisation de localisation refusee';

  @override
  String get gettingLocation => 'Obtention de la position...';

  @override
  String getLocationFailed(String error) {
    return 'Echec de l\'obtention de la position : $error';
  }

  @override
  String get currentLocation => 'Position actuelle';

  @override
  String nearbyPlace(int index) {
    return 'Lieu a proximite $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Environ $distance';
  }

  @override
  String get mapPreview => 'Apercu de la carte';

  @override
  String get searchLocation => 'Rechercher un lieu';

  @override
  String redPacketSent(String amount, String token) {
    return 'Enveloppe rouge de $amount $token envoyee';
  }

  @override
  String get transferDefault => 'Transfert';

  @override
  String transferSent(String amount, String token) {
    return 'Transfert de $amount $token envoye';
  }

  @override
  String pickFileFailed(String error) {
    return 'Echec de la selection du fichier : $error';
  }

  @override
  String get fileSizeLimit => 'La taille du fichier ne peut pas depasser 50 Mo';

  @override
  String fileSending(String filename) {
    return 'Envoi du fichier : $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Echec de l\'envoi du fichier : $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Carte de contact de $name envoyee';
  }

  @override
  String get favoritesFeature => 'Favoris';

  @override
  String get couponsFeature => 'Coupons';

  @override
  String get giftFeature => 'Cadeau';

  @override
  String sharedMusic(String name) {
    return '$name partage';
  }

  @override
  String get endPollTitle => 'Terminer le sondage';

  @override
  String get endPollConfirmMessage =>
      'Etes-vous sur de vouloir terminer ce sondage ? Le vote sera ferme apres la fin.';

  @override
  String get pollEndedMessage => 'Sondage termine';

  @override
  String get connectingCall => 'Connexion en cours...';

  @override
  String get muteCall => 'Couper le son';

  @override
  String get speakerOff => 'Haut-parleur desactive';

  @override
  String get speakerOn => 'Haut-parleur';

  @override
  String get cameraOn => 'Camera activee';

  @override
  String get cameraOff => 'Camera desactivee';

  @override
  String get hangUp => 'Raccrocher';

  @override
  String get selectForwardTargetTitle => 'Selectionner la cible du transfert';

  @override
  String get noForwardableChat => 'Aucun chat disponible pour le transfert';

  @override
  String get noMatchingChat => 'Aucun chat correspondant trouve';

  @override
  String get imagePreview => '[Image]';

  @override
  String get voicePreview => '[Message vocal]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[Fichier] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Position] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Musique] $title';
  }

  @override
  String get messagePreview => '[Message]';

  @override
  String get locationTitle => 'Position';

  @override
  String get sendButton => 'Envoyer';

  @override
  String get retryButton => 'Reessayer';

  @override
  String get selectContact => 'Selectionner un contact';

  @override
  String get searchContactHint => 'Rechercher des contacts';

  @override
  String get shareMusic => 'Partager de la musique';

  @override
  String get recentPlayed => 'Recent';

  @override
  String get myFavorites => 'Favoris';

  @override
  String get networkLink => 'Lien';

  @override
  String get localFile => 'Local';

  @override
  String get musicLinkRequired => 'Lien musical *';

  @override
  String get pasteMusicLink => 'Collez le lien musical';

  @override
  String get enterSongNamePlaceholder => 'Entrez le nom de la chanson';

  @override
  String get enterArtistNamePlaceholder => 'Entrez le nom de l\'artiste';

  @override
  String get shareMusicButton => 'Partager la musique';

  @override
  String get selectLocalAudio => 'Selectionner un fichier audio local';

  @override
  String get supportedAudioFormats => 'Supporte MP3, M4A, WAV, FLAC, etc.';

  @override
  String get selectFileButton => 'Selectionner le fichier';

  @override
  String get pleaseEnterMusicLink => 'Veuillez entrer le lien musical';

  @override
  String get pleaseEnterValidLink => 'Veuillez entrer une URL valide';

  @override
  String get sharedSong => 'Chanson partagee';

  @override
  String get selectMember => 'Selectionner un membre';

  @override
  String get searchMemberHint => 'Rechercher des membres';

  @override
  String get noMatchingMembers => 'Aucun membre correspondant trouve';

  @override
  String get unknownMember => 'Inconnu';

  @override
  String selectedMessagesCount(int count) {
    return '$count messages selectionnes';
  }

  @override
  String get searchContactsOrGroups => 'Rechercher des contacts ou des groupes';

  @override
  String get noMatchingConversations =>
      'Aucune conversation correspondante trouvee';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Chargement...';

  @override
  String get videoPlaybackFailed => 'Echec de la lecture video';

  @override
  String get videoLoadFailed => 'Echec du chargement de la video';

  @override
  String get playerInitFailed => 'Echec de l\'initialisation du lecteur';

  @override
  String get createPollTitle => 'Creer un sondage';

  @override
  String get submitPoll => 'Soumettre';

  @override
  String get pollQuestionLabel => 'Question du sondage';

  @override
  String get enterPollQuestionHint => 'Entrez la question du sondage';

  @override
  String get pollOptionsLabel => 'Options du sondage';

  @override
  String optionHintWithIndex(int index) {
    return 'Option $index';
  }

  @override
  String get addOptionButton => 'Ajouter une option';

  @override
  String get pollSettingsLabel => 'Parametres du sondage';

  @override
  String get selectionType => 'Type de selection';

  @override
  String get singleChoiceLabel => 'Choix unique';

  @override
  String get multiChoiceLabel => 'Choix multiple';

  @override
  String get anonymousPollSwitch => 'Sondage anonyme';

  @override
  String get pleaseEnterQuestion => 'Veuillez entrer la question du sondage';

  @override
  String get atLeastTwoOptions => 'Au moins 2 options requises';

  @override
  String confirmWithCount(int count) {
    return 'Confirmer ($count)';
  }

  @override
  String get emailVerificationTitle => 'Verification par e-mail';

  @override
  String get enterValidEmailAddress =>
      'Veuillez entrer une adresse e-mail valide';

  @override
  String verificationCodeSentTo(String email) {
    return 'Code de verification envoye a $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Echec de l\'envoi du code : $error';
  }

  @override
  String get verificationSuccess => 'Verification reussie';

  @override
  String get verificationFailed => 'Echec de la verification';

  @override
  String verificationCodeError(String error) {
    return 'Erreur du code de verification : $error';
  }

  @override
  String get enterVerificationCode => 'Entrez le code de verification';

  @override
  String get enterYourEmail => 'Entrez votre e-mail';

  @override
  String weSentCodeTo(String email) {
    return 'Nous avons envoye un code a 6 chiffres a\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Entrez votre adresse e-mail, nous vous enverrons un code de verification';

  @override
  String get sendVerificationCode => 'Envoyer le code de verification';

  @override
  String get resendVerificationCode => 'Renvoyer le code de verification';

  @override
  String canResendAfter(int seconds) {
    return 'Peut renvoyer apres $seconds secondes';
  }

  @override
  String get changeEmail => 'Changer d\'e-mail';

  @override
  String get addToContacts => 'Ajouter aux contacts';

  @override
  String get addingToContacts => 'Ajout en cours...';

  @override
  String get addedToContacts => 'Ajoute aux contacts';

  @override
  String addFailedWithError(String error) {
    return 'Echec de l\'ajout : $error';
  }

  @override
  String get addPhone => 'Ajouter un telephone';

  @override
  String get addTag => 'Ajouter des tags';

  @override
  String get addText => 'Ajouter du texte';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String groupCountLabel(int count) {
    return '$count groupes';
  }

  @override
  String get addedViaSearch => 'Ajoute via la recherche';

  @override
  String get addTime => 'Ajouter l\'heure';

  @override
  String get doneButton => 'Termine';

  @override
  String get waitingForParticipants => 'En attente des participants...';

  @override
  String participantMe(String name) {
    return '$name (Moi)';
  }

  @override
  String get sharingLabel => 'Partage';

  @override
  String screenSharingBy(String name) {
    return '$name partage son ecran';
  }

  @override
  String participantCount(int count) {
    return '$count participants';
  }

  @override
  String get muteLabel => 'Couper le son';

  @override
  String get unmuteLabel => 'Reactiver le son';

  @override
  String get turnOffVideo => 'Desactiver la video';

  @override
  String get turnOnVideo => 'Activer la video';

  @override
  String get shareScreen => 'Partager l\'ecran';

  @override
  String get stopSharing => 'Arreter le partage';

  @override
  String get switchCameraLabel => 'Changer';

  @override
  String get leaveLabel => 'Quitter';

  @override
  String get participantsLabel => 'Participants';

  @override
  String get joiningMeeting => 'Rejoindre la reunion...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count votes ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count participants';
  }

  @override
  String get tapToRetry => 'Appuyez pour réessayer';

  @override
  String get noConversationsToForward => 'Aucune conversation à transférer';

  @override
  String get defaultRedPacketGreeting => 'Meilleurs vœux de prospérité';

  @override
  String get emojiCategoryFace => 'Émoticônes';

  @override
  String get emojiCategoryHeart => 'Cœurs';

  @override
  String get emojiCategoryAnimal => 'Animaux';

  @override
  String get emojiCategoryFood => 'Nourriture';

  @override
  String get emojiCategoryTransport => 'Transports';

  @override
  String get emojiCategoryActivity => 'Activités';

  @override
  String get emojiCategoryObject => 'Objets';

  @override
  String get emojiCategorySymbol => 'Symboles';

  @override
  String get allowOthersToSearchAndJoin =>
      'Permettre aux autres de rechercher et de rejoindre';

  @override
  String get allowStrangerMessages => 'Autoriser les messages d\'inconnus';

  @override
  String get alwaysUseDarkTheme => 'Toujours utiliser le thème sombre';

  @override
  String get alwaysUseLightTheme => 'Toujours utiliser le thème clair';

  @override
  String get autoSwitchBySystem =>
      'Changer automatiquement selon les paramètres système';

  @override
  String get bubbleStyle => 'Style de bulle';

  @override
  String get bubbleStyleClassic => 'Style classique';

  @override
  String get bubbleStyleClassicDesc => 'Style de bulle traditionnel';

  @override
  String get bubbleStyleModern => 'Style moderne';

  @override
  String get bubbleStyleModernDesc => 'Style de bulle moderne et épuré';

  @override
  String get bubbleStyleWechat => 'Style WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Style de bulle classique WeChat';

  @override
  String get callEnded => 'Appel terminé';

  @override
  String get callFailed => 'Appel échoué';

  @override
  String get checkForUpdates => 'Rechercher des mises à jour';

  @override
  String get confirmClearChatHistory =>
      'Êtes-vous sûr de vouloir effacer l\'historique des messages?';

  @override
  String get createGroupToChat => 'Créez un groupe pour commencer à discuter';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get darkModeOption => 'Mode sombre';

  @override
  String get doNotDisturbDescription =>
      'Ne pas recevoir de notifications pendant la période spécifiée';

  @override
  String get doNotDisturbMode => 'Ne pas déranger';

  @override
  String get editGroupAnnouncement => 'Modifier l\'annonce du groupe';

  @override
  String get editGroupDescription => 'Modifier la description du groupe';

  @override
  String get enterGroupAnnouncement => 'Veuillez saisir l\'annonce du groupe';

  @override
  String errorWithMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String get feedbackAndSuggestions => 'Commentaires et suggestions';

  @override
  String get followSystem => 'Suivre le système';

  @override
  String get fontSize => 'Taille de police';

  @override
  String get fontSizeExtraLarge => 'Très grand';

  @override
  String get fontSizeLarge => 'Grand';

  @override
  String get fontSizeSmall => 'Petit';

  @override
  String get fontSizeStandard => 'Standard';

  @override
  String get incomingVideoCall => 'Appel vidéo entrant';

  @override
  String get incomingVoiceCall => 'Appel vocal entrant';

  @override
  String get letOthersKnowYouRead =>
      'Permettre aux autres de savoir que vous avez lu leurs messages';

  @override
  String get letOthersKnowYouTyping =>
      'Permettre aux autres de savoir que vous écrivez';

  @override
  String get lightMode => 'Mode clair';

  @override
  String memberCountClickToCopy(int count) {
    return '$count membres, cliquez pour copier l\'ID du groupe';
  }

  @override
  String get messageNotifications => 'Notifications de messages';

  @override
  String get messagesLabel => 'Messages';

  @override
  String get musicLinkLabel => 'Lien musical';

  @override
  String get noMediaUrlAvailable => 'URL média non disponible';

  @override
  String get noPermissionToEditGroupName =>
      'Vous n\'avez pas la permission de modifier le nom du groupe';

  @override
  String get receiveMessagesFromNonContacts =>
      'Recevoir les messages des non-contacts';

  @override
  String get receiveNewMessageNotifications =>
      'Recevoir les notifications de nouveaux messages';

  @override
  String get reconnectingCall => 'Reconnexion en cours...';

  @override
  String get redPacketTransferCannotForward =>
      'Les enveloppes rouges et les transferts ne peuvent pas être transférés';

  @override
  String get showMessageContentInNotification =>
      'Afficher le contenu du message dans les notifications';

  @override
  String get showMessagePreview => 'Afficher l\'aperçu du message';

  @override
  String get typingIndicator => 'Indicateur de saisie';

  @override
  String versionInfo(String version) {
    return 'Version $version';
  }

  @override
  String get vibration => 'Vibration';

  @override
  String get videoCallInProgress => 'Appel vidéo';

  @override
  String get voiceCallInProgress => 'Appel vocal';

  @override
  String whoCanSeeTitle(String title) {
    return 'Qui peut voir $title';
  }

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get enterEmailAddress => 'Entrez l\'adresse e-mail';

  @override
  String get emailRecoveryHint =>
      'Utilisé pour la récupération du mot de passe';

  @override
  String get invalidEmailFormat => 'Veuillez entrer une adresse e-mail valide';

  @override
  String get optional => 'Optionnel';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordTitle => 'Réinitialiser votre mot de passe';

  @override
  String get enterRegisteredEmail =>
      'Entrez l\'adresse e-mail avec laquelle vous vous êtes inscrit';

  @override
  String get sendResetCode => 'Envoyer le code de réinitialisation';

  @override
  String resetCodeSent(String email) {
    return 'Code de réinitialisation envoyé à $email';
  }

  @override
  String get enterResetCode => 'Entrez le code de réinitialisation';

  @override
  String get setNewPassword => 'Définir un nouveau mot de passe';

  @override
  String get confirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get passwordResetSuccess =>
      'Mot de passe réinitialisé avec succès. Veuillez vous connecter avec votre nouveau mot de passe.';

  @override
  String get resetPasswordFailed =>
      'Échec de la réinitialisation du mot de passe';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get enterCurrentPassword => 'Entrez le mot de passe actuel';

  @override
  String get enterNewPassword => 'Entrez le nouveau mot de passe';

  @override
  String get passwordChanged =>
      'Mot de passe modifié avec succès. Veuillez vous connecter avec votre nouveau mot de passe.';

  @override
  String get changePasswordFailed => 'Échec du changement de mot de passe';

  @override
  String get incorrectCurrentPassword => 'Mot de passe actuel incorrect';

  @override
  String get newPasswordMustBeDifferent =>
      'Le nouveau mot de passe doit être différent du mot de passe actuel';

  @override
  String get changePasswordInfo =>
      'Après avoir changé le mot de passe, vous serez déconnecté et devrez vous reconnecter avec le nouveau mot de passe.';

  @override
  String get passwordRequirements => 'Exigences du mot de passe :';

  @override
  String get securityNote =>
      'Pour des raisons de sécurité, vous devrez vous reconnecter sur tous les appareils après avoir changé le mot de passe.';

  @override
  String get security => 'Sécurité';

  @override
  String get currentBoundEmail => 'E-mail actuellement lié';

  @override
  String get newEmailAddress => 'Nouvelle adresse e-mail';

  @override
  String get enterNewEmail => 'Entrez la nouvelle adresse e-mail';

  @override
  String get verificationCode => 'Code de vérification';

  @override
  String get verificationCodeSent => 'Code de vérification envoyé';

  @override
  String get codeSentTo => 'Code de vérification envoyé à';

  @override
  String get didNotReceiveCode => 'Vous n\'avez pas reçu le code ?';

  @override
  String get emailChangedSuccess => 'E-mail modifié avec succès';

  @override
  String get changeEmailFailed => 'Échec du changement d\'e-mail';

  @override
  String get emailSecurityNote =>
      'Votre e-mail est utilisé pour la récupération du mot de passe. Gardez-le en sécurité.';

  @override
  String get googleLogin => 'Se connecter avec Google';

  @override
  String get appleLogin => 'Se connecter avec Apple';

  @override
  String get socialLoginCancelled => 'Connexion annulée';

  @override
  String get socialLoginFailed => 'Échec de la connexion sociale';

  @override
  String get language => 'Langue';

  @override
  String get languageChanged => 'Langue modifiée';

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
}
