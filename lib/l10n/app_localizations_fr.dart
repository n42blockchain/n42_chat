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
  String authLoginFailed(Object error) {
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
  String get commonImage => '[image]';

  @override
  String get chatVideo => '[Vidéo]';

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
  String get chatMicrophonePermissionDeniedPermanent =>
      'L\'autorisation du microphone a été refusée. Veuillez l\'activer dans les paramètres système pour utiliser les messages vocaux.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Echec du demarrage de l\'enregistrement : $error';
  }

  @override
  String get commonRecordingTooShort => 'Enregistrement trop court';

  @override
  String commonStopRecordingFailed(Object error) {
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
  String get chatReadAloud => 'Lire à haute voix';

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
  String contactN42Id(Object id) {
    return 'ID N42 : $id';
  }

  @override
  String get profileN42IdTitle => 'ID N42';

  @override
  String get profileN42Bean => 'Haricot N42';

  @override
  String get contactFriendInfo => 'Infos de l\'ami';

  @override
  String get contactFriendInfoDesc =>
      'Ajouter une remarque, telephone, tags, notes, photos et definir les permissions.';

  @override
  String get commonMoments => 'Instants';

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
  String get contactTags => 'Balises';

  @override
  String get contactNotes => 'Remarques';

  @override
  String get contactPhotos => 'Photos';

  @override
  String get contactPermissions => 'Autorisations';

  @override
  String get contactChatMomentsEtc => 'Discussions, Moments, Sports, etc.';

  @override
  String get contactMoreInfo => 'Plus d\'infos';

  @override
  String get contactCommonGroups => 'Groupes en commun';

  @override
  String get contactSource => 'Origine';

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
  String profileSaveFailed(Object error) {
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
  String get authAnd => ' et ';

  @override
  String get authPrivacyPolicy => 'Politique de confidentialite';

  @override
  String get authServerAddress => 'Adresse du serveur';

  @override
  String get authEnterServerAddress => 'Entrez l\'adresse du serveur';

  @override
  String authConnectedTo(Object serverName) {
    return 'Connecte a $serverName';
  }

  @override
  String get authUsername => 'Nom d\'utilisateur';

  @override
  String get authEnterUsername => 'Entrez le nom d\'utilisateur';

  @override
  String get authUsernameOrEmail => 'Nom d\'utilisateur ou Email';

  @override
  String get authEnterUsernameOrEmail =>
      'Entrez le nom d\'utilisateur ou email';

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
  String get profileAvatar => 'avatar';

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
  String commonFeatureComingSoon(Object feature) {
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
  String conversationDeleteConversationConfirm(Object name) {
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
  String get contactChatOnlyFriends => 'Amis de chat uniquement';

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
  String contactRecommendFailed(Object error) {
    return 'Echec de la recommandation : $error';
  }

  @override
  String get profileEnterRemark => 'Entrez une remarque';

  @override
  String get contactOpeningChat => 'Ouverture du chat...';

  @override
  String contactOpenChatFailed(Object error) {
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
  String commonGroupMembers(Object count) {
    return 'Membres ($count)';
  }

  @override
  String get groupMembersTitle => 'Membres du groupe';

  @override
  String get groupViewAll => 'Voir tout';

  @override
  String get groupOwner => 'Proprietaire';

  @override
  String get groupAdmin => 'Administrateur';

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
  String transferAvailableBalance(Object balance, Object symbol) {
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
  String commonFromSender(String name) {
    return 'De $name';
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
  String commonSelectImageFailed(Object error) {
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
  String profileSaveAddressFailed(Object error) {
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
  String profileSaveInvoiceFailed(Object error) {
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
  String favoriteOpenItem(Object content) {
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
  String commonFeatureInDevelopment(Object feature) {
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
  String get profileServices => 'Prestations';

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
  String get profileRegion => 'Région';

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
  String get authRegistrationDisabled =>
      'Les inscriptions sont désactivées sur ce serveur. Contactez son administrateur pour les activer.';

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
    return 'Contacts $count';
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
  String get favoriteNote => 'Remarque';

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
  String get commonNormalRedPacket => 'Normale';

  @override
  String get commonLuckyRedPacket => 'Chance';

  @override
  String get commonRedPacketCount => 'Nombre d\'enveloppes rouges';

  @override
  String get commonPieces => 'morceaux';

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
  String get profileOk => 'D\'accord';

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
  String get commonGroupAdmin => 'Administrateur';

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
  String get profileBio => 'Biographie';

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
  String get searchClearHistoryConfirm =>
      'Effacer toutes les recherches récentes ?';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Aucun resultat trouve pour \"$query\"';
  }

  @override
  String get searchAllResults => 'Tout';

  @override
  String get searchInChat => 'Rechercher dans le chat';

  @override
  String get searchContactLabel => 'Contacter';

  @override
  String get searchGroupLabel => 'Groupe';

  @override
  String get searchConversationLabel => 'Conversation';

  @override
  String get searchMessageLabel => 'Message';

  @override
  String get settingsSecurityTitle => 'Securite';

  @override
  String get settingsDeleteAccountTitle => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Désactiver ce compte Matrix et nettoyer ses données de discussion locales';

  @override
  String get settingsDeleteAccountExplanation =>
      'Cette action demande la désactivation définitive du compte Matrix. Après confirmation du serveur, l’application supprime la session de discussion locale et les clés de chiffrement de ce compte dès que cela peut être fait sans risque. Les autres comptes et votre portefeuille sont conservés. La fédération et les règles de conservation des serveurs peuvent limiter l’effacement des données.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Mot de passe Matrix, si demandé';

  @override
  String get settingsDeleteAccountServerErase =>
      'Demander l’effacement des données du serveur';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Demandez à ce serveur d’accueil d’effacer les données du compte si cette fonction est prise en charge. Des copies détenues par d’autres serveurs ou soumises à une obligation de conservation peuvent subsister.';

  @override
  String get settingsDeleteAccountChooseStage => 'Vérifier ce compte Matrix';

  @override
  String get settingsDeleteAccountUsePassword =>
      'Utiliser le mot de passe Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'Continuer dans le navigateur';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Revenir de la vérification Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Le retour depuis le navigateur ne confirme pas la suppression. Vérifiez la demande initiale auprès du serveur Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'Vérifier auprès du serveur';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'Le serveur Matrix n’a pas confirmé la suppression du compte.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Nettoyage local du compte en attente';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Examiner le nettoyage d’un compte Matrix précédemment désactivé';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Impossible de lire les enregistrements de nettoyage en attente. Touchez pour réessayer.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Le compte Matrix a été désactivé, mais le nettoyage local reste en attente. Les autres comptes restent disponibles.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'La gestion du compte a été ouverte dans votre navigateur. La suppression n’a pas été confirmée dans cette application ; votre session de discussion reste donc disponible.';

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
  String get settingsBackupSuccess => 'Clés sauvegardées avec succès';

  @override
  String get settingsBackupFailed => 'La sauvegarde a échoué';

  @override
  String get settingsRecoveryKey => 'Clé de récupération';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Veuillez conserver cette clé de récupération dans un endroit sûr. Vous en aurez besoin pour restaurer vos messages cryptés sur un nouvel appareil.';

  @override
  String get settingsRecoveryKeySaved => 'je l\'ai sauvegardé';

  @override
  String get settingsRestoreSuccess => 'Clés restaurées avec succès';

  @override
  String get settingsRestoreEmpty =>
      'Aucune clé de message trouvée dans cette sauvegarde.';

  @override
  String settingsRestoreSessions(int count) {
    return '$count sessions de clés restaurées. Les messages sans clés peuvent rester chiffrés.';
  }

  @override
  String get settingsRestoreFailed => 'La restauration a échoué';

  @override
  String get settingsPassword => 'Mot de passe';

  @override
  String get settingsEnterRecoveryKey => 'Entrez la clé de récupération';

  @override
  String get settingsEnterPassword => 'Entrez le mot de passe';

  @override
  String get settingsExportSuccess =>
      'Clés exportées avec succès vers la sauvegarde du serveur';

  @override
  String get settingsExportNeedBackupFirst =>
      'Veuillez d\'abord créer une sauvegarde de clé';

  @override
  String get settingsExportFailed => 'Échec de l\'exportation';

  @override
  String get settingsResetSuccess => 'Réinitialisation du cryptage réussie';

  @override
  String get settingsResetFailed => 'Échec de la réinitialisation';

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
  String get chatRecentPlayed => 'Récent';

  @override
  String get chatMyFavorites => 'Favoris';

  @override
  String get chatNetworkLink => 'Lien';

  @override
  String get chatLocalFile => 'Locale';

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
  String get chatVideoTitle => 'Vidéo';

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
    return 'participants $count';
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
    return 'Votes $count ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return 'participants $count';
  }

  @override
  String get chatNoMediaUrlAvailable => 'URL média non disponible';

  @override
  String chatDownloadFailed(String code) {
    return 'Échec du téléchargement : $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String get chatMusicLinkLabel => 'Lien musical';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Les enveloppes rouges et les transferts ne peuvent pas être transférés';

  @override
  String commonShareFailed(String error) {
    return 'Échec du partage : $error';
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
  String groupMemberCountClickToCopy(Object count) {
    return '$count membres, cliquez pour copier l\'ID du groupe';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Vous n\'avez pas la permission de modifier le nom du groupe';

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
  String get settingsTranslation => 'Traduction';

  @override
  String get settingsTranslateTextTo => 'Traduire le texte en';

  @override
  String get settingsTranslateDescription =>
      'Sélectionnez la langue dans laquelle vous souhaitez que les messages soient traduits.';

  @override
  String get settingsAutoTranslate =>
      'Traduire automatiquement les messages reçus';

  @override
  String get settingsAutoTranslateDescription =>
      'Traduisez automatiquement les messages reçus dans le chat dans la langue sélectionnée.';

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
  String get authPasskeyLabel => 'Clé d\'accès';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Pomme';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Ce serveur n\'a pas configuré de fournisseurs de connexion SSO';

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
  String get contactCreateTag => 'Créer une balise';

  @override
  String get contactEnterTagName => 'Entrez le nom de la balise';

  @override
  String get contactEditTag => 'Modifier la balise';

  @override
  String get contactDeleteTag => 'Supprimer la balise';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Etes-vous sûr de vouloir supprimer la balise « $tagName » ?';
  }

  @override
  String get contactNoTags => 'Pas encore de balises';

  @override
  String get contactFriendPermissions => 'Autorisations des amis';

  @override
  String get contactSetChatOnly => 'Définir comme chat uniquement';

  @override
  String get contactChatOnlyDesc =>
      'Je ne peux discuter qu\'avec vous, les autres contenus seront masqués';

  @override
  String get contactHideMyMoments => 'Cacher mes moments';

  @override
  String get contactHideMyMomentsDesc => 'Cet ami ne peut pas voir mes Moments';

  @override
  String get contactHideTheirMoments => 'Cacher leurs moments';

  @override
  String get contactHideTheirMomentsDesc =>
      'Je ne vois pas les moments de cet ami';

  @override
  String get contactHideMyStatus => 'Masquer mon statut';

  @override
  String get contactHideMyStatusDesc =>
      'Cet ami ne peut pas voir les mises à jour de mon statut';

  @override
  String get contactNoChatOnlyFriends => 'Pas d\'amis qui discutent uniquement';

  @override
  String get contactNoOfficialAccounts => 'Pas de comptes officiels';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Suivez les comptes officiels pour obtenir les dernières mises à jour';

  @override
  String get contactNoServiceAccounts => 'Aucun compte de service';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Abonnez-vous à des comptes de service pour bénéficier de services pratiques';

  @override
  String get contactNoEnterpriseContacts => 'Aucun contact d\'entreprise';

  @override
  String get contactEnterpriseContactsDesc =>
      'Les contacts d\'entreprise seront affichés ici';

  @override
  String get profileCardPack => 'Paquet de cartes';

  @override
  String get profileOrders => 'Commandes';

  @override
  String get profileNoOrders => 'Aucune commande';

  @override
  String get profileOrdersDesc => 'Vos commandes seront affichées ici';

  @override
  String get profileNoCards => 'Pas de cartes';

  @override
  String get profileCardsDesc => 'Vos cartes seront affichées ici';

  @override
  String get favoriteEnterTagsHint =>
      'Entrez les balises séparées par des virgules';

  @override
  String get favoriteTagsUpdated => 'Balises mises à jour';

  @override
  String get favoriteForwardedContent => 'Contenu transféré';

  @override
  String get favoriteEnterNoteContent => 'Saisir le contenu de la note';

  @override
  String get favoriteNoteAdded => 'Remarque ajoutée';

  @override
  String get favoriteLinkTitle => 'Titre du lien';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Lien ajouté';

  @override
  String get contactPhotoAdded => 'Photo ajoutée';

  @override
  String get contactEnterPhone => 'Entrez le numéro de téléphone';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Conversation : $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Contact : $userId';
  }

  @override
  String get commonDiscover => 'Decouvrir';

  @override
  String commonDeveloping(Object title) {
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
  String get commonVibration => 'Vibrations';

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
  String get settingsFontSizeStandard => 'Norme';

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
  String get groupVisibilityUpdated => 'Visibilité du groupe mise à jour';

  @override
  String get groupChannelCreated => 'Chaîne créée';

  @override
  String get groupChannelUpdated => 'Chaîne mise à jour';

  @override
  String get groupChannelDeleted => 'Chaîne supprimée';

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
  String callJoinMeetingFailed(Object error) {
    return 'Echec de la participation a la reunion : $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Echec du partage d\'ecran : $error';
  }

  @override
  String get profileN42BeanTitle => 'Haricot N42';

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
  String profilePlayFailed(Object ringtoneName) {
    return 'Echec de la lecture : $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
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
    return 'Messages ($count)';
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
  String commonReadCount(Object count) {
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

  @override
  String get securityDeviceIdRequired => 'L\'ID de l\'appareil est requis';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Échec du démarrage de la vérification : $error';
  }

  @override
  String get securityVerificationFailed => 'La vérification a échoué';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Échec de la vérification : $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Vérification rejetée : les emoji ne correspondent pas';

  @override
  String get securityWaitingForDeviceAccept =>
      'En attendant que l\'autre appareil accepte...';

  @override
  String get securityVerifyDevice => 'Vérifier cet appareil';

  @override
  String get securityConfirmEmojiMatch =>
      'Confirmez que les emoji ci-dessous sont affichés sur les deux appareils, dans le même ordre';

  @override
  String get securityEmojiDontMatch => 'Ils ne correspondent pas';

  @override
  String get securityEmojiMatch => 'Ils correspondent';

  @override
  String get securityWaitingForDeviceConfirm =>
      'En attendant que l\'autre appareil confirme...';

  @override
  String get securityVerificationSuccess => 'Vérification réussie !';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Cet appareil est désormais vérifié et fiable.';

  @override
  String get securityCompareEmoji =>
      'Comparez les emoji sur les deux appareils';

  @override
  String get securityCompareNumbers =>
      'Comparez les chiffres sur les deux appareils';

  @override
  String get commonTryAgain => 'Réessayez';

  @override
  String get commonDone => 'Terminé';

  @override
  String get chatExportTitle => 'Exporter la discussion';

  @override
  String get chatExportSuccess => 'Exportation réussie';

  @override
  String chatExportFailed(String error) {
    return 'Échec de l\'exportation : $error';
  }

  @override
  String get chatExportFormat => 'Format d\'exportation';

  @override
  String get chatExportHtmlDesc =>
      'Lisible dans n\'importe quel navigateur avec une mise en page stylisée';

  @override
  String get chatExportJsonDesc =>
      'Format de données structurées lisible par machine';

  @override
  String get chatExportDateRange => 'Plage de dates';

  @override
  String get chatExportAll => 'Tous les messages';

  @override
  String get chatExportLastWeek => '7 derniers jours';

  @override
  String get chatExportLastMonth => 'Le mois dernier';

  @override
  String get chatExportLast3Months => '3 derniers mois';

  @override
  String get chatExportMessageCount => 'Messages à exporter';

  @override
  String get chatExportButton => 'Exporter et partager';

  @override
  String get chatMediaGallery => 'Galerie Média';

  @override
  String get chatExportHistory => 'Exporter l\'historique des discussions';

  @override
  String get pdfLoadFailed => 'Échec du chargement du PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'Tout';

  @override
  String get mediaImages => 'Images';

  @override
  String get mediaVideos => 'Vidéos';

  @override
  String get mediaFiles => 'Fichiers';

  @override
  String get mediaAudio => 'Audio';

  @override
  String mediaItemsCount(int count) {
    return 'Articles $count';
  }

  @override
  String get mediaNoMediaFound => 'Aucun média trouvé';

  @override
  String get spacesTitle => 'Communautés';

  @override
  String get spacesCreate => 'Créer une communauté';

  @override
  String get spacesJoined => 'Rejoint';

  @override
  String get spacesDiscover => 'Découvrez';

  @override
  String get spacesNoJoined => 'Aucune communauté rejointe pour l\'instant';

  @override
  String get spacesExplore => 'Explorez les communautés';

  @override
  String get spacesNoPublic => 'Aucune communauté publique trouvée';

  @override
  String get spacesJoin => 'Rejoindre';

  @override
  String get spacesSubSpaces => 'Sous-communautés';

  @override
  String get spacesChannels => 'Canaux';

  @override
  String spacesMembersCount(int count) {
    return 'Membres $count';
  }

  @override
  String get spacesPublic => 'Publique';

  @override
  String get spacesPrivate => 'Privé';

  @override
  String get spacesSuggested => 'Suggéré';

  @override
  String spacesChannelsCount(int count) {
    return 'Canaux $count';
  }

  @override
  String get callInCallChat => 'Chat en appel';

  @override
  String callMessagesCount(int count) {
    return 'Messages $count';
  }

  @override
  String get callNoMessagesYet =>
      'Aucun message pour l\'instant.\nEnvoyez un message pour commencer.';

  @override
  String get callTypeMessage => 'Tapez un message...';

  @override
  String get callYouSender => 'Vous';

  @override
  String get callChatLabel => 'Discuter';

  @override
  String get chatEdited => 'Modifié';

  @override
  String get chatEditHistory => 'Modifier l\'historique';

  @override
  String get chatOriginalMessage => 'Originale';

  @override
  String chatEditedAt(String time) {
    return 'Edité à $time';
  }

  @override
  String get chatViewOnce => 'Afficher une fois';

  @override
  String get chatViewOncePhoto => 'Voir une fois la photo';

  @override
  String get chatViewOnceVideo => 'Voir la vidéo une fois';

  @override
  String get chatViewOnceViewed => 'Vu';

  @override
  String get chatViewOnceExpired => 'Expiré';

  @override
  String get chatViewOnceTap => 'Appuyez pour voir';

  @override
  String get chatAutoFaceBlur => 'Flou automatique du visage';

  @override
  String get chatAutoFaceBlurDesc =>
      'Frouiller automatiquement les visages lors de l\'envoi de photos';

  @override
  String get threadReplyInThread => 'Répondre dans le fil de discussion';

  @override
  String threadReplies(int count) {
    return '$count répond';
  }

  @override
  String get threadReply => '1 réponse';

  @override
  String threadLatestReply(String preview) {
    return 'Dernier : $preview';
  }

  @override
  String get threadTitle => 'Sujet';

  @override
  String get threadReplyPlaceholder => 'Répondre dans le fil de discussion...';

  @override
  String threadParticipants(int count) {
    return 'participants $count';
  }

  @override
  String get voiceRoomTitle => 'Salle de voix';

  @override
  String get voiceRoomCreate => 'Créer une salle vocale';

  @override
  String get voiceRoomJoin => 'Rejoindre';

  @override
  String get voiceRoomLeave => 'Partir';

  @override
  String get voiceRoomEnd => 'Salle de fin';

  @override
  String get voiceRoomRaiseHand => 'Lever la main';

  @override
  String get voiceRoomLowerHand => 'Baisser la main';

  @override
  String get voiceRoomMute => 'Muet';

  @override
  String get voiceRoomUnmute => 'Activer le son';

  @override
  String get voiceRoomHost => 'Hôte';

  @override
  String get voiceRoomSpeakers => 'Haut-parleurs';

  @override
  String get voiceRoomListeners => 'Auditeurs';

  @override
  String get voiceRoomLive => 'EN DIRECT';

  @override
  String get voiceRoomEnded => 'Terminé';

  @override
  String get voiceRoomScheduled => 'Programmé';

  @override
  String get voiceRoomApprove => 'Approuver';

  @override
  String get voiceRoomDemote => 'Passer à l\'écouteur';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name a levé la main';
  }

  @override
  String get voiceRoomName => 'Nom de la pièce';

  @override
  String get voiceRoomTopic => 'Sujet (facultatif)';

  @override
  String get voiceRoomNoActive => 'Aucune salle vocale active';

  @override
  String get voiceRoomConnecting => 'Connexion...';

  @override
  String get usernameTitle => 'Nom d\'utilisateur';

  @override
  String get usernameSet => 'Définir le nom d\'utilisateur';

  @override
  String get usernameChange => 'Changer le nom d\'utilisateur';

  @override
  String get usernamePlaceholder => 'Entrez le nom d\'utilisateur';

  @override
  String get usernameAvailable => 'Nom d\'utilisateur disponible';

  @override
  String get usernameUnavailable => 'Nom d\'utilisateur déjà pris';

  @override
  String get usernameInvalid =>
      '3 à 30 caractères, lettres minuscules, chiffres, trait de soulignement. Doit commencer par une lettre.';

  @override
  String get usernameReserved => 'Ce nom d\'utilisateur est réservé';

  @override
  String get usernameSaved => 'Nom d\'utilisateur enregistré';

  @override
  String get usernameSearchHint => 'Rechercher par @nom d\'utilisateur';

  @override
  String get ensName => 'Nom de l\'ENS';

  @override
  String get ensLinked => 'Lié à l\'ENS';

  @override
  String get ensResolving => 'Résolution de l\'ENS...';

  @override
  String get ensNotFound => 'Nom ENS introuvable';

  @override
  String get tokenGateTitle => 'Porte des jetons';

  @override
  String get tokenGateEnable => 'Activer la porte de jetons';

  @override
  String get tokenGateDisable => 'Désactiver la porte de jetons';

  @override
  String get tokenGateAddRule => 'Ajouter une règle';

  @override
  String get tokenGateRemoveRule => 'Supprimer la règle';

  @override
  String get tokenGateContractAddress => 'Adresse du contrat';

  @override
  String get tokenGateMinBalance => 'Solde minimum';

  @override
  String get tokenGateTokenId => 'ID de jeton (ERC-1155)';

  @override
  String get tokenGateChainId => 'ID de chaîne';

  @override
  String get tokenGateVerifying => 'Vérification des avoirs en jetons...';

  @override
  String get tokenGateVerified => 'Vérification réussie';

  @override
  String get tokenGateDenied =>
      'Vous ne remplissez pas les exigences en matière de jetons';

  @override
  String get tokenGateOperatorAnd => 'Doit respecter TOUTES les règles';

  @override
  String get tokenGateOperatorOr => 'Doit respecter TOUTE règle';

  @override
  String get tokenGateRuleErc20 => 'Jeton ERC-20';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Multi-jeton (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Jeton natif';

  @override
  String get tokenGateSaved => 'Porte à jetons enregistrée';

  @override
  String get tokenGateEnableDescription =>
      'Exiger que les membres détiennent des jetons pour adhérer';

  @override
  String get tokenGateOperator => 'Logique des règles';

  @override
  String get tokenGateRules => 'Règles';

  @override
  String get tokenGateSymbol => 'Symbole (facultatif)';

  @override
  String get tokenGateChain => 'Chaîne';

  @override
  String get tokenGateTokenStandard => 'Norme de jeton';

  @override
  String get tokenGateDenialMessage => 'Message de refus';

  @override
  String get tokenGateDenialMessageHint =>
      'Message affiché lorsque la vérification échoue';

  @override
  String get tokenGateVerifyTitle => 'Vérification des jetons';

  @override
  String get tokenGateVerifyPassed => 'Vérification réussie';

  @override
  String get tokenGateVerifyFailed => 'Échec de la vérification';

  @override
  String get tokenGateRetryVerify => 'Réessayer';

  @override
  String get tokenGateRequired => 'Obligatoire';

  @override
  String get tokenGateYourBalance => 'Votre solde';

  @override
  String get tokenGateRulesActive => 'règles actives';

  @override
  String get tokenGateDisabled => 'Désactivé';

  @override
  String get ensNotBound => 'Non lié';

  @override
  String get liveLocation => 'Localisation en direct';

  @override
  String get stopLiveLocation => 'Arrêter de partager';

  @override
  String get startLiveLocation => 'Commencer le partage';

  @override
  String get selectDuration => 'Sélectionnez la durée';

  @override
  String get groupChatFiles => 'Fichiers de discussion';

  @override
  String get groupLinks => 'Liens';

  @override
  String get groupNoLinks => 'Pas encore de liens';

  @override
  String get chatBackground => 'Fond de discussion';

  @override
  String get solidColors => 'Couleurs unies';

  @override
  String get gradients => 'Dégradés';

  @override
  String get defaultBackground => 'Par défaut';

  @override
  String get settingsFontSizeSlider => 'Taille de la police';

  @override
  String get autoDownload => 'Téléchargement automatique';

  @override
  String get images => 'Images';

  @override
  String get voice => 'Voix';

  @override
  String get video => 'Vidéo';

  @override
  String get files => 'Fichiers';

  @override
  String get mobileData => 'Données mobiles';

  @override
  String get roaming => 'Itinérance';

  @override
  String get storageManagement => 'Stockage';

  @override
  String get totalUsage => 'Utilisation totale';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Autre';

  @override
  String get clearCache => 'Vider le cache';

  @override
  String get cacheCleared => 'Cache vidé';

  @override
  String get clearCacheFailed => 'Échec de la suppression du cache';

  @override
  String get confirmClearCache => 'Effacer toutes les données du cache ?';

  @override
  String get mapView => 'Vue cartographique';

  @override
  String liveLocationSharingCount(int count) {
    return '$count personnes partageant leur position';
  }

  @override
  String get minutes15 => '15 minutes';

  @override
  String get minutes30 => '30 minutes';

  @override
  String get hour1 => '1 heure';

  @override
  String get hours8 => '8 heures';

  @override
  String get personalCard => 'Carte personnelle';

  @override
  String get downloadFailed => 'Le téléchargement a échoué';

  @override
  String get locationExpired => 'Expiré';

  @override
  String secondsRemaining(int count) {
    return '$count secondes';
  }

  @override
  String minutesRemaining(int count) {
    return '${count}minutes';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours heures $minutes minutes';
  }

  @override
  String get favoriteMessages => 'Favoris';

  @override
  String get linksCopied => 'Lien copié';

  @override
  String get noLinksFound => 'Aucun lien trouvé';

  @override
  String get roomStorageRanking => 'Classement du stockage des pièces';

  @override
  String get downloadComplete => 'Téléchargement terminé';

  @override
  String get downloading => 'Téléchargement...';

  @override
  String get draftSaved => 'Brouillon enregistré';

  @override
  String get voiceRecording => 'Enregistrement vocal';

  @override
  String get searchLocation => 'Rechercher un emplacement';

  @override
  String get tapToSearch => 'Appuyez pour rechercher';

  @override
  String get settingsThisDevice => 'Cet appareil';

  @override
  String get settingsJustNow => 'Juste maintenant';

  @override
  String get settingsDeviceId => 'ID de l\'appareil';

  @override
  String get settingsStatus => 'Statut';

  @override
  String get settingsLastActive => 'Dernier actif';

  @override
  String get settingsIpAddress => 'Adresse IP';

  @override
  String get settingsRenameDevice => 'Renommer l\'appareil';

  @override
  String get settingsDeviceNameHint => 'Entrez le nom de l\'appareil';

  @override
  String get settingsDeviceRenamed => 'Appareil renommé';

  @override
  String get settingsRenameFailed => 'Échec du changement de nom';

  @override
  String get settingsRemoteLogout => 'Déconnexion à distance';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Etes-vous sûr de vouloir vous déconnecter de « $deviceName » ? Cette action ne peut pas être annulée.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Appareil déconnecté';

  @override
  String get settingsLogoutFailed => 'Échec de la déconnexion';

  @override
  String get settingsLogout => 'Déconnexion';

  @override
  String get settingsVerifyIdentity => 'Vérifier l\'identité';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Entrez votre mot de passe pour confirmer cette action.';

  @override
  String get scheduledSendTitle => 'Message de planification';

  @override
  String get scheduledSendInOneHour => 'Dans 1 heure';

  @override
  String get scheduledSendTonight => 'Ce soir (20h00)';

  @override
  String get scheduledSendTomorrowMorning => 'Demain matin (9h00)';

  @override
  String get scheduledSendCustom => 'Choisissez une date et une heure';

  @override
  String get scheduledMessageLabel => 'Programmé';

  @override
  String get scheduledMessageCancel => 'Annuler le message programmé';

  @override
  String get chatLockTitle => 'Verrouillage du chat';

  @override
  String get chatLockEnable => 'Verrouillez ce chat';

  @override
  String get chatLockDisable => 'Débloquez ce chat';

  @override
  String get chatLockDescription =>
      'Les discussions verrouillées nécessitent une vérification biométrique ou PIN pour s\'ouvrir';

  @override
  String get chatLockVerifyTitle => 'Chat verrouillé';

  @override
  String get chatLockVerifySubtitle => 'Vérifiez pour accéder à ce chat';

  @override
  String get chatLockVerifyFailed => 'La vérification a échoué';

  @override
  String get chatLockEnabled => 'Chat verrouillé';

  @override
  String get chatLockDisabled => 'Chat débloqué';

  @override
  String get chatLockPinTitle => 'Entrez le code PIN';

  @override
  String get chatLockPinSetTitle => 'Définir le code PIN';

  @override
  String get chatLockPinConfirmTitle => 'Confirmer le code PIN';

  @override
  String get chatLockPinMismatch => 'Le code PIN ne correspond pas';

  @override
  String get chatLockUseBiometric => 'Utiliser la biométrie';

  @override
  String get chatLockUsePin => 'Utiliser le code PIN';

  @override
  String get mediaEditorUndo => 'Annuler';

  @override
  String get mediaEditorRedo => 'Refaire';

  @override
  String get mediaEditorCrop => 'Recadrer';

  @override
  String get mediaEditorFilter => 'Filtrer';

  @override
  String get mediaEditorDraw => 'Dessiner';

  @override
  String get mediaEditorText => 'Texte';

  @override
  String get aiAssistant => 'Assistant IA';

  @override
  String get aiAssistantWelcome =>
      'Bonjour ! Je suis l\'assistant IA du N42. Comment puis-je t\'aider?';

  @override
  String get aiAssistantNotConfigured => 'Service IA non configuré';

  @override
  String get aiAssistantSettings => 'Paramètres IA';

  @override
  String get aiAssistantClearHistory => 'Effacer l\'historique des discussions';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Êtes-vous sûr de vouloir effacer tout l\'historique des discussions IA ?';

  @override
  String get aiAssistantStopGenerating => 'Arrêter de générer';

  @override
  String get aiAssistantModel => 'Modèle';

  @override
  String get aiAssistantTemperature => 'Température';

  @override
  String get aiAssistantMaxTokens => 'Nombre maximum de jetons';

  @override
  String get aiAssistantContextWindow => 'Fenêtre contextuelle';

  @override
  String get aiAssistantServiceStatus => 'Statut des services';

  @override
  String get aiAssistantAvailable => 'Disponible';

  @override
  String get aiAssistantUnavailable => 'Indisponible';

  @override
  String get aiSummarize => 'Résumé de l\'IA';

  @override
  String aiSummarizeUnread(int count) {
    return 'Résumer les messages non lus $count';
  }

  @override
  String get aiSummarizeLoading => 'En résumé...';

  @override
  String get aiSummarizeError => 'Impossible de résumer';

  @override
  String get aiRewrite => 'Réécriture de l\'IA';

  @override
  String get aiRewriteFormal => 'Formel';

  @override
  String get aiRewriteCasual => 'Décontracté';

  @override
  String get aiRewritePlayful => 'Ludique';

  @override
  String get aiRewriteProfessional => 'Professionnel';

  @override
  String get aiRewriteAccept => 'Utiliser';

  @override
  String get aiRewriteCancel => 'Annuler';

  @override
  String get aiRewriteLoading => 'Réécriture...';

  @override
  String get aiLinkSummary => 'Résumé de l\'IA';

  @override
  String get aiLinkSummaryAnalyzing => 'Analyser...';

  @override
  String get chatFolderManagement => 'Gérer les dossiers';

  @override
  String get chatFolderSystem => 'Dossiers système';

  @override
  String get chatFolderCustom => 'Dossiers personnalisés';

  @override
  String get chatFolderEmpty => 'Aucun dossier personnalisé pour l\'instant';

  @override
  String get chatFolderCreate => 'Créer un dossier';

  @override
  String get chatFolderEdit => 'Modifier le dossier';

  @override
  String get chatFolderNameHint => 'Nom du dossier';

  @override
  String get chatFolderAll => 'Tout';

  @override
  String get chatFolderUnread => 'Non lu';

  @override
  String get chatFolderPersonal => 'Personnel';

  @override
  String get chatFolderGroups => 'Groupes';

  @override
  String get chatFolderChannels => 'Canaux';

  @override
  String get chatFolderMuted => 'En sourdine';

  @override
  String get storyAddMusic => 'Ajouter de la musique';

  @override
  String get storyChangeMusic => 'Changer de musique';

  @override
  String get storyBackgroundMusic => 'Musique de fond';

  @override
  String get storyMusicPreview => 'Aperçu (max 15 s)';

  @override
  String get storyChooseFromDevice => 'Choisissez parmi l\'appareil';

  @override
  String get storyUseThisMusic => 'Utilisez cette musique';

  @override
  String get authPasskeyNotSupported =>
      'Le mot de passe n\'est pas pris en charge sur cet appareil';

  @override
  String get authPasskeyRegister => 'Enregistrer le mot de passe';

  @override
  String get authPasskeyNoRegistered => 'Aucun mot de passe enregistré';

  @override
  String get authPasskeyRegisterHint =>
      'Enregistrez un mot de passe pour ce compte. La connexion par mot de passe autonome sera activée ultérieurement.';

  @override
  String get authPasskeyNameYours => 'Nommez votre mot de passe';

  @override
  String get authPasskeyRegistered => 'Mot de passe enregistré sur ce compte';

  @override
  String get authPasskeyDeleted => 'Clé d\'accès supprimée de ce compte';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Supprimer le mot de passe « $name » ? Vous devrez l\'enregistrer à nouveau avant d\'utiliser la connexion par mot de passe ultérieurement.';
  }

  @override
  String get momentVisibilityPublic => 'Publique';

  @override
  String get momentVisibilityPrivate => 'Privé';

  @override
  String get momentVisibilityPartial => 'Amis sélectionnés';

  @override
  String get momentVisibilityExcluded => 'Exclure certains amis';

  @override
  String momentUserMoments(String userName) {
    return 'Les moments de $userName';
  }

  @override
  String get momentForwardTo => 'Envoyer à';

  @override
  String get momentForwardSuccess => 'Transféré avec succès';

  @override
  String get momentSelectFriends => 'Sélectionnez des amis';

  @override
  String get momentSelectTags => 'Sélectionner par balises';

  @override
  String momentSelectedCount(int count) {
    return 'Sélectionné ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Pas encore de moments';

  @override
  String get momentForwardMoment => 'Moment en avant';

  @override
  String get momentAddComment => 'Ajouter un commentaire...';

  @override
  String momentForwardContent(String content) {
    return '[Moment] $content';
  }

  @override
  String get momentDeleteMoment => 'Supprimer le moment';

  @override
  String get momentDeleteConfirm =>
      'Êtes-vous sûr de vouloir supprimer ce moment ?';

  @override
  String get momentComment => 'Commentaire';

  @override
  String get momentWriteComment => 'Écrivez un commentaire...';

  @override
  String get momentLike => 'Comme';

  @override
  String get momentUnlike => 'Contrairement à';

  @override
  String get momentForward => 'En avant';

  @override
  String get momentDelete => 'Supprimer';

  @override
  String get momentReply => 'répondre';

  @override
  String get momentMoment => 'Instant';

  @override
  String momentLikesCount(int count) {
    return '$count aime';
  }

  @override
  String momentCommentsCount(int count) {
    return 'Commentaires sur $count';
  }

  @override
  String get momentNoComments => 'Pas encore de commentaires';

  @override
  String get momentFailedToLoad => 'Échec du chargement de l\'image';

  @override
  String momentReplyTo(String userName) {
    return 'Répondre à $userName...';
  }

  @override
  String get momentNoConversations => 'Aucune conversation';

  @override
  String get momentJustNow => 'juste maintenant';

  @override
  String momentMinutesAgo(int count) {
    return 'Il y a ${count}m';
  }

  @override
  String momentHoursAgo(int count) {
    return 'Il y a ${count}h';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}j il y a';
  }

  @override
  String get chatGroupAnnouncementHint => 'Entrez l\'annonce du groupe';

  @override
  String get chatGroupAnnouncementEmpty => 'Aucune annonce';

  @override
  String get chatEditNickname => 'Modifier le pseudo';

  @override
  String get chatNicknameHint => 'Entrez votre pseudo dans ce groupe';

  @override
  String get contactAddPhoneHint => 'Entrez le numéro de téléphone';

  @override
  String get contactNotesHint => 'Ajouter des notes sur ce contact';

  @override
  String get reportTitle => 'Rapport';

  @override
  String get reportReasonSpam => 'Pourriel';

  @override
  String get reportReasonHarassment => 'Harcèlement';

  @override
  String get reportReasonFraud => 'Fraude';

  @override
  String get reportReasonOther => 'Autre';

  @override
  String get reportSubmitted => 'Rapport soumis';

  @override
  String get reportDescription => 'Description supplémentaire (facultatif)';

  @override
  String get qrcodeSaved => 'Code QR enregistré dans l\'album';

  @override
  String get chatSendRedPacketInChat =>
      'Veuillez envoyer un paquet rouge dans le chat';

  @override
  String get commonSaveFailed => 'Échec de l\'enregistrement';

  @override
  String get reportSelectReason => 'Veuillez sélectionner une raison';

  @override
  String get reportUnavailable => 'Connectez-vous pour envoyer un signalement.';

  @override
  String get reportAccountChanged =>
      'Le compte a changé. Rouvrez ce signalement pour l’envoyer.';

  @override
  String get reportUnsupported =>
      'Ce serveur d’accueil ne prend pas en charge les signalements d’utilisateurs.';

  @override
  String get reportRoomUnsupported =>
      'Ce serveur d’accueil ne prend pas en charge les signalements de salons.';

  @override
  String get reportRateLimited =>
      'Trop de signalements. Veuillez réessayer plus tard.';

  @override
  String get reportCouldNotSend =>
      'Impossible d’envoyer le signalement. Veuillez réessayer.';

  @override
  String get gameCenter => 'Jeux';

  @override
  String get gameHighScore => 'Meilleur';

  @override
  String get gameScore => 'Score';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String get gamePlayAgain => 'Rejouer';

  @override
  String get gameLeaderboard => 'Classement';

  @override
  String get gamePause => 'En pause';

  @override
  String get gameResume => 'Appuyez pour reprendre';

  @override
  String get gameConfirmExit => 'Quitter le jeu ?';

  @override
  String get gameNoScores => 'Aucun score';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Fusionnez les tuiles jusqu\'à 2048';

  @override
  String get gameBlockDrop => 'Bloquer la chute';

  @override
  String get gameBlockDropDesc => 'Faites tomber et éliminez les lignes';

  @override
  String get gameMinesweeper => 'Démineur';

  @override
  String get gameMinesweeperDesc => 'Trouvez toutes les cases sûres';

  @override
  String get gameMatch3 => 'Aligner 3';

  @override
  String get gameMatch3Desc => 'Alignez 3 gemmes ou plus';

  @override
  String get gameMinesweeperEasy => 'Facile';

  @override
  String get gameMinesweeperMedium => 'Moyen';

  @override
  String get gameMinesLeft => 'Mines restantes';

  @override
  String get gameTimeLeft => 'Temps';

  @override
  String get gameLevel => 'Niveau';

  @override
  String get gameNext => 'Suivant';

  @override
  String get gameBestTime => 'Meilleur temps';

  @override
  String get gameNewRecord => 'Nouveau record !';

  @override
  String get gameLines => 'Lignes';

  @override
  String get storyMyStory => 'Mon histoire';

  @override
  String get storageSmartCleanup => 'Nettoyage intelligent';

  @override
  String get storageOldMediaFiles => 'Anciens fichiers multimédias';

  @override
  String get storageLargeFiles => 'Fichiers volumineux';

  @override
  String get storageAppCache => 'Cache d\'application';

  @override
  String get storageSettings => 'Paramètres de stockage';

  @override
  String get storageAutoCleanup => 'Nettoyage automatique';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Nettoyer automatiquement les fichiers datant de plus de jours $days';
  }

  @override
  String get storageCleanupPeriod => 'Période de nettoyage';

  @override
  String get storagePreserveThumbnails => 'Conserver les vignettes';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Conserver les vignettes des images pendant le nettoyage';

  @override
  String get storageWarningHigh =>
      'L\'utilisation du stockage est élevée. Pensez à nettoyer les anciens fichiers.';

  @override
  String get storageWarningCritical =>
      'Le stockage est extrêmement faible. Veuillez nettoyer pour libérer de l\'espace.';

  @override
  String storageFreed(String size, int count) {
    return '$size libéré (fichiers $count)';
  }

  @override
  String storageDays(int days) {
    return '$days jours';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Voir toutes les chambres $count';
  }

  @override
  String get storageNoFiles => 'Aucun fichier trouvé';

  @override
  String get storageFilePinned => 'Épinglé';

  @override
  String storageDeleteSelected(int count) {
    return 'Supprimer les fichiers sélectionnés $count ? Ils peuvent être retéléchargés depuis le serveur.';
  }

  @override
  String get backupRestore => 'Sauvegarde et restauration';

  @override
  String get backupCreate => 'Créer une sauvegarde';

  @override
  String get backupCreateDesc =>
      'Sauvegardez vos paramètres et vos clés de cryptage. Les messages seront restaurés à partir du serveur après la reconnexion.';

  @override
  String get backupIncludeKeys => 'Inclure les clés de chiffrement';

  @override
  String get backupIncludeKeysDesc =>
      'Nécessaire pour lire les messages cryptés';

  @override
  String get backupPasswordProtect => 'Protéger par mot de passe';

  @override
  String get backupEnterPassword => 'Entrez le mot de passe de sauvegarde';

  @override
  String get backupHistory => 'Historique de sauvegarde';

  @override
  String get backupNoBackups => 'Aucune sauvegarde pour le moment';

  @override
  String get backupRestore2 => 'Restaurer';

  @override
  String get backupDelete => 'Supprimer';

  @override
  String get backupDeleteConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette sauvegarde ? Cela ne peut pas être annulé.';

  @override
  String get backupRestoreFromFile => 'Restaurer à partir d\'un fichier';

  @override
  String get backupRestoreFromFileDesc =>
      'Importez un fichier de sauvegarde .n42 à partir d\'un autre appareil ou d\'une sauvegarde précédente.';

  @override
  String get backupChooseFile => 'Choisissez le fichier de sauvegarde';

  @override
  String get backupRestoring => 'Restauration...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Sauvegarde créée : salles $rooms, messages $messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Paramètres $settings restaurés à partir des pièces $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Échec de la sauvegarde : $error';
  }

  @override
  String get backupPasswordRequired =>
      'Cette sauvegarde est protégée par mot de passe';

  @override
  String get blocGroupNotFound => 'Groupe introuvable';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Membres $count invités';
  }

  @override
  String get blocGroupMemberRemoved => 'Membre supprimé';

  @override
  String get blocGroupAdminRemoved => 'Administrateur supprimé';

  @override
  String get blocGroupLeft => 'A quitté le groupe';

  @override
  String get blocGroupDisbanded => 'Groupe dissous';

  @override
  String get blocGroupJoined => 'A rejoint le groupe';

  @override
  String get blocGroupInviteDeclined => 'Invitation refusée';

  @override
  String get blocGroupTokenGateUpdated => 'Porte de jeton mise à jour';

  @override
  String get blocTransferProcessing => 'Transfert en cours...';

  @override
  String get blocTransferCancelled => 'Transfert annulé';

  @override
  String get blocTransferFailed => 'Le transfert a échoué';

  @override
  String get blocPaymentProcessing => 'Traitement du paiement...';

  @override
  String get blocPaymentFailed => 'Échec du paiement';

  @override
  String get groupMaxMembers => 'Limite de membres';

  @override
  String get groupMaxMembersUnlimited => 'Illimité';

  @override
  String get groupMaxMembersHint =>
      'Entrez la limite (laissez vide pour illimité)';

  @override
  String get groupMaxMembersUpdated => 'Limite de membres mise à jour';

  @override
  String get groupFull => 'Le groupe est à pleine capacité';

  @override
  String get groupChannels => 'Chaînes thématiques';

  @override
  String get groupChannelsEmpty => 'Aucune chaîne pour l\'instant';

  @override
  String get groupChannelsCount => 'chaînes';

  @override
  String get groupChannelCreate => 'Nouvelle chaîne';

  @override
  String get groupChannelName => 'Nom de la chaîne';

  @override
  String get groupChannelTopic => 'Sujet de la chaîne (facultatif)';

  @override
  String get groupChannelDelete => 'Supprimer la chaîne';

  @override
  String get groupChannelDeleteConfirm =>
      'Supprimer cette chaîne ? Tous les messages seront perdus.';

  @override
  String get groupBotSettings => 'Paramètres du robot';

  @override
  String get groupBotEnabled => 'Activer le robot';

  @override
  String get groupBotWelcomeMessage => 'Modèle de message de bienvenue';

  @override
  String get groupBotWelcomeHint =>
      'Utilisez « nom » comme espace réservé pour le nom du nouveau membre';

  @override
  String get groupBotConfigUpdated => 'Paramètres du robot mis à jour';

  @override
  String get groupContentFilter => 'Filtre de contenu';

  @override
  String get groupContentFilterEnabled => 'Activer le filtre par mots clés';

  @override
  String get groupContentFilterReplace => 'Remplacer par ***';

  @override
  String get groupContentFilterHide => 'Masquer le message';

  @override
  String get groupContentFilterAddWord => 'Ajouter un mot clé';

  @override
  String get groupContentFilterUpdated => 'Filtre de contenu mis à jour';

  @override
  String get chatSlashCommands => 'Commandes';

  @override
  String get chatCommandPoll => '/poll — Créer un sondage';

  @override
  String get chatCommandAnnounce => '/announce — Envoyer une annonce';

  @override
  String get chatCommandWelcome => '/welcome — Définir un message de bienvenue';

  @override
  String get chatReportMessage => 'Rapport';

  @override
  String get chatReportReason => 'Raison du rapport';

  @override
  String get chatReportSpam => 'Pourriel';

  @override
  String get chatReportHarassment => 'Harcèlement';

  @override
  String get chatReportInappropriate => 'Contenu inapproprié';

  @override
  String get chatReportOther => 'Autre';

  @override
  String get chatReportSuccess => 'Rapport soumis';

  @override
  String get spacesName => 'Nom de la communauté';

  @override
  String get spacesNameHint => 'par ex. Commerçants de crypto';

  @override
  String get spacesNameRequired => 'Le nom est requis';

  @override
  String get spacesDescription => 'Descriptif';

  @override
  String get spacesDescriptionHint => 'De quoi parle cette communauté ?';

  @override
  String get spacesType => 'Type de communauté';

  @override
  String get spacesPublicDesc => 'Tout le monde peut découvrir et rejoindre';

  @override
  String get spacesPrivateDesc => 'Seuls les membres invités peuvent rejoindre';

  @override
  String get spacesNotFound => 'Communauté introuvable';

  @override
  String get spacesSearch => 'Rechercher des communautés...';

  @override
  String get spacesMembers => 'Membres';

  @override
  String get spacesNoChannels => 'Aucune chaîne pour l\'instant';

  @override
  String get spacesLeave => 'Quitter la communauté';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Etes-vous sûr de vouloir quitter « $name » ?';
  }

  @override
  String get spacesDelete => 'Supprimer la communauté';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Cela supprimera définitivement « $name » et toutes ses chaînes. Cette action ne peut pas être annulée.';
  }

  @override
  String get spacesCreateChannel => 'Ajouter une chaîne';

  @override
  String get spacesChannelName => 'Nom de la chaîne';

  @override
  String get spacesChannelTopic => 'Sujet (facultatif)';

  @override
  String get spacesDeleteChannel => 'Supprimer la chaîne';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Êtes-vous sûr de vouloir supprimer « #$name » ?';
  }

  @override
  String get spacesEditName => 'Modifier le nom';

  @override
  String get spacesEditDescription => 'Modifier la description';

  @override
  String spacesViewAllMembers(int count) {
    return 'Voir tous les membres de $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Coup de pied $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Interdire $name';
  }

  @override
  String get spacesPromoteAdmin => 'Promouvoir au rang d\'administrateur';

  @override
  String get spacesDemoteAdmin => 'Supprimer l\'administrateur';

  @override
  String get spacesInviteMember => 'Inviter un membre';

  @override
  String get spacesInviteMemberUserId =>
      'ID utilisateur (par exemple @user:server.com)';

  @override
  String get spacesSave => 'Enregistrer';

  @override
  String get settingsScreenshotProtection =>
      'Protection contre les captures d\'écran';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Empêcher les captures d\'écran et l\'enregistrement d\'écran';

  @override
  String get chatSelfDestructTimer => 'Autodestruction';

  @override
  String get chatTimerPickerTitle => 'Minuterie d\'autodestruction';

  @override
  String get chatTimerOff => 'Désactivé';

  @override
  String get onChainNotificationsTitle => 'Événements on-chain';

  @override
  String get onChainMarkAllRead => 'Tout marquer comme lu';

  @override
  String get onChainNoNotifications => 'Pas encore d\'événements on-chain';

  @override
  String get onChainNoNotificationsDesc =>
      'Les événements des canaux abonnés apparaîtront ici';

  @override
  String get onChainViewDetails => 'Voir les détails';

  @override
  String get chatCommandHelp => '/help — Voir toutes les commandes';

  @override
  String get chatCommandPrice => '/price — Obtenir le prix du token';

  @override
  String get chatCommandBalance => '/balance — Voir le solde du portefeuille';

  @override
  String get chatCommandChains => '/chains — Lister 236+ réseaux supportés';

  @override
  String get chatMiniApps => 'Applications';

  @override
  String get miniAppMarketTitle => 'Mini-applications';

  @override
  String get miniAppCategoryAll => 'Tout';

  @override
  String get miniAppSearch => 'Rechercher des apps...';

  @override
  String get miniAppFeatured => 'À la une';

  @override
  String get miniAppAllApps => 'Toutes les Apps';

  @override
  String get miniAppNoResults => 'Aucune app trouvée';

  @override
  String get slideToPayLabel => '→→→  Glissez pour confirmer';

  @override
  String get slideToPayConfirming => 'Confirmation...';

  @override
  String get redPacketBestLuck => 'Meilleure chance';

  @override
  String get redPacketBestLuckCongrats =>
      'Meilleure chance ! Vous avez obtenu le plus !';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total réclamés';
  }

  @override
  String get redPacketStatsTotal => 'total';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 A reçu une enveloppe rouge • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  adresse 0x  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'Rechercher par ID, wallet ou ENS...';

  @override
  String get web3WalletAddress => 'Adresse du wallet';

  @override
  String get web3AddressCopied => 'Adresse copiée';

  @override
  String get web3Copy => 'Copier';

  @override
  String get web3SendMessage => 'Envoyer un message';

  @override
  String get web3SendToWallet => 'Message au wallet';

  @override
  String get web3WalletOnlyHint =>
      'Cette adresse n\'a pas de compte N42. Le message sera livré quand il rejoindra.';

  @override
  String get web3NftAvatar => 'Avatar NFT';

  @override
  String get web3ResolveFailed => 'Échec de la résolution d\'identité';

  @override
  String web3EnsNotFound(String name) {
    return 'Nom ENS \"$name\" introuvable';
  }

  @override
  String get web3NoN42AccountTitle => 'Pas de compte N42';

  @override
  String get web3NoN42AccountDesc =>
      'Cette adresse de portefeuille n\'a pas encore de compte N42. Vous pouvez partager votre lien d’invitation N42 avec eux pour commencer.';

  @override
  String get web3ShareInvite => 'Partager l\'invitation';

  @override
  String get nftPickerTitle => 'Sélectionner un avatar NFT';

  @override
  String get nftPickerTabPopular => 'Populaire';

  @override
  String get nftPickerTabCustom => 'Personnalisé';

  @override
  String get nftPickerChain => 'Chaîne';

  @override
  String get nftPickerContract => 'Adresse du contrat';

  @override
  String get nftPickerTokenId => 'ID de jeton';

  @override
  String get nftPickerVerifyOwnership =>
      'Vérifier la propriété et prévisualiser';

  @override
  String get nftPickerUseAsAvatar => 'Utiliser comme avatar';

  @override
  String get nftPickerPreview => 'Aperçu';

  @override
  String get nftPickerNotOwned => 'Vous ne possédez pas ce NFT';

  @override
  String get nftPickerInvalidTokenId => 'ID de jeton invalide';

  @override
  String get nftPickerEnterBoth =>
      'Entrez l\'adresse du contrat et l\'ID du jeton';

  @override
  String get nftPickerInfoTitle => 'Avatar NFT — Vérifié sur la chaîne';

  @override
  String get nftPickerInfoDesc =>
      'Liez un NFT que vous possédez comme avatar. N\'importe qui peut vérifier la propriété en chaîne. Affiché avec un anneau en or sur N42.';

  @override
  String get nftPickerPopularCollections => 'Collections populaires';

  @override
  String get nftPickerWalletHint =>
      'Connectez votre wallet N42 pour découvrir vos NFT sur 236+ chaînes.';

  @override
  String get profileBindNftAvatar => 'Lier un avatar NFT';

  @override
  String get profileChangeAvatar => 'Changer l avatar';

  @override
  String get groupTopics => 'Sujets';

  @override
  String get groupTopicsEmpty => 'Aucun sujet pour l instant';

  @override
  String get syncInProgress => 'Synchronisation de l historique...';

  @override
  String get recoveryKeyReminderTitle => 'Protégez vos messages';

  @override
  String get recoveryKeyReminderDesc =>
      'Créez une clé de récupération pour synchroniser vos messages chiffrés sur plusieurs appareils';

  @override
  String get recoveryKeySetupNow => 'Configurer maintenant';

  @override
  String get recoveryKeyRemindLater => 'Me rappeler plus tard';

  @override
  String get channelReadOnly =>
      'Seuls les administrateurs peuvent publier sur cette chaîne';

  @override
  String get channelSubscribers => 'abonnés';

  @override
  String get channelVerified => 'Chaîne vérifiée';

  @override
  String get redPacketHistory => 'Historique des paquets rouges';

  @override
  String get redPacketSent => 'Envoyé';

  @override
  String get redPacketReceived => 'Reçu';

  @override
  String get redPacketExpired => 'Expiré';

  @override
  String get redPacketClaimed => 'Réclamé';

  @override
  String get redPacketInsufficientBalance => 'Solde insuffisant';

  @override
  String selfDestructCountdown(String time) {
    return 'Autodestruction dans $time';
  }

  @override
  String get messageDestroyed => 'Message détruit';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Autorisation refusée : $permission';
  }

  @override
  String get aiSuggestionGasFee => 'Qu\'est-ce que les frais de gaz ?';

  @override
  String get aiSuggestionDefi => 'Guide du débutant DeFi';

  @override
  String get aiSuggestionSecurity => 'Comment vérifier la sécurité du contrat';

  @override
  String get aiSuggestionBridge => 'Pontage entre chaînes';

  @override
  String get channelDiscoverTitle => 'Découvrir les chaînes';

  @override
  String get channelDiscoverSearch => 'Rechercher des chaînes...';

  @override
  String get channelJoin => 'Rejoindre';

  @override
  String get channelJoined => 'Rejoint';

  @override
  String get channelCategory => 'Catégorie';

  @override
  String slowModeCooldown(int seconds) {
    return 'Mode lent : attendez ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Copier l\'adresse';

  @override
  String get addressSendMessage => 'Envoyer un message';

  @override
  String get addressViewProfile => 'Voir le profil';

  @override
  String get sendToAddress => 'Envoyer à l\'adresse du portefeuille';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Échec de l\'envoi du code de vérification';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Ce serveur ne prend pas en charge la réinitialisation du mot de passe de messagerie';

  @override
  String get blocAuthResetPasswordFailed =>
      'Échec de la réinitialisation du mot de passe';

  @override
  String get blocAuthChangePasswordFailed =>
      'Échec de la modification du mot de passe';

  @override
  String get blocAuthOldPasswordWrong => 'Mot de passe actuel incorrect';

  @override
  String get blocAuthLoginCancelled => 'Connexion annulée';

  @override
  String get blocAuthGoogleLoginFailed => 'La connexion à Google a échoué';

  @override
  String get blocAuthAppleLoginFailed => 'La connexion Apple a échoué';

  @override
  String get blocAuthSsoLoginFailed => 'La connexion SSO a échoué';

  @override
  String get blocAuthFacebookLoginFailed => 'La connexion à Facebook a échoué';

  @override
  String get blocAuthTwitterLoginFailed => 'La connexion à Twitter a échoué';

  @override
  String get blocAuthWeChatLoginFailed => 'La connexion à WeChat a échoué';

  @override
  String get blocAuthWeChatNotConfigured => 'Connexion WeChat non configurée';

  @override
  String get blocAuthWeChatNotInstalled => 'Veuillez d\'abord installer WeChat';

  @override
  String get blocAuthPasswordWrong => 'Mot de passe incorrect';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Cet e-mail est déjà lié à un autre compte';

  @override
  String get blocAuthChangeEmailFailed =>
      'Échec du changement d\'adresse e-mail';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'Le code de vérification est incorrect ou expiré';

  @override
  String get blocAuthSessionExpired =>
      'Session expirée, veuillez vous reconnecter';

  @override
  String get blocAuthSessionIncomplete =>
      'Données de session incomplètes, veuillez vous reconnecter';

  @override
  String get chatReadingMode => 'Mode lecture';

  @override
  String get groupPoints => 'Points';

  @override
  String get settingsPrivacySecurity => 'Confidentialité et sécurité';

  @override
  String get settingsSystemAccounts => 'Système et comptes';

  @override
  String get settingsNotificationPrivacy => 'Confidentialité des notifications';

  @override
  String get settingsSenderOnly => 'Afficher uniquement l’expéditeur';

  @override
  String get settingsHiddenNotification => 'Masquer l’expéditeur et le message';

  @override
  String get settingsSmartFilter => 'Filtre intelligent';

  @override
  String get settingsEmailVerificationSent => 'E-mail de vérification envoyé';

  @override
  String get settingsEmailLinkInstructions =>
      'Ouvrez le lien de vérification dans votre e-mail, puis revenez ici et confirmez.';

  @override
  String get settingsSendVerificationEmail =>
      'Envoyer un e-mail de vérification';

  @override
  String get chatLogoutKeyWarning =>
      'Sauvegardez vos clés de chiffrement avant de vous déconnecter, sinon vous risquez de perdre l’accès aux messages chiffrés.';

  @override
  String get settingsBiometricUnavailable =>
      'L’authentification biométrique est indisponible. Vérifiez la configuration et les autorisations dans les réglages de l’appareil.';

  @override
  String get chatEncryptionNotReady =>
      'La connexion sécurisée n’est pas prête. Message non envoyé. Vérifiez la connexion et la vérification des appareils des deux comptes, puis réessayez.';

  @override
  String get contactRequestPending => 'En attente d’acceptation';

  @override
  String get chatFriendRequestPending =>
      'L’amitié n’est pas confirmée. Vérifiez Contacts > Nouveaux amis avant d’envoyer un message.';

  @override
  String contactPhotoCount(int count) {
    return '$count photos';
  }

  @override
  String get videoPublish => 'Publier une vidéo';

  @override
  String get videoGoLive => 'Démarrer un direct';

  @override
  String get videoSelect => 'Choisir une vidéo';

  @override
  String get videoLiveUnavailable =>
      'La diffusion en direct n’est pas disponible';

  @override
  String get qrcodeAlbum => 'Album';

  @override
  String get settingsSwitchAccount => 'Changer de compte';

  @override
  String get chatFilterUnread => 'Non lus';

  @override
  String get chatFilterEmpty => 'Aucune conversation dans ce filtre';

  @override
  String get accountAdd => 'Ajouter un compte';

  @override
  String get accountCurrent => 'Compte actuel';

  @override
  String get accountSwitching => 'Changement de compte…';

  @override
  String get accountSwitchFailed =>
      'Impossible de changer de compte. Réessayez ou ajoutez le compte pour vous reconnecter.';

  @override
  String get accountSessionsHint =>
      'Changez de compte ici pour conserver séparément les messages et la session sécurisée de chaque compte.';

  @override
  String get accountNoSaved => 'Aucun compte enregistré';

  @override
  String get contactRequestSent => 'Demande envoyée';

  @override
  String get contactRequestsIncoming => 'Demandes reçues';

  @override
  String get contactRequestsOutgoing => 'Demandes envoyées';

  @override
  String get contactRequestHint =>
      'Vous pourrez discuter et appeler une fois la demande acceptée.';

  @override
  String get callReturnToCall => 'Revenir à l’appel';

  @override
  String get chatMessageSending => 'Envoi en cours';

  @override
  String get chatMessageSent => 'Envoyé';

  @override
  String get chatMessageDelivered => 'Distribué';

  @override
  String get chatMessageRead => 'Lu';

  @override
  String get chatMessageFailed => 'Non envoyé. Touchez pour réessayer.';

  @override
  String get chatMessageUnavailable =>
      'Message indisponible sur cet appareil. Touchez pour voir les options de récupération.';

  @override
  String get contactStarredFriends => 'Contacts favoris';

  @override
  String get chatRecipientKeysMissing =>
      'Ce contact n’a aucune session chiffrée disponible. Demandez-lui de se connecter et d’ouvrir l’application, puis réessayez. Pour changer de compte, utilisez « Changer de compte » sans vous déconnecter.';

  @override
  String get chatSwitchForMessaging =>
      'Vous changez de compte ? Utilisez « Changer de compte » pour conserver vos messages et sessions sécurisées. La déconnexion révoque cet appareil et peut rendre les messages chiffrés entrants illisibles.';

  @override
  String get aiServiceUnavailable =>
      'Les résumés IA sont actuellement indisponibles. Réessayez lorsque l’accès au service sera rétabli.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Résumer les $count derniers messages';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined ont rejoint · $invited invités';
  }

  @override
  String contactPendingCount(int count) {
    return '$count demandes en attente';
  }

  @override
  String get chatDraftLabel => 'Brouillon';

  @override
  String get contactIndexLabel => 'Index des contacts';

  @override
  String get transferAssetUnavailable => 'L’actif de paiement est indisponible';

  @override
  String get transferPaymentRequestUnavailable =>
      'La demande de paiement est indisponible';

  @override
  String get chatCatchUp => 'Se mettre à jour';

  @override
  String get chatCatchUpMentions => 'Mentions';

  @override
  String get chatCatchUpReplies => 'Réponses à mes messages';

  @override
  String get chatCatchUpPinned => 'Messages épinglés';

  @override
  String get chatCatchUpScope =>
      'Les mentions et les réponses proviennent des messages chargés, y compris ceux déjà lus. Chargez les messages plus anciens pour trouver les réponses antérieures.';

  @override
  String get chatCatchUpLoadMore => 'Charger les messages plus anciens';

  @override
  String get chatActionPreview => 'Vérifier la suggestion de calendrier';

  @override
  String get chatActionPrivacy =>
      'Seuls le titre et l’heure ci-dessous seront transmis à votre application de calendrier après confirmation. Vérifiez le fuseau horaire. Votre compte de calendrier peut synchroniser cet événement.';

  @override
  String get chatActionTitle => 'Événement de discussion';

  @override
  String get chatActionSuggestion => 'Suggestion de calendrier';

  @override
  String get chatUnreadAttention => 'Mentions et réponses non lues';

  @override
  String get chatScanAgain => 'Rechercher à nouveau';

  @override
  String get chatUnreadScope =>
      'Parcourt l’historique du serveur jusqu’à votre marqueur de lecture. Ouvrez une conversation pour la lire ; actualisez pour reconstruire les résultats.';

  @override
  String get chatScanIncomplete =>
      'Résultats incomplets : historique, déchiffrement ou marqueur de lecture indisponible. Réessayez après la synchronisation.';

  @override
  String get chatHistoryShare => 'Partager l’historique sélectionné';

  @override
  String get chatHistoryExplanation =>
      'Réservé aux administrateurs. Sélectionnez du texte brut et une discussion directe chiffrée existante avec un membre ayant rejoint le groupe. Le partage crée des messages d’audit visibles dans le groupe.';

  @override
  String get chatHistoryEnable => 'Activer le partage';

  @override
  String get chatHistoryDisable => 'Désactiver le partage';

  @override
  String get chatHistoryPolicy => 'Règles de partage de l’historique du groupe';

  @override
  String get chatHistoryPolicyDetail =>
      'Seuls les administrateurs peuvent partager. L’activation limite aussi la visibilité de l’historique du groupe aux événements postérieurs à l’adhésion. Définissez ci-dessous les limites des messages texte, puis confirmez.';

  @override
  String get chatHistoryPolicySaved => 'Règles enregistrées';

  @override
  String get chatHistoryRecipient => 'Conversation chiffrée du destinataire';

  @override
  String get chatHistoryReview => 'Vérifier les messages sélectionnés';

  @override
  String get chatHistoryMessages => 'messages';

  @override
  String get chatHistoryConfirmDetail =>
      'Avant le partage, confirmez le destinataire, chaque message et son heure. Un résultat en échec ou inconnu peut correspondre à un envoi déjà effectué : vérifiez son état avant de continuer.';

  @override
  String get chatHistoryCompleted =>
      'Historique sélectionné envoyé et audit du groupe confirmé';

  @override
  String get chatHistoryPending =>
      'En attente : vérifiez le résultat, puis confirmez à nouveau pour continuer. Les envois au résultat inconnu ne sont jamais répétés.';

  @override
  String get chatHistoryReconcile => 'Vérifier le résultat de l’envoi';

  @override
  String get chatHistoryFailed =>
      'Impossible de terminer. Vérifiez les droits d’administration, les règles du groupe, le chiffrement, l’appartenance du destinataire et la sélection. Si l’envoi a commencé, vérifiez son résultat.';

  @override
  String get chatDeviceActions => 'Actions sur l’appareil';

  @override
  String get chatDeviceActionsReview =>
      'Après confirmation, seul ce message est fourni aux suggestions d’actions du système sur l’appareil. Choisissez une action pour ouvrir Calendrier, Rappels ou Plans.';

  @override
  String get chatHistoryMaxMessages => 'Limite de messages (1–50)';

  @override
  String get chatHistoryMaxHours => 'Période d’historique en heures (1–720)';

  @override
  String get chatNotifyAll => 'Tous les messages';

  @override
  String get chatNotifyAllDescription =>
      'Notifier chaque nouveau message dans cette discussion';

  @override
  String get chatNotifyMentions => 'Mentions uniquement';

  @override
  String get chatNotifyMentionsDescription =>
      'Notifier uniquement lorsque vous êtes mentionné ou que @room est utilisé';

  @override
  String get chatNotifyMutedDescription =>
      'Désactiver les notifications de cette discussion sur tous les appareils';

  @override
  String get scheduledMessagesTitle => 'Messages programmés';

  @override
  String get scheduledMessagesEmpty => 'Aucun message programmé pour le moment';

  @override
  String get scheduledMessagesHint =>
      'Appuyez longuement sur Envoyer, Photos, Fichiers, un GIF ou un sticker pour programmer un message.';

  @override
  String get scheduledMessageCancelled => 'Message programmé annulé';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Créé le $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Livraison non confirmée';

  @override
  String get scheduledRecoveryCopy => 'Enregistrer une copie de récupération';

  @override
  String get scheduledRecoveryCopyHint =>
      'Enregistrée sur cet appareil sans modifier ni envoyer de messages. L’aperçu affiche jusqu’à 8 000 caractères.';

  @override
  String get scheduledRecoveryCopies => 'Copies de récupération';

  @override
  String get scheduledRecoveryReset => 'Réinitialiser la file endommagée';

  @override
  String get scheduledRecoveryResetHint =>
      'Une copie exacte est enregistrée sur cet appareil. Réinitialiser tous les messages programmés de ce compte ? Certains ont peut-être déjà été envoyés. Les copies et pièces jointes sont conservées. Aucun message ne sera renvoyé.';

  @override
  String get scheduledRecoveryExportHint =>
      'Ce fichier contient du texte de brouillons et des informations de compte non chiffrés. Les pièces jointes ne sont pas incluses. Choisissez une destination de confiance.';

  @override
  String get scheduledRecoveryImport => 'Importer une copie de récupération';

  @override
  String get scheduledRecoveryImportHint =>
      'Enregistrer cet aperçu uniquement comme copie de récupération. Aucun message ne sera programmé ni envoyé. Les pièces jointes ne sont pas incluses. L’auteur du fichier n’est pas vérifié.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Ajoutez le texte au brouillon actuel pour le vérifier. Rien ne sera envoyé. Les pièces jointes, mentions et minuteries ne seront pas restaurées. Vérifiez si ce message a déjà été remis.';

  @override
  String get backupRecoverLegacyArchive =>
      'Restaurer un ancien historique local';

  @override
  String get backupLegacyArchiveWarning =>
      'Le propriétaire de cet historique n’est pas vérifié. Copiez uniquement vos salons vers le compte ci-dessous. L’original est conservé.';

  @override
  String get backupOlderFiles => 'Anciens fichiers de sauvegarde';

  @override
  String get backupOlderFilesWarning =>
      'Ces fichiers peuvent appartenir à un autre compte. Sélectionnez un fichier pour vérifier son contenu et son propriétaire avant de le restaurer.';

  @override
  String get stickerImportTitle => 'Importer un pack de stickers';

  @override
  String get stickerImportLinkHint => 'Lien du pack de stickers Matrix';

  @override
  String get stickerImportPreview => 'Aperçu';

  @override
  String get stickerImportUnavailable =>
      'Ce pack est indisponible ou vous n’y avez pas accès.';

  @override
  String get stickerImportCopyNotice =>
      'Ajoutez une copie privée de ce pack. Ses images et métadonnées ne sont pas chiffrées de bout en bout.';

  @override
  String get stickerImportFailed => 'Impossible d’ajouter ce pack. Réessayez.';

  @override
  String get stickerImportAccountChanged =>
      'Le compte a changé ou la session a expiré. Rouvrez l’importation de stickers.';

  @override
  String get stickerPackSourceRoom => 'Discussion d’origine';

  @override
  String get stickerPackImages => 'Visuels';

  @override
  String get stickerPublishNotice =>
      'Publiez ce pack dans le groupe sélectionné. Ses images et métadonnées ne sont pas chiffrées de bout en bout. Les personnes pouvant lire l’état du groupe peuvent y accéder.';

  @override
  String get stickerPublishFailed =>
      'La publication n’a pas été confirmée. Vérifiez le groupe avant de réessayer.';

  @override
  String get stickerPublishReceiptMissing =>
      'Publié, mais le lien n’a pas été enregistré. Partagez-le ou copiez-le avant de quitter cette page.';

  @override
  String get stickerSubscribe => 'Suivre les mises à jour';

  @override
  String get stickerSubscribeNotice =>
      'Suivez les futures modifications des administrateurs du pack. Les images et métadonnées ne sont pas chiffrées de bout en bout. Vous pourrez vous désabonner ; cela ne vous fait pas rejoindre la discussion source.';

  @override
  String get stickerSubscriptions => 'Abonnements aux stickers';

  @override
  String get stickerUnsubscribe => 'Se désabonner';

  @override
  String get stickerSubscriptionsEmpty => 'Aucun abonnement aux stickers';

  @override
  String get chatAttachmentEvent => 'Événement';

  @override
  String get chatRecentMedia => 'Photos et vidéos récentes';

  @override
  String get chatRecentMediaLoadFailed =>
      'Impossible de charger les médias récents';

  @override
  String get chatRecentMediaPermission =>
      'L’accès aux photos est nécessaire pour afficher les médias récents';

  @override
  String get chatRecentMediaEmpty => 'Aucune photo ou vidéo récente';

  @override
  String get chatRecentPhoto => 'Photo récente';

  @override
  String get chatRecentVideo => 'Vidéo récente';

  @override
  String get chatAttachmentTip => 'Pourboire';

  @override
  String get chatAttachmentWhiteboard => 'Tableau blanc';

  @override
  String get chatAttachmentVideoNote => 'Message vidéo';

  @override
  String get chatAttachmentCode => 'Extrait de code';

  @override
  String get chatAttachmentShop => 'Boutique';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Limite de sélection : $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Ce soir ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Demain matin ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Défiler vers le bas';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Saisissez un message avant de le programmer';

  @override
  String get ui3SendCode => 'Envoyer du code';

  @override
  String get ui3CodeLanguage => 'Langage';

  @override
  String get ui3PasteCodeHere => 'Collez le code ici';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Rappel défini · $time';
  }

  @override
  String get ui3RedPacketCreateFailed =>
      'Impossible de créer l\'enveloppe rouge';

  @override
  String get ui3SendTip => 'Envoyer un pourboire';

  @override
  String get ui3TokenLabel => 'Jeton';

  @override
  String get ui3NoteOptional => 'Note (facultatif)';

  @override
  String ui3TipFailed(String error) {
    return 'Échec du pourboire : $error';
  }

  @override
  String get ui3GiftNftTitle => 'Offrir un NFT';

  @override
  String get ui3TokenId => 'ID du jeton';

  @override
  String ui3NftGiftFailed(String error) {
    return 'Échec de l\'envoi du NFT : $error';
  }

  @override
  String get ui3AiAgentSubtitle =>
      'Décrivez une tâche, ouvrez la bonne mini-app';

  @override
  String get ui3GiftNft => 'Offrir un NFT';

  @override
  String get ui3GiftNftSubtitle => 'Envoyer un NFT à ce contact';

  @override
  String get ui3MiniAppUnavailable => 'La mini-app n\'est pas disponible';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'Impossible d\'envoyer $count média(s) sélectionné(s)';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Envoyez des photos et vidéos dans un format adapté au chat';

  @override
  String get ui3OriginalImages => 'Images originales';

  @override
  String get ui3OriginalImagesSubtitle =>
      'Envoyer des photos non compressées en tant que fichiers';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename programmé pour $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Envoi de l\'image originale : $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Image originale programmée : $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Paiement déjà envoyé';

  @override
  String get ui3PaymentProcessing => 'Paiement en cours de traitement';

  @override
  String ui3ChainStatus(String status) {
    return 'Statut on-chain : $status';
  }

  @override
  String get ui3NotChecked => 'Non vérifié';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Confirmé : $confirmations / $required blocs';
  }

  @override
  String get ui3CopyTxHash => 'Copier le hash de la transaction';

  @override
  String get ui3VerifyAgain => 'Vérifier à nouveau';

  @override
  String get ui3VerifyOnChain => 'Vérifier on-chain';

  @override
  String get ui3TransferMissingChainDetails =>
      'Ce transfert ne contient pas les détails exacts de la chaîne et de l\'actif.';

  @override
  String get ui3ReceiptPending => 'En attente on-chain';

  @override
  String get ui3ReceiptConfirmed => 'Confirmé';

  @override
  String get ui3ReceiptFailed => 'Échec on-chain';

  @override
  String get ui3ReceiptMismatch =>
      'Les détails de la transaction ne correspondent pas';

  @override
  String get ui3ReceiptUnsupported =>
      'Vérification on-chain non prise en charge';

  @override
  String get ui3ReceiptUnavailable => 'Vérification indisponible';

  @override
  String get ui3OpenOrSave => 'Ouvrir / Enregistrer';

  @override
  String get ui3UnableToOpenFile => 'Impossible d\'ouvrir ce fichier.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'Échec de la reformulation par l\'IA : $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Partager des messages avec l\'IA ?';

  @override
  String get ui3AiShareMessagesBody =>
      'Sélectionnez les messages que l\'IA peut utiliser pour cette réponse. Cette autorisation ponctuelle expire au bout de deux minutes. Fermer Réponse rapide annule les résultats en attente. Elle n\'autorise ni paiements ni exportations.';

  @override
  String get ui3OtherParticipant => 'Interlocuteur';

  @override
  String get ui3ShareSelected => 'Partager la sélection';

  @override
  String get ui3BotCommandError => 'Erreur de commande';

  @override
  String get ui3BotUnknownCommand => 'Commande inconnue';

  @override
  String get ui3BotTypeHelp =>
      'Tapez /help pour voir les commandes disponibles.';

  @override
  String get ui3FilesMediaLinks => 'Fichiers, médias et liens';

  @override
  String get ui3ChatStorage => 'Stockage du chat';

  @override
  String get ui3EncryptionKeysDevices => 'Clés de chiffrement et appareils';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'Le service de chiffrement n\'est pas encore disponible';

  @override
  String get ui3ExportLoadingHistory =>
      'Chargement de l\'historique supplémentaire pour l\'export...';

  @override
  String get ui3ExportTxtDesc =>
      'Transcription en texte brut pour notes, sauvegarde ou contrôle de conformité';

  @override
  String get ui3ExportCustomRange => 'Période personnalisée';

  @override
  String get ui3ExportStart => 'Début';

  @override
  String get ui3ExportEnd => 'Fin';

  @override
  String get ui3ExportSelectDate => 'Choisir une date';

  @override
  String get ui3FolderFilterUnreadOnly => 'Non lus uniquement';

  @override
  String get ui3FolderFilterMutedOnly => 'Mis en sourdine uniquement';

  @override
  String get ui3FolderFilterNoDms => 'Sans messages privés';

  @override
  String get ui3FolderFilterNoGroups => 'Sans groupes';

  @override
  String get ui3FolderFilterNoChannels => 'Sans chaînes';

  @override
  String get ui3FolderFilterAllChats => 'Toutes les discussions';

  @override
  String get ui3Create => 'Créer';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Supprimer le dossier « $name » ?';
  }

  @override
  String get a11yDecreaseTextSize => 'Réduire la taille du texte';

  @override
  String get a11yIncreaseTextSize => 'Augmenter la taille du texte';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes min de lecture';
  }

  @override
  String get ui3TipOnChain => 'Sur la chaîne ✓';

  @override
  String get ui3ViewSource => 'Afficher la source';

  @override
  String get a11yPreviousPage => 'Page précédente';

  @override
  String get a11yNextPage => 'Page suivante';

  @override
  String get ui3OpenExternalLinkTitle => 'Ouvrir le lien externe ?';

  @override
  String get ui3Open => 'Ouvrir';

  @override
  String get ui3UnableToOpenLink => 'Impossible d\'ouvrir ce lien.';

  @override
  String get ui3ImageUnavailable => 'Image indisponible';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Charger l\'image depuis $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Réessayer l\'image depuis $host';
  }

  @override
  String get ui3TranslatedByN42 => 'Traduit par N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Traduit depuis $language par N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Effacer le tableau blanc ?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Tous les tracés seront supprimés pour tout le monde. Cette action est irréversible.';

  @override
  String get ui3WhiteboardLive => 'Tableau blanc · En direct';

  @override
  String get a11yPenColor => 'Couleur du stylo';

  @override
  String get ui3AiDescribeOcr => 'Description IA / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Impossible de prévisualiser ce document en toute sécurité. Vérifiez la connexion et la taille du fichier (2 Mo max.).';

  @override
  String get ui3AiConsentMessage =>
      'Sélectionnez les messages que l\'IA peut utiliser pour ce résumé. Cette autorisation ponctuelle expire au bout de deux minutes. Elle n\'autorise ni paiements ni exportations.';

  @override
  String get ui3AiSuggestedReplies => 'Réponses suggérées';

  @override
  String get ui3AiGeneratingSuggestions => 'Génération de suggestions...';

  @override
  String get ui3StickersEmpty => 'Aucun sticker pour l\'instant';

  @override
  String get ui3StickersGet => 'Obtenir des stickers';

  @override
  String get a11yFormatBold => 'Gras';

  @override
  String get a11yFormatItalic => 'Italique';

  @override
  String get a11yFormatStrikethrough => 'Barré';

  @override
  String get a11yFormatInlineCode => 'Code en ligne';

  @override
  String get a11yFormatCodeBlock => 'Bloc de code';

  @override
  String get a11yFormatChecklistItem => 'Élément de liste de tâches';

  @override
  String get a11yFormatBulletList => 'Liste à puces';

  @override
  String get a11yFormatNumberedList => 'Liste numérotée';

  @override
  String get a11yFormatLink => 'Lien';

  @override
  String get a11yFormatTable => 'Tableau';

  @override
  String get a11yFormatMeetingTemplate => 'Modèle de réunion';

  @override
  String get a11yEmojiSmileys => 'Smileys et personnes';

  @override
  String get a11yEmojiHearts => 'Cœurs';

  @override
  String get a11yEmojiAnimals => 'Animaux et nature';

  @override
  String get a11yEmojiFood => 'Nourriture et boissons';

  @override
  String get a11yEmojiTravel => 'Voyages et lieux';

  @override
  String get a11yEmojiActivities => 'Activités';

  @override
  String get a11yEmojiObjects => 'Objets';

  @override
  String get a11yEmojiSymbols => 'Symboles';

  @override
  String get ui3FrequentlyUsed => 'Fréquemment utilisés';

  @override
  String get ui3NoEditHistory => 'Aucun historique des modifications';

  @override
  String get ui3EventNew => 'Nouvel événement';

  @override
  String get ui3EventTitleLabel => 'Titre';

  @override
  String get ui3EventLocationOptional => 'Lieu (facultatif)';

  @override
  String get ui3EventDescriptionOptional => 'Description (facultative)';

  @override
  String get ui3EventSend => 'Envoyer l’événement';

  @override
  String get ui3EventTitleRequired => 'Le titre est obligatoire';

  @override
  String get ui3EventEndAfterStart =>
      'L’heure de fin doit être postérieure au début';

  @override
  String get ui3MiniAppAgentIntro =>
      'Décrivez ce que vous voulez faire, j’ouvrirai la mini-app adaptée.';

  @override
  String get ui3MiniAppAgentExample => 'ex. : échanger des ETH contre des USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Aucune mini-app correspondante. Essayez de reformuler.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Ouvrir $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Prend en charge les liens de titres de NetEase Cloud Music, QQ Music, Kugou, Kuwo et plus';

  @override
  String get ui3PollMarkCorrectAnswer => 'Indiquez une bonne réponse non vide';

  @override
  String get ui3PollQuizMode => 'Mode quiz';

  @override
  String get ui3PollAnswerExplanationHint =>
      'Explication de la réponse (facultatif)';

  @override
  String get a11yCorrectAnswer => 'Bonne réponse';

  @override
  String get ui3AiSuggestions => 'Suggestions de l’IA';

  @override
  String get a11yPaste => 'Coller';

  @override
  String get a11yRefresh => 'Actualiser';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Conservez cette clé en lieu sûr. C’est le seul moyen de récupérer vos messages chiffrés si vous perdez l’accès à tous vos appareils.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Enregistré : $path';
  }

  @override
  String get ui3UnknownAccount => 'Compte inconnu';

  @override
  String get ui3UnknownHomeserver => 'Serveur d’accueil inconnu';

  @override
  String get ui3ImportRecoveryKey => 'Importer la clé de récupération';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Saisissez ou collez votre clé de récupération pour restaurer les clés de salon de l’historique des messages chiffrés.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Compte : $account\\nServeur d’accueil : $homeserver';
  }

  @override
  String get ui3Import => 'Importer';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Format de clé de récupération invalide';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '$restored clés sur $total restaurées. Échec pour $failed clés. Vérifiez le compte, le réseau et la sauvegarde, puis réessayez. Une partie de l’historique peut rester illisible.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '$restored clés sur $total restaurées avec succès';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Échec de l’importation : $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Échec de l’enregistrement de la clé d’accès : $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'Ma clé d’accès';

  @override
  String get ui3PasskeyNameHint => 'ex. : iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Impossible de supprimer la clé d’accès';

  @override
  String get ui3TwoFactorAuth => 'Authentification à deux facteurs';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'Activée — code de l’app d’authentification requis';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Désactivée — protégez-vous avec une app d’authentification (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Afficher la clé de récupération';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Affichez votre clé de récupération pour la sauvegarder';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Restaurer les messages avec une clé de récupération';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Impossible de créer la clé de récupération';

  @override
  String get ui3TotpIncorrectCode => 'Code incorrect, réessayez';

  @override
  String get ui3TwoFactorEnabled => 'Authentification à deux facteurs activée';

  @override
  String get ui3TwoFactorDisabled =>
      'Authentification à deux facteurs désactivée';

  @override
  String get ui3TwoFactorTurnOffTitle =>
      'Désactiver l’authentification à deux facteurs ?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'Votre app d’authentification ne sera plus requise. Vous pourrez la reconfigurer plus tard avec une nouvelle clé.';

  @override
  String get ui3TurnOff => 'Désactiver';

  @override
  String get ui3TwoFactorTotpTitle => 'Deux facteurs (TOTP)';

  @override
  String get ui3TwoFactorIsOn =>
      'L’authentification à deux facteurs est activée';

  @override
  String get ui3TwoFactorCodeRequired =>
      'Un code de votre app d’authentification est requis.';

  @override
  String get ui3TotpStepScan =>
      '1. Scannez ce QR code avec une app d’authentification (Google Authenticator, Authy, 1Password…) ou saisissez la clé manuellement.';

  @override
  String get ui3TotpKeyCopied => 'Clé copiée';

  @override
  String get ui3TotpStepConfirm =>
      '2. Saisissez le code à 6 chiffres pour confirmer.';

  @override
  String get ui3Enable => 'Activer';

  @override
  String get ui3BackupSettingsDesc =>
      'Sauvegardez vos paramètres de chat locaux. Les messages seront restaurés depuis le serveur après reconnexion.';

  @override
  String get ui3BackupKeysSeparate =>
      'Les clés de chiffrement sont gérées séparément';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Utilisez Sécurité > Clé de récupération pour sauvegarder l’accès aux messages chiffrés.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms salons  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Importez un fichier .n42backup depuis un autre appareil ou une sauvegarde précédente. Les clés de chiffrement sont restaurées séparément avec votre clé de récupération.';

  @override
  String get ui3UsernameSessionRequired =>
      'Le nom d’utilisateur nécessite une session active';

  @override
  String get ui3SecuritySessionRequired =>
      'Les paramètres de sécurité nécessitent une session active';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'Les comptes associés nécessitent une session active';

  @override
  String get ui3SystemAccounts => 'Système et comptes';

  @override
  String get ui3AccountIdentity => 'Compte et identité';

  @override
  String get ui3Accounts => 'Comptes';

  @override
  String get ui3DevicesSessions => 'Appareils et sessions';

  @override
  String get ui3Integrations => 'Intégrations';

  @override
  String get ui3ConnectedAccounts => 'Comptes associés';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Intégrations Telegram, WhatsApp, Discord et passerelles API';

  @override
  String get ui3SystemOverview => 'Aperçu du système';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comptes',
      one: '1 compte',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count appareils',
      one: '1 appareil',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Chiffrement de bout en bout, protection contre les captures d’écran et contrôle du proxy';

  @override
  String get ui3ConversationPrivacy => 'Confidentialité des conversations';

  @override
  String get ui3NetworkPrivacy => 'Confidentialité réseau';

  @override
  String get ui3IdentityPrivacy => 'Confidentialité de l’identité';

  @override
  String get ui3EncryptionKeyBackup => 'Chiffrement et sauvegarde des clés';

  @override
  String get ui3DevicesVerification => 'Appareils et vérification';

  @override
  String get ui3ChipE2eeDefault => 'E2EE par défaut';

  @override
  String get ui3ChipManualE2ee => 'E2EE manuel';

  @override
  String get ui3ChipSelfDestruct => 'Autodestruction';

  @override
  String get ui3ChipScreenshotGuard => 'Protection des captures';

  @override
  String get ui3ChipIpProxy => 'IP / serveur proxy';

  @override
  String get ui3ChipLinkPreviewsOff => 'Aperçus de liens désactivés';

  @override
  String get ui3ChipPublicHandle => 'Identifiant public';

  @override
  String get a11yShowPassword => 'Afficher le mot de passe';

  @override
  String get a11yHidePassword => 'Masquer le mot de passe';

  @override
  String get a11yCheckServer => 'Vérifier le serveur';

  @override
  String get ui3AuthAnonymousRegistration => 'Inscription anonyme';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Créez un compte sans associer de téléphone ni d’e-mail. Un nom d’utilisateur sera généré automatiquement.';

  @override
  String get ui3AuthAnonymousModeOn => 'Le mode anonyme est activé';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'L’app va créer pour vous un nom d’utilisateur Matrix aléatoire. Vous pourrez vous connecter plus tard avec le compte et le mot de passe générés.';

  @override
  String get ui3AuthChooseLoginMethod => 'Choisir une méthode de connexion';

  @override
  String get ui3AuthSsoOpenFailed =>
      'Impossible d’ouvrir la page de connexion SSO';

  @override
  String get ui3AuthWalletUnavailable => 'Le portefeuille n’est pas disponible';

  @override
  String get ui3ProfileSubscriptions => 'Abonnements';

  @override
  String get ui3ProfileBuySellCrypto => 'Acheter / vendre des cryptos';

  @override
  String get ui3ProfileOnDeviceAi => 'IA sur l’appareil';

  @override
  String get ui3ProfileSetAUsername => 'Définir un nom d’utilisateur';

  @override
  String get ui3ProfileAvatarStudio => 'Studio d’avatar';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'Avatar NFT / Décorations';

  @override
  String get ui3ProfileCustomize => 'Personnaliser';

  @override
  String get ui3ProfileQrSubtitle =>
      'Scannez pour ouvrir ce profil ou démarrer une discussion';

  @override
  String get ui3PrivacyHardening => 'Renforcement de la confidentialité';

  @override
  String get ui3HidePhoneNumber => 'Masquer le numéro de téléphone';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Masquer tout numéro de téléphone associé sur les pages de profil de cet appareil';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'Chiffrer les nouvelles discussions par défaut';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Démarrer les nouvelles discussions directes et salons privés avec le E2EE activé';

  @override
  String get ui3PrivateChatMode => 'Mode discussion privée';

  @override
  String get ui3PrivateChatModeDesc =>
      'Bloquer temporairement les captures d’écran lors de l’affichage de discussions privées ou chiffrées';

  @override
  String get ui3DefaultSelfDestructTimer =>
      'Minuteur d’autodestruction par défaut';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Appliquer un minuteur d’autodestruction par défaut aux nouveaux messages envoyés';

  @override
  String get ui3LinkPreviews => 'Aperçus de liens';

  @override
  String get ui3LinkPreviewsDesc =>
      'Récupérer titres, descriptions et miniatures quand les messages contiennent des URL';

  @override
  String get ui3IpAddressProtection => 'Protection de l’adresse IP';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Faire passer les requêtes Matrix et d’aperçu de liens par votre proxy HTTP de confidentialité configuré, si disponible';

  @override
  String get ui3UseTorProxy => 'Utiliser le proxy HTTP Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Utilisez un point de terminaison proxy HTTP local, comme Privoxy sur 127.0.0.1:8118. Le routage Tor natif via SOCKS5 n’est pas pris en charge ici.';

  @override
  String get ui3CustomProxy => 'Proxy personnalisé';

  @override
  String get ui3CustomProxyDesc =>
      'Utiliser un proxy HTTP ou HTTPS personnalisé pour le trafic Matrix et les aperçus de liens';

  @override
  String get ui3ProxyEndpoint => 'Adresse du proxy';

  @override
  String get ui3ProxyEndpointDesc =>
      'Adresse du proxy HTTP/HTTPS (SOCKS non pris en charge)';

  @override
  String get ui3InvalidEndpoint => 'Adresse non valide';

  @override
  String get ui3CustomProxyStaysOff =>
      'Le proxy personnalisé reste désactivé tant qu’aucune adresse valide n’est définie';

  @override
  String get ui3NotificationFilterNote =>
      'Les règles prioritaires notifient toujours (en ignorant la sourdine, les mentions uniquement et Ne pas déranger). Les mots-clés masqués suppriment les notifications.';

  @override
  String get ui3PriorityKeywords => 'Mots-clés prioritaires';

  @override
  String get ui3PriorityKeywordHint => 'ex. : urgent';

  @override
  String get ui3MutedKeywords => 'Mots-clés masqués';

  @override
  String get ui3MutedKeywordHint => 'ex. : spam';

  @override
  String get ui3PrioritySenders => 'Expéditeurs prioritaires';

  @override
  String get ui3CaseSensitive => 'Respecter la casse';

  @override
  String get ui3None => 'Aucun';

  @override
  String get ui3SmartReplyTranslation =>
      'Traduction des réponses intelligentes';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Traduire automatiquement vos messages dans la langue du destinataire avant l’envoi.';

  @override
  String get ui3FromPhotos => 'Depuis Photos';

  @override
  String get ui3ChangePhoto => 'Changer de photo';

  @override
  String get ui3RoamingUsesMobileData =>
      'L’itinérance suit les règles des données mobiles';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'La détection de l’itinérance n’est pas encore disponible : l’itinérance suit donc les réglages de téléchargement automatique des données mobiles.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Supprimer « $content » ?';
  }

  @override
  String get ui3ResetToDefaults => 'Rétablir les valeurs par défaut';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Toutes les réponses rapides personnalisées seront supprimées et celles par défaut restaurées. Continuer ?';

  @override
  String get ui3LocalLlmUnavailable => 'Non pris en charge sur cet appareil';

  @override
  String get ui3LocalLlmNotDownloaded => 'Modèle non téléchargé';

  @override
  String get ui3LocalLlmReady => 'Prêt (sur l’appareil)';

  @override
  String get ui3LocalLlmDescription =>
      'Une fois activées et prêtes, les fonctions d’IA (résumé, reformulation, traduction, réponses) s’exécutent entièrement sur l’appareil — vos données ne quittent jamais votre téléphone. Sinon, elles utilisent le fournisseur cloud.';

  @override
  String get ui3UseOnDeviceAi => 'Utiliser l’IA sur l’appareil';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'Privilégier l’inférence locale quand elle est prête';

  @override
  String get ui3DownloadModel => 'Télécharger le modèle';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'L’inférence sur l’appareil nécessite l’environnement d’exécution natif (Android MediaPipe / iOS Core ML). Elle s’activera automatiquement dès que le gestionnaire de la plateforme sera disponible.';

  @override
  String get ui3PhotoAvatar => 'Avatar photo';

  @override
  String get ui3AvatarStyles => 'Styles d’avatar';

  @override
  String get ui3AvatarStylesDesc =>
      'Utiliser un seul sélecteur de décorations pour le profil et les accès à l’avatar.';

  @override
  String get ui3ReplaceNftAvatar => 'Remplacer l’avatar NFT';

  @override
  String get ui3NftAvatarDesc =>
      'Utilisez un objet de collection on-chain comme avatar.';

  @override
  String get ui3UsePhotoAvatar => 'Utiliser l’avatar photo';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Conserver l’avatar importé et supprimer l’association NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Style d’avatar défini : $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'Avatar NFT mis à jour';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Retour à l’avatar photo';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Connectez-vous pour voir l’historique des enveloppes rouges';

  @override
  String get ui3RedPacketActive => 'En cours';

  @override
  String get ui3RedPacketCompleted => 'Terminées';

  @override
  String get ui3CardsAndPasses => 'Cartes et pass';

  @override
  String get ui3CardsAndPassesDesc =>
      'Les cartes du portefeuille, coupons et pass sont gérés dans l’app principale.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'Le paquet de cartes nécessite l’app principale';

  @override
  String get ui3OpenCardPack => 'Ouvrir le paquet de cartes';

  @override
  String get ui3UnableToOpenChat =>
      'Impossible d’ouvrir une discussion avec ce contact';

  @override
  String get ui3WalletManagedInMainApp =>
      'Le portefeuille est géré dans l’app principale';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Formules';
  }

  @override
  String get ui3NewPlan => 'Nouvelle formule';

  @override
  String get ui3MySubscriptions => 'Mes abonnements';

  @override
  String get ui3AvailablePlans => 'Formules disponibles';

  @override
  String get ui3NoPlansYet =>
      'Aucune formule · appuyez sur « Nouvelle formule » pour en créer une';

  @override
  String ui3DaysLeft(Object days) {
    return '$days j restants';
  }

  @override
  String get ui3SubscriptionCancelled => 'Annulé';

  @override
  String get ui3AutoRenewOn => 'Renouvellement auto : activé';

  @override
  String get ui3AutoRenewOff => 'Renouvellement auto : désactivé';

  @override
  String get ui3CancelSubscriptionTitle => 'Annuler l’abonnement ?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Votre abonnement à $name reste actif jusqu\'à son expiration et ne sera pas renouvelé.';
  }

  @override
  String get ui3Subscribe => 'S\'abonner';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Abonné à $name';
  }

  @override
  String get ui3PlanPriceLabel => 'Prix (ex. 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Description (facultatif)';

  @override
  String get ui3PlanBenefitsLabel => 'Avantages (séparés par des virgules)';

  @override
  String get ui3PlanPeriod => 'Période :';

  @override
  String get ui3Monthly => 'Mensuel';

  @override
  String get ui3Yearly => 'Annuel';

  @override
  String get ui3SaveRemarkFailed => 'Impossible d\'enregistrer la note';

  @override
  String get ui3CopyLink => 'Copier le lien';

  @override
  String get ui3Connect => 'Se connecter';

  @override
  String get ui3CommonTokens => 'Jetons en commun';

  @override
  String get ui3SharedNfts => 'NFT en commun';

  @override
  String get ui3TransactionHistory => 'Historique des transactions';

  @override
  String get ui3CommonDaos => 'DAO en commun';

  @override
  String get ui3SameChains => 'Mêmes chaînes';

  @override
  String get ui3ChatInitFailed => 'Échec de l\'initialisation du chat';

  @override
  String get ui3CheckNetworkRetry =>
      'Vérifiez votre connexion réseau et réessayez';

  @override
  String get ui3FromContacts => 'Depuis les contacts';

  @override
  String get ui3FindFriendsFromContacts =>
      'Trouvez des amis parmi vos contacts';

  @override
  String get ui3EnsOrDomain => 'ENS / Domaine';

  @override
  String get ui3LoadingContacts => 'Chargement des contacts...';

  @override
  String get ui3ContactsPermissionRequired =>
      'Autorisation d\'accès aux contacts requise';

  @override
  String get ui3ContactsPermissionMessage =>
      'Pour trouver des amis parmi vos contacts, autorisez l\'accès à vos contacts.';

  @override
  String get ui3AllowAccess => 'Autoriser l\'accès';

  @override
  String get ui3NoContactMatches => 'Aucune correspondance trouvée';

  @override
  String get ui3NoContactMatchesMessage =>
      'Aucun de vos contacts n\'utilise encore cette app. Invitez-les à la rejoindre !';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count contacts analysés';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return '$count correspondances trouvées dans vos contacts';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'Dans les contacts : $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Supprimer cette photo ?';

  @override
  String get ui3InviteLink => 'Lien d\'invitation';

  @override
  String get ui3ShareJoinLink => 'Partager un lien pour rejoindre ce salon';

  @override
  String get ui3ShareRoomReference =>
      'Partager une référence du salon avec les membres invités';

  @override
  String get ui3ScanToJoinGroup =>
      'Scannez pour rejoindre directement ce groupe';

  @override
  String get ui3ScanToShareRoomReference =>
      'Scannez pour partager la référence de ce salon avec les membres invités';

  @override
  String get ui3InviteLinkLoadFailed =>
      'Impossible de charger le lien d\'invitation';

  @override
  String get ui3InviteLinkCopied => 'Lien d\'invitation copié';

  @override
  String get ui3ChannelCategoryOptional => 'Catégorie (facultatif)';

  @override
  String get ui3ChannelCategoryHint => 'Annonces / Produit / Assistance';

  @override
  String get ui3DescriptionOptional => 'Description (facultatif)';

  @override
  String get ui3WebhookEnable => 'Activer l\'automatisation par webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'Envoie les événements d\'arrivée de membres et de bienvenue à votre point de terminaison.';

  @override
  String get ui3WebhookUrl => 'URL du webhook';

  @override
  String get ui3WebhookSecretOptional => 'Secret de signature (facultatif)';

  @override
  String get ui3WebhookSecretHint => 'Utilisé pour X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined =>
      'Notifier lorsqu\'un membre rejoint';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'Notifier lors de l\'envoi du message de bienvenue';

  @override
  String get ui3WebhookTestSend => 'Envoyer un webhook de test';

  @override
  String get ui3WebhookTestSending => 'Envoi du webhook de test...';

  @override
  String get ui3WebhookTestSent => 'Webhook de test envoyé avec succès';

  @override
  String get ui3WebhookTestFailed => 'Échec de l\'envoi du webhook de test';

  @override
  String get ui3WebhookUrlInvalid =>
      'L\'URL du webhook doit être une adresse HTTPS publique';

  @override
  String get ui3WebhookSelectEvent =>
      'Sélectionnez au moins un événement webhook';

  @override
  String get ui3SensitiveDataDetection => 'Détection des données sensibles';

  @override
  String get ui3Email => 'E-mail';

  @override
  String get ui3CreditCard => 'Carte bancaire';

  @override
  String get ui3DetectEmailDesc =>
      'Détecter les adresses e-mail dans les messages texte';

  @override
  String get ui3DetectPhoneDesc =>
      'Détecter les numéros de téléphone et internationaux';

  @override
  String get ui3DetectCardDesc =>
      'Détecter les numéros bancaires et de carte probables';

  @override
  String get ui3DetectWalletDesc =>
      'Détecter les adresses de portefeuille de type Ethereum';

  @override
  String get ui3GeneralTopic => 'Général';

  @override
  String get a11yPreviousResult => 'Résultat précédent';

  @override
  String get a11yNextResult => 'Résultat suivant';

  @override
  String get ui3TryDifferentKeywords => 'Essayez d\'autres mots-clés';

  @override
  String ui3FiltersActive(Object count) {
    return 'Filtres actifs : $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Filtres de messages actifs : $count';
  }

  @override
  String get ui3LoadMore => 'Charger plus';

  @override
  String get ui3MessageFilters => 'Filtres de messages';

  @override
  String get ui3SenderUserId => 'ID utilisateur de l\'expéditeur';

  @override
  String get ui3FilterType => 'Type de message';

  @override
  String get ui3FilterAny => 'Tous';

  @override
  String get ui3FilterImage => 'Photo';

  @override
  String get ui3FilterTime => 'Date';

  @override
  String get ui3AnyTime => 'N\'importe quand';

  @override
  String get ui3OnlyMyMessages => 'Mes messages uniquement';

  @override
  String get ui3MediaOnly => 'Médias uniquement';

  @override
  String get ui3Apply => 'Appliquer';

  @override
  String get ui3QrStyleClassic => 'Classique';

  @override
  String get ui3QrStyleOcean => 'Océan';

  @override
  String get ui3QrStyleBerry => 'Baie';

  @override
  String get a11yFlashlightOn => 'Allumer la lampe torche';

  @override
  String get a11yFlashlightOff => 'Éteindre la lampe torche';

  @override
  String get ui3SocialGraph => 'Graphe social';

  @override
  String get ui3RecommendedConnections => 'Connexions recommandées';

  @override
  String get ui3Portfolio => 'Portefeuille';

  @override
  String get ui3Chains => 'Chaînes';

  @override
  String get ui3Tokens => 'Jetons';

  @override
  String get ui3NoConnectionsFound => 'Aucune connexion trouvée';

  @override
  String get ui3ConnectionsHint =>
      'Les connexions apparaissent au fil de votre activité on-chain';

  @override
  String get ui3SocialGraphLoadFailed =>
      'Impossible de charger le graphe social';

  @override
  String get ui3Similarity => 'Similarité';

  @override
  String get ui3Breakdown => 'Détail';

  @override
  String get ui3TokenHoldings => 'Tokens détenus';

  @override
  String get ui3NftCollections => 'Collections NFT';

  @override
  String get ui3ChainUsage => 'Utilisation des chaînes';

  @override
  String get ui3Transactions => 'Opérations';

  @override
  String get ui3DaoMembership => 'Adhésion aux DAO';

  @override
  String get ui3NotWeighted => 'Non pondéré';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent % (poids : $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Activité on-chain commune';

  @override
  String get ui3SharedTokens => 'Tokens en commun';

  @override
  String get ui3SharedNftCollections => 'Collections NFT en commun';

  @override
  String get ui3SharedChains => 'Chaînes en commun';

  @override
  String get ui3NoSharedTokens => 'Aucun token en commun';

  @override
  String get ui3NoSharedNftCollections => 'Aucune collection NFT en commun';

  @override
  String get ui3NoSharedChains => 'Aucune chaîne en commun';

  @override
  String get ui3SimilarityFailed => 'Impossible de calculer la similarité';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +$count autres';
  }

  @override
  String get a11yGovernance => 'Gouvernance';

  @override
  String get ui3CommunityLink => 'Lien de la communauté';

  @override
  String get ui3CommunityQrCode => 'QR code de la communauté';

  @override
  String get ui3CommunityQrSubtitle =>
      'Scannez pour rejoindre cette communauté et parcourir ses canaux';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Impossible de charger le lien de la communauté';

  @override
  String get ui3CommunityLinkCopied => 'Lien de la communauté copié';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name sera retiré(e) de cette communauté.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name sera retiré(e) et ne pourra plus rejoindre.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Connectez-vous pour découvrir les canaux publics';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Impossible de rejoindre $name : $error';
  }

  @override
  String get ui3CategoryTech => 'Technologie';

  @override
  String get ui3CategorySocial => 'Réseaux sociaux';

  @override
  String get ui3NoPublicChannels => 'Aucun canal public trouvé';

  @override
  String get ui3StoriesAndFun => 'Stories et divertissement';

  @override
  String get ui3SearchMusicHint => 'Rechercher des titres, artistes ou amis';

  @override
  String get ui3ForYou => 'Pour vous';

  @override
  String get ui3Liked => 'Aimés';

  @override
  String get ui3NoLikedMusic => 'Aucune musique aimée pour l\'instant';

  @override
  String get ui3NoMusicStories => 'Aucune story musicale pour l\'instant';

  @override
  String get ui3LikedMusicHint =>
      'Touchez le cœur à côté d\'un titre pour le retrouver ici.';

  @override
  String get ui3MusicStoriesHint =>
      'La musique partagée dans les stories apparaîtra ici.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · partagé par $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Impossible de lire $title : $error';
  }

  @override
  String get a11yPreviousTrack => 'Titre précédent';

  @override
  String get a11yNextTrack => 'Titre suivant';

  @override
  String get a11yPlay => 'Lire';

  @override
  String get a11yPause => 'Mettre en pause';

  @override
  String get ui3Refresh => 'Actualiser';

  @override
  String get ui3NearbyIntroTitle =>
      'Découvrez les publications publiques à proximité';

  @override
  String get ui3NearbyIntroBody =>
      'Votre position est utilisée une seule fois sur cet appareil pour trier les Moments publics. Elle n\'est ni envoyée, ni diffusée, ni montrée à d\'autres personnes.';

  @override
  String get ui3UseMyLocation => 'Utiliser ma position';

  @override
  String get ui3NearbyUnavailable => 'À proximité est indisponible';

  @override
  String get ui3NoNearbyPosts =>
      'Aucune publication à proximité pour l\'instant';

  @override
  String get ui3NoNearbyPostsHint =>
      'Les Moments publics avec une position apparaîtront ici.';

  @override
  String get ui3NearbyDistanceNote =>
      'Distance approximative · publications publiques géolocalisées uniquement';

  @override
  String get ui3PublicLocationPost => 'Publication publique géolocalisée';

  @override
  String get ui3LocationServicesOff =>
      'Le service de localisation est désactivé';

  @override
  String get ui3LocationPermissionDenied =>
      'L\'autorisation de localisation a été refusée';

  @override
  String get ui3EnableLocationInSettings =>
      'Activez l\'autorisation de localisation dans les réglages du système';

  @override
  String get ui3CreateStory => 'Créer une story';

  @override
  String get ui3CreateStoryDesc => 'Publiez un statut texte ou photo.';

  @override
  String get ui3StoryCamera => 'Caméra story';

  @override
  String get ui3StoryCameraDesc =>
      'Accédez directement aux filtres et à la retouche photo.';

  @override
  String get ui3MomentsDesc => 'Ouvrez le fil complet et les commentaires.';

  @override
  String get ui3MomentCamera => 'Caméra Moments';

  @override
  String get ui3MomentCameraDesc =>
      'Créez une publication et choisissez un média immédiatement.';

  @override
  String get ui3GamesDesc => 'Lancez le centre de jeux occasionnels intégré.';

  @override
  String get ui3AvatarStudio => 'Studio d\'avatars';

  @override
  String get ui3AvatarStudioDesc =>
      'Décorations, avatar NFT et touches d\'identité.';

  @override
  String get ui3SocialGraphDesc => 'Abonnements, fans et connexions on-chain.';

  @override
  String get ui3SocialHubHeroTitle => 'Stories, moments, jeux et avatars';

  @override
  String get ui3SocialHubHeroBody =>
      'Toutes les fonctions sociales au même endroit, au lieu d\'être dispersées entre chat, profil et découverte.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'Le graphe social n\'est pas configuré dans cette version';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Connectez un portefeuille pour voir votre graphe social';

  @override
  String get ui3AvatarStudioSignIn =>
      'Le studio d\'avatars nécessite une connexion';

  @override
  String get a11yRemoveImage => 'Supprimer l\'image';

  @override
  String get a11yBack => 'Retour';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Confirmer la transaction';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Une mini-app demande à envoyer une transaction en votre nom.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Ouvrir $name ?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Ouvrir';

  @override
  String get ui3StoryReplySendFailed =>
      'Impossible d\'envoyer la réponse à la story';

  @override
  String get ui3RedPacketDemoNotice =>
      'Enveloppe rouge de démonstration — simple trace dans le chat, aucun actif on-chain réel n\'est transféré.';

  @override
  String get ui3RedPacketCoverClassic => 'Rouge classique';

  @override
  String get ui3RedPacketCoverGolden => 'Doré';

  @override
  String get ui3RedPacketCoverPurple => 'Violet';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Bleu océan';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Vert nature';

  @override
  String get ui3RedPacketCoverRosePink => 'Rose poudré';

  @override
  String get ui3RedPacketHistoryEmpty =>
      'Aucune enveloppe rouge pour l\'instant';

  @override
  String get ui3TransferMerchantQrWithAmount => 'QR marchand (avec montant)';

  @override
  String get ui3TransferMerchantQrTitle => 'QR marchand';

  @override
  String get ui3TransferOpenAmountHint => 'Laissez vide pour un montant libre';

  @override
  String get ui3FiatRampTitle => 'Acheter / vendre des cryptos';

  @override
  String get ui3FiatRampBuy => 'Acheter';

  @override
  String get ui3FiatRampSell => 'Vendre';

  @override
  String get ui3FiatRampNotConfigured =>
      'La passerelle fiat d\'entrée/sortie n\'est pas configurée';

  @override
  String get a11yPointsAddRule => 'Ajouter une règle de récompense';

  @override
  String get a11yGovernanceRemoveChoice => 'Supprimer l\'option';

  @override
  String get a11yGovernanceCreateProposal => 'Créer une proposition';

  @override
  String get ui3MiniAppUpdateN42 => 'Mettre à jour N42';

  @override
  String get ui3MiniAppOfficial => 'Officiel';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count utilisateurs';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Couleur d\'arrière-plan $index';
  }

  @override
  String get a11yStoryAdd => 'Ajouter une story';

  @override
  String get ui3StoryPostFailed => 'Impossible de publier la story';

  @override
  String get ui3StoryTapToSelectImage => 'Appuyez pour choisir une image';

  @override
  String get ui3StoryChangeImage => 'Changer';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Impossible de lire la musique sélectionnée : $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Supprimer cette story ?';

  @override
  String get ui3StoryDeleteFailed => 'Impossible de supprimer la story';

  @override
  String get ui3MomentCreateTitle => 'Créer un moment';

  @override
  String get ui3MomentContentHint => 'À quoi pensez-vous ?';

  @override
  String get ui3MomentAddPhotos => 'Ajouter des photos';

  @override
  String get ui3MomentAddLocation => 'Ajouter un lieu';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Médias sélectionnés ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Tout effacer';

  @override
  String get ui3MomentClearMediaConfirm =>
      'Retirer toutes les photos/vidéos sélectionnées ?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Visible par tous les amis';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Visible par vous uniquement';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Choisir qui peut voir';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Masquer à certains amis';

  @override
  String get ui3MomentVideos => 'Vidéos';

  @override
  String get ui3MomentNoVideos => 'Aucune vidéo pour l\'instant';

  @override
  String get a11yCallMinimize => 'Réduire';

  @override
  String get a11yCallGridView => 'Vue en grille';

  @override
  String get a11yCallFocusView => 'Vue focalisée';

  @override
  String get ui3CallTools => 'Outils d\'appel';

  @override
  String get ui3CallMeetingTools => 'Outils de réunion';

  @override
  String get ui3CallToolsSubtitle =>
      'Réglez la qualité audio et vidéo sans quitter l\'appel.';

  @override
  String get ui3CallAudioEnhancement => 'Amélioration audio';

  @override
  String get ui3CallNoiseSuppression => 'Suppression du bruit';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Réduit les bruits de clavier et de fond.';

  @override
  String get ui3CallEchoCancellation => 'Annulation de l\'écho';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Empêche le son du haut-parleur de revenir dans le micro.';

  @override
  String get ui3CallAutoGainControl => 'Contrôle automatique du gain';

  @override
  String get ui3CallAutoGainControlDesc => 'Stabilise le volume du micro.';

  @override
  String get ui3CallVoiceIsolation => 'Isolation vocale améliorée';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Utilise un profil de réduction du bruit plus puissant.';

  @override
  String get ui3CallVideoSection => 'Vidéo';

  @override
  String get ui3CallBackgroundBlur => 'Flou d\'arrière-plan (bêta)';

  @override
  String get ui3CallBlurDescReady =>
      'Préférence activée. Le flou visible dépend encore du déploiement du traitement vidéo.';

  @override
  String get ui3CallBlurDescSaved =>
      'La préférence de flou est enregistrée et s\'appliquera dès que le traitement de la caméra sera disponible.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Activez votre caméra une fois le traitement de l\'arrière-plan disponible.';

  @override
  String get ui3CallRecordingSection => 'Enregistrement';

  @override
  String get ui3CallRecordingDesc =>
      'Nécessite une sortie côté serveur pour enregistrer les enregistrements.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Impossible de mettre à jour les paramètres d\'appel : $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Enregistrement démarré';

  @override
  String get ui3VoiceRoomNotFound => 'Salon introuvable';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Voulez-vous vraiment mettre fin à ce salon vocal ?';

  @override
  String get a11yGameMoveUp => 'Déplacer vers le haut';

  @override
  String get a11yGameMoveDown => 'Déplacer vers le bas';

  @override
  String get a11yGameMoveLeft => 'Déplacer vers la gauche';

  @override
  String get a11yGameMoveRight => 'Déplacer vers la droite';

  @override
  String get a11yGameRotate => 'Faire pivoter';

  @override
  String get a11yGameDrop => 'Lâcher';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count sticker(s) ajouté(s)';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Échec de l\'ajout : $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Retirer le sticker';

  @override
  String get ui3StickerRemoveConfirm => 'Retirer ce sticker du pack ?';

  @override
  String get ui3StickerRemoveFailed => 'Échec du retrait';

  @override
  String get ui3StickerRenamePack => 'Renommer le pack';

  @override
  String get ui3StickerPackName => 'Nom du pack';

  @override
  String get ui3StickerRenameFailed => 'Échec du renommage';

  @override
  String get ui3StickerDeletePack => 'Supprimer le pack';

  @override
  String get ui3StickerThisPack => 'ce pack';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Supprimer « $name » et tous ses stickers ? Cette action est irréversible.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Échec de la suppression';

  @override
  String get ui3StickerPack => 'Pack de stickers';

  @override
  String get ui3StickerAdding => 'Ajout…';

  @override
  String get ui3StickerAddStickers => 'Ajouter des stickers';

  @override
  String get ui3StickerPackNotFound => 'Pack introuvable';

  @override
  String get ui3StickerEmptyHint =>
      'Appuyez sur « Ajouter des stickers » pour importer des images';

  @override
  String get ui3StickerNewPack => 'Nouveau pack de stickers';

  @override
  String get ui3StickerCreate => 'Créer';

  @override
  String get ui3StickerCreateFailed => 'Impossible de créer le pack';

  @override
  String ui3StickerInstalled(Object name) {
    return '« $name » installé';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Retirer le pack de stickers';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Retirer « $name » de vos stickers ?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '« $name » retiré';
  }

  @override
  String get ui3StickerAiSticker => 'Sticker IA';

  @override
  String get ui3StickerStoreTab => 'Boutique';

  @override
  String get ui3StickerMyStickersTab => 'Mes stickers';

  @override
  String get ui3StickerNoneFound => 'Aucun sticker trouvé';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'par $author';
  }

  @override
  String get ui3StickerManage => 'Gérer';

  @override
  String ui3StickerCount(Object count) {
    return 'Stickers : $count';
  }

  @override
  String get ui3StickerNoneInstalled => 'Aucun sticker installé';

  @override
  String get ui3StickerGetFromStore => 'Obtenez des stickers dans la boutique';

  @override
  String get ui3StickerBrowseStore => 'Parcourir la boutique';

  @override
  String get ui3StickerAddedToAi => 'Ajouté à « Stickers IA »';

  @override
  String get ui3StickerAddOneFailed => 'Impossible d\'ajouter le sticker';

  @override
  String get ui3StickerPromptLabel => 'Décrivez votre sticker';

  @override
  String get ui3StickerPromptHint =>
      'ex. : un chat roux joyeux avec des lunettes de soleil';

  @override
  String get ui3StickerGenerating => 'Génération…';

  @override
  String get ui3StickerGenerate => 'Générer';

  @override
  String get ui3StickerAddToStickers => 'Ajouter aux stickers';

  @override
  String get ui3StickerGeneratingPreview => 'Génération de votre sticker…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Décrivez un sticker et appuyez sur « Générer »';
}
