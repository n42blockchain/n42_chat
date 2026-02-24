// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonUnknownUser => 'Usuario desconocido';

  @override
  String get transferWalletNotConnected => 'Billetera no conectada';

  @override
  String get chatCallServiceNotInitialized =>
      'Servicio de llamadas no inicializado';

  @override
  String authLoginFailed(String error) {
    return 'Error de inicio de sesion: $error';
  }

  @override
  String get chatCallBack => 'Devolver llamada';

  @override
  String get chatMissedVideoCall => 'Videollamada perdida';

  @override
  String get chatMissedVoiceCall => 'Llamada de voz perdida';

  @override
  String get chatCallNotAnswered => 'No contestada';

  @override
  String get chatCallDurationLabel => 'Duración de la llamada';

  @override
  String get chatVoiceCallCancelled => 'Llamada de voz cancelada';

  @override
  String get chatVideoCallCancelled => 'Videollamada cancelada';

  @override
  String get commonImage => '[Imagen]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Voz]';

  @override
  String get commonFile => '[Archivo]';

  @override
  String get chatLocation => '[Ubicacion]';

  @override
  String get chatUnknownMessage => '[Mensaje desconocido]';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get chatDeleteThisMessage => '¿Eliminar este mensaje?';

  @override
  String get chatMessageDeleted => 'Mensaje eliminado';

  @override
  String get profileNotLoggedIn => 'No has iniciado sesion';

  @override
  String get chatMyLocation => 'Mi ubicacion';

  @override
  String get commonGroupChat => 'Chat grupal';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonLoadFailed => 'Error al cargar';

  @override
  String get commonMessages => 'Mensajes';

  @override
  String get commonContacts => 'Contactos';

  @override
  String get commonMe => 'Yo';

  @override
  String get commonVoiceLoading => 'Cargando audio, intenta de nuevo mas tarde';

  @override
  String get commonVoiceToTextFailed => 'Error al convertir voz a texto';

  @override
  String get commonConvertToText => 'A texto';

  @override
  String get chatCopy => 'Copiar';

  @override
  String get commonForward => 'Reenviar';

  @override
  String get commonUnfavorite => 'Quitar de favoritos';

  @override
  String get commonFavorite => 'Favorito';

  @override
  String get settingsResend => 'Reenviar';

  @override
  String get chatRecall => 'Retirar';

  @override
  String get commonQuote => 'Citar';

  @override
  String get commonRemind => 'Recordar';

  @override
  String get chatCopied => 'Copiado';

  @override
  String get storySendMessageHint => 'Enviar un mensaje';

  @override
  String get commonMicrophonePermissionRequired =>
      'Por favor permite el acceso al microfono';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Error al iniciar grabacion: $error';
  }

  @override
  String get commonRecordingTooShort => 'Grabacion muy corta';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Error al detener grabacion: $error';
  }

  @override
  String get chatReleaseToCancel => 'Suelta para cancelar';

  @override
  String get chatReleaseToSend =>
      'Suelta para enviar, desliza hacia arriba para cancelar';

  @override
  String get commonHoldToTalk => 'Manten presionado para hablar';

  @override
  String get commonSend => 'Enviar';

  @override
  String get commonAddFriend => 'Agregar amigo';

  @override
  String get commonChatServiceNotConnected => 'Servicio de chat no conectado';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Usuario \"$query\" no encontrado\n\nSugerencias:\n- Intenta ingresar el ID completo, ej. @usuario:servidor.com\n- Verifica la ortografia del nombre de usuario';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Error al crear chat: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Error en la busqueda: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Ingresa ID de usuario o nombre para buscar';

  @override
  String get contactSearching => 'Buscando...';

  @override
  String get contactSearchUserToChat => 'Busca un usuario para iniciar un chat';

  @override
  String get contactMatrixIdExample =>
      'Puedes ingresar un ID de Matrix completo\nej. @usuario:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Usuario \"$username\" no encontrado';
  }

  @override
  String get commonChat => 'Chat';

  @override
  String get commonSettings => 'Configuracion';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get authLogin => 'Iniciar sesion';

  @override
  String get commonCreateGroup => 'Crear grupo';

  @override
  String get chatError => 'Error';

  @override
  String get commonTransfer => 'Transferir';

  @override
  String get commonReceived => 'Recibido';

  @override
  String get commonRefunded => 'Reembolsado';

  @override
  String get commonExpired => 'Expirado';

  @override
  String get chatRedPacketGreeting => 'Mejores deseos';

  @override
  String get commonN42RedPacket => 'Sobre rojo N42';

  @override
  String get commonClaimed => 'Reclamado';

  @override
  String get commonAllClaimed => 'Todo reclamado';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Responder';

  @override
  String get commonEdit => 'Editar';

  @override
  String get chatSelectForwardTarget => 'Seleccionar destinatario';

  @override
  String commonSendCount(int count) {
    return 'Enviar ($count)';
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
  String get contactFriendInfo => 'Info del amigo';

  @override
  String get contactFriendInfoDesc =>
      'Agrega notas, telefono, etiquetas, anotaciones, fotos y configura permisos.';

  @override
  String get commonMoments => 'Momentos';

  @override
  String get commonSendMessage => 'Mensaje';

  @override
  String get contactAudioVideoCall => 'Llamada de audio/video';

  @override
  String get contactVideoChannel => 'Canal de video';

  @override
  String get contactRemark => 'Nota';

  @override
  String get contactRemarkName => 'Nombre de nota';

  @override
  String get contactPhone => 'Telefono';

  @override
  String get contactTags => 'Etiquetas';

  @override
  String get contactNotes => 'Notas';

  @override
  String get contactPhotos => 'Fotos';

  @override
  String get contactPermissions => 'Permisos';

  @override
  String get contactChatMomentsEtc => 'Chat, Momentos, Deportes, etc.';

  @override
  String get contactMoreInfo => 'Mas informacion';

  @override
  String get contactCommonGroups => 'Grupos en comun';

  @override
  String get contactSource => 'Origen';

  @override
  String get settingsNotificationSettings => 'Notificaciones';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get commonLogout => 'Cerrar sesion';

  @override
  String get commonLogoutConfirm =>
      'Estas seguro de que quieres cerrar sesion?';

  @override
  String get commonSave => 'Guardar';

  @override
  String get profileNickname => 'Apodo';

  @override
  String get profileEnterNickname => 'Ingresa apodo';

  @override
  String get profileSignature => 'Firma';

  @override
  String get profileAddSignature => 'Agregar una firma';

  @override
  String get commonTakePhoto => 'Tomar foto';

  @override
  String get profileChooseFromGallery => 'Elegir de la galeria';

  @override
  String profileSaveFailed(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Mensajeria segura y descentralizada';

  @override
  String get commonEndToEndEncryption => 'Cifrado de extremo a extremo';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Mensajes visibles solo para ti y el destinatario';

  @override
  String get authDecentralized => 'Descentralizado';

  @override
  String get authBasedOnMatrix => 'Basado en el protocolo abierto Matrix';

  @override
  String get authWalletIntegration => 'Integracion de billetera';

  @override
  String get authEasyCryptoTransfer =>
      'Transferencias de criptomonedas faciles';

  @override
  String get authRegister => 'Registrarse';

  @override
  String get authAgreeTerms => 'Al iniciar sesion, aceptas';

  @override
  String get authTermsOfService => 'Terminos de servicio';

  @override
  String get authAnd => 'y';

  @override
  String get authPrivacyPolicy => 'Politica de privacidad';

  @override
  String get authServerAddress => 'Direccion del servidor';

  @override
  String get authEnterServerAddress => 'Ingresa direccion del servidor';

  @override
  String authConnectedTo(String serverName) {
    return 'Conectado a $serverName';
  }

  @override
  String get authUsername => 'Nombre de usuario';

  @override
  String get authEnterUsername => 'Ingresa nombre de usuario';

  @override
  String get authUsernameOrEmail => 'Usuario o Email';

  @override
  String get authEnterUsernameOrEmail => 'Ingresa usuario o email';

  @override
  String get authPassword => 'Contrasena';

  @override
  String get authEnterPassword => 'Ingresa contrasena';

  @override
  String get authRegisterAccount => 'Registrarse';

  @override
  String get authForgotPassword => 'Olvide mi contrasena';

  @override
  String get authOtherLoginMethods => 'Otros metodos de inicio de sesion';

  @override
  String get authCreateAccount => 'Crear cuenta';

  @override
  String get authJoinN42Chat => 'Unete a N42 Chat para comenzar a chatear';

  @override
  String get authUsernameHint => '3-20 caracteres, letras/numeros/_';

  @override
  String get authUsernameMinLength =>
      'El nombre de usuario debe tener al menos 3 caracteres';

  @override
  String get authUsernameMaxLength =>
      'El nombre de usuario debe tener maximo 20 caracteres';

  @override
  String get authUsernameFormat =>
      'El nombre de usuario solo puede contener letras, numeros y guiones bajos';

  @override
  String get authPasswordHint => 'Minimo 8 caracteres';

  @override
  String get commonPasswordMinLength =>
      'La contrasena debe tener al menos 8 caracteres';

  @override
  String get authConfirmPassword => 'Confirmar contrasena';

  @override
  String get authFilled => 'Completado';

  @override
  String get authEnterInviteCode => 'Ingresa codigo de invitacion';

  @override
  String get authAlreadyHaveAccount => 'Ya tienes una cuenta?';

  @override
  String get authLoginNow => 'Iniciar sesion ahora';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Estado';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get conversationNoConversations => 'Sin conversaciones';

  @override
  String get conversationTapToChat =>
      'Toca arriba a la derecha para iniciar un chat';

  @override
  String get conversationStartGroup => 'Iniciar chat grupal';

  @override
  String get commonScan => 'Escanear';

  @override
  String get commonPayment => 'Pago';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature proximamente';
  }

  @override
  String get conversationMarkAsRead => 'Marcar como leido';

  @override
  String get commonUnmute => 'Activar sonido';

  @override
  String get commonMute => 'Silenciar';

  @override
  String get conversationUnpin => 'Desanclar';

  @override
  String get conversationPin => 'Anclar';

  @override
  String get conversationDeleteConversation => 'Eliminar conversacion';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Eliminar conversacion con \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Sin contactos';

  @override
  String get contactAddFriendsToChat => 'Agrega amigos para comenzar a chatear';

  @override
  String get contactNotFound => 'Contacto no encontrado';

  @override
  String get contactTryOtherKeywords =>
      'Intenta con otras palabras clave o busqueda global';

  @override
  String get contactSearchResults => 'Resultados de busqueda';

  @override
  String get contactNewFriends => 'Nuevos amigos';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Cuentas oficiales';

  @override
  String get contactServiceAccounts => 'Cuentas de servicio';

  @override
  String get contactEnterpriseContacts => 'Contactos empresariales';

  @override
  String get contactRecommendToFriend => 'Compartir contacto';

  @override
  String get commonSetRemark => 'Establecer nota';

  @override
  String get contactSendingCard => 'Enviando tarjeta de contacto...';

  @override
  String get commonFileLabel => 'Archivo';

  @override
  String get commonLocationLabel => 'Ubicacion';

  @override
  String contactRecommendFailed(String error) {
    return 'Error al recomendar: $error';
  }

  @override
  String get profileEnterRemark => 'Ingresa nota';

  @override
  String get contactOpeningChat => 'Abriendo chat...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Error al abrir chat: $error';
  }

  @override
  String get contactAddContact => 'Agregar contacto';

  @override
  String get contactEnterUserId => 'Ingresa ID de usuario';

  @override
  String get contactNoFriendRequests => 'Sin solicitudes de amistad';

  @override
  String get commonAccept => 'Aceptar';

  @override
  String get commonReject => 'Rechazar';

  @override
  String get commonNoGroups => 'Sin grupos';

  @override
  String get contactSelectFriendToRecommend =>
      'Selecciona un amigo para recomendar';

  @override
  String get commonSearchContacts => 'Buscar contactos';

  @override
  String get contactNoContactsFound => 'No se encontraron contactos';

  @override
  String get favoriteYesterday => 'Ayer';

  @override
  String get chatJustNow => 'Ahora';

  @override
  String get profileOnline => 'En linea';

  @override
  String get profileOffline => 'Desconectado';

  @override
  String get searchContactsGroupsMessages =>
      'Buscar contactos, grupos, mensajes';

  @override
  String get searchError => 'Error de busqueda';

  @override
  String get chatSearchHint => 'Buscar contactos, grupos y mensajes';

  @override
  String get searchHistory => 'Historial de busqueda';

  @override
  String get commonClear => 'Limpiar';

  @override
  String get commonAll => 'Todo';

  @override
  String get searchGroups => 'Grupos';

  @override
  String get searchNoResults => 'Sin resultados';

  @override
  String commonGroupMembers(int count) {
    return 'Miembros ($count)';
  }

  @override
  String get groupMembersTitle => 'Miembros del grupo';

  @override
  String get groupViewAll => 'Ver todo';

  @override
  String get groupOwner => 'Propietario';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Invitar';

  @override
  String get commonGroupAnnouncement => 'Anuncio del grupo';

  @override
  String get commonNotSet => 'No establecido';

  @override
  String get groupDescription => 'Descripcion del grupo';

  @override
  String get groupPublicGroup => 'Grupo publico';

  @override
  String get commonClearChatHistory => 'Borrar historial de chat';

  @override
  String get commonDissolveGroup => 'Disolver grupo';

  @override
  String get commonLeaveGroup => 'Salir del grupo';

  @override
  String get groupChangeGroupName => 'Cambiar nombre del grupo';

  @override
  String get commonEnterGroupName => 'Ingresa nombre del grupo';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get groupEnterGroupDescription => 'Ingresa descripcion del grupo';

  @override
  String get groupPublish => 'Publicar';

  @override
  String get chatClearHistoryConfirm =>
      'Borrar todo el historial de chat? Esto no se puede deshacer.';

  @override
  String get chatClearAction => 'Borrar';

  @override
  String get commonChatHistoryCleared => 'Historial de chat borrado';

  @override
  String get commonDissolve => 'Disolver';

  @override
  String get groupQrCode => 'Codigo QR del grupo';

  @override
  String get commonSearchChatHistory => 'Buscar historial de chat';

  @override
  String get groupIdCopied => 'ID del grupo copiado';

  @override
  String get transferEnterOrPasteAddress =>
      'Ingresa o pega direccion de billetera';

  @override
  String get transferSelectToken => 'Seleccionar token';

  @override
  String get commonTransferAmount => 'Monto de transferencia';

  @override
  String get transferAvailable => 'Disponible';

  @override
  String get transferMemoOptional => 'Memo (opcional)';

  @override
  String get transferConfirmTransfer => 'Confirmar transferencia';

  @override
  String get transferAddressVerified => 'Direccion verificada';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Disponible: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Ingresa monto';

  @override
  String get commonRedPacketCountMin => 'Se requiere al menos 1 sobre rojo';

  @override
  String get commonViewRedPacketDetails => 'Ver detalles del sobre rojo';

  @override
  String get commonEnterTransferAmount => 'Ingresa monto de transferencia';

  @override
  String get commonTransferTo => 'Transferir a';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'De $senderName';
  }

  @override
  String get commonConfirmReceive => 'Confirmar recepcion';

  @override
  String get groupProfile => 'Info del grupo';

  @override
  String get groupRemoveMember => 'Eliminar del grupo';

  @override
  String get commonRemove => 'Eliminar';

  @override
  String get profileClearStatus => 'Borrar estado';

  @override
  String get profileClearStatusConfirm => 'Borrar estado actual?';

  @override
  String get profileStatusCleared => 'Estado borrado';

  @override
  String get profileUserNotExist => 'El usuario no existe';

  @override
  String get profileUserIdCopied => 'ID de usuario copiado';

  @override
  String get commonReport => 'Reportar';

  @override
  String get profileQrCode => 'Codigo QR';

  @override
  String get profileAvatarUpdated => 'Avatar actualizado';

  @override
  String commonSelectImageFailed(String error) {
    return 'Error al seleccionar imagen: $error';
  }

  @override
  String get profileChangeName => 'Cambiar nombre';

  @override
  String get profileMale => 'Masculino';

  @override
  String get profileFemale => 'Femenino';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature en desarrollo...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Error al guardar direccion: $error';
  }

  @override
  String get profileAddNew => 'Agregar';

  @override
  String get profileAddAddress => 'Agregar direccion';

  @override
  String get profileAddressAdded => 'Direccion agregada';

  @override
  String get profileAddressUpdated => 'Direccion actualizada';

  @override
  String get profileDeleteAddress => 'Eliminar direccion';

  @override
  String get profileAddressDeleted => 'Direccion eliminada';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Error al guardar factura: $error';
  }

  @override
  String get profileMyInvoices => 'Mis facturas';

  @override
  String get profileAddInvoice => 'Agregar factura';

  @override
  String get profileInvoiceAdded => 'Factura agregada';

  @override
  String get profileInvoiceUpdated => 'Factura actualizada';

  @override
  String get profileDeleteInvoice => 'Eliminar factura';

  @override
  String get profileInvoiceDeleted => 'Factura eliminada';

  @override
  String get profilePersonal => 'Personal';

  @override
  String get groupSelectAtLeastOne =>
      'Por favor selecciona al menos un miembro';

  @override
  String get chatFileNotExist => 'El archivo no existe';

  @override
  String chatSendFailed(String error) {
    return 'Error al enviar: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'No se puede abrir el navegador';

  @override
  String chatSelectFileFailed(String error) {
    return 'Error al seleccionar archivo: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Error de configuracion: $error';
  }

  @override
  String get transferEnterValidAmount => 'Por favor ingresa un monto valido';

  @override
  String get commonAddressCopied => 'Direccion copiada';

  @override
  String favoriteOpenItem(String content) {
    return 'Abrir: $content';
  }

  @override
  String get favoriteDeleted => 'Eliminado';

  @override
  String get profileWallet => 'Billetera';

  @override
  String get chatRecording => 'Grabando';

  @override
  String get chatInvalidVideoUrl => 'URL de video invalida';

  @override
  String get chatDownloadFile => 'Descargar archivo';

  @override
  String get chatClearChatHistoryTitle => 'Borrar historial de chat';

  @override
  String get chatVideoCall => 'Videollamada';

  @override
  String get commonVoiceCall => 'Llamada de voz';

  @override
  String get callLeaveMeeting => 'Salir de la reunion';

  @override
  String get chatDetails => 'Detalles del chat';

  @override
  String get chatViewAllGroupMembers => 'Ver todos los miembros';

  @override
  String get chatGroupName => 'Nombre del grupo';

  @override
  String get chatGroupNameUpdated => 'Nombre del grupo actualizado';

  @override
  String get chatUpdateFailed => 'Error de actualizacion';

  @override
  String get chatNoPermissionToModify => 'No tienes permiso para modificar';

  @override
  String get chatGroupManagement => 'Gestion del grupo';

  @override
  String get chatMyNicknameInGroup => 'Mi apodo en el grupo';

  @override
  String get chatPinChat => 'Anclar chat';

  @override
  String get chatStrongReminder => 'Recordatorio fuerte';

  @override
  String get chatSetChatBackground => 'Establecer fondo del chat';

  @override
  String get chatUnknownFile => 'Archivo desconocido';

  @override
  String get chatDownload => 'Descargar';

  @override
  String get chatInvalidLocation => 'Ubicacion invalida';

  @override
  String get chatTapToCancel => 'Toca para cancelar';

  @override
  String chatCaptureFailed(Object error) {
    return 'Error de captura: $error';
  }

  @override
  String get chatProcessingVideo => 'Procesando video...';

  @override
  String get chatVideoFileNotExist => 'El archivo de video no existe';

  @override
  String get chatVideoDataEmpty => 'Los datos del video estan vacios';

  @override
  String get chatVideoTooLarge => 'El tamano del video no puede exceder 100MB';

  @override
  String get chatSendingVideo => 'Enviando video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Error al enviar video: $error';
  }

  @override
  String get chatImageFileNotExist => 'El archivo de imagen no existe';

  @override
  String get commonImageDataEmpty => 'Los datos de la imagen estan vacios';

  @override
  String get chatSendingImage => 'Enviando imagen...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Error al enviar imagen: $error';
  }

  @override
  String get chatSendLocation => 'Enviar ubicacion';

  @override
  String get chatSelectLocationAndSend => 'Selecciona ubicacion y envia';

  @override
  String get chatShareRealTimeLocation => 'Compartir ubicacion en tiempo real';

  @override
  String get chatShareLocationForOneHour =>
      'Comparte tu ubicacion en tiempo real con un amigo por 1 hora';

  @override
  String get chatLocationSent => 'Ubicacion enviada';

  @override
  String get chatSelectMessages => 'Seleccionar mensajes';

  @override
  String chatSelectedCount(int count) {
    return '$count seleccionados';
  }

  @override
  String get chatSelectAll => 'Seleccionar todo';

  @override
  String chatGroupChatCount(int count) {
    return 'Chat grupal ($count)';
  }

  @override
  String get chatPrivateChat => 'Chat privado';

  @override
  String get chatNoMessages => 'Sin mensajes';

  @override
  String get chatSendFirstMessage =>
      'Envia el primer mensaje para iniciar el chat';

  @override
  String get chatEncryptionNotice =>
      'Este chat tiene cifrado de extremo a extremo. Solo tu y el destinatario pueden leer los mensajes.';

  @override
  String get chatMultiForward => 'Reenviar';

  @override
  String get chatCollect => 'Guardar';

  @override
  String get chatNoMembers => 'Sin miembros';

  @override
  String get chatMemberNotFound => 'Miembro no encontrado';

  @override
  String get chatVoiceFileNotExist => 'El archivo de voz no existe';

  @override
  String get chatVoiceFileEmpty => 'El archivo de voz esta vacio';

  @override
  String get chatSendingVoice => 'Enviando voz...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Error al enviar voz: $error';
  }

  @override
  String get chatMessageForwarded => 'Mensaje reenviado';

  @override
  String chatForwardFailed(Object error) {
    return 'Error al reenviar: $error';
  }

  @override
  String get chatUnfavorited => 'Eliminado de favoritos';

  @override
  String get chatFavorited => 'Agregado a favoritos';

  @override
  String get chatReactionAdded => 'Reaccion agregada';

  @override
  String get chatReactionRemoved => 'Reaccion eliminada';

  @override
  String get chatFailedMessageDeleted => 'Mensaje fallido eliminado';

  @override
  String get chatDeleteMessages => 'Eliminar mensajes';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Estas seguro de que quieres eliminar $count mensajes?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Nota: $count mensajes son de otros y solo se eliminaran para ti.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count mensajes tuyos seran retirados para todos.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Retirados $count mensajes, $localCount eliminados solo para ti';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Retirados $count mensajes';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count mensajes eliminados solo para ti';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Reenviados $count mensajes';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Reenvio completo: $success exitosos, $failed fallidos';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'La funcion de recordatorio solo esta disponible en chat grupal';

  @override
  String get chatOnlyTextSearchable =>
      'Solo los mensajes de texto se pueden buscar';

  @override
  String chatSearchFor(Object text) {
    return 'Buscar \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Busqueda Baidu';

  @override
  String get chatGoogleSearch => 'Busqueda Google';

  @override
  String get chatBingSearch => 'Busqueda Bing';

  @override
  String get chatCalling => 'Llamando...';

  @override
  String get chatRinging => 'Sonando...';

  @override
  String get chatInCall => 'En llamada';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Funcion en desarrollo...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Guardados $count mensajes';
  }

  @override
  String commonMemberCount(int count) {
    return '$count miembros';
  }

  @override
  String groupDone(int count) {
    return 'Listo($count)';
  }

  @override
  String get profileServices => 'Servicios';

  @override
  String get commonFavorites => 'Favoritos';

  @override
  String get profileOrdersAndCards => 'Pedidos y tarjetas';

  @override
  String get profileStickers => 'Stickers';

  @override
  String profileStatusSetTo(String status) {
    return 'Estado establecido: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Error al subir avatar';

  @override
  String get profilePersonalProfile => 'Perfil personal';

  @override
  String get profileName => 'Nombre';

  @override
  String get profileGender => 'Genero';

  @override
  String get profileRegion => 'Region';

  @override
  String get commonMyQrCode => 'Mi codigo QR';

  @override
  String get profilePoke => 'Toque';

  @override
  String get profileRingtone => 'Tono';

  @override
  String get profileDefaultRingtone => 'Tono predeterminado';

  @override
  String get profileMyAddresses => 'Mis direcciones';

  @override
  String profileGenderSetTo(String gender) {
    return 'Genero establecido: $gender';
  }

  @override
  String get profileSelectRegion => 'Seleccionar region';

  @override
  String get profileSelectCity => 'Seleccionar ciudad';

  @override
  String profileRegionSetTo(String region) {
    return 'Region establecida: $region';
  }

  @override
  String get profileSetPoke => 'Establecer toque';

  @override
  String get profileFriendPokedMe => 'Un amigo me toco';

  @override
  String get profileExample => 'Ejemplo';

  @override
  String get profileOnTheShoulder => ' en el hombro';

  @override
  String get profilePokeCleared => 'Toque borrado';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Toque establecido: me toco$suffix';
  }

  @override
  String get profileEditSignature => 'Editar firma';

  @override
  String get profileIntroduceYourself => 'Una frase para presentarte';

  @override
  String get profileSignatureCleared => 'Firma borrada';

  @override
  String get profileSignatureUpdated => 'Firma actualizada';

  @override
  String get profileScanToAddFriend =>
      'Escanea el codigo QR de arriba para agregarme como amigo';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Tono establecido: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '¿Estás seguro de que quieres disolver \"$name\"? Esta acción no se puede deshacer.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Por favor ingresa una direccion de servidor valida';

  @override
  String get authEmailOtp => 'OTP por correo';

  @override
  String get authEnterServerAddressFirst =>
      'Por favor ingresa la direccion del servidor primero';

  @override
  String get authPasskeyRequiresServer =>
      'El inicio de sesion con Passkey requiere soporte del servidor';

  @override
  String get authLoginAgreement => 'Al iniciar sesion, aceptas ';

  @override
  String get authPleaseAgreeToTerms =>
      'Por favor lee y acepta los Terminos de servicio y Politica de privacidad';

  @override
  String get authRegisterFailed => 'Error de registro';

  @override
  String get commonReenterPassword => 'Reingresa la contrasena';

  @override
  String get commonPasswordsDoNotMatch => 'Las contrasenas no coinciden';

  @override
  String get authInviteCodeBuiltIn => 'Codigo de invitacion (integrado)';

  @override
  String get authInviteCodeBuiltInNote =>
      'El codigo de invitacion esta integrado, normalmente no es necesario modificarlo';

  @override
  String get authIHaveReadAndAgree => 'He leido y acepto ';

  @override
  String get mainStartGroupChat => 'Iniciar chat grupal';

  @override
  String get mainAddFriends => 'Agregar amigos';

  @override
  String get mainPaymentAndCollection => 'Pago';

  @override
  String contactCount(int count) {
    return '$count contactos';
  }

  @override
  String get contactAddToHomeScreen => 'Agregar a pantalla de inicio';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Tarjeta de $contact recomendada a $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Ingresa nombre de nota';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Nota establecida: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Aceptaste la solicitud de amistad de $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Rechazaste la solicitud de amistad de $name';
  }

  @override
  String get commonGroupInvites => 'Invitaciones a grupos';

  @override
  String commonMyGroups(int count) {
    return 'Mis grupos ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Invitado a unirse al grupo';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '¿Estás seguro de que quieres salir de \"$name\"?';
  }

  @override
  String get commonLeave => 'Salir';

  @override
  String get commonRecallThisMessage => 'Retirar este mensaje?';

  @override
  String get commonSavedToGallery => 'Guardado en galeria';

  @override
  String get commonFailedToSave => 'Error al guardar';

  @override
  String get chatSaving => 'Guardando...';

  @override
  String get commonShare => 'Compartir';

  @override
  String get chatSaveToGallery => 'Guardar en galeria';

  @override
  String chatDownloadFailed(String code) {
    return 'Descarga fallida: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Error al compartir: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Error al cargar imagen';

  @override
  String get chatVideoRecordingFailed =>
      'Error de grabacion de video. Por favor intenta de nuevo.';

  @override
  String get profileRedPacket => 'Sobre rojo';

  @override
  String get commonMusic => 'Musica';

  @override
  String get commonCoupon => 'Cupon';

  @override
  String get commonGift => 'Regalo';

  @override
  String get commonPoll => 'Encuesta';

  @override
  String get favoriteText => 'Texto';

  @override
  String get favoriteLinkLabel => 'Enlace';

  @override
  String get favoriteNote => 'Nota';

  @override
  String get favoriteMyNotes => 'Mis notas';

  @override
  String get favoriteToday => 'Hoy';

  @override
  String favoriteDaysAgoText(int count) {
    return 'Hace $count dias';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Sin favoritos aun';

  @override
  String get favoriteLongPressToFavorite =>
      'Manten presionado un mensaje para agregarlo a favoritos';

  @override
  String get favoriteNewNote => 'Nueva nota';

  @override
  String get favoriteLink => 'Enlace favorito';

  @override
  String get favoriteEditTags => 'Editar etiquetas';

  @override
  String get favoriteDeleteFavorite => 'Eliminar favorito';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Estas seguro de que quieres eliminar este favorito?';

  @override
  String get favoriteNoSearchResultsFound => 'No se encontraron resultados';

  @override
  String get commonSendRedPacket => 'Enviar sobre rojo';

  @override
  String get transferAmount => 'Monto';

  @override
  String get commonRedPacketCover => 'Portada del sobre rojo';

  @override
  String get commonRedPacketType => 'Tipo de sobre rojo';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'De la suerte';

  @override
  String get commonRedPacketCount => 'Cantidad de sobres rojos';

  @override
  String get commonPieces => 'piezas';

  @override
  String get commonPutMoneyInRedPacket => 'Poner dinero en el sobre rojo';

  @override
  String get commonRedPacketRefundNotice =>
      'Los sobres rojos no reclamados seran reembolsados despues de 24 horas';

  @override
  String get commonOpenRedPacket => 'Abrir';

  @override
  String get commonRedPacketAllClaimed => 'Todos los sobres rojos reclamados';

  @override
  String get commonRedPacketExpired => 'Sobre rojo expirado';

  @override
  String get commonAddTransferNote => 'Agregar nota de transferencia';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'Responder con este emoji';

  @override
  String get contactEditRemark => 'Editar nota';

  @override
  String get contactSetPermissions => 'Establecer permisos';

  @override
  String get profileAddToBlacklist => 'Agregar a lista negra';

  @override
  String get contactDeleteContact => 'Eliminar contacto';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Estas seguro de que quieres eliminar a $name?';
  }

  @override
  String get transferTitle => 'Transferir';

  @override
  String get transferReceiverAddressLabel => 'Direccion del destinatario';

  @override
  String get transferSelectTokenLabel => 'Seleccionar token';

  @override
  String get transferAmountLabel => 'Monto de transferencia';

  @override
  String get transferMemoLabel => 'Memo (opcional)';

  @override
  String get transferAddMemoHint => 'Agregar un memo';

  @override
  String get transferSendPaymentRequest => 'Enviar solicitud de pago';

  @override
  String get transferQrCodeGenerateFailed => 'Error al generar codigo QR';

  @override
  String get transferScanQrToPayMe => 'Escanea el codigo QR para pagarme';

  @override
  String get transferMyWalletAddress => 'Mi direccion de billetera';

  @override
  String get transferCreatePaymentRequest => 'Crear solicitud de pago';

  @override
  String profileN42IdLabel(String id) {
    return 'ID N42: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Mejores deseos';

  @override
  String commonSenderRedPacket(String name) {
    return 'Sobre rojo de $name';
  }

  @override
  String get transferEnterValidAddress =>
      'Por favor ingresa una direccion valida';

  @override
  String get transferPleaseSelectToken => 'Por favor selecciona un token';

  @override
  String get commonReceivedTransfer => 'Transferencia recibida';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name envio un sobre rojo';
  }

  @override
  String get commonSavedToBalance =>
      'Guardado en saldo, puedes transferir directamente';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Sobre rojo expirado/todos reclamados';

  @override
  String get transferScanFeatureComingSoon =>
      'Funcion de escaneo proximamente...';

  @override
  String get contactSetAsStarred => 'Marcar como destacado';

  @override
  String get contactAddToBlocklist => 'Agregar a lista de bloqueados';

  @override
  String get commonClaimedYour => ' reclamo tu ';

  @override
  String get commonClaimedText => ' reclamo ';

  @override
  String commonUserTyping(String name) {
    return '$name esta escribiendo...';
  }

  @override
  String get commonTyping => 'Escribiendo...';

  @override
  String get commonWaitingToReceive => 'Esperando recibir';

  @override
  String get commonTapToClaim => 'Toca para reclamar';

  @override
  String get commonHasBeenReceived => 'Ha sido recibido';

  @override
  String get commonGetLucky => 'Buena suerte';

  @override
  String get qrcodeCameraStartFailed => 'Error al iniciar camara';

  @override
  String get qrcodeUnknownError => 'Error desconocido';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Coloca el codigo QR dentro del marco para escanear';

  @override
  String get qrcodeCloseManualInput => 'Cerrar entrada manual';

  @override
  String get qrcodeManualInputUserId => 'Ingresar ID de usuario manualmente';

  @override
  String get commonAdd => 'Agregar';

  @override
  String get profileSetStatus => 'Establecer estado';

  @override
  String get profileVisibleToFriends24h => 'Visible para amigos por 24 horas';

  @override
  String get profileWriteStatus => 'Escribir estado';

  @override
  String get profileEnterYourStatus => 'Ingresa tu estado...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Se requiere permiso de camara para escanear codigo QR';

  @override
  String get qrcodeCameraPermissionDenied =>
      'El permiso de camara fue denegado permanentemente. Por favor habilitalo en configuracion del sistema.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Error al verificar permiso: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Codigo QR invalido';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'No se puede agregar amigo: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Escanear codigo QR';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Verificando permiso de camara...';

  @override
  String get qrcodeNeedCameraPermission => 'Se requiere permiso de camara';

  @override
  String get qrcodeRetryPermission => 'Reintentar';

  @override
  String get qrcodeOpenSettings => 'Abrir configuracion';

  @override
  String get groupInviteMembers => 'Invitar miembros';

  @override
  String groupInviteCount(int count) {
    return 'Invitar($count)';
  }

  @override
  String get profileNoShippingAddress => 'Sin direccion de envio';

  @override
  String get profileDefaultLabel => 'Predeterminado';

  @override
  String get profileNoInvoice => 'Sin factura';

  @override
  String get profileCompany => 'Empresa';

  @override
  String get profileTaxNumber => 'Numero fiscal';

  @override
  String get profileConfirmDeleteAddress =>
      'Estas seguro de que quieres eliminar esta direccion?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Estas seguro de que quieres eliminar esta factura?';

  @override
  String get commonGroupOwner => 'Propietario';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Buscar miembros';

  @override
  String groupTotalMembers(int count) {
    return '$count miembros';
  }

  @override
  String get chatRemoveFromGroup => 'Eliminar del grupo';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Estas seguro de que quieres eliminar a \"$name\" del grupo?';
  }

  @override
  String get chatUnknownSong => 'Cancion desconocida';

  @override
  String get chatUnknownArtist => 'Artista desconocido';

  @override
  String get chatUnknownContact => 'Contacto desconocido';

  @override
  String get chatPersonalCard => 'Tarjeta de contacto';

  @override
  String get chatSingleChoice => 'Unica';

  @override
  String get chatMultiChoice => 'Multiple';

  @override
  String get chatEnded => 'Finalizada';

  @override
  String get chatEndPollButton => 'Finalizar encuesta';

  @override
  String get chatPollHint =>
      'La encuesta se mostrara en el chat. Los miembros del grupo pueden votar.';

  @override
  String get chatSearchSongOrArtist => 'Buscar cancion o artista';

  @override
  String get chatNoSongsFound => 'No se encontraron canciones';

  @override
  String get chatSongNameOptional => 'Nombre de cancion (opcional)';

  @override
  String get chatEnterSongName => 'Ingresa nombre de cancion';

  @override
  String get chatArtistNameOptional => 'Nombre de artista (opcional)';

  @override
  String get chatEnterArtistName => 'Ingresa nombre de artista';

  @override
  String get chatRealTimeLocationSharing =>
      'Compartir ubicacion en tiempo real en desarrollo...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Funcion de llamada de voz en desarrollo...';

  @override
  String get profileReportFeatureInDev => 'Funcion de reporte en desarrollo...';

  @override
  String get profileShareFeatureInDev =>
      'Funcion de compartir en desarrollo...';

  @override
  String get profileQrCodeFeatureInDev =>
      'Funcion de codigo QR en desarrollo...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Escanea el codigo QR de arriba para agregarme como amigo';

  @override
  String get qrcodeSaveToAlbum => 'Guardar en album';

  @override
  String get qrcodeChangeStyle => 'Cambiar estilo';

  @override
  String get qrcodeCopyId => 'Copiar ID';

  @override
  String get qrcodeIdCopied => 'ID copiado';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'Mas estilos proximamente';

  @override
  String get profileBio => 'Biografia';

  @override
  String get profileHomeServer => 'Servidor';

  @override
  String get profileShareContactCard => 'Compartir tarjeta de contacto';

  @override
  String get profileRemoveFromBlacklist => 'Eliminar de lista negra';

  @override
  String get profileConfirmAddBlacklist =>
      'Estas seguro de que quieres agregar a este usuario a la lista negra? No recibiras mensajes de el.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Estas seguro de que quieres eliminar a este usuario de la lista negra?';

  @override
  String get profileRemarkSaved => 'Nota guardada';

  @override
  String get profileRemarkCleared => 'Nota borrada';

  @override
  String get transferReceive => 'Recibir';

  @override
  String get transferPleaseConnectWallet =>
      'Por favor conecta tu billetera primero';

  @override
  String get transferSendRequest => 'Enviar solicitud';

  @override
  String get transferPleaseEnterValidAmount =>
      'Por favor ingresa un monto valido';

  @override
  String get searchPlaceholder => 'Buscar contactos, grupos, mensajes';

  @override
  String get searchEnterKeywordToSearch => 'Ingresa palabras clave para buscar';

  @override
  String get searchClearHistory => 'Borrar';

  @override
  String searchNoResultsForQuery(String query) {
    return 'No se encontraron resultados para \"$query\"';
  }

  @override
  String get searchAllResults => 'Todo';

  @override
  String get searchInChat => 'Buscar en chat';

  @override
  String get searchContactLabel => 'Contacto';

  @override
  String get searchGroupLabel => 'Grupo';

  @override
  String get searchConversationLabel => 'Conversación';

  @override
  String get searchMessageLabel => 'Mensaje';

  @override
  String get settingsSecurityTitle => 'Seguridad';

  @override
  String get settingsKeyBackup => 'Respaldo de claves';

  @override
  String get settingsBackupEncryptionKeys => 'Respaldar claves de cifrado';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count claves respaldadas';
  }

  @override
  String get settingsBackupNotSet => 'Respaldo no configurado';

  @override
  String get settingsRestoreKeys => 'Restaurar claves';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Restaurar claves de cifrado desde respaldo';

  @override
  String get settingsExportKeys => 'Exportar claves';

  @override
  String get settingsExportKeysToFile => 'Exportar claves a archivo';

  @override
  String get settingsLoggedInDevices => 'Dispositivos conectados';

  @override
  String get settingsNoOtherDevices => 'Sin otros dispositivos';

  @override
  String get settingsVerified => 'Verificado';

  @override
  String get settingsUnverified => 'No verificado';

  @override
  String get settingsAdvanced => 'Avanzado';

  @override
  String get settingsCrossSigning => 'Firma cruzada';

  @override
  String get settingsEnabled => 'Habilitado';

  @override
  String get settingsNotEnabled => 'No habilitado';

  @override
  String get settingsResetEncryption => 'Restablecer cifrado';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Eliminar todas las claves de cifrado';

  @override
  String get settingsEncryptionNotSupported => 'Cifrado no soportado';

  @override
  String get settingsNotInitialized => 'No inicializado';

  @override
  String get settingsBackupKeyTitle => 'Respaldar claves';

  @override
  String get settingsBackupKeyMessage =>
      'Crear un nuevo respaldo de claves? Esto te ayudara a restaurar mensajes cifrados en un nuevo dispositivo.';

  @override
  String get settingsBackup => 'Respaldar';

  @override
  String get settingsRestoreKeyTitle => 'Restaurar claves';

  @override
  String get settingsRestoreKeyMessage =>
      'Ingresa tu contrasena de recuperacion o clave de recuperacion para restaurar mensajes cifrados.';

  @override
  String get settingsRestore => 'Restaurar';

  @override
  String get settingsExportKeyTitle => 'Exportar claves';

  @override
  String get settingsExportKeyMessage =>
      'El archivo de claves exportado contiene todas tus claves de cifrado. Por favor guardalo de forma segura.';

  @override
  String get settingsExport => 'Exportar';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID de dispositivo: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Estado: Verificado';

  @override
  String get settingsDeviceStatusUnverified => 'Estado: No verificado';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Ultima actividad: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Verificar este dispositivo';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'La firma cruzada ya esta habilitada';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Firma cruzada configurada exitosamente';

  @override
  String get settingsResetEncryptionTitle => 'Restablecer cifrado';

  @override
  String get settingsResetEncryptionWarning =>
      'Advertencia: Esto eliminara todas tus claves de cifrado. No podras descifrar mensajes cifrados anteriores. Esta accion no se puede deshacer.';

  @override
  String get settingsReset => 'Restablecer';

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
      'Estas seguro de que quieres salir de la reunion?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'toco a $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'No hay contactos disponibles para agregar';

  @override
  String get chatAddMembers => 'Agregar miembros';

  @override
  String chatInvitedMembers(int count) {
    return 'Invitados $count miembros';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Error de invitacion: $error';
  }

  @override
  String get chatMemberRemoved => 'Miembro eliminado';

  @override
  String chatRemoveFailed(String error) {
    return 'Error al eliminar: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Despues de compartir, la otra persona podra ver tu ubicacion en tiempo real por 1 hora.';

  @override
  String get chatStartSharing => 'Iniciar compartir';

  @override
  String get chatLocationServiceNotEnabled =>
      'El servicio de ubicacion no esta habilitado';

  @override
  String get chatEnableLocationService =>
      'Por favor habilita el servicio de ubicacion para usar esta funcion';

  @override
  String get chatGoToSettings => 'Ir a configuracion';

  @override
  String get chatLocationPermissionRequired =>
      'Se requiere permiso de ubicacion para esta funcion';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'El permiso de ubicacion ha sido denegado permanentemente. Por favor habilitalo en configuracion.';

  @override
  String get chatLocationPermissionDenied => 'Permiso de ubicacion denegado';

  @override
  String get chatGettingLocation => 'Obteniendo ubicacion...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Error al obtener ubicacion: $error';
  }

  @override
  String get chatMapPreview => 'Vista previa del mapa';

  @override
  String get chatSearchLocation => 'Buscar ubicacion';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Enviado sobre rojo de $amount $token';
  }

  @override
  String get chatTransferDefault => 'Transferencia';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Enviada transferencia de $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Error al seleccionar archivo: $error';
  }

  @override
  String get chatFileSizeLimit => 'El tamano del archivo no puede exceder 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Enviando archivo: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Error al enviar archivo: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Enviada tarjeta de contacto de $name';
  }

  @override
  String get chatFavoritesFeature => 'Favoritos';

  @override
  String get chatCouponsFeature => 'Cupones';

  @override
  String get chatGiftFeature => 'Regalo';

  @override
  String chatSharedMusic(String name) {
    return 'Compartido $name';
  }

  @override
  String get chatEndPollTitle => 'Finalizar encuesta';

  @override
  String get chatEndPollConfirmMessage =>
      'Estas seguro de que quieres finalizar esta encuesta? La votacion se cerrara despues de finalizar.';

  @override
  String get chatPollEndedMessage => 'Encuesta finalizada';

  @override
  String get chatConnectingCall => 'Conectando...';

  @override
  String get chatMuteCall => 'Silenciar';

  @override
  String get chatSpeakerOff => 'Altavoz apagado';

  @override
  String get chatSpeakerOn => 'Altavoz';

  @override
  String get chatCameraOn => 'Camara encendida';

  @override
  String get chatCameraOff => 'Camara apagada';

  @override
  String get chatHangUp => 'Colgar';

  @override
  String get chatSelectForwardTargetTitle => 'Seleccionar destino de reenvio';

  @override
  String get chatNoForwardableChat => 'No hay chats disponibles para reenviar';

  @override
  String get chatNoMatchingChat => 'No se encontraron chats coincidentes';

  @override
  String get chatLocationTitle => 'Ubicacion';

  @override
  String get chatSendButton => 'Enviar';

  @override
  String get chatRetryButton => 'Reintentar';

  @override
  String get chatSearchContactHint => 'Buscar contactos';

  @override
  String get chatShareMusic => 'Compartir musica';

  @override
  String get chatRecentPlayed => 'Recientes';

  @override
  String get chatMyFavorites => 'Favoritos';

  @override
  String get chatNetworkLink => 'Enlace';

  @override
  String get chatLocalFile => 'Local';

  @override
  String get chatPasteMusicLink => 'Pegar enlace de musica';

  @override
  String get chatShareMusicButton => 'Compartir musica';

  @override
  String get chatSelectLocalAudio => 'Seleccionar archivo de audio local';

  @override
  String get chatSupportedAudioFormats => 'Soporta MP3, M4A, WAV, FLAC, etc.';

  @override
  String get chatSelectFileButton => 'Seleccionar archivo';

  @override
  String get chatPleaseEnterMusicLink => 'Por favor ingresa enlace de musica';

  @override
  String get chatPleaseEnterValidLink => 'Por favor ingresa una URL valida';

  @override
  String get chatSharedSong => 'Cancion compartida';

  @override
  String get chatSelectMember => 'Seleccionar miembro';

  @override
  String get chatSearchMemberHint => 'Buscar miembros';

  @override
  String get chatNoMatchingMembers => 'No se encontraron miembros coincidentes';

  @override
  String get commonUnknownMember => 'Desconocido';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count mensajes seleccionados';
  }

  @override
  String get chatSearchContactsOrGroups => 'Buscar contactos o grupos';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Cargando...';

  @override
  String get chatVideoLoadFailed => 'Error al cargar video';

  @override
  String get chatPlayerInitFailed => 'Error de inicializacion del reproductor';

  @override
  String get chatCreatePollTitle => 'Crear encuesta';

  @override
  String get chatSubmitPoll => 'Enviar';

  @override
  String get chatPollQuestionLabel => 'Pregunta de la encuesta';

  @override
  String get chatEnterPollQuestionHint =>
      'Por favor ingresa pregunta de la encuesta';

  @override
  String get chatPollOptionsLabel => 'Opciones de la encuesta';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Opcion $index';
  }

  @override
  String get chatAddOptionButton => 'Agregar opcion';

  @override
  String get chatPollSettingsLabel => 'Configuracion de encuesta';

  @override
  String get chatSelectionType => 'Tipo de seleccion';

  @override
  String get chatSingleChoiceLabel => 'Unica';

  @override
  String get chatMultiChoiceLabel => 'Multiple';

  @override
  String get chatAnonymousPollSwitch => 'Encuesta anonima';

  @override
  String get chatPleaseEnterQuestion =>
      'Por favor ingresa pregunta de la encuesta';

  @override
  String get chatAtLeastTwoOptions => 'Se requieren al menos 2 opciones';

  @override
  String chatConfirmWithCount(int count) {
    return 'Confirmar ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Verificacion de correo';

  @override
  String get authEnterValidEmailAddress =>
      'Por favor ingresa una direccion de correo valida';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Codigo de verificacion enviado a $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Error al enviar codigo: $error';
  }

  @override
  String get authVerificationSuccess => 'Verificacion exitosa';

  @override
  String get authVerificationFailed => 'Error de verificacion';

  @override
  String authVerificationCodeError(String error) {
    return 'Error de codigo de verificacion: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Ingresa codigo de verificacion';

  @override
  String get authEnterYourEmail => 'Ingresa correo';

  @override
  String authWeSentCodeTo(String email) {
    return 'Enviamos un codigo de 6 digitos a\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Ingresa tu direccion de correo, enviaremos codigo de verificacion';

  @override
  String get commonSendVerificationCode => 'Enviar codigo de verificacion';

  @override
  String get authResendVerificationCode => 'Reenviar codigo de verificacion';

  @override
  String authCanResendAfter(int seconds) {
    return 'Puedes reenviar despues de $seconds segundos';
  }

  @override
  String get commonChangeEmail => 'Cambiar correo';

  @override
  String get contactAddToContacts => 'Agregar a contactos';

  @override
  String get contactAddingToContacts => 'Agregando...';

  @override
  String get contactAddedToContacts => 'Agregado a contactos';

  @override
  String contactAddFailedWithError(String error) {
    return 'Error al agregar: $error';
  }

  @override
  String get contactAddPhone => 'Agregar telefono';

  @override
  String get contactAddTag => 'Agregar etiquetas';

  @override
  String get contactAddText => 'Agregar texto';

  @override
  String get contactAddPhoto => 'Agregar foto';

  @override
  String contactGroupCountLabel(int count) {
    return '$count grupos';
  }

  @override
  String get contactAddedViaSearch => 'Agregado via busqueda';

  @override
  String get contactAddTime => 'Agregar hora';

  @override
  String get contactDoneButton => 'Listo';

  @override
  String get callWaitingForParticipants =>
      'Esperando que los participantes se unan...';

  @override
  String callParticipantMe(String name) {
    return '$name (Yo)';
  }

  @override
  String get callSharingLabel => 'Compartiendo';

  @override
  String callScreenSharingBy(String name) {
    return '$name esta compartiendo pantalla';
  }

  @override
  String callParticipantCount(int count) {
    return '$count participantes';
  }

  @override
  String get callMuteLabel => 'Silenciar';

  @override
  String get callUnmuteLabel => 'Activar sonido';

  @override
  String get callTurnOffVideo => 'Apagar video';

  @override
  String get callTurnOnVideo => 'Encender video';

  @override
  String get callShareScreen => 'Compartir pantalla';

  @override
  String get callStopSharing => 'Dejar de compartir';

  @override
  String get callSwitchCameraLabel => 'Cambiar';

  @override
  String get callLeaveLabel => 'Salir';

  @override
  String get callParticipantsLabel => 'Participantes';

  @override
  String get callJoiningMeeting => 'Uniendose a la reunion...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count votos ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count participantes';
  }

  @override
  String get commonTapToRetry => 'Toca para reintentar';

  @override
  String get chatDefaultRedPacketGreeting => 'Que la prosperidad te acompañe';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Permitir que otros busquen y se unan';

  @override
  String get groupConfirmClearChatHistory =>
      '¿Estás seguro de que deseas borrar el historial de chat?';

  @override
  String get groupCreateGroupToChat => 'Crea un grupo para comenzar a chatear';

  @override
  String get groupEditGroupAnnouncement => 'Editar anuncio del grupo';

  @override
  String get groupEditGroupDescription => 'Editar descripción del grupo';

  @override
  String get groupEnterGroupAnnouncement => 'Ingresa el anuncio del grupo';

  @override
  String chatErrorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count miembros, haz clic para copiar el ID del grupo';
  }

  @override
  String get chatMusicLinkLabel => 'Enlace de musica';

  @override
  String get chatNoMediaUrlAvailable => 'URL de medios no disponible';

  @override
  String get groupNoPermissionToEditGroupName =>
      'No tienes permiso para editar el nombre del grupo';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Los sobres rojos y transferencias no se pueden reenviar';

  @override
  String get authEmailAddress => 'Dirección de correo electrónico';

  @override
  String get commonEnterEmailAddress =>
      'Ingrese la dirección de correo electrónico';

  @override
  String get authEmailRecoveryHint => 'Se usa para recuperar la contraseña';

  @override
  String get commonInvalidEmailFormat =>
      'Ingrese una dirección de correo electrónico válida';

  @override
  String get authOptional => 'Opcional';

  @override
  String get authResetPassword => 'Restablecer contraseña';

  @override
  String get authEnterRegisteredEmail =>
      'Ingrese la dirección de correo electrónico con la que se registró';

  @override
  String get authSendResetCode => 'Enviar código de restablecimiento';

  @override
  String authResetCodeSent(String email) {
    return 'Código de restablecimiento enviado a $email';
  }

  @override
  String get authEnterResetCode => 'Ingrese el código de restablecimiento';

  @override
  String get authSetNewPassword => 'Establecer nueva contraseña';

  @override
  String get commonConfirmNewPassword => 'Confirmar nueva contraseña';

  @override
  String get commonNewPassword => 'Nueva contraseña';

  @override
  String get authPasswordResetSuccess =>
      'Contraseña restablecida correctamente. Inicie sesión con su nueva contraseña.';

  @override
  String get authResetPasswordFailed => 'Error al restablecer la contraseña';

  @override
  String get settingsChangePassword => 'Cambiar contraseña';

  @override
  String get settingsCurrentPassword => 'Contraseña actual';

  @override
  String get settingsEnterCurrentPassword => 'Ingrese la contraseña actual';

  @override
  String get settingsEnterNewPassword => 'Ingrese la nueva contraseña';

  @override
  String get settingsPasswordChanged =>
      'Contraseña cambiada correctamente. Inicie sesión con su nueva contraseña.';

  @override
  String get settingsChangePasswordFailed => 'Error al cambiar la contraseña';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'La nueva contraseña debe ser diferente de la contraseña actual';

  @override
  String get settingsChangePasswordInfo =>
      'Después de cambiar la contraseña, se cerrará la sesión y deberá iniciar sesión con la nueva contraseña.';

  @override
  String get settingsPasswordRequirements => 'Requisitos de contraseña:';

  @override
  String get settingsSecurityNote =>
      'Por seguridad, deberá volver a iniciar sesión en todos los dispositivos después de cambiar la contraseña.';

  @override
  String get settingsSecurity => 'Seguridad';

  @override
  String get settingsCurrentBoundEmail => 'Correo electrónico actual vinculado';

  @override
  String get settingsNewEmailAddress => 'Nueva dirección de correo electrónico';

  @override
  String get settingsEnterNewEmail =>
      'Ingrese la nueva dirección de correo electrónico';

  @override
  String get settingsVerificationCode => 'Código de verificación';

  @override
  String get settingsVerificationCodeSent => 'Código de verificación enviado';

  @override
  String get settingsCodeSentTo => 'Código de verificación enviado a';

  @override
  String get settingsDidNotReceiveCode => '¿No recibió el código?';

  @override
  String get settingsEmailChangedSuccess =>
      'Correo electrónico cambiado correctamente';

  @override
  String get settingsChangeEmailFailed =>
      'Error al cambiar el correo electrónico';

  @override
  String get settingsEmailSecurityNote =>
      'Su correo electrónico se usa para recuperar la contraseña. Manténgalo seguro.';

  @override
  String get commonGoogleLogin => 'Iniciar sesión con Google';

  @override
  String get commonAppleLogin => 'Iniciar sesión con Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageChanged => 'Idioma cambiado';

  @override
  String get settingsBiometricLogin => 'Inicio biométrico';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Iniciar sesión con $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Inicio biométrico activado';

  @override
  String get settingsBiometricLoginDisabled => 'Inicio biométrico desactivado';

  @override
  String get settingsEnableBiometricLogin => 'Activar inicio biométrico';

  @override
  String get settingsBiometricEnabled =>
      'Activado - Usa biometría para iniciar sesión';

  @override
  String get settingsBiometricDisabled => 'Desactivado - Toca para activar';

  @override
  String get settingsBiometricNeedRelogin =>
      'Por favor, cierra sesión e inicia sesión de nuevo para activar el inicio biométrico';

  @override
  String get authOr => 'O';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'El acceso a la cámara está restringido en este dispositivo';

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
      'Introduce el sufijo del toque, p.ej.: en el hombro';

  @override
  String get groupAlbum => 'Álbum del grupo';

  @override
  String get groupFiles => 'Archivos del grupo';

  @override
  String get groupImages => 'Imágenes';

  @override
  String get groupVideos => 'Videos';

  @override
  String get groupTotal => 'Total';

  @override
  String get groupSize => 'Tamaño';

  @override
  String get groupNoMedia => 'Sin medios';

  @override
  String get groupNoMediaDescription =>
      'Aún no hay fotos ni videos en este grupo';

  @override
  String get groupDocuments => 'Documentos';

  @override
  String get groupNoFiles => 'Sin archivos';

  @override
  String get groupNoFilesDescription => 'Aún no hay archivos en este grupo';

  @override
  String groupDownloadStarted(String filename) {
    return 'Descargando $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Sin grupos en común';

  @override
  String get contactNoCommonGroupsDescription =>
      'No tienen ningún grupo en común';

  @override
  String get chatVoiceMessage => 'Voz';

  @override
  String get chatMessage => 'Mensaje';

  @override
  String get conversationHideChat => 'Ocultar';

  @override
  String get settingsQuickReply => 'Respuesta rápida';

  @override
  String get commonTranslate => 'Traducir';

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
    return 'Conversacion: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Contacto: $userId';
  }

  @override
  String get commonDiscover => 'Descubrir';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Proximamente)';
  }

  @override
  String get commonPageNotFound => 'Pagina no encontrada';

  @override
  String get commonBackToHome => 'Volver al inicio';

  @override
  String get settingsMessageNotifications => 'Notificaciones de mensajes';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Recibir notificaciones de nuevos mensajes';

  @override
  String get settingsShowMessagePreview => 'Mostrar vista previa del mensaje';

  @override
  String get settingsShowMessageContentInNotification =>
      'Mostrar contenido del mensaje en notificaciones';

  @override
  String get settingsNotificationSound => 'Sonido de notificacion';

  @override
  String get settingsPlaySoundOnMessage =>
      'Reproducir sonido al recibir mensajes';

  @override
  String get commonVibration => 'Vibracion';

  @override
  String get settingsVibrateOnMessage => 'Vibrar al recibir mensajes';

  @override
  String get settingsDoNotDisturbMode => 'No molestar';

  @override
  String get settingsDoNotDisturbDescription =>
      'No recibir notificaciones durante el tiempo especificado';

  @override
  String get settingsStartTime => 'Hora de inicio';

  @override
  String get settingsEndTime => 'Hora de fin';

  @override
  String get settingsDeleteQuickReply => 'Eliminar respuesta rápida';

  @override
  String get settingsEditQuickReply => 'Editar respuesta rápida';

  @override
  String get settingsAddQuickReply => 'Añadir respuesta rápida';

  @override
  String get settingsManageQuickReplies => 'Gestionar respuestas rápidas';

  @override
  String get settingsNoQuickReplies => 'Sin respuestas rápidas';

  @override
  String get settingsDefaultQuickReplies =>
      'Se mostrarán las respuestas rápidas predeterminadas';

  @override
  String get settingsWhoCanSee => 'Quien puede ver';

  @override
  String get settingsLastSeen => 'Ultima vez visto';

  @override
  String get settingsHiddenChats => 'Chats ocultos';

  @override
  String get settingsMessagesLabel => 'Mensajes';

  @override
  String get settingsAllowStrangerMessages => 'Permitir mensajes de extraños';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Recibir mensajes de no contactos';

  @override
  String get settingsReadReceipts => 'Confirmaciones de lectura';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Permitir que otros sepan que leiste sus mensajes';

  @override
  String get settingsTypingIndicator => 'Indicador de escritura';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Permitir que otros sepan que estas escribiendo';

  @override
  String get settingsEveryone => 'Todos';

  @override
  String get settingsContactsOnly => 'Solo contactos';

  @override
  String get settingsNobody => 'Nadie';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Quien puede ver $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Versión $version';
  }

  @override
  String get settingsCheckForUpdates => 'Buscar actualizaciones';

  @override
  String get settingsOpenSourceLicenses => 'Licencias de codigo abierto';

  @override
  String get settingsFeedbackAndSuggestions => 'Comentarios y sugerencias';

  @override
  String get settingsBuiltOnMatrix => 'Basado en el protocolo Matrix';

  @override
  String get settingsNoHiddenChats => 'Sin chats ocultos';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Los chats que ocultes aparecerán aquí';

  @override
  String get settingsUnhideChat => 'Mostrar';

  @override
  String get settingsDarkMode => 'Modo oscuro';

  @override
  String get settingsFontSize => 'Tamano de fuente';

  @override
  String get settingsBubbleStyle => 'Estilo de burbuja';

  @override
  String get settingsFollowSystem => 'Seguir sistema';

  @override
  String get settingsAutoSwitchBySystem =>
      'Cambiar automaticamente segun configuracion del sistema';

  @override
  String get settingsLightMode => 'Modo claro';

  @override
  String get settingsAlwaysUseLightTheme => 'Usar siempre tema claro';

  @override
  String get settingsDarkModeOption => 'Modo oscuro';

  @override
  String get settingsAlwaysUseDarkTheme => 'Usar siempre tema oscuro';

  @override
  String get settingsFontSizeSmall => 'Pequeno';

  @override
  String get settingsFontSizeStandard => 'Estandar';

  @override
  String get settingsFontSizeLarge => 'Grande';

  @override
  String get settingsFontSizeExtraLarge => 'Extra grande';

  @override
  String get settingsBubbleStyleWechat => 'Estilo WeChat';

  @override
  String get settingsBubbleStyleWechatDesc =>
      'Estilo de burbuja clasico de WeChat';

  @override
  String get settingsBubbleStyleModern => 'Estilo moderno';

  @override
  String get settingsBubbleStyleModernDesc =>
      'Estilo de burbuja moderno y limpio';

  @override
  String get settingsBubbleStyleClassic => 'Estilo clasico';

  @override
  String get settingsBubbleStyleClassicDesc => 'Estilo de burbuja tradicional';

  @override
  String get discoverVideoChannels => 'Canales';

  @override
  String get discoverLive => 'En vivo';

  @override
  String get discoverListen => 'Escuchar';

  @override
  String get discoverWatch => 'Ver';

  @override
  String get discoverSearchDiscover => 'Buscar';

  @override
  String get discoverNearbyPeople => 'Cercanos';

  @override
  String get discoverGames => 'Juegos';

  @override
  String get discoverMiniPrograms => 'Mini programas';

  @override
  String get chatAlreadyInCall => 'Ya estas en una llamada';

  @override
  String get commonConnectionFailed => 'Conexion fallida';

  @override
  String get chatCallRejected => 'Llamada rechazada';

  @override
  String get chatNoAnswer => 'Sin respuesta';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get chatSelectContact => 'Seleccionar contacto';

  @override
  String get chatVoteRemoved => 'Voto eliminado';

  @override
  String get chatVoteChanged => 'Voto cambiado';

  @override
  String get chatVoted => 'Votado';

  @override
  String chatReplyTo(String name) {
    return 'Responder a $name';
  }

  @override
  String get chatCurrentLocation => 'Ubicacion actual';

  @override
  String chatNearbyPlace(int index) {
    return 'Lugar cercano $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Aproximadamente $distance';
  }

  @override
  String get chatAddress => 'Direccion';

  @override
  String get chatLatitude => 'Latitud';

  @override
  String get chatLongitude => 'Longitud';

  @override
  String get groupDescriptionUpdated => 'Descripción del grupo actualizada';

  @override
  String get groupAvatarUpdated => 'Avatar del grupo actualizado';

  @override
  String get callDecline => 'Rechazar';

  @override
  String get callAnswer => 'Contestar';

  @override
  String get callIncomingVideoCall => 'Videollamada entrante';

  @override
  String get callIncomingVoiceCall => 'Llamada de voz entrante';

  @override
  String get callVideoCallInProgress => 'Videollamada';

  @override
  String get callVoiceCallInProgress => 'Llamada de voz';

  @override
  String get callReconnectingCall => 'Reconectando...';

  @override
  String get callEnded => 'Llamada terminada';

  @override
  String get callFailed => 'Llamada fallida';

  @override
  String get callLivekitNotConfigured => 'LiveKit no configurado';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Error al unirse a la reunion: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Error al compartir pantalla: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Sin N42 Bean';

  @override
  String get profileN42BeanDetails => 'Detalles de N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean es un token para canjear artículos virtuales y servicios en N42. Actualmente disponible para:';

  @override
  String get profileN42BeanFeature1 =>
      'Stickers y temas exclusivos para miembros';

  @override
  String get profileN42BeanFeature2 => 'Personalización de burbujas de chat';

  @override
  String get profileN42BeanFeature3 => 'Personalización de sobres rojos';

  @override
  String get profileN42BeanFeature4 => 'Insignia de apodo exclusiva';

  @override
  String get profileN42BeanFeature5 => 'Privilegios de chat grupal';

  @override
  String get profileN42BeanFeature6 => 'Expansión de almacenamiento en la nube';

  @override
  String get profileN42BeanFeature7 => 'Filtros de belleza para videollamadas';

  @override
  String get profileN42BeanFeature8 => 'Personalización de fondo de Moments';

  @override
  String get profileN42BeanFeature9 => 'Prioridad en servicio al cliente VIP';

  @override
  String get profileGotIt => 'Entendido';

  @override
  String get profileNoN42BeanRecords => 'Sin registros de N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Animo y pensamientos';

  @override
  String get profileStatusHappy => 'Feliz';

  @override
  String get profileStatusCracked => 'Destrozado';

  @override
  String get profileStatusLucky => 'Con suerte';

  @override
  String get profileStatusSunny => 'Soleado';

  @override
  String get profileStatusTired => 'Cansado';

  @override
  String get profileStatusDaydream => 'Sonando despierto';

  @override
  String get profileStatusRushing => 'Apurado';

  @override
  String get profileStatusOverthinking => 'Pensando demasiado';

  @override
  String get profileStatusEnergized => 'Energizado';

  @override
  String get profileWorkAndStudy => 'Trabajo y estudio';

  @override
  String get profileStatusWorking => 'Trabajando';

  @override
  String get profileStatusStudying => 'Estudiando';

  @override
  String get profileStatusBusy => 'Ocupado';

  @override
  String get profileStatusSlacking => 'Holgazaneando';

  @override
  String get profileStatusTraveling => 'Viajando';

  @override
  String get profileStatusGoingHome => 'Yendo a casa';

  @override
  String get profileStatusDnd => 'No molestar';

  @override
  String get profileActivities => 'Actividades';

  @override
  String get profileStatusHanging => 'Pasando el rato';

  @override
  String get profileStatusCheckIn => 'Registrandome';

  @override
  String get profileStatusExercising => 'Ejercitandome';

  @override
  String get profileStatusCoffee => 'Cafe';

  @override
  String get profileStatusBubbleTea => 'Te de burbujas';

  @override
  String get profileStatusEating => 'Comiendo';

  @override
  String get profileStatusParenting => 'Cuidando ninos';

  @override
  String get profileStatusSavingWorld => 'Salvando el mundo';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Descanso';

  @override
  String get profileStatusRetreat => 'Retiro';

  @override
  String get profileStatusHome => 'En casa';

  @override
  String get profileStatusSleeping => 'Durmiendo';

  @override
  String get profileStatusCatLover => 'Amante de gatos';

  @override
  String get profileStatusDogWalking => 'Paseando al perro';

  @override
  String get profileStatusGaming => 'Jugando';

  @override
  String get profileStatusListening => 'Escuchando';

  @override
  String get profileEditAddress => 'Editar direccion';

  @override
  String get profileRecipient => 'Destinatario';

  @override
  String get profileEnterRecipientName => 'Ingresa nombre del destinatario';

  @override
  String get profilePhoneNumber => 'Numero de telefono';

  @override
  String get profileEnterPhoneNumber => 'Ingresa numero de telefono';

  @override
  String get profileRegionHint => 'Provincia/Ciudad/Distrito';

  @override
  String get profileDetailedAddress => 'Direccion detallada';

  @override
  String get profileDetailedAddressHint => 'Calle, numero de edificio, etc.';

  @override
  String get profileSetAsDefaultAddress =>
      'Establecer como direccion predeterminada';

  @override
  String get profilePleaseCompleteInfo => 'Por favor completa todos los campos';

  @override
  String get profileEditInvoice => 'Editar factura';

  @override
  String get profileInvoiceType => 'Tipo de factura: ';

  @override
  String get profileCompanyName => 'Nombre de empresa';

  @override
  String get profilePersonalName => 'Nombre personal';

  @override
  String get profileEnterCompanyName => 'Ingresa nombre de empresa';

  @override
  String get profileEnterName => 'Ingresa nombre';

  @override
  String get profileTaxIdNumber => 'Numero de identificacion fiscal';

  @override
  String get profileEnterTaxIdNumber =>
      'Ingresa numero de identificacion fiscal';

  @override
  String get profileBankNameOptional => 'Nombre del banco (opcional)';

  @override
  String get profileEnterBankName => 'Ingresa nombre del banco';

  @override
  String get profileBankAccountOptional => 'Cuenta bancaria (opcional)';

  @override
  String get profileEnterBankAccount => 'Ingresa cuenta bancaria';

  @override
  String get profileCompanyAddressOptional => 'Direccion de empresa (opcional)';

  @override
  String get profileEnterCompanyAddress => 'Ingresa direccion de empresa';

  @override
  String get profileCompanyPhoneOptional => 'Telefono de empresa (opcional)';

  @override
  String get profileEnterCompanyPhone => 'Ingresa telefono de empresa';

  @override
  String get profileSetAsDefaultInvoice =>
      'Establecer como factura predeterminada';

  @override
  String get profileRingtoneVibrate => 'Vibrar';

  @override
  String get profileRingtoneSilent => 'Silencioso';

  @override
  String get profileVibrateMode => 'Modo vibracion';

  @override
  String get profileSilentMode => 'Modo silencioso';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Error al reproducir: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Reproduciendo: $ringtoneName';
  }

  @override
  String get profileStop => 'Detener';

  @override
  String get profileSelectRingtone => 'Seleccionar tono';

  @override
  String get profileLoadingRingtones => 'Cargando tonos...';

  @override
  String get profileNoRingtonesFound => 'No se encontraron tonos';

  @override
  String mainMessagesWithCount(int count) {
    return 'Mensajes($count)';
  }

  @override
  String get storyViewers => 'Espectadores';

  @override
  String get storyNoViewers => 'Aún sin espectadores';

  @override
  String get storyReplyToStory => 'Responder a la historia...';

  @override
  String get commonCopiedToClipboard => 'Copiado al portapapeles';

  @override
  String get commonMore => 'Mas';

  @override
  String get commonTranslating => 'Traduciendo...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Traducido de $language';
  }

  @override
  String get commonTranslation => 'Traducción';

  @override
  String get commonTranslationFailed => 'Error en la traducción';

  @override
  String get commonAllRead => 'Todo leido';

  @override
  String commonReadCount(int count) {
    return '$count leidos';
  }

  @override
  String get commonYouRecalledMessage => 'Retiraste un mensaje';

  @override
  String get commonMessageRecalled => 'Mensaje retirado';

  @override
  String get commonReEdit => 'Reeditar';

  @override
  String get commonWalletArea => 'Area de billetera';

  @override
  String get callIncomingCall => 'Llamada entrante';

  @override
  String get callMissedCall => 'Llamada perdida';

  @override
  String get groupRemoveAdmin => 'Quitar admin';

  @override
  String get chatSelectCurrency => 'Seleccionar moneda';

  @override
  String get chatSelectEmoji => 'Seleccionar emoji';

  @override
  String get chatSelectRedPacketCover => 'Seleccionar portada';

  @override
  String get groupSetAsAdmin => 'Establecer como admin';

  @override
  String get chatVideoPlaybackFailed => 'Error de reproduccion de video';

  @override
  String get groupViewProfile => 'Ver perfil';

  @override
  String get favoriteAddLinkComingSoon =>
      'Funcion de agregar enlace proximamente';

  @override
  String get favoriteNewNoteComingSoon => 'Funcion de nueva nota proximamente';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Funcion de guardar proximamente';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Funcion de compartir proximamente';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Error al procesar codigo QR: $error';
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
  String get gameCenter => 'Juegos';

  @override
  String get gameHighScore => 'Récord';

  @override
  String get gameScore => 'Puntuación';

  @override
  String get gameOver => 'Fin del juego';

  @override
  String get gamePlayAgain => 'Jugar de nuevo';

  @override
  String get gameLeaderboard => 'Clasificación';

  @override
  String get gamePause => 'Pausado';

  @override
  String get gameResume => 'Toca para continuar';

  @override
  String get gameConfirmExit => '¿Salir del juego?';

  @override
  String get gameNoScores => 'Sin puntuaciones';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Combina fichas hasta llegar a 2048';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Deja caer y elimina líneas';

  @override
  String get gameMinesweeper => 'Buscaminas';

  @override
  String get gameMinesweeperDesc => 'Encuentra todas las celdas seguras';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => 'Conecta 3 o más gemas';

  @override
  String get gameMinesweeperEasy => 'Fácil';

  @override
  String get gameMinesweeperMedium => 'Medio';

  @override
  String get gameMinesLeft => 'Minas restantes';

  @override
  String get gameTimeLeft => 'Tiempo';

  @override
  String get gameLevel => 'Nivel';

  @override
  String get gameNext => 'Siguiente';

  @override
  String get gameBestTime => 'Mejor tiempo';

  @override
  String get gameNewRecord => '¡Nuevo récord!';

  @override
  String get gameLines => 'Líneas';

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
  String get onChainNotificationsTitle => 'Eventos on-chain';

  @override
  String get onChainMarkAllRead => 'Marcar todo como leído';

  @override
  String get onChainNoNotifications => 'Aún no hay eventos on-chain';

  @override
  String get onChainNoNotificationsDesc =>
      'Los eventos de los canales suscritos aparecerán aquí';

  @override
  String get onChainViewDetails => 'Ver detalles';

  @override
  String get chatCommandHelp => '/help — Ver todos los comandos';

  @override
  String get chatCommandPrice => '/price — Obtener precio del token';

  @override
  String get chatCommandBalance => '/balance — Ver saldo de la billetera';

  @override
  String get chatCommandChains => '/chains — Listar 236+ redes soportadas';

  @override
  String get chatMiniApps => 'Apps';

  @override
  String get miniAppMarketTitle => 'Mini Apps';

  @override
  String get miniAppCategoryAll => 'Todas';

  @override
  String get miniAppSearch => 'Buscar apps...';

  @override
  String get miniAppFeatured => 'Destacados';

  @override
  String get miniAppAllApps => 'Todas las Apps';

  @override
  String get miniAppNoResults => 'No se encontraron apps';

  @override
  String get slideToPayLabel => '→→→  Desliza para confirmar';

  @override
  String get slideToPayConfirming => 'Confirmando...';

  @override
  String get redPacketBestLuck => 'Mejor suerte';

  @override
  String get redPacketBestLuckCongrats => '¡Mejor suerte! ¡Recibiste más!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total reclamados';
  }

  @override
  String get redPacketStatsTotal => 'total';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 Recibió un sobre rojo • $amount $token';
  }
}
