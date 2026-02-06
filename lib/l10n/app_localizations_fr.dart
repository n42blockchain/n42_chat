// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get commonRetry => 'Reessayer';

  @override
  String get commonUnknownUser => 'Utilisateur inconnu';

  @override
  String get transferWalletNotConnected => 'Portefeuille non connecte';

  @override
  String get chatCallServiceNotInitialized => 'Service d\'appel non initialise';

  @override
  String authLoginFailed(String error) {
    return 'Echec de la connexion : $error';
  }

  @override
  String get chatCallBack => 'Rappeler';

  @override
  String get chatMissedVideoCall => 'Appel video manque';

  @override
  String get chatMissedVoiceCall => 'Appel vocal manque';

  @override
  String get chatCallNotAnswered => 'Sans réponse';

  @override
  String get chatCallDurationLabel => 'Durée de l\'appel';

  @override
  String get chatVoiceCallCancelled => 'Appel vocal annulé';

  @override
  String get chatVideoCallCancelled => 'Appel vidéo annulé';

  @override
  String get commonImage => '[Image]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Message vocal]';

  @override
  String get commonFile => '[Fichier]';

  @override
  String get chatLocation => '[Position]';

  @override
  String get chatUnknownMessage => '[Message inconnu]';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get chatDeleteThisMessage => 'Supprimer ce message ?';

  @override
  String get chatMessageDeleted => 'Message supprimé';

  @override
  String get profileNotLoggedIn => 'Non connecte';

  @override
  String get chatMyLocation => 'Ma position';

  @override
  String get commonGroupChat => 'Discussion de groupe';

  @override
  String get commonSearch => 'Rechercher';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonLoadFailed => 'Echec du chargement';

  @override
  String get commonMessages => 'Messages';

  @override
  String get commonContacts => 'Contacts';

  @override
  String get commonMe => 'Moi';

  @override
  String get commonVoiceLoading =>
      'Chargement vocal, veuillez reessayer plus tard';

  @override
  String get commonVoiceToTextFailed =>
      'Echec de la conversion vocale en texte';

  @override
  String get commonConvertToText => 'En texte';

  @override
  String get chatCopy => 'Copier';

  @override
  String get commonForward => 'Transferer';

  @override
  String get commonUnfavorite => 'Retirer des favoris';

  @override
  String get commonFavorite => 'Ajouter aux favoris';

  @override
  String get settingsResend => 'Renvoyer';

  @override
  String get chatRecall => 'Rappeler';

  @override
  String get commonQuote => 'Citer';

  @override
  String get commonRemind => 'Mentionner';

  @override
  String get chatCopied => 'Copie';

  @override
  String get storySendMessageHint => 'Envoyer un message';

  @override
  String get commonMicrophonePermissionRequired =>
      'Veuillez autoriser l\'acces au microphone';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Echec du demarrage de l\'enregistrement : $error';
  }

  @override
  String get commonRecordingTooShort => 'Enregistrement trop court';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Echec de l\'arret de l\'enregistrement : $error';
  }

  @override
  String get chatReleaseToCancel => 'Relacher pour annuler';

  @override
  String get chatReleaseToSend =>
      'Relacher pour envoyer, glisser vers le haut pour annuler';

  @override
  String get commonHoldToTalk => 'Maintenir pour parler';

  @override
  String get commonSend => 'Envoyer';

  @override
  String get commonAddFriend => 'Ajouter un ami';

  @override
  String get commonChatServiceNotConnected => 'Service de chat non connecte';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Utilisateur \"$query\" introuvable\n\nConseils :\n- Essayez de saisir l\'identifiant complet, ex. @utilisateur:serveur.com\n- Verifiez l\'orthographe du nom d\'utilisateur';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Echec de la creation du chat : $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Echec de la recherche : $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Entrez l\'identifiant ou le nom d\'utilisateur pour rechercher';

  @override
  String get contactSearching => 'Recherche en cours...';

  @override
  String get contactSearchUserToChat =>
      'Rechercher un utilisateur pour commencer a discuter';

  @override
  String get contactMatrixIdExample =>
      'Vous pouvez entrer un identifiant Matrix complet\nex. @utilisateur:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Utilisateur \"$username\" introuvable';
  }

  @override
  String get commonChat => 'Discussion';

  @override
  String get commonSettings => 'Parametres';

  @override
  String get profileEditProfile => 'Modifier le profil';

  @override
  String get authLogin => 'Se connecter';

  @override
  String get commonCreateGroup => 'Creer un groupe';

  @override
  String get chatError => 'Erreur';

  @override
  String get commonTransfer => 'Transfert';

  @override
  String get commonReceived => 'Recu';

  @override
  String get commonRefunded => 'Rembourse';

  @override
  String get commonExpired => 'Expire';

  @override
  String get chatRedPacketGreeting => 'Meilleurs voeux';

  @override
  String get commonN42RedPacket => 'Enveloppe rouge N42';

  @override
  String get commonClaimed => 'Reclame';

  @override
  String get commonAllClaimed => 'Tout reclame';

  @override
  String get chatReply => 'Repondre';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get chatSelectForwardTarget => 'Choisir le destinataire';

  @override
  String commonSendCount(int count) {
    return 'Envoyer ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'ID N42 : $id';
  }

  @override
  String get profileN42IdTitle => 'ID N42';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Infos de l\'ami';

  @override
  String get contactFriendInfoDesc =>
      'Ajouter une remarque, telephone, tags, notes, photos et definir les permissions.';

  @override
  String get commonMoments => 'Moments';

  @override
  String get commonSendMessage => 'Message';

  @override
  String get contactAudioVideoCall => 'Appel audio/video';

  @override
  String get contactVideoChannel => 'Canal video';

  @override
  String get contactRemark => 'Remarque';

  @override
  String get contactRemarkName => 'Nom de remarque';

  @override
  String get contactPhone => 'Telephone';

  @override
  String get contactTags => 'Tags';

  @override
  String get contactNotes => 'Notes';

  @override
  String get contactPhotos => 'Photos';

  @override
  String get contactPermissions => 'Permissions';

  @override
  String get contactChatMomentsEtc => 'Chat, Moments, Sports, etc.';

  @override
  String get contactMoreInfo => 'Plus d\'infos';

  @override
  String get contactCommonGroups => 'Groupes en commun';

  @override
  String get contactSource => 'Source';

  @override
  String get settingsNotificationSettings => 'Notifications';

  @override
  String get settingsPrivacy => 'Confidentialite';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsAbout => 'A propos';

  @override
  String get commonLogout => 'Se deconnecter';

  @override
  String get commonLogoutConfirm =>
      'Etes-vous sur de vouloir vous deconnecter ?';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get profileNickname => 'Surnom';

  @override
  String get profileEnterNickname => 'Entrez un surnom';

  @override
  String get profileSignature => 'Signature';

  @override
  String get profileAddSignature => 'Ajouter une signature';

  @override
  String get commonTakePhoto => 'Prendre une photo';

  @override
  String get profileChooseFromGallery => 'Choisir dans la galerie';

  @override
  String profileSaveFailed(String error) {
    return 'Echec de l\'enregistrement : $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Messagerie securisee et decentralisee';

  @override
  String get commonEndToEndEncryption => 'Chiffrement de bout en bout';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Messages visibles uniquement par vous et le destinataire';

  @override
  String get authDecentralized => 'Decentralise';

  @override
  String get authBasedOnMatrix => 'Base sur le protocole ouvert Matrix';

  @override
  String get authWalletIntegration => 'Integration du portefeuille';

  @override
  String get authEasyCryptoTransfer => 'Transferts de crypto-monnaie faciles';

  @override
  String get authRegister => 'S\'inscrire';

  @override
  String get authAgreeTerms => 'En vous connectant, vous acceptez';

  @override
  String get authTermsOfService => 'Conditions d\'utilisation';

  @override
  String get authAnd => 'et';

  @override
  String get authPrivacyPolicy => 'Politique de confidentialite';

  @override
  String get authServerAddress => 'Adresse du serveur';

  @override
  String get authEnterServerAddress => 'Entrez l\'adresse du serveur';

  @override
  String authConnectedTo(String serverName) {
    return 'Connecte a $serverName';
  }

  @override
  String get authUsername => 'Nom d\'utilisateur';

  @override
  String get authEnterUsername => 'Entrez le nom d\'utilisateur';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authEnterPassword => 'Entrez le mot de passe';

  @override
  String get authRegisterAccount => 'S\'inscrire';

  @override
  String get authForgotPassword => 'Mot de passe oublie';

  @override
  String get authOtherLoginMethods => 'Autres methodes de connexion';

  @override
  String get authCreateAccount => 'Creer un compte';

  @override
  String get authJoinN42Chat => 'Rejoignez N42 Chat pour commencer a discuter';

  @override
  String get authUsernameHint => '3-20 caracteres, lettres/chiffres/_';

  @override
  String get authUsernameMinLength =>
      'Le nom d\'utilisateur doit comporter au moins 3 caracteres';

  @override
  String get authUsernameMaxLength =>
      'Le nom d\'utilisateur doit comporter au maximum 20 caracteres';

  @override
  String get authUsernameFormat =>
      'Le nom d\'utilisateur ne peut contenir que des lettres, des chiffres et des traits de soulignement';

  @override
  String get authPasswordHint => 'Min 8 caracteres';

  @override
  String get commonPasswordMinLength =>
      'Le mot de passe doit comporter au moins 8 caracteres';

  @override
  String get authConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get authFilled => 'Rempli';

  @override
  String get authEnterInviteCode => 'Entrez le code d\'invitation';

  @override
  String get authAlreadyHaveAccount => 'Vous avez deja un compte ?';

  @override
  String get authLoginNow => 'Se connecter maintenant';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Statut';

  @override
  String get commonLoading => 'Chargement...';

  @override
  String get conversationNoConversations => 'Aucune conversation';

  @override
  String get conversationTapToChat =>
      'Appuyez en haut a droite pour commencer a discuter';

  @override
  String get conversationStartGroup => 'Demarrer une discussion de groupe';

  @override
  String get commonScan => 'Scanner';

  @override
  String get commonPayment => 'Paiement';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature bientot disponible';
  }

  @override
  String get conversationMarkAsRead => 'Marquer comme lu';

  @override
  String get commonUnmute => 'Reactiver le son';

  @override
  String get commonMute => 'Couper le son';

  @override
  String get conversationUnpin => 'Desepingler';

  @override
  String get conversationPin => 'Epingler';

  @override
  String get conversationDeleteConversation => 'Supprimer la conversation';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Supprimer la conversation avec \"$name\" ?';
  }

  @override
  String get commonNoContacts => 'Aucun contact';

  @override
  String get contactAddFriendsToChat =>
      'Ajoutez des amis pour commencer a discuter';

  @override
  String get contactNotFound => 'Contact introuvable';

  @override
  String get contactTryOtherKeywords =>
      'Essayez d\'autres mots-cles ou une recherche globale';

  @override
  String get contactSearchResults => 'Resultats de la recherche';

  @override
  String get contactNewFriends => 'Nouveaux amis';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Comptes officiels';

  @override
  String get contactServiceAccounts => 'Comptes de service';

  @override
  String get contactEnterpriseContacts => 'Contacts entreprise';

  @override
  String get contactRecommendToFriend => 'Partager le contact';

  @override
  String get commonSetRemark => 'Definir une remarque';

  @override
  String get contactSendingCard => 'Envoi de la carte de contact...';

  @override
  String get commonFileLabel => 'Fichier';

  @override
  String get commonLocationLabel => 'Position';

  @override
  String contactRecommendFailed(String error) {
    return 'Echec de la recommandation : $error';
  }

  @override
  String get profileEnterRemark => 'Entrez une remarque';

  @override
  String get contactOpeningChat => 'Ouverture du chat...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Echec de l\'ouverture du chat : $error';
  }

  @override
  String get contactAddContact => 'Ajouter un contact';

  @override
  String get contactEnterUserId => 'Entrez l\'identifiant utilisateur';

  @override
  String get contactNoFriendRequests => 'Aucune demande d\'ami';

  @override
  String get commonAccept => 'Accepter';

  @override
  String get commonReject => 'Refuser';

  @override
  String get commonNoGroups => 'Aucun groupe';

  @override
  String get contactSelectFriendToRecommend =>
      'Selectionnez un ami a qui recommander';

  @override
  String get commonSearchContacts => 'Rechercher des contacts';

  @override
  String get contactNoContactsFound => 'Aucun contact trouve';

  @override
  String get favoriteYesterday => 'Hier';

  @override
  String get chatJustNow => 'A l\'instant';

  @override
  String get profileOnline => 'En ligne';

  @override
  String get profileOffline => 'Hors ligne';

  @override
  String get searchContactsGroupsMessages =>
      'Rechercher contacts, groupes, messages';

  @override
  String get searchError => 'Erreur de recherche';

  @override
  String get chatSearchHint => 'Rechercher contacts, groupes et messages';

  @override
  String get searchHistory => 'Historique de recherche';

  @override
  String get commonClear => 'Effacer';

  @override
  String get commonAll => 'Tout';

  @override
  String get searchGroups => 'Groupes';

  @override
  String get searchNoResults => 'Aucun resultat';

  @override
  String commonGroupMembers(int count) {
    return 'Membres ($count)';
  }

  @override
  String get groupMembersTitle => 'Membres du groupe';

  @override
  String get groupViewAll => 'Voir tout';

  @override
  String get groupOwner => 'Proprietaire';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Inviter';

  @override
  String get commonGroupAnnouncement => 'Annonce du groupe';

  @override
  String get commonNotSet => 'Non defini';

  @override
  String get groupDescription => 'Description du groupe';

  @override
  String get groupPublicGroup => 'Groupe public';

  @override
  String get commonClearChatHistory => 'Effacer l\'historique du chat';

  @override
  String get commonDissolveGroup => 'Dissoudre le groupe';

  @override
  String get commonLeaveGroup => 'Quitter le groupe';

  @override
  String get groupChangeGroupName => 'Changer le nom du groupe';

  @override
  String get commonEnterGroupName => 'Entrez le nom du groupe';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get groupEnterGroupDescription => 'Entrez la description du groupe';

  @override
  String get groupPublish => 'Publier';

  @override
  String get chatClearHistoryConfirm =>
      'Effacer tout l\'historique du chat ? Cette action est irreversible.';

  @override
  String get chatClearAction => 'Effacer';

  @override
  String get commonChatHistoryCleared => 'Historique du chat efface';

  @override
  String get commonDissolve => 'Dissoudre';

  @override
  String get groupQrCode => 'Code QR du groupe';

  @override
  String get commonSearchChatHistory => 'Rechercher dans l\'historique du chat';

  @override
  String get groupIdCopied => 'ID du groupe copie';

  @override
  String get transferEnterOrPasteAddress =>
      'Entrez ou collez l\'adresse du portefeuille';

  @override
  String get transferSelectToken => 'Selectionner un jeton';

  @override
  String get commonTransferAmount => 'Montant du transfert';

  @override
  String get transferAvailable => 'Disponible';

  @override
  String get transferMemoOptional => 'Memo (facultatif)';

  @override
  String get transferConfirmTransfer => 'Confirmer le transfert';

  @override
  String get transferAddressVerified => 'Adresse verifiee';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Disponible : $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Entrez le montant';

  @override
  String get commonRedPacketCountMin => 'Au moins 1 enveloppe rouge requise';

  @override
  String get commonViewRedPacketDetails =>
      'Voir les details de l\'enveloppe rouge';

  @override
  String get commonEnterTransferAmount => 'Entrez le montant du transfert';

  @override
  String get commonTransferTo => 'Transferer a';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'De $senderName';
  }

  @override
  String get commonConfirmReceive => 'Confirmer la reception';

  @override
  String get groupProfile => 'Infos du groupe';

  @override
  String get groupRemoveMember => 'Retirer du groupe';

  @override
  String get commonRemove => 'Retirer';

  @override
  String get profileClearStatus => 'Effacer le statut';

  @override
  String get profileClearStatusConfirm => 'Effacer le statut actuel ?';

  @override
  String get profileStatusCleared => 'Statut efface';

  @override
  String get profileUserNotExist => 'L\'utilisateur n\'existe pas';

  @override
  String get profileUserIdCopied => 'ID utilisateur copie';

  @override
  String get commonReport => 'Signaler';

  @override
  String get profileQrCode => 'Code QR';

  @override
  String get profileAvatarUpdated => 'Avatar mis a jour';

  @override
  String commonSelectImageFailed(String error) {
    return 'Echec de la selection de l\'image : $error';
  }

  @override
  String get profileChangeName => 'Changer le nom';

  @override
  String get profileMale => 'Homme';

  @override
  String get profileFemale => 'Femme';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature en developpement...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Echec de l\'enregistrement de l\'adresse : $error';
  }

  @override
  String get profileAddNew => 'Ajouter';

  @override
  String get profileAddAddress => 'Ajouter une adresse';

  @override
  String get profileAddressAdded => 'Adresse ajoutee';

  @override
  String get profileAddressUpdated => 'Adresse mise a jour';

  @override
  String get profileDeleteAddress => 'Supprimer l\'adresse';

  @override
  String get profileAddressDeleted => 'Adresse supprimee';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Echec de l\'enregistrement de la facture : $error';
  }

  @override
  String get profileMyInvoices => 'Mes factures';

  @override
  String get profileAddInvoice => 'Ajouter une facture';

  @override
  String get profileInvoiceAdded => 'Facture ajoutee';

  @override
  String get profileInvoiceUpdated => 'Facture mise a jour';

  @override
  String get profileDeleteInvoice => 'Supprimer la facture';

  @override
  String get profileInvoiceDeleted => 'Facture supprimee';

  @override
  String get profilePersonal => 'Personnel';

  @override
  String get groupSelectAtLeastOne =>
      'Veuillez selectionner au moins un membre';

  @override
  String get chatFileNotExist => 'Le fichier n\'existe pas';

  @override
  String chatSendFailed(String error) {
    return 'Echec de l\'envoi : $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Impossible d\'ouvrir le navigateur';

  @override
  String chatSelectFileFailed(String error) {
    return 'Echec de la selection du fichier : $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Echec de la configuration : $error';
  }

  @override
  String get transferEnterValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get commonAddressCopied => 'Adresse copiee';

  @override
  String favoriteOpenItem(String content) {
    return 'Ouvrir : $content';
  }

  @override
  String get favoriteDeleted => 'Supprime';

  @override
  String get profileWallet => 'Portefeuille';

  @override
  String get chatRecording => 'Enregistrement';

  @override
  String get chatInvalidVideoUrl => 'URL video invalide';

  @override
  String get chatDownloadFile => 'Telecharger le fichier';

  @override
  String get chatClearChatHistoryTitle => 'Effacer l\'historique du chat';

  @override
  String get chatVideoCall => 'Appel video';

  @override
  String get commonVoiceCall => 'Appel vocal';

  @override
  String get callLeaveMeeting => 'Quitter la reunion';

  @override
  String get chatDetails => 'Details du chat';

  @override
  String get chatViewAllGroupMembers => 'Voir tous les membres';

  @override
  String get chatGroupName => 'Nom du groupe';

  @override
  String get chatGroupNameUpdated => 'Nom du groupe mis a jour';

  @override
  String get chatUpdateFailed => 'Echec de la mise a jour';

  @override
  String get chatNoPermissionToModify =>
      'Vous n\'avez pas la permission de modifier';

  @override
  String get chatGroupManagement => 'Gestion du groupe';

  @override
  String get chatMyNicknameInGroup => 'Mon surnom dans le groupe';

  @override
  String get chatPinChat => 'Epingler le chat';

  @override
  String get chatStrongReminder => 'Rappel important';

  @override
  String get chatSetChatBackground => 'Definir l\'arriere-plan du chat';

  @override
  String get chatUnknownFile => 'Fichier inconnu';

  @override
  String get chatDownload => 'Telecharger';

  @override
  String get chatInvalidLocation => 'Position invalide';

  @override
  String get chatTapToCancel => 'Appuyez pour annuler';

  @override
  String chatCaptureFailed(Object error) {
    return 'Echec de la capture : $error';
  }

  @override
  String get chatProcessingVideo => 'Traitement de la video...';

  @override
  String get chatVideoFileNotExist => 'Le fichier video n\'existe pas';

  @override
  String get chatVideoDataEmpty => 'Les donnees video sont vides';

  @override
  String get chatVideoTooLarge =>
      'La taille de la video ne peut pas depasser 100 Mo';

  @override
  String get chatSendingVideo => 'Envoi de la video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Echec de l\'envoi de la video : $error';
  }

  @override
  String get chatImageFileNotExist => 'Le fichier image n\'existe pas';

  @override
  String get commonImageDataEmpty => 'Les donnees de l\'image sont vides';

  @override
  String get chatSendingImage => 'Envoi de l\'image...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Echec de l\'envoi de l\'image : $error';
  }

  @override
  String get chatSendLocation => 'Envoyer la position';

  @override
  String get chatSelectLocationAndSend => 'Selectionner la position et envoyer';

  @override
  String get chatShareRealTimeLocation => 'Partager la position en temps reel';

  @override
  String get chatShareLocationForOneHour =>
      'Partager la position en temps reel avec un ami pendant 1 heure';

  @override
  String get chatLocationSent => 'Position envoyee';

  @override
  String get chatSelectMessages => 'Selectionner les messages';

  @override
  String chatSelectedCount(int count) {
    return '$count selectionne(s)';
  }

  @override
  String get chatSelectAll => 'Tout selectionner';

  @override
  String chatGroupChatCount(int count) {
    return 'Discussion de groupe ($count)';
  }

  @override
  String get chatPrivateChat => 'Discussion privee';

  @override
  String get chatNoMessages => 'Aucun message';

  @override
  String get chatSendFirstMessage =>
      'Envoyez le premier message pour commencer a discuter';

  @override
  String get chatEncryptionNotice =>
      'Cette conversation est chiffree de bout en bout. Seuls vous et le destinataire pouvez lire les messages.';

  @override
  String get chatMultiForward => 'Transferer';

  @override
  String get chatCollect => 'Collecter';

  @override
  String get chatNoMembers => 'Aucun membre';

  @override
  String get chatMemberNotFound => 'Membre introuvable';

  @override
  String get chatVoiceFileNotExist => 'Le fichier vocal n\'existe pas';

  @override
  String get chatVoiceFileEmpty => 'Le fichier vocal est vide';

  @override
  String get chatSendingVoice => 'Envoi du message vocal...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Echec de l\'envoi du message vocal : $error';
  }

  @override
  String get chatMessageForwarded => 'Message transfere';

  @override
  String chatForwardFailed(Object error) {
    return 'Echec du transfert : $error';
  }

  @override
  String get chatUnfavorited => 'Retire des favoris';

  @override
  String get chatFavorited => 'Ajoute aux favoris';

  @override
  String get chatReactionAdded => 'Reaction ajoutee';

  @override
  String get chatReactionRemoved => 'Reaction supprimee';

  @override
  String get chatFailedMessageDeleted => 'Message echoue supprime';

  @override
  String get chatDeleteMessages => 'Supprimer les messages';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Etes-vous sur de vouloir supprimer $count messages ?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Remarque : $count messages proviennent d\'autres personnes et ne seront supprimes que pour vous.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count de vos messages seront rappeles pour tout le monde.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '$count messages rappeles, $localCount supprimes uniquement pour vous';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '$count messages rappeles';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count messages supprimes uniquement pour vous';
  }

  @override
  String chatForwardedCount(Object count) {
    return '$count messages transferes';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Transfert termine : $success reussi(s), $failed echoue(s)';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'La fonctionnalite de rappel n\'est disponible que dans les discussions de groupe';

  @override
  String get chatOnlyTextSearchable =>
      'Seuls les messages texte peuvent etre recherches';

  @override
  String chatSearchFor(Object text) {
    return 'Rechercher \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Recherche Baidu';

  @override
  String get chatGoogleSearch => 'Recherche Google';

  @override
  String get chatBingSearch => 'Recherche Bing';

  @override
  String get chatCalling => 'Appel en cours...';

  @override
  String get chatRinging => 'Sonnerie...';

  @override
  String get chatInCall => 'En appel';

  @override
  String commonFeatureInDevelopment(String feature) {
    return '$feature en cours de developpement...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '$count messages collectes';
  }

  @override
  String commonMemberCount(int count) {
    return '$count membres';
  }

  @override
  String groupDone(int count) {
    return 'Termine($count)';
  }

  @override
  String get profileServices => 'Services';

  @override
  String get commonFavorites => 'Favoris';

  @override
  String get profileOrdersAndCards => 'Commandes et cartes';

  @override
  String get profileStickers => 'Autocollants';

  @override
  String profileStatusSetTo(String status) {
    return 'Statut defini : $status';
  }

  @override
  String get profileAvatarUploadFailed =>
      'Echec du telechargement de l\'avatar';

  @override
  String get profilePersonalProfile => 'Profil personnel';

  @override
  String get profileName => 'Nom';

  @override
  String get profileGender => 'Genre';

  @override
  String get profileRegion => 'Region';

  @override
  String get commonMyQrCode => 'Mon code QR';

  @override
  String get profilePoke => 'Tapotement';

  @override
  String get profileRingtone => 'Sonnerie';

  @override
  String get profileDefaultRingtone => 'Sonnerie par defaut';

  @override
  String get profileMyAddresses => 'Mes adresses';

  @override
  String profileGenderSetTo(String gender) {
    return 'Genre defini : $gender';
  }

  @override
  String get profileSelectRegion => 'Selectionner la region';

  @override
  String get profileSelectCity => 'Selectionner la ville';

  @override
  String profileRegionSetTo(String region) {
    return 'Region definie : $region';
  }

  @override
  String get profileSetPoke => 'Definir le tapotement';

  @override
  String get profileFriendPokedMe => 'Mon ami m\'a tapote';

  @override
  String get profileExample => 'Exemple';

  @override
  String get profileOnTheShoulder => ' sur l\'epaule';

  @override
  String get profilePokeCleared => 'Tapotement efface';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Tapotement defini : m\'a tapote$suffix';
  }

  @override
  String get profileEditSignature => 'Modifier la signature';

  @override
  String get profileIntroduceYourself => 'Une phrase pour vous presenter';

  @override
  String get profileSignatureCleared => 'Signature effacee';

  @override
  String get profileSignatureUpdated => 'Signature mise a jour';

  @override
  String get profileScanToAddFriend =>
      'Scannez le code QR ci-dessus pour m\'ajouter comme ami';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Sonnerie definie : $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Êtes-vous sûr de vouloir dissoudre « $name » ? Cette action est irréversible.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Veuillez entrer une adresse de serveur valide';

  @override
  String get authEmailOtp => 'OTP par e-mail';

  @override
  String get authEnterServerAddressFirst =>
      'Veuillez d\'abord entrer l\'adresse du serveur';

  @override
  String get authPasskeyRequiresServer =>
      'La connexion par cle d\'acces necessite le support du serveur';

  @override
  String get authLoginAgreement => 'En vous connectant, vous acceptez ';

  @override
  String get authPleaseAgreeToTerms =>
      'Veuillez lire et accepter les conditions d\'utilisation et la politique de confidentialite';

  @override
  String get authRegisterFailed => 'Echec de l\'inscription';

  @override
  String get commonReenterPassword => 'Ressaisir le mot de passe';

  @override
  String get commonPasswordsDoNotMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get authInviteCodeBuiltIn => 'Code d\'invitation (integre)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Le code d\'invitation est integre, generalement pas besoin de modifier';

  @override
  String get authIHaveReadAndAgree => 'J\'ai lu et j\'accepte ';

  @override
  String get mainStartGroupChat => 'Demarrer une discussion de groupe';

  @override
  String get mainAddFriends => 'Ajouter des amis';

  @override
  String get mainPaymentAndCollection => 'Paiement';

  @override
  String contactCount(int count) {
    return '$count contacts';
  }

  @override
  String get contactAddToHomeScreen => 'Ajouter a l\'ecran d\'accueil';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Carte de $contact recommandee a $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Entrez le nom de remarque';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Remarque definie : $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Demande d\'ami de $name acceptee';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Demande d\'ami de $name refusee';
  }

  @override
  String get commonGroupInvites => 'Invitations de groupe';

  @override
  String commonMyGroups(int count) {
    return 'Mes groupes ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Invite a rejoindre le groupe';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Êtes-vous sûr de vouloir quitter « $name » ?';
  }

  @override
  String get commonLeave => 'Quitter';

  @override
  String get commonRecallThisMessage => 'Rappeler ce message ?';

  @override
  String get commonSavedToGallery => 'Enregistre dans la galerie';

  @override
  String get commonFailedToSave => 'Echec de l\'enregistrement';

  @override
  String get chatSaving => 'Enregistrement...';

  @override
  String get commonShare => 'Partager';

  @override
  String get chatSaveToGallery => 'Enregistrer dans la galerie';

  @override
  String chatDownloadFailed(String code) {
    return 'Échec du téléchargement : $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Échec du partage : $error';
  }

  @override
  String get chatFailedToLoadImage => 'Echec du chargement de l\'image';

  @override
  String get chatVideoRecordingFailed =>
      'Echec de l\'enregistrement video. Veuillez reessayer.';

  @override
  String get profileRedPacket => 'Enveloppe rouge';

  @override
  String get commonMusic => 'Musique';

  @override
  String get commonCoupon => 'Coupon';

  @override
  String get commonGift => 'Cadeau';

  @override
  String get commonPoll => 'Sondage';

  @override
  String get favoriteText => 'Texte';

  @override
  String get favoriteLinkLabel => 'Lien';

  @override
  String get favoriteNote => 'Note';

  @override
  String get favoriteMyNotes => 'Mes notes';

  @override
  String get favoriteToday => 'Aujourd\'hui';

  @override
  String favoriteDaysAgoText(int count) {
    return 'Il y a $count jours';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Pas encore de favoris';

  @override
  String get favoriteLongPressToFavorite =>
      'Appuyez longuement sur un message pour l\'ajouter aux favoris';

  @override
  String get favoriteNewNote => 'Nouvelle note';

  @override
  String get favoriteLink => 'Lien favori';

  @override
  String get favoriteEditTags => 'Modifier les tags';

  @override
  String get favoriteDeleteFavorite => 'Supprimer le favori';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Etes-vous sur de vouloir supprimer ce favori ?';

  @override
  String get favoriteNoSearchResultsFound => 'Aucun resultat trouve';

  @override
  String get commonSendRedPacket => 'Envoyer une enveloppe rouge';

  @override
  String get transferAmount => 'Montant';

  @override
  String get commonRedPacketCover => 'Couverture de l\'enveloppe rouge';

  @override
  String get commonRedPacketType => 'Type d\'enveloppe rouge';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'Chance';

  @override
  String get commonRedPacketCount => 'Nombre d\'enveloppes rouges';

  @override
  String get commonPieces => 'pieces';

  @override
  String get commonPutMoneyInRedPacket =>
      'Mettre de l\'argent dans l\'enveloppe rouge';

  @override
  String get commonRedPacketRefundNotice =>
      'Les enveloppes rouges non reclamees seront remboursees apres 24 heures';

  @override
  String get commonOpenRedPacket => 'Ouvrir';

  @override
  String get commonRedPacketAllClaimed =>
      'Enveloppe rouge entierement reclamee';

  @override
  String get commonRedPacketExpired => 'Enveloppe rouge expiree';

  @override
  String get commonAddTransferNote => 'Ajouter une note de transfert';

  @override
  String get commonYuan => 'EUR';

  @override
  String get commonReplyWithEmoji => 'Repondre avec cet emoji';

  @override
  String get contactEditRemark => 'Modifier la remarque';

  @override
  String get contactSetPermissions => 'Definir les permissions';

  @override
  String get profileAddToBlacklist => 'Ajouter a la liste noire';

  @override
  String get contactDeleteContact => 'Supprimer le contact';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Etes-vous sur de vouloir supprimer $name ?';
  }

  @override
  String get transferTitle => 'Transfert';

  @override
  String get transferReceiverAddressLabel => 'Adresse du destinataire';

  @override
  String get transferSelectTokenLabel => 'Selectionner un jeton';

  @override
  String get transferAmountLabel => 'Montant du transfert';

  @override
  String get transferMemoLabel => 'Memo (facultatif)';

  @override
  String get transferAddMemoHint => 'Ajouter un memo';

  @override
  String get transferSendPaymentRequest => 'Envoyer une demande de paiement';

  @override
  String get transferQrCodeGenerateFailed =>
      'Echec de la generation du code QR';

  @override
  String get transferScanQrToPayMe => 'Scannez le code QR pour me payer';

  @override
  String get transferMyWalletAddress => 'Adresse de mon portefeuille';

  @override
  String get transferCreatePaymentRequest => 'Creer une demande de paiement';

  @override
  String profileN42IdLabel(String id) {
    return 'ID N42 : $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Meilleurs voeux';

  @override
  String commonSenderRedPacket(String name) {
    return 'Enveloppe rouge de $name';
  }

  @override
  String get transferEnterValidAddress => 'Veuillez entrer une adresse valide';

  @override
  String get transferPleaseSelectToken => 'Veuillez selectionner un jeton';

  @override
  String get commonReceivedTransfer => 'Transfert recu';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name a envoye une enveloppe rouge';
  }

  @override
  String get commonSavedToBalance =>
      'Enregistre dans le solde, transfert direct possible';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Enveloppe rouge expiree/entierement reclamee';

  @override
  String get transferScanFeatureComingSoon =>
      'Fonctionnalite de scan bientot disponible...';

  @override
  String get contactSetAsStarred => 'Definir comme favori';

  @override
  String get contactAddToBlocklist => 'Ajouter a la liste de blocage';

  @override
  String get commonClaimedYour => ' a reclame votre ';

  @override
  String get commonClaimedText => ' a reclame ';

  @override
  String commonUserTyping(String name) {
    return '$name est en train d\'ecrire...';
  }

  @override
  String get commonTyping => 'En train d\'ecrire...';

  @override
  String get commonWaitingToReceive => 'En attente de reception';

  @override
  String get commonTapToClaim => 'Appuyez pour reclamer';

  @override
  String get commonHasBeenReceived => 'A ete recu';

  @override
  String get commonGetLucky => 'Bonne chance';

  @override
  String get qrcodeCameraStartFailed => 'Echec du demarrage de la camera';

  @override
  String get qrcodeUnknownError => 'Erreur inconnue';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Placez le code QR dans le cadre pour scanner';

  @override
  String get qrcodeCloseManualInput => 'Fermer la saisie manuelle';

  @override
  String get qrcodeManualInputUserId => 'Saisie manuelle de l\'ID utilisateur';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get profileSetStatus => 'Definir le statut';

  @override
  String get profileVisibleToFriends24h =>
      'Visible par les amis pendant 24 heures';

  @override
  String get profileWriteStatus => 'Ecrire le statut';

  @override
  String get profileEnterYourStatus => 'Entrez votre statut...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'L\'autorisation de la camera est requise pour scanner le code QR';

  @override
  String get qrcodeCameraPermissionDenied =>
      'L\'autorisation de la camera a ete refusee definitivement. Veuillez l\'activer dans les parametres systeme.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Erreur lors de la verification de l\'autorisation : $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Code QR invalide';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Impossible d\'ajouter l\'ami : $error';
  }

  @override
  String get qrcodeScanQrCode => 'Scanner le code QR';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Verification de l\'autorisation de la camera...';

  @override
  String get qrcodeNeedCameraPermission => 'Autorisation de la camera requise';

  @override
  String get qrcodeRetryPermission => 'Reessayer';

  @override
  String get qrcodeOpenSettings => 'Ouvrir les parametres';

  @override
  String get groupInviteMembers => 'Inviter des membres';

  @override
  String groupInviteCount(int count) {
    return 'Inviter($count)';
  }

  @override
  String get profileNoShippingAddress => 'Pas d\'adresse de livraison';

  @override
  String get profileDefaultLabel => 'Par defaut';

  @override
  String get profileNoInvoice => 'Pas de facture';

  @override
  String get profileCompany => 'Entreprise';

  @override
  String get profileTaxNumber => 'Numero de TVA';

  @override
  String get profileConfirmDeleteAddress =>
      'Etes-vous sur de vouloir supprimer cette adresse ?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Etes-vous sur de vouloir supprimer cette facture ?';

  @override
  String get commonGroupOwner => 'Proprietaire';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Rechercher des membres';

  @override
  String groupTotalMembers(int count) {
    return '$count membres';
  }

  @override
  String get chatRemoveFromGroup => 'Retirer du groupe';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Etes-vous sur de vouloir retirer \"$name\" du groupe ?';
  }

  @override
  String get chatUnknownSong => 'Chanson inconnue';

  @override
  String get chatUnknownArtist => 'Artiste inconnu';

  @override
  String get chatUnknownContact => 'Contact inconnu';

  @override
  String get chatPersonalCard => 'Carte de contact';

  @override
  String get chatSingleChoice => 'Choix unique';

  @override
  String get chatMultiChoice => 'Choix multiple';

  @override
  String get chatEnded => 'Termine';

  @override
  String get chatEndPollButton => 'Terminer le sondage';

  @override
  String get chatPollHint =>
      'Le sondage sera affiche dans le chat. Les membres du groupe peuvent voter.';

  @override
  String get chatSearchSongOrArtist => 'Rechercher une chanson ou un artiste';

  @override
  String get chatNoSongsFound => 'Aucune chanson trouvee';

  @override
  String get chatSongNameOptional => 'Nom de la chanson (facultatif)';

  @override
  String get chatEnterSongName => 'Entrez le nom de la chanson';

  @override
  String get chatArtistNameOptional => 'Nom de l\'artiste (facultatif)';

  @override
  String get chatEnterArtistName => 'Entrez le nom de l\'artiste';

  @override
  String get chatRealTimeLocationSharing =>
      'Partage de position en temps reel en developpement...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Fonctionnalite d\'appel vocal en developpement...';

  @override
  String get profileReportFeatureInDev =>
      'Fonctionnalite de signalement en developpement...';

  @override
  String get profileShareFeatureInDev =>
      'Fonctionnalite de partage en developpement...';

  @override
  String get profileQrCodeFeatureInDev =>
      'Fonctionnalite de code QR en developpement...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Scannez le code QR ci-dessus pour m\'ajouter comme ami';

  @override
  String get qrcodeSaveToAlbum => 'Enregistrer dans l\'album';

  @override
  String get qrcodeChangeStyle => 'Changer le style';

  @override
  String get qrcodeCopyId => 'Copier l\'ID';

  @override
  String get qrcodeIdCopied => 'ID copie';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'Plus de styles bientot disponibles';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Serveur';

  @override
  String get profileShareContactCard => 'Partager la carte de contact';

  @override
  String get profileRemoveFromBlacklist => 'Retirer de la liste noire';

  @override
  String get profileConfirmAddBlacklist =>
      'Etes-vous sur de vouloir ajouter cet utilisateur a la liste noire ? Vous ne recevrez plus ses messages.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Etes-vous sur de vouloir retirer cet utilisateur de la liste noire ?';

  @override
  String get profileRemarkSaved => 'Remarque enregistree';

  @override
  String get profileRemarkCleared => 'Remarque effacee';

  @override
  String get transferReceive => 'Recevoir';

  @override
  String get transferPleaseConnectWallet =>
      'Veuillez d\'abord connecter votre portefeuille';

  @override
  String get transferSendRequest => 'Envoyer la demande';

  @override
  String get transferPleaseEnterValidAmount =>
      'Veuillez entrer un montant valide';

  @override
  String get searchPlaceholder => 'Rechercher contacts, groupes, messages';

  @override
  String get searchEnterKeywordToSearch =>
      'Entrez un mot-cle pour commencer la recherche';

  @override
  String get searchClearHistory => 'Effacer';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Aucun resultat trouve pour \"$query\"';
  }

  @override
  String get searchAllResults => 'Tout';

  @override
  String get searchInChat => 'Rechercher dans le chat';

  @override
  String get searchContactLabel => 'Contact';

  @override
  String get searchGroupLabel => 'Groupe';

  @override
  String get searchConversationLabel => 'Conversation';

  @override
  String get searchMessageLabel => 'Message';

  @override
  String get settingsSecurityTitle => 'Securite';

  @override
  String get settingsKeyBackup => 'Sauvegarde des cles';

  @override
  String get settingsBackupEncryptionKeys =>
      'Sauvegarder les cles de chiffrement';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count cles sauvegardees';
  }

  @override
  String get settingsBackupNotSet => 'Sauvegarde non configuree';

  @override
  String get settingsRestoreKeys => 'Restaurer les cles';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Restaurer les cles de chiffrement depuis la sauvegarde';

  @override
  String get settingsExportKeys => 'Exporter les cles';

  @override
  String get settingsExportKeysToFile => 'Exporter les cles vers un fichier';

  @override
  String get settingsLoggedInDevices => 'Appareils connectes';

  @override
  String get settingsNoOtherDevices => 'Pas d\'autres appareils';

  @override
  String get settingsVerified => 'Verifie';

  @override
  String get settingsUnverified => 'Non verifie';

  @override
  String get settingsAdvanced => 'Avance';

  @override
  String get settingsCrossSigning => 'Signature croisee';

  @override
  String get settingsEnabled => 'Active';

  @override
  String get settingsNotEnabled => 'Non active';

  @override
  String get settingsResetEncryption => 'Reinitialiser le chiffrement';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Supprimer toutes les cles de chiffrement';

  @override
  String get settingsEncryptionNotSupported => 'Chiffrement non supporte';

  @override
  String get settingsNotInitialized => 'Non initialise';

  @override
  String get settingsBackupKeyTitle => 'Sauvegarder les cles';

  @override
  String get settingsBackupKeyMessage =>
      'Creer une nouvelle sauvegarde de cles ? Cela vous aidera a restaurer les messages chiffres sur un nouvel appareil.';

  @override
  String get settingsBackup => 'Sauvegarder';

  @override
  String get settingsRestoreKeyTitle => 'Restaurer les cles';

  @override
  String get settingsRestoreKeyMessage =>
      'Entrez votre mot de passe de recuperation ou votre cle de recuperation pour restaurer les messages chiffres.';

  @override
  String get settingsRestore => 'Restaurer';

  @override
  String get settingsExportKeyTitle => 'Exporter les cles';

  @override
  String get settingsExportKeyMessage =>
      'Le fichier de cles exporte contient toutes vos cles de chiffrement. Veuillez le garder en securite.';

  @override
  String get settingsExport => 'Exporter';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID de l\'appareil : $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Statut : Verifie';

  @override
  String get settingsDeviceStatusUnverified => 'Statut : Non verifie';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Derniere activite : $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Verifier cet appareil';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'La signature croisee est deja activee';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Configuration de la signature croisee reussie';

  @override
  String get settingsResetEncryptionTitle => 'Reinitialiser le chiffrement';

  @override
  String get settingsResetEncryptionWarning =>
      'Attention : Cela supprimera toutes vos cles de chiffrement. Vous ne pourrez plus dechiffrer les messages chiffres precedents. Cette action est irreversible.';

  @override
  String get settingsReset => 'Reinitialiser';

  @override
  String get callLeaveMeetingConfirm =>
      'Etes-vous sur de vouloir quitter la reunion ?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'a tapote $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Aucun contact disponible a ajouter';

  @override
  String get chatAddMembers => 'Ajouter des membres';

  @override
  String chatInvitedMembers(int count) {
    return '$count membres invites';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Echec de l\'invitation : $error';
  }

  @override
  String get chatMemberRemoved => 'Membre retire';

  @override
  String chatRemoveFailed(String error) {
    return 'Echec du retrait : $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Apres le partage, l\'autre partie peut voir votre position en temps reel pendant 1 heure.';

  @override
  String get chatStartSharing => 'Commencer le partage';

  @override
  String get chatLocationServiceNotEnabled =>
      'Le service de localisation n\'est pas active';

  @override
  String get chatEnableLocationService =>
      'Veuillez activer le service de localisation pour utiliser cette fonctionnalite';

  @override
  String get chatGoToSettings => 'Aller aux parametres';

  @override
  String get chatLocationPermissionRequired =>
      'L\'autorisation de localisation est requise pour cette fonctionnalite';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'L\'autorisation de localisation a ete refusee definitivement. Veuillez l\'activer dans les parametres.';

  @override
  String get chatLocationPermissionDenied =>
      'Autorisation de localisation refusee';

  @override
  String get chatGettingLocation => 'Obtention de la position...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Echec de l\'obtention de la position : $error';
  }

  @override
  String get chatMapPreview => 'Apercu de la carte';

  @override
  String get chatSearchLocation => 'Rechercher un lieu';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Enveloppe rouge de $amount $token envoyee';
  }

  @override
  String get chatTransferDefault => 'Transfert';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Transfert de $amount $token envoye';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Echec de la selection du fichier : $error';
  }

  @override
  String get chatFileSizeLimit =>
      'La taille du fichier ne peut pas depasser 50 Mo';

  @override
  String chatFileSending(String filename) {
    return 'Envoi du fichier : $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Echec de l\'envoi du fichier : $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Carte de contact de $name envoyee';
  }

  @override
  String get chatFavoritesFeature => 'Favoris';

  @override
  String get chatCouponsFeature => 'Coupons';

  @override
  String get chatGiftFeature => 'Cadeau';

  @override
  String chatSharedMusic(String name) {
    return '$name partage';
  }

  @override
  String get chatEndPollTitle => 'Terminer le sondage';

  @override
  String get chatEndPollConfirmMessage =>
      'Etes-vous sur de vouloir terminer ce sondage ? Le vote sera ferme apres la fin.';

  @override
  String get chatPollEndedMessage => 'Sondage termine';

  @override
  String get chatConnectingCall => 'Connexion en cours...';

  @override
  String get chatMuteCall => 'Couper le son';

  @override
  String get chatSpeakerOff => 'Haut-parleur desactive';

  @override
  String get chatSpeakerOn => 'Haut-parleur';

  @override
  String get chatCameraOn => 'Camera activee';

  @override
  String get chatCameraOff => 'Camera desactivee';

  @override
  String get chatHangUp => 'Raccrocher';

  @override
  String get chatSelectForwardTargetTitle =>
      'Selectionner la cible du transfert';

  @override
  String get chatNoForwardableChat => 'Aucun chat disponible pour le transfert';

  @override
  String get chatNoMatchingChat => 'Aucun chat correspondant trouve';

  @override
  String get chatLocationTitle => 'Position';

  @override
  String get chatSendButton => 'Envoyer';

  @override
  String get chatRetryButton => 'Reessayer';

  @override
  String get chatSearchContactHint => 'Rechercher des contacts';

  @override
  String get chatShareMusic => 'Partager de la musique';

  @override
  String get chatRecentPlayed => 'Recent';

  @override
  String get chatMyFavorites => 'Favoris';

  @override
  String get chatNetworkLink => 'Lien';

  @override
  String get chatLocalFile => 'Local';

  @override
  String get chatPasteMusicLink => 'Collez le lien musical';

  @override
  String get chatShareMusicButton => 'Partager la musique';

  @override
  String get chatSelectLocalAudio => 'Selectionner un fichier audio local';

  @override
  String get chatSupportedAudioFormats => 'Supporte MP3, M4A, WAV, FLAC, etc.';

  @override
  String get chatSelectFileButton => 'Selectionner le fichier';

  @override
  String get chatPleaseEnterMusicLink => 'Veuillez entrer le lien musical';

  @override
  String get chatPleaseEnterValidLink => 'Veuillez entrer une URL valide';

  @override
  String get chatSharedSong => 'Chanson partagee';

  @override
  String get chatSelectMember => 'Selectionner un membre';

  @override
  String get chatSearchMemberHint => 'Rechercher des membres';

  @override
  String get chatNoMatchingMembers => 'Aucun membre correspondant trouve';

  @override
  String get commonUnknownMember => 'Inconnu';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count messages selectionnes';
  }

  @override
  String get chatSearchContactsOrGroups =>
      'Rechercher des contacts ou des groupes';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Chargement...';

  @override
  String get chatVideoLoadFailed => 'Echec du chargement de la video';

  @override
  String get chatPlayerInitFailed => 'Echec de l\'initialisation du lecteur';

  @override
  String get chatCreatePollTitle => 'Creer un sondage';

  @override
  String get chatSubmitPoll => 'Soumettre';

  @override
  String get chatPollQuestionLabel => 'Question du sondage';

  @override
  String get chatEnterPollQuestionHint => 'Entrez la question du sondage';

  @override
  String get chatPollOptionsLabel => 'Options du sondage';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Option $index';
  }

  @override
  String get chatAddOptionButton => 'Ajouter une option';

  @override
  String get chatPollSettingsLabel => 'Parametres du sondage';

  @override
  String get chatSelectionType => 'Type de selection';

  @override
  String get chatSingleChoiceLabel => 'Choix unique';

  @override
  String get chatMultiChoiceLabel => 'Choix multiple';

  @override
  String get chatAnonymousPollSwitch => 'Sondage anonyme';

  @override
  String get chatPleaseEnterQuestion =>
      'Veuillez entrer la question du sondage';

  @override
  String get chatAtLeastTwoOptions => 'Au moins 2 options requises';

  @override
  String chatConfirmWithCount(int count) {
    return 'Confirmer ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Verification par e-mail';

  @override
  String get authEnterValidEmailAddress =>
      'Veuillez entrer une adresse e-mail valide';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Code de verification envoye a $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Echec de l\'envoi du code : $error';
  }

  @override
  String get authVerificationSuccess => 'Verification reussie';

  @override
  String get authVerificationFailed => 'Echec de la verification';

  @override
  String authVerificationCodeError(String error) {
    return 'Erreur du code de verification : $error';
  }

  @override
  String get commonEnterVerificationCode => 'Entrez le code de verification';

  @override
  String get authEnterYourEmail => 'Entrez votre e-mail';

  @override
  String authWeSentCodeTo(String email) {
    return 'Nous avons envoye un code a 6 chiffres a\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Entrez votre adresse e-mail, nous vous enverrons un code de verification';

  @override
  String get commonSendVerificationCode => 'Envoyer le code de verification';

  @override
  String get authResendVerificationCode => 'Renvoyer le code de verification';

  @override
  String authCanResendAfter(int seconds) {
    return 'Peut renvoyer apres $seconds secondes';
  }

  @override
  String get commonChangeEmail => 'Changer d\'e-mail';

  @override
  String get contactAddToContacts => 'Ajouter aux contacts';

  @override
  String get contactAddingToContacts => 'Ajout en cours...';

  @override
  String get contactAddedToContacts => 'Ajoute aux contacts';

  @override
  String contactAddFailedWithError(String error) {
    return 'Echec de l\'ajout : $error';
  }

  @override
  String get contactAddPhone => 'Ajouter un telephone';

  @override
  String get contactAddTag => 'Ajouter des tags';

  @override
  String get contactAddText => 'Ajouter du texte';

  @override
  String get contactAddPhoto => 'Ajouter une photo';

  @override
  String contactGroupCountLabel(int count) {
    return '$count groupes';
  }

  @override
  String get contactAddedViaSearch => 'Ajoute via la recherche';

  @override
  String get contactAddTime => 'Ajouter l\'heure';

  @override
  String get contactDoneButton => 'Termine';

  @override
  String get callWaitingForParticipants => 'En attente des participants...';

  @override
  String callParticipantMe(String name) {
    return '$name (Moi)';
  }

  @override
  String get callSharingLabel => 'Partage';

  @override
  String callScreenSharingBy(String name) {
    return '$name partage son ecran';
  }

  @override
  String callParticipantCount(int count) {
    return '$count participants';
  }

  @override
  String get callMuteLabel => 'Couper le son';

  @override
  String get callUnmuteLabel => 'Reactiver le son';

  @override
  String get callTurnOffVideo => 'Desactiver la video';

  @override
  String get callTurnOnVideo => 'Activer la video';

  @override
  String get callShareScreen => 'Partager l\'ecran';

  @override
  String get callStopSharing => 'Arreter le partage';

  @override
  String get callSwitchCameraLabel => 'Changer';

  @override
  String get callLeaveLabel => 'Quitter';

  @override
  String get callParticipantsLabel => 'Participants';

  @override
  String get callJoiningMeeting => 'Rejoindre la reunion...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count votes ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count participants';
  }

  @override
  String get commonTapToRetry => 'Appuyez pour réessayer';

  @override
  String get chatDefaultRedPacketGreeting => 'Meilleurs vœux de prospérité';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Permettre aux autres de rechercher et de rejoindre';

  @override
  String get groupConfirmClearChatHistory =>
      'Êtes-vous sûr de vouloir effacer l\'historique des messages?';

  @override
  String get groupCreateGroupToChat =>
      'Créez un groupe pour commencer à discuter';

  @override
  String get groupEditGroupAnnouncement => 'Modifier l\'annonce du groupe';

  @override
  String get groupEditGroupDescription => 'Modifier la description du groupe';

  @override
  String get groupEnterGroupAnnouncement =>
      'Veuillez saisir l\'annonce du groupe';

  @override
  String chatErrorWithMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count membres, cliquez pour copier l\'ID du groupe';
  }

  @override
  String get chatMusicLinkLabel => 'Lien musical';

  @override
  String get chatNoMediaUrlAvailable => 'URL média non disponible';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Vous n\'avez pas la permission de modifier le nom du groupe';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Les enveloppes rouges et les transferts ne peuvent pas être transférés';

  @override
  String get authEmailAddress => 'Adresse e-mail';

  @override
  String get commonEnterEmailAddress => 'Entrez l\'adresse e-mail';

  @override
  String get authEmailRecoveryHint =>
      'Utilisé pour la récupération du mot de passe';

  @override
  String get commonInvalidEmailFormat =>
      'Veuillez entrer une adresse e-mail valide';

  @override
  String get authOptional => 'Optionnel';

  @override
  String get authResetPassword => 'Réinitialiser le mot de passe';

  @override
  String get authEnterRegisteredEmail =>
      'Entrez l\'adresse e-mail avec laquelle vous vous êtes inscrit';

  @override
  String get authSendResetCode => 'Envoyer le code de réinitialisation';

  @override
  String authResetCodeSent(String email) {
    return 'Code de réinitialisation envoyé à $email';
  }

  @override
  String get authEnterResetCode => 'Entrez le code de réinitialisation';

  @override
  String get authSetNewPassword => 'Définir un nouveau mot de passe';

  @override
  String get commonConfirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get commonNewPassword => 'Nouveau mot de passe';

  @override
  String get authPasswordResetSuccess =>
      'Mot de passe réinitialisé avec succès. Veuillez vous connecter avec votre nouveau mot de passe.';

  @override
  String get authResetPasswordFailed =>
      'Échec de la réinitialisation du mot de passe';

  @override
  String get settingsChangePassword => 'Changer le mot de passe';

  @override
  String get settingsCurrentPassword => 'Mot de passe actuel';

  @override
  String get settingsEnterCurrentPassword => 'Entrez le mot de passe actuel';

  @override
  String get settingsEnterNewPassword => 'Entrez le nouveau mot de passe';

  @override
  String get settingsPasswordChanged =>
      'Mot de passe modifié avec succès. Veuillez vous connecter avec votre nouveau mot de passe.';

  @override
  String get settingsChangePasswordFailed =>
      'Échec du changement de mot de passe';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Le nouveau mot de passe doit être différent du mot de passe actuel';

  @override
  String get settingsChangePasswordInfo =>
      'Après avoir changé le mot de passe, vous serez déconnecté et devrez vous reconnecter avec le nouveau mot de passe.';

  @override
  String get settingsPasswordRequirements => 'Exigences du mot de passe :';

  @override
  String get settingsSecurityNote =>
      'Pour des raisons de sécurité, vous devrez vous reconnecter sur tous les appareils après avoir changé le mot de passe.';

  @override
  String get settingsSecurity => 'Sécurité';

  @override
  String get settingsCurrentBoundEmail => 'E-mail actuellement lié';

  @override
  String get settingsNewEmailAddress => 'Nouvelle adresse e-mail';

  @override
  String get settingsEnterNewEmail => 'Entrez la nouvelle adresse e-mail';

  @override
  String get settingsVerificationCode => 'Code de vérification';

  @override
  String get settingsVerificationCodeSent => 'Code de vérification envoyé';

  @override
  String get settingsCodeSentTo => 'Code de vérification envoyé à';

  @override
  String get settingsDidNotReceiveCode => 'Vous n\'avez pas reçu le code ?';

  @override
  String get settingsEmailChangedSuccess => 'E-mail modifié avec succès';

  @override
  String get settingsChangeEmailFailed => 'Échec du changement d\'e-mail';

  @override
  String get settingsEmailSecurityNote =>
      'Votre e-mail est utilisé pour la récupération du mot de passe. Gardez-le en sécurité.';

  @override
  String get commonGoogleLogin => 'Se connecter avec Google';

  @override
  String get commonAppleLogin => 'Se connecter avec Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageChanged => 'Langue modifiée';

  @override
  String get settingsBiometricLogin => 'Connexion biométrique';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Se connecter avec $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Connexion biométrique activée';

  @override
  String get settingsBiometricLoginDisabled =>
      'Connexion biométrique désactivée';

  @override
  String get settingsEnableBiometricLogin => 'Activer la connexion biométrique';

  @override
  String get settingsBiometricEnabled =>
      'Activé - Utiliser la biométrie pour se connecter';

  @override
  String get settingsBiometricDisabled => 'Désactivé - Appuyez pour activer';

  @override
  String get settingsBiometricNeedRelogin =>
      'Veuillez vous déconnecter et vous reconnecter pour activer la connexion biométrique';

  @override
  String get authOr => 'OU';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'L\'accès à la caméra est restreint sur cet appareil';

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
      'Entrez le suffixe du clin d\'œil, ex.: sur l\'épaule';

  @override
  String get groupAlbum => 'Album du groupe';

  @override
  String get groupFiles => 'Fichiers du groupe';

  @override
  String get groupImages => 'Images';

  @override
  String get groupVideos => 'Vidéos';

  @override
  String get groupTotal => 'Total';

  @override
  String get groupSize => 'Taille';

  @override
  String get groupNoMedia => 'Aucun média';

  @override
  String get groupNoMediaDescription =>
      'Aucune photo ou vidéo dans ce groupe pour le moment';

  @override
  String get groupDocuments => 'Documents';

  @override
  String get groupNoFiles => 'Aucun fichier';

  @override
  String get groupNoFilesDescription =>
      'Aucun fichier dans ce groupe pour le moment';

  @override
  String groupDownloadStarted(String filename) {
    return 'Téléchargement de $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Aucun groupe en commun';

  @override
  String get contactNoCommonGroupsDescription =>
      'Vous n\'avez aucun groupe en commun';

  @override
  String get chatVoiceMessage => 'Vocal';

  @override
  String get chatMessage => 'Message';

  @override
  String get conversationHideChat => 'Masquer';

  @override
  String get settingsQuickReply => 'Réponse rapide';

  @override
  String get commonTranslate => 'Traduire';

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
    return 'Conversation : $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Contact : $userId';
  }

  @override
  String get commonDiscover => 'Decouvrir';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Bientot disponible)';
  }

  @override
  String get commonPageNotFound => 'Page introuvable';

  @override
  String get commonBackToHome => 'Retour a l\'accueil';

  @override
  String get settingsMessageNotifications => 'Notifications de messages';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Recevoir les notifications de nouveaux messages';

  @override
  String get settingsShowMessagePreview => 'Afficher l\'aperçu du message';

  @override
  String get settingsShowMessageContentInNotification =>
      'Afficher le contenu du message dans les notifications';

  @override
  String get settingsNotificationSound => 'Son de notification';

  @override
  String get settingsPlaySoundOnMessage =>
      'Jouer un son a la reception des messages';

  @override
  String get commonVibration => 'Vibration';

  @override
  String get settingsVibrateOnMessage => 'Vibrer a la reception des messages';

  @override
  String get settingsDoNotDisturbMode => 'Ne pas déranger';

  @override
  String get settingsDoNotDisturbDescription =>
      'Ne pas recevoir de notifications pendant la période spécifiée';

  @override
  String get settingsStartTime => 'Heure de debut';

  @override
  String get settingsEndTime => 'Heure de fin';

  @override
  String get settingsDeleteQuickReply => 'Supprimer la réponse rapide';

  @override
  String get settingsEditQuickReply => 'Modifier la réponse rapide';

  @override
  String get settingsAddQuickReply => 'Ajouter une réponse rapide';

  @override
  String get settingsManageQuickReplies => 'Gérer les réponses rapides';

  @override
  String get settingsNoQuickReplies => 'Aucune réponse rapide';

  @override
  String get settingsDefaultQuickReplies =>
      'Les réponses rapides par défaut seront affichées';

  @override
  String get settingsWhoCanSee => 'Qui peut voir';

  @override
  String get settingsLastSeen => 'Derniere connexion';

  @override
  String get settingsHiddenChats => 'Discussions masquées';

  @override
  String get settingsMessagesLabel => 'Messages';

  @override
  String get settingsAllowStrangerMessages =>
      'Autoriser les messages d\'inconnus';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Recevoir les messages des non-contacts';

  @override
  String get settingsReadReceipts => 'Accusess de lecture';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Permettre aux autres de savoir que vous avez lu leurs messages';

  @override
  String get settingsTypingIndicator => 'Indicateur de saisie';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Permettre aux autres de savoir que vous écrivez';

  @override
  String get settingsEveryone => 'Tout le monde';

  @override
  String get settingsContactsOnly => 'Contacts uniquement';

  @override
  String get settingsNobody => 'Personne';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Qui peut voir $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Version $version';
  }

  @override
  String get settingsCheckForUpdates => 'Rechercher des mises à jour';

  @override
  String get settingsOpenSourceLicenses => 'Licences open source';

  @override
  String get settingsFeedbackAndSuggestions => 'Commentaires et suggestions';

  @override
  String get settingsBuiltOnMatrix => 'Base sur le protocole Matrix';

  @override
  String get settingsNoHiddenChats => 'Aucune discussion masquée';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Les discussions que vous masquez apparaîtront ici';

  @override
  String get settingsUnhideChat => 'Afficher';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String get settingsFontSize => 'Taille de police';

  @override
  String get settingsBubbleStyle => 'Style de bulle';

  @override
  String get settingsFollowSystem => 'Suivre le système';

  @override
  String get settingsAutoSwitchBySystem =>
      'Changer automatiquement selon les paramètres système';

  @override
  String get settingsLightMode => 'Mode clair';

  @override
  String get settingsAlwaysUseLightTheme => 'Toujours utiliser le thème clair';

  @override
  String get settingsDarkModeOption => 'Mode sombre';

  @override
  String get settingsAlwaysUseDarkTheme => 'Toujours utiliser le thème sombre';

  @override
  String get settingsFontSizeSmall => 'Petit';

  @override
  String get settingsFontSizeStandard => 'Standard';

  @override
  String get settingsFontSizeLarge => 'Grand';

  @override
  String get settingsFontSizeExtraLarge => 'Très grand';

  @override
  String get settingsBubbleStyleWechat => 'Style WeChat';

  @override
  String get settingsBubbleStyleWechatDesc => 'Style de bulle classique WeChat';

  @override
  String get settingsBubbleStyleModern => 'Style moderne';

  @override
  String get settingsBubbleStyleModernDesc => 'Style de bulle moderne et épuré';

  @override
  String get settingsBubbleStyleClassic => 'Style classique';

  @override
  String get settingsBubbleStyleClassicDesc => 'Style de bulle traditionnel';

  @override
  String get discoverVideoChannels => 'Chaines';

  @override
  String get discoverLive => 'Direct';

  @override
  String get discoverListen => 'Ecouter';

  @override
  String get discoverWatch => 'Regarder';

  @override
  String get discoverSearchDiscover => 'Rechercher';

  @override
  String get discoverNearbyPeople => 'A proximite';

  @override
  String get discoverGames => 'Jeux';

  @override
  String get discoverMiniPrograms => 'Mini programmes';

  @override
  String get chatAlreadyInCall => 'Deja en appel';

  @override
  String get commonConnectionFailed => 'Echec de la connexion';

  @override
  String get chatCallRejected => 'Appel refuse';

  @override
  String get chatNoAnswer => 'Pas de reponse';

  @override
  String get commonClose => 'Fermer';

  @override
  String get chatSelectContact => 'Selectionner un contact';

  @override
  String get chatVoteRemoved => 'Vote retire';

  @override
  String get chatVoteChanged => 'Vote modifie';

  @override
  String get chatVoted => 'Vote';

  @override
  String chatReplyTo(String name) {
    return 'Repondre a $name';
  }

  @override
  String get chatCurrentLocation => 'Position actuelle';

  @override
  String chatNearbyPlace(int index) {
    return 'Lieu a proximite $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Environ $distance';
  }

  @override
  String get chatAddress => 'Adresse';

  @override
  String get chatLatitude => 'Latitude';

  @override
  String get chatLongitude => 'Longitude';

  @override
  String get groupDescriptionUpdated => 'Description du groupe mise à jour';

  @override
  String get groupAvatarUpdated => 'Avatar du groupe mis à jour';

  @override
  String get callDecline => 'Refuser';

  @override
  String get callAnswer => 'Repondre';

  @override
  String get callIncomingVideoCall => 'Appel vidéo entrant';

  @override
  String get callIncomingVoiceCall => 'Appel vocal entrant';

  @override
  String get callVideoCallInProgress => 'Appel vidéo';

  @override
  String get callVoiceCallInProgress => 'Appel vocal';

  @override
  String get callReconnectingCall => 'Reconnexion en cours...';

  @override
  String get callEnded => 'Appel terminé';

  @override
  String get callFailed => 'Appel échoué';

  @override
  String get callLivekitNotConfigured => 'LiveKit non configure';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Echec de la participation a la reunion : $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Echec du partage d\'ecran : $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Pas de N42 Bean';

  @override
  String get profileN42BeanDetails => 'Détails N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean est un jeton pour échanger des articles virtuels et des services dans N42. Actuellement disponible pour :';

  @override
  String get profileN42BeanFeature1 =>
      'Autocollants et thèmes exclusifs aux membres';

  @override
  String get profileN42BeanFeature2 => 'Personnalisation des bulles de chat';

  @override
  String get profileN42BeanFeature3 => 'Personnalisation des enveloppes rouges';

  @override
  String get profileN42BeanFeature4 => 'Badge de pseudo exclusif';

  @override
  String get profileN42BeanFeature5 => 'Privilèges de chat de groupe';

  @override
  String get profileN42BeanFeature6 => 'Extension de stockage cloud';

  @override
  String get profileN42BeanFeature7 => 'Filtres beauté pour appels vidéo';

  @override
  String get profileN42BeanFeature8 =>
      'Personnalisation de l\'arrière-plan Moments';

  @override
  String get profileN42BeanFeature9 => 'Priorité au service client VIP';

  @override
  String get profileGotIt => 'Compris';

  @override
  String get profileNoN42BeanRecords => 'Aucun enregistrement N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Humeur et pensees';

  @override
  String get profileStatusHappy => 'Heureux';

  @override
  String get profileStatusCracked => 'Brise';

  @override
  String get profileStatusLucky => 'Chanceux';

  @override
  String get profileStatusSunny => 'Ensoleille';

  @override
  String get profileStatusTired => 'Fatigue';

  @override
  String get profileStatusDaydream => 'Reverie';

  @override
  String get profileStatusRushing => 'Presse';

  @override
  String get profileStatusOverthinking => 'Trop reflechir';

  @override
  String get profileStatusEnergized => 'Energise';

  @override
  String get profileWorkAndStudy => 'Travail et etudes';

  @override
  String get profileStatusWorking => 'Au travail';

  @override
  String get profileStatusStudying => 'En etudes';

  @override
  String get profileStatusBusy => 'Occupe';

  @override
  String get profileStatusSlacking => 'Au repos';

  @override
  String get profileStatusTraveling => 'En voyage';

  @override
  String get profileStatusGoingHome => 'Rentrer a la maison';

  @override
  String get profileStatusDnd => 'Ne pas deranger';

  @override
  String get profileActivities => 'Activites';

  @override
  String get profileStatusHanging => 'Sortie';

  @override
  String get profileStatusCheckIn => 'Enregistrement';

  @override
  String get profileStatusExercising => 'Exercice';

  @override
  String get profileStatusCoffee => 'Cafe';

  @override
  String get profileStatusBubbleTea => 'The a bulles';

  @override
  String get profileStatusEating => 'Manger';

  @override
  String get profileStatusParenting => 'Parentalite';

  @override
  String get profileStatusSavingWorld => 'Sauver le monde';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Repos';

  @override
  String get profileStatusRetreat => 'Retraite';

  @override
  String get profileStatusHome => 'A la maison';

  @override
  String get profileStatusSleeping => 'Dormir';

  @override
  String get profileStatusCatLover => 'Amateur de chats';

  @override
  String get profileStatusDogWalking => 'Promener le chien';

  @override
  String get profileStatusGaming => 'Jouer';

  @override
  String get profileStatusListening => 'Ecouter';

  @override
  String get profileEditAddress => 'Modifier l\'adresse';

  @override
  String get profileRecipient => 'Destinataire';

  @override
  String get profileEnterRecipientName => 'Entrez le nom du destinataire';

  @override
  String get profilePhoneNumber => 'Numero de telephone';

  @override
  String get profileEnterPhoneNumber => 'Entrez le numero de telephone';

  @override
  String get profileRegionHint => 'Region/Departement/Ville';

  @override
  String get profileDetailedAddress => 'Adresse detaillee';

  @override
  String get profileDetailedAddressHint => 'Rue, numero de batiment, etc.';

  @override
  String get profileSetAsDefaultAddress => 'Definir comme adresse par defaut';

  @override
  String get profilePleaseCompleteInfo => 'Veuillez completer tous les champs';

  @override
  String get profileEditInvoice => 'Modifier la facture';

  @override
  String get profileInvoiceType => 'Type de facture : ';

  @override
  String get profileCompanyName => 'Nom de l\'entreprise';

  @override
  String get profilePersonalName => 'Nom personnel';

  @override
  String get profileEnterCompanyName => 'Entrez le nom de l\'entreprise';

  @override
  String get profileEnterName => 'Entrez le nom';

  @override
  String get profileTaxIdNumber => 'Numero d\'identification fiscale';

  @override
  String get profileEnterTaxIdNumber =>
      'Entrez le numero d\'identification fiscale';

  @override
  String get profileBankNameOptional => 'Nom de la banque (facultatif)';

  @override
  String get profileEnterBankName => 'Entrez le nom de la banque';

  @override
  String get profileBankAccountOptional => 'Compte bancaire (facultatif)';

  @override
  String get profileEnterBankAccount => 'Entrez le compte bancaire';

  @override
  String get profileCompanyAddressOptional =>
      'Adresse de l\'entreprise (facultatif)';

  @override
  String get profileEnterCompanyAddress => 'Entrez l\'adresse de l\'entreprise';

  @override
  String get profileCompanyPhoneOptional =>
      'Telephone de l\'entreprise (facultatif)';

  @override
  String get profileEnterCompanyPhone => 'Entrez le telephone de l\'entreprise';

  @override
  String get profileSetAsDefaultInvoice => 'Definir comme facture par defaut';

  @override
  String get profileRingtoneVibrate => 'Vibration';

  @override
  String get profileRingtoneSilent => 'Silencieux';

  @override
  String get profileVibrateMode => 'Mode vibration';

  @override
  String get profileSilentMode => 'Mode silencieux';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Echec de la lecture : $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Lecture : $ringtoneName';
  }

  @override
  String get profileStop => 'Arreter';

  @override
  String get profileSelectRingtone => 'Selectionner la sonnerie';

  @override
  String get profileLoadingRingtones => 'Chargement des sonneries...';

  @override
  String get profileNoRingtonesFound => 'Aucune sonnerie trouvee';

  @override
  String mainMessagesWithCount(int count) {
    return 'Messages($count)';
  }

  @override
  String get storyViewers => 'Spectateurs';

  @override
  String get storyNoViewers => 'Aucun spectateur pour le moment';

  @override
  String get storyReplyToStory => 'Répondre à la story...';

  @override
  String get commonCopiedToClipboard => 'Copie dans le presse-papiers';

  @override
  String get commonMore => 'Plus';

  @override
  String get commonTranslating => 'Traduction en cours...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Traduit de $language';
  }

  @override
  String get commonTranslation => 'Traduction';

  @override
  String get commonTranslationFailed => 'Échec de la traduction';

  @override
  String get commonAllRead => 'Tout lu';

  @override
  String commonReadCount(int count) {
    return '$count lu(s)';
  }

  @override
  String get commonYouRecalledMessage => 'Vous avez rappele un message';

  @override
  String get commonMessageRecalled => 'Message rappele';

  @override
  String get commonReEdit => 'Reediter';

  @override
  String get commonWalletArea => 'Zone portefeuille';

  @override
  String get callIncomingCall => 'Appel entrant';

  @override
  String get callMissedCall => 'Appel manque';

  @override
  String get groupRemoveAdmin => 'Retirer admin';

  @override
  String get chatSelectCurrency => 'Selectionner la devise';

  @override
  String get chatSelectEmoji => 'Choisir un emoji';

  @override
  String get chatSelectRedPacketCover => 'Sélectionner la couverture';

  @override
  String get groupSetAsAdmin => 'Definir comme admin';

  @override
  String get chatVideoPlaybackFailed => 'Echec de la lecture video';

  @override
  String get groupViewProfile => 'Voir le profil';

  @override
  String get favoriteAddLinkComingSoon => 'Ajout de lien bientot disponible';

  @override
  String get favoriteNewNoteComingSoon => 'Nouvelle note bientot disponible';

  @override
  String get qrcodeSaveFeatureComingSoon =>
      'Fonctionnalite d\'enregistrement bientot disponible';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Fonctionnalite de partage bientot disponible';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Echec du traitement du code QR : $error';
  }
}
