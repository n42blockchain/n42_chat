// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Error al inicializar el modulo de chat';

  @override
  String get checkNetworkRetry =>
      'Por favor verifica tu conexion a internet e intenta de nuevo';

  @override
  String get retry => 'Reintentar';

  @override
  String get unknownUser => 'Usuario desconocido';

  @override
  String get walletNotConnected => 'Billetera no conectada';

  @override
  String get cannotGetWalletAddress =>
      'No se puede obtener la direccion de la billetera';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Solicitud de pago: $requestId';
  }

  @override
  String get callServiceNotInitialized =>
      'Servicio de llamadas no inicializado';

  @override
  String get alreadyInCall => 'Ya estas en una llamada';

  @override
  String get meetingServiceNotInitialized =>
      'Servicio de reuniones no inicializado';

  @override
  String get livekitNotConfigured => 'LiveKit no configurado';

  @override
  String get unknownConversation => 'Conversacion desconocida';

  @override
  String startCallFailed(String error) {
    return 'Error al iniciar llamada: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Error al contestar: $error';
  }

  @override
  String get connectionFailed => 'Conexion fallida';

  @override
  String get callRejected => 'Llamada rechazada';

  @override
  String get noAnswer => 'Sin respuesta';

  @override
  String get invalidLoginResponse => 'Respuesta de inicio de sesion invalida';

  @override
  String loginFailed(String error) {
    return 'Error de inicio de sesion: $error';
  }

  @override
  String get sessionRestoreFailed => 'Error al restaurar la sesion';

  @override
  String get additionalVerificationRequired =>
      'Se requiere verificacion adicional';

  @override
  String registrationFailed(String error) {
    return 'Error de registro: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'No se puede conectar al servidor: $error';
  }

  @override
  String get wrongUsernamePassword => 'Usuario o contrasena incorrectos';

  @override
  String get usernameTaken => 'El nombre de usuario ya esta en uso';

  @override
  String get invalidUsernameFormat => 'Formato de nombre de usuario invalido';

  @override
  String get rateLimitExceeded => 'Demasiadas solicitudes, intenta mas tarde';

  @override
  String get loginExpired => 'Sesion expirada';

  @override
  String joinMeetingFailed(String error) {
    return 'Error al unirse a la reunion: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Error al compartir pantalla: $error';
  }

  @override
  String get answer => 'Contestar';

  @override
  String get decline => 'Rechazar';

  @override
  String get missedCall => 'Llamada perdida';

  @override
  String get callBack => 'Devolver llamada';

  @override
  String get incomingCall => 'Llamada entrante';

  @override
  String get missedVideoCall => 'Videollamada perdida';

  @override
  String get missedVoiceCall => 'Llamada de voz perdida';

  @override
  String get passkeyNotInitialized => 'Passkey no inicializado';

  @override
  String get googleSignInNotConfigured =>
      'Inicio de sesion con Google no configurado';

  @override
  String get encryptedMessage => '[Mensaje cifrado]';

  @override
  String get sticker => '[Sticker]';

  @override
  String get groupCreated => 'Grupo creado';

  @override
  String get groupNameChanged => 'Nombre del grupo cambiado';

  @override
  String get groupAvatarChanged => 'Avatar del grupo cambiado';

  @override
  String get groupAnnouncementChanged => 'Anuncio del grupo cambiado';

  @override
  String get image => '[Imagen]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Voz]';

  @override
  String get file => '[Archivo]';

  @override
  String get location => '[Ubicacion]';

  @override
  String get unknownMessage => '[Mensaje desconocido]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName se unio al grupo';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName salio del grupo';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName fue invitado';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName fue eliminado';
  }

  @override
  String get avatarDataEmpty => 'Los datos del avatar estan vacios';

  @override
  String get avatarTooLarge =>
      'El archivo del avatar es muy grande, maximo 10MB';

  @override
  String get uploadAvatarFailed => 'Error al subir el avatar';

  @override
  String get delete => 'Eliminar';

  @override
  String get notLoggedIn => 'No has iniciado sesion';

  @override
  String roomNotExist(String roomId) {
    return 'Sala no encontrada: $roomId';
  }

  @override
  String get uploadImageFailed => 'Error al subir la imagen';

  @override
  String get matrixClientNotInitialized => 'Cliente Matrix no inicializado';

  @override
  String get uploadVoiceFailed =>
      'Error al subir audio: No se puede obtener URI MXC';

  @override
  String get uploadVideoFailed =>
      'Error al subir video: No se puede obtener URI MXC';

  @override
  String get uploadFileFailed =>
      'Error al subir archivo: No se puede obtener URI MXC';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Ubicacion: $lat, $lon';
  }

  @override
  String get myLocation => 'Mi ubicacion';

  @override
  String get pollEnded => 'Encuesta finalizada';

  @override
  String get groupChat => 'Chat grupal';

  @override
  String get search => 'Buscar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get userCancelled => 'Usuario cancelo';

  @override
  String get noData => 'Sin datos';

  @override
  String get noSearchResults => 'Sin resultados de busqueda';

  @override
  String get tryDifferentKeyword => 'Intenta con otra palabra clave';

  @override
  String get loadFailed => 'Error al cargar';

  @override
  String get checkNetwork => 'Por favor verifica tu conexion a internet';

  @override
  String get networkConnectionFailed => 'Error de conexion a la red';

  @override
  String get checkNetworkSettings =>
      'Por favor verifica tu configuracion de red';

  @override
  String get messages => 'Mensajes';

  @override
  String get contacts => 'Contactos';

  @override
  String get discover => 'Descubrir';

  @override
  String get me => 'Yo';

  @override
  String get voiceLoading => 'Cargando audio, intenta de nuevo mas tarde';

  @override
  String get voiceToTextFailed => 'Error al convertir voz a texto';

  @override
  String get converting => 'Convirtiendo...';

  @override
  String get convertToText => 'A texto';

  @override
  String get convertToTextTitle => 'Convertir a texto';

  @override
  String get selectEmoji => 'Seleccionar emoji';

  @override
  String get frequentlyUsed => 'Usados frecuentemente';

  @override
  String get copy => 'Copiar';

  @override
  String get forward => 'Reenviar';

  @override
  String get unfavorite => 'Quitar de favoritos';

  @override
  String get favorite => 'Favorito';

  @override
  String get resend => 'Reenviar';

  @override
  String get recall => 'Retirar';

  @override
  String get multiSelect => 'Seleccion multiple';

  @override
  String get quote => 'Citar';

  @override
  String get remind => 'Recordar';

  @override
  String get searchThis => 'Buscar';

  @override
  String get recallMessageConfirm => 'Retirar este mensaje?';

  @override
  String get youRecalledMessage => 'Retiraste un mensaje';

  @override
  String get otherRecalledMessage => 'Mensaje retirado';

  @override
  String get reEdit => 'Reeditar';

  @override
  String get copied => 'Copiado';

  @override
  String get sendMessageHint => 'Enviar un mensaje';

  @override
  String get microphonePermissionRequired =>
      'Por favor permite el acceso al microfono';

  @override
  String startRecordingFailed(String error) {
    return 'Error al iniciar grabacion: $error';
  }

  @override
  String get recordingTooShort => 'Grabacion muy corta';

  @override
  String stopRecordingFailed(String error) {
    return 'Error al detener grabacion: $error';
  }

  @override
  String get releaseToCancel => 'Suelta para cancelar';

  @override
  String get releaseToSend =>
      'Suelta para enviar, desliza hacia arriba para cancelar';

  @override
  String get holdToTalk => 'Manten presionado para hablar';

  @override
  String get send => 'Enviar';

  @override
  String conversationWithId(String roomId) {
    return 'Conversacion: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Contacto: $userId';
  }

  @override
  String get addFriend => 'Agregar amigo';

  @override
  String get chatServiceNotConnected => 'Servicio de chat no conectado';

  @override
  String userNotFoundHint(String query) {
    return 'Usuario \"$query\" no encontrado\n\nSugerencias:\n- Intenta ingresar el ID completo, ej. @usuario:servidor.com\n- Verifica la ortografia del nombre de usuario';
  }

  @override
  String createChatFailed(String error) {
    return 'Error al crear chat: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Error en la busqueda: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Ingresa ID de usuario o nombre para buscar';

  @override
  String get searching => 'Buscando...';

  @override
  String get searchUserToChat => 'Busca un usuario para iniciar un chat';

  @override
  String get matrixIdExample =>
      'Puedes ingresar un ID de Matrix completo\nej. @usuario:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Usuario \"$username\" no encontrado';
  }

  @override
  String get chat => 'Chat';

  @override
  String get settings => 'Configuracion';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get login => 'Iniciar sesion';

  @override
  String get createGroup => 'Crear grupo';

  @override
  String developing(String title) {
    return '$title\n(Proximamente)';
  }

  @override
  String get error => 'Error';

  @override
  String get pageNotFound => 'Pagina no encontrada';

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get allRead => 'Todo leido';

  @override
  String readCount(int count) {
    return '$count leidos';
  }

  @override
  String get transfer => 'Transferir';

  @override
  String get pendingReceipt => 'Pendiente';

  @override
  String get tapToReceive => 'Toca para recibir';

  @override
  String get received => 'Recibido';

  @override
  String get paymentReceived => 'Pago recibido';

  @override
  String get refunded => 'Reembolsado';

  @override
  String get expired => 'Expirado';

  @override
  String get redPacketGreeting => 'Mejores deseos';

  @override
  String get n42RedPacket => 'Sobre rojo N42';

  @override
  String get goodLuck => 'Buena suerte';

  @override
  String get claimed => 'Reclamado';

  @override
  String get allClaimed => 'Todo reclamado';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Amor';

  @override
  String get animals => 'Animales';

  @override
  String get food => 'Comida';

  @override
  String get travel => 'Viajes';

  @override
  String get activities => 'Actividades';

  @override
  String get objects => 'Objetos';

  @override
  String get symbols => 'Simbolos';

  @override
  String get reply => 'Responder';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles';

  @override
  String get edit => 'Editar';

  @override
  String get more => 'Mas';

  @override
  String get selectForwardTarget => 'Seleccionar destinatario';

  @override
  String sendCount(int count) {
    return 'Enviar ($count)';
  }

  @override
  String get draft => '[Borrador] ';

  @override
  String n42Id(String id) {
    return 'ID N42: $id';
  }

  @override
  String get n42IdTitle => 'ID N42';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Info del amigo';

  @override
  String get friendInfoDesc =>
      'Agrega notas, telefono, etiquetas, anotaciones, fotos y configura permisos.';

  @override
  String get moments => 'Momentos';

  @override
  String get sendMessage => 'Mensaje';

  @override
  String get audioVideoCall => 'Llamada de audio/video';

  @override
  String get videoChannel => 'Canal de video';

  @override
  String get remark => 'Nota';

  @override
  String get remarkName => 'Nombre de nota';

  @override
  String get phone => 'Telefono';

  @override
  String get tags => 'Etiquetas';

  @override
  String get notes => 'Notas';

  @override
  String get photos => 'Fotos';

  @override
  String get permissions => 'Permisos';

  @override
  String get chatMomentsEtc => 'Chat, Momentos, Deportes, etc.';

  @override
  String get moreInfo => 'Mas informacion';

  @override
  String get commonGroups => 'Grupos en comun';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Origen';

  @override
  String get notificationSettings => 'Notificaciones';

  @override
  String get receiveNotifications =>
      'Recibir notificaciones de mensajes nuevos';

  @override
  String get showPreview => 'Mostrar vista previa del mensaje';

  @override
  String get showContentInNotification =>
      'Mostrar contenido del mensaje en notificaciones';

  @override
  String get notificationSound => 'Sonido de notificacion';

  @override
  String get playSoundOnMessage => 'Reproducir sonido al recibir mensajes';

  @override
  String get vibrate => 'Vibrar';

  @override
  String get vibrateOnMessage => 'Vibrar al recibir mensajes';

  @override
  String get doNotDisturb => 'No molestar';

  @override
  String get dndDescription =>
      'Silenciar notificaciones durante horas especificadas';

  @override
  String get startTime => 'Hora de inicio';

  @override
  String get endTime => 'Hora de fin';

  @override
  String get privacy => 'Privacidad';

  @override
  String get appearance => 'Apariencia';

  @override
  String get about => 'Acerca de';

  @override
  String get logout => 'Cerrar sesion';

  @override
  String get logoutConfirm => 'Estas seguro de que quieres cerrar sesion?';

  @override
  String get exit => 'Cerrar sesion';

  @override
  String get save => 'Guardar';

  @override
  String get nickname => 'Apodo';

  @override
  String get enterNickname => 'Ingresa apodo';

  @override
  String get signature => 'Firma';

  @override
  String get addSignature => 'Agregar una firma';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get chooseFromGallery => 'Elegir de la galeria';

  @override
  String saveFailed(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get secureDecentralizedChat => 'Mensajeria segura y descentralizada';

  @override
  String get endToEndEncryption => 'Cifrado de extremo a extremo';

  @override
  String get messagesOnlyYouCanSee =>
      'Mensajes visibles solo para ti y el destinatario';

  @override
  String get decentralized => 'Descentralizado';

  @override
  String get basedOnMatrix => 'Basado en el protocolo abierto Matrix';

  @override
  String get walletIntegration => 'Integracion de billetera';

  @override
  String get easyCryptoTransfer => 'Transferencias de criptomonedas faciles';

  @override
  String get register => 'Registrarse';

  @override
  String get agreeTerms => 'Al iniciar sesion, aceptas';

  @override
  String get termsOfService => 'Terminos de servicio';

  @override
  String get and => 'y';

  @override
  String get privacyPolicy => 'Politica de privacidad';

  @override
  String get serverAddress => 'Direccion del servidor';

  @override
  String get enterServerAddress => 'Ingresa direccion del servidor';

  @override
  String get validServerAddress =>
      'Por favor ingresa una direccion de servidor valida';

  @override
  String connectedTo(String serverName) {
    return 'Conectado a $serverName';
  }

  @override
  String get username => 'Nombre de usuario';

  @override
  String get enterUsername => 'Ingresa nombre de usuario';

  @override
  String get password => 'Contrasena';

  @override
  String get enterPassword => 'Ingresa contrasena';

  @override
  String get registerAccount => 'Registrarse';

  @override
  String get forgotPassword => 'Olvide mi contrasena';

  @override
  String get otherLoginMethods => 'Otros metodos de inicio de sesion';

  @override
  String get emailVerification => 'Codigo de verificacion por correo';

  @override
  String get enterServerFirst =>
      'Por favor ingresa la direccion del servidor primero';

  @override
  String get passkeyNeedsServer =>
      'El inicio de sesion con Passkey requiere soporte del servidor';

  @override
  String googleLoginSuccess(String email) {
    return 'Inicio de sesion con Google exitoso: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Error de inicio de sesion con Google: $error';
  }

  @override
  String get appleLoginSuccess => 'Inicio de sesion con Apple exitoso';

  @override
  String appleLoginFailed(String error) {
    return 'Error de inicio de sesion con Apple: $error';
  }

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get joinN42Chat => 'Unete a N42 Chat para comenzar a chatear';

  @override
  String get usernameHint => '3-20 caracteres, letras/numeros/_';

  @override
  String get usernameMinLength =>
      'El nombre de usuario debe tener al menos 3 caracteres';

  @override
  String get usernameMaxLength =>
      'El nombre de usuario debe tener maximo 20 caracteres';

  @override
  String get usernameFormat =>
      'El nombre de usuario solo puede contener letras, numeros y guiones bajos';

  @override
  String get passwordHint => 'Minimo 8 caracteres';

  @override
  String get passwordMinLength =>
      'La contrasena debe tener al menos 8 caracteres';

  @override
  String get confirmPassword => 'Confirmar contrasena';

  @override
  String get reEnterPassword => 'Reingresa la contrasena';

  @override
  String get passwordsNotMatch => 'Las contrasenas no coinciden';

  @override
  String get inviteCode => 'Codigo de invitacion (integrado)';

  @override
  String get filled => 'Completado';

  @override
  String get enterInviteCode => 'Ingresa codigo de invitacion';

  @override
  String get inviteCodeHint =>
      'El codigo de invitacion esta integrado, normalmente no es necesario modificarlo';

  @override
  String get agreeTermsFirst =>
      'Por favor lee y acepta los terminos y politica de privacidad primero';

  @override
  String get iAgree => 'He leido y acepto';

  @override
  String get alreadyHaveAccount => 'Ya tienes una cuenta?';

  @override
  String get loginNow => 'Iniciar sesion ahora';

  @override
  String get whoCanSee => 'Quien puede ver';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Estado';

  @override
  String get lastSeen => 'Ultima vez visto';

  @override
  String get messageSettings => 'Mensajes';

  @override
  String get allowStrangerMessage => 'Permitir mensajes de desconocidos';

  @override
  String get receiveNonContact => 'Recibir mensajes de no contactos';

  @override
  String get readReceipts => 'Confirmaciones de lectura';

  @override
  String get letOthersKnowRead =>
      'Permitir que otros sepan que leiste sus mensajes';

  @override
  String get typingStatus => 'Estado de escritura';

  @override
  String get letOthersKnowTyping =>
      'Permitir que otros sepan que estas escribiendo';

  @override
  String get everyone => 'Todos';

  @override
  String get contactsOnly => 'Solo contactos';

  @override
  String get nobody => 'Nadie';

  @override
  String whoCanSeeItem(String title) {
    return 'Quien puede ver $title';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get checkUpdate => 'Buscar actualizaciones';

  @override
  String get openSourceLicenses => 'Licencias de codigo abierto';

  @override
  String get feedback => 'Comentarios';

  @override
  String get builtOnMatrix => 'Basado en el protocolo Matrix';

  @override
  String get loading => 'Cargando...';

  @override
  String get noConversations => 'Sin conversaciones';

  @override
  String get tapToChat => 'Toca arriba a la derecha para iniciar un chat';

  @override
  String get startGroup => 'Iniciar chat grupal';

  @override
  String get scan => 'Escanear';

  @override
  String get payment => 'Pago';

  @override
  String featureComingSoon(String feature) {
    return '$feature proximamente';
  }

  @override
  String get markAsRead => 'Marcar como leido';

  @override
  String get unmute => 'Activar sonido';

  @override
  String get mute => 'Silenciar';

  @override
  String get unpin => 'Desanclar';

  @override
  String get pin => 'Anclar';

  @override
  String get deleteConversation => 'Eliminar conversacion';

  @override
  String deleteConversationConfirm(String name) {
    return 'Eliminar conversacion con \"$name\"?';
  }

  @override
  String get noContacts => 'Sin contactos';

  @override
  String get addFriendsToChat => 'Agrega amigos para comenzar a chatear';

  @override
  String get contactNotFound => 'Contacto no encontrado';

  @override
  String get tryOtherKeywords =>
      'Intenta con otras palabras clave o busqueda global';

  @override
  String get searchResults => 'Resultados de busqueda';

  @override
  String get newFriends => 'Nuevos amigos';

  @override
  String get chatOnlyFriends => 'Amigos solo de chat';

  @override
  String get officialAccounts => 'Cuentas oficiales';

  @override
  String get serviceAccounts => 'Cuentas de servicio';

  @override
  String get enterpriseContacts => 'Contactos empresariales';

  @override
  String contactsCount(int count) {
    return '$count contactos';
  }

  @override
  String get recommendToFriend => 'Compartir contacto';

  @override
  String get setRemark => 'Establecer nota';

  @override
  String get addToHome => 'Agregar a pantalla de inicio';

  @override
  String get sendingCard => 'Enviando tarjeta de contacto...';

  @override
  String get contactCard => '[Tarjeta de contacto]';

  @override
  String get fileLabel => 'Archivo';

  @override
  String get locationLabel => 'Ubicacion';

  @override
  String cardSent(String contact, String friend) {
    return 'Tarjeta de $contact enviada a $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Error al recomendar: $error';
  }

  @override
  String get enterRemark => 'Ingresa nota';

  @override
  String remarkSet(String remark) {
    return 'Nota establecida: $remark';
  }

  @override
  String get openingChat => 'Abriendo chat...';

  @override
  String openChatFailed(String error) {
    return 'Error al abrir chat: $error';
  }

  @override
  String get addContact => 'Agregar contacto';

  @override
  String get enterUserId => 'Ingresa ID de usuario';

  @override
  String get noFriendRequests => 'Sin solicitudes de amistad';

  @override
  String get accept => 'Aceptar';

  @override
  String get reject => 'Rechazar';

  @override
  String acceptedRequest(String name) {
    return 'Aceptaste la solicitud de amistad de $name';
  }

  @override
  String rejectedRequest(String name) {
    return 'Rechazaste la solicitud de amistad de $name';
  }

  @override
  String get noGroups => 'Sin grupos';

  @override
  String get creatingGroup => 'Creacion de grupo proximamente...';

  @override
  String get selectFriendToRecommend => 'Selecciona un amigo para recomendar';

  @override
  String get searchContacts => 'Buscar contactos';

  @override
  String get noContactsFound => 'No se encontraron contactos';

  @override
  String get yesterday => 'Ayer';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mie';

  @override
  String get thursday => 'Jue';

  @override
  String get friday => 'Vie';

  @override
  String get saturday => 'Sab';

  @override
  String get sunday => 'Dom';

  @override
  String get justNow => 'Ahora';

  @override
  String minutesAgo(int count) {
    return 'Hace $count min';
  }

  @override
  String hoursAgo(int count) {
    return 'Hace ${count}h';
  }

  @override
  String daysAgo(int count) {
    return 'Hace ${count}d';
  }

  @override
  String get online => 'En linea';

  @override
  String get offline => 'Desconectado';

  @override
  String minutesAgoOnline(int count) {
    return 'En linea hace $count min';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'En linea hace ${count}h';
  }

  @override
  String daysAgoOnline(int count) {
    return 'En linea hace ${count}d';
  }

  @override
  String get searchContactsGroupsMessages =>
      'Buscar contactos, grupos, mensajes';

  @override
  String get searchError => 'Error de busqueda';

  @override
  String get searchHint => 'Buscar contactos, grupos y mensajes';

  @override
  String get enterKeyword => 'Ingresa palabras clave para buscar';

  @override
  String get searchHistory => 'Historial de busqueda';

  @override
  String get clear => 'Limpiar';

  @override
  String noResultsFor(String query) {
    return 'Sin resultados para \"$query\"';
  }

  @override
  String get all => 'Todo';

  @override
  String get groups => 'Grupos';

  @override
  String get noResults => 'Sin resultados';

  @override
  String get groupInfo => 'Info del grupo';

  @override
  String groupMembers(int count) {
    return 'Miembros ($count)';
  }

  @override
  String get groupMembersTitle => 'Miembros del grupo';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get owner => 'Propietario';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Invitar';

  @override
  String get groupAnnouncement => 'Anuncio del grupo';

  @override
  String get notSet => 'No establecido';

  @override
  String get groupDescription => 'Descripcion del grupo';

  @override
  String get publicGroup => 'Grupo publico';

  @override
  String get allowSearchJoin => 'Permitir que otros busquen y se unan';

  @override
  String get clearChatHistory => 'Borrar historial de chat';

  @override
  String get dissolveGroup => 'Disolver grupo';

  @override
  String get leaveGroup => 'Salir del grupo';

  @override
  String get changeGroupName => 'Cambiar nombre del grupo';

  @override
  String get enterGroupName => 'Ingresa nombre del grupo';

  @override
  String get confirm => 'Confirmar';

  @override
  String get changeGroupDescription => 'Cambiar descripcion del grupo';

  @override
  String get enterGroupDescription => 'Ingresa descripcion del grupo';

  @override
  String get editAnnouncement => 'Editar anuncio';

  @override
  String get enterAnnouncement => 'Ingresa anuncio';

  @override
  String get publish => 'Publicar';

  @override
  String get clearHistoryConfirm =>
      'Borrar todo el historial de chat? Esto no se puede deshacer.';

  @override
  String get clearAction => 'Borrar';

  @override
  String get chatHistoryCleared => 'Historial de chat borrado';

  @override
  String leaveGroupConfirm(String name) {
    return 'Salir de \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Disolver \"$name\"? Esto no se puede deshacer.';
  }

  @override
  String get dissolve => 'Disolver';

  @override
  String get groupQrCode => 'Codigo QR del grupo';

  @override
  String get searchChatHistory => 'Buscar historial de chat';

  @override
  String get groupIdCopied => 'ID del grupo copiado';

  @override
  String tapCopyGroupId(int count) {
    return '$count miembros - Toca para copiar ID del grupo';
  }

  @override
  String get receiverAddress => 'Direccion del destinatario';

  @override
  String get enterOrPasteAddress => 'Ingresa o pega direccion de billetera';

  @override
  String get selectToken => 'Seleccionar token';

  @override
  String get transferAmount => 'Monto de transferencia';

  @override
  String get available => 'Disponible';

  @override
  String get allAmount => 'Todo';

  @override
  String get memoOptional => 'Memo (opcional)';

  @override
  String get addMemo => 'Agregar un memo';

  @override
  String get confirmTransfer => 'Confirmar transferencia';

  @override
  String get invalidAddress =>
      'Por favor ingresa una direccion de destinatario valida';

  @override
  String get invalidAmount => 'Por favor ingresa un monto valido';

  @override
  String get selectTokenPlease => 'Por favor selecciona un token';

  @override
  String get addressVerified => 'Direccion verificada';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Disponible: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Funcion de escaneo en desarrollo...';

  @override
  String get enterAmount => 'Ingresa monto';

  @override
  String get redPacketCountMin => 'Se requiere al menos 1 sobre rojo';

  @override
  String get viewRedPacketDetails => 'Ver detalles del sobre rojo';

  @override
  String get enterTransferAmount => 'Ingresa monto de transferencia';

  @override
  String get transferTo => 'Transferir a';

  @override
  String get selectCurrency => 'Seleccionar moneda';

  @override
  String get receiveTransfer => 'Transferencia recibida';

  @override
  String fromSender(String name, Object senderName) {
    return 'De $senderName';
  }

  @override
  String get confirmReceive => 'Confirmar recepcion';

  @override
  String get groupProfile => 'Info del grupo';

  @override
  String get viewProfile => 'Ver perfil';

  @override
  String get removeMember => 'Eliminar del grupo';

  @override
  String removeMemberConfirm(String name) {
    return 'Eliminar a \"$name\" del grupo?';
  }

  @override
  String get remove => 'Eliminar';

  @override
  String get clearStatus => 'Borrar estado';

  @override
  String get clearStatusConfirm => 'Borrar estado actual?';

  @override
  String get statusCleared => 'Estado borrado';

  @override
  String statusSet(String result) {
    return 'Estado establecido: $result';
  }

  @override
  String get userNotExist => 'El usuario no existe';

  @override
  String get userIdCopied => 'ID de usuario copiado';

  @override
  String get voiceCallInDevelopment => 'Llamada de voz en desarrollo...';

  @override
  String get report => 'Reportar';

  @override
  String get reportInDevelopment => 'Funcion de reporte en desarrollo...';

  @override
  String get shareCard => 'Compartir tarjeta';

  @override
  String get shareInDevelopment => 'Funcion de compartir en desarrollo...';

  @override
  String get qrCode => 'Codigo QR';

  @override
  String get qrCodeInDevelopment => 'Funcion de codigo QR en desarrollo...';

  @override
  String get avatarUpdated => 'Avatar actualizado';

  @override
  String selectImageFailed(String error) {
    return 'Error al seleccionar imagen: $error';
  }

  @override
  String get changeName => 'Cambiar nombre';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Femenino';

  @override
  String genderSet(String gender) {
    return 'Genero establecido: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Region establecida: $region';
  }

  @override
  String get setPatText => 'Establecer texto de toque';

  @override
  String get changeSignature => 'Cambiar firma';

  @override
  String ringtoneSet(String result) {
    return 'Tono establecido: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature en desarrollo...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Error al guardar direccion: $error';
  }

  @override
  String get myAddress => 'Mi direccion';

  @override
  String get addNew => 'Agregar';

  @override
  String get addAddress => 'Agregar direccion';

  @override
  String get addressAdded => 'Direccion agregada';

  @override
  String get addressUpdated => 'Direccion actualizada';

  @override
  String get deleteAddress => 'Eliminar direccion';

  @override
  String get deleteAddressConfirm => 'Eliminar esta direccion?';

  @override
  String get addressDeleted => 'Direccion eliminada';

  @override
  String get setDefaultAddress => 'Establecer como predeterminada';

  @override
  String get fillCompleteInfo => 'Por favor completa todos los campos';

  @override
  String saveInvoiceFailed(String error) {
    return 'Error al guardar factura: $error';
  }

  @override
  String get myInvoices => 'Mis facturas';

  @override
  String get addInvoice => 'Agregar factura';

  @override
  String get invoiceAdded => 'Factura agregada';

  @override
  String get invoiceUpdated => 'Factura actualizada';

  @override
  String get deleteInvoice => 'Eliminar factura';

  @override
  String get deleteInvoiceConfirm => 'Eliminar esta factura?';

  @override
  String get invoiceDeleted => 'Factura eliminada';

  @override
  String get invoiceType => 'Tipo de factura: ';

  @override
  String get personal => 'Personal';

  @override
  String get enterprise => 'Empresa';

  @override
  String get setDefaultInvoice => 'Establecer como predeterminada';

  @override
  String get enterTaxId => 'Ingresa numero de identificacion fiscal';

  @override
  String get vibrateMode => 'Modo vibracion';

  @override
  String get silentMode => 'Modo silencioso';

  @override
  String playing(String ringtoneName) {
    return 'Reproduciendo: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Error al reproducir: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Por favor ingresa nombre del grupo';

  @override
  String get selectAtLeastOne => 'Por favor selecciona al menos un miembro';

  @override
  String get fillStatus => 'Escribir estado';

  @override
  String get fileNotExist => 'El archivo no existe';

  @override
  String sendFailed(String error) {
    return 'Error al enviar: $error';
  }

  @override
  String get cannotOpenBrowser => 'No se puede abrir el navegador';

  @override
  String selectFileFailed(String error) {
    return 'Error al seleccionar archivo: $error';
  }

  @override
  String get enterMusicLink => 'Ingresa enlace de musica';

  @override
  String get enterValidLink => 'Por favor ingresa un enlace valido';

  @override
  String get enterPollQuestion => 'Ingresa pregunta de la encuesta';

  @override
  String get minTwoOptions => 'Se requieren al menos 2 opciones';

  @override
  String get crossDeviceEnabled => 'Firma entre dispositivos habilitada';

  @override
  String get crossDeviceSet =>
      'Firma entre dispositivos configurada exitosamente';

  @override
  String setupFailed(String error) {
    return 'Error de configuracion: $error';
  }

  @override
  String get receiveAmount => 'Monto a recibir';

  @override
  String get enterValidAmount => 'Por favor ingresa un monto valido';

  @override
  String get addressCopied => 'Direccion copiada';

  @override
  String openItem(String content) {
    return 'Abrir: $content';
  }

  @override
  String get newNoteComingSoon => 'Funcion de nueva nota proximamente';

  @override
  String get addLinkComingSoon => 'Funcion de agregar enlace proximamente';

  @override
  String get deleted => 'Eliminado';

  @override
  String get shareComingSoon => 'Funcion de compartir proximamente';

  @override
  String get saveComingSoon => 'Funcion de guardar proximamente';

  @override
  String get moreStylesComingSoon => 'Mas estilos proximamente';

  @override
  String get wallet => 'Billetera';

  @override
  String get walletArea => 'Area de billetera';

  @override
  String get recording => 'Grabando';

  @override
  String get invalidVideoUrl => 'URL de video invalida';

  @override
  String get downloadFile => 'Descargar archivo';

  @override
  String get clearChatHistoryTitle => 'Borrar historial de chat';

  @override
  String get cannotUndo => 'Esto no se puede deshacer';

  @override
  String get videoCall => 'Videollamada';

  @override
  String get voiceCall => 'Llamada de voz';

  @override
  String get leaveMeeting => 'Salir de la reunion';

  @override
  String get chatDetails => 'Detalles del chat';

  @override
  String get viewAllGroupMembers => 'Ver todos los miembros';

  @override
  String get groupName => 'Nombre del grupo';

  @override
  String get groupNameUpdated => 'Nombre del grupo actualizado';

  @override
  String get updateFailed => 'Error de actualizacion';

  @override
  String get noPermissionToModify => 'No tienes permiso para modificar';

  @override
  String get groupManagement => 'Gestion del grupo';

  @override
  String get myNicknameInGroup => 'Mi apodo en el grupo';

  @override
  String get pinChat => 'Anclar chat';

  @override
  String get strongReminder => 'Recordatorio fuerte';

  @override
  String get setChatBackground => 'Establecer fondo del chat';

  @override
  String get unknownFile => 'Archivo desconocido';

  @override
  String get download => 'Descargar';

  @override
  String get invalidLocation => 'Ubicacion invalida';

  @override
  String get address => 'Direccion';

  @override
  String get latitude => 'Latitud';

  @override
  String get longitude => 'Longitud';

  @override
  String get close => 'Cerrar';

  @override
  String get tapToCancel => 'Toca para cancelar';

  @override
  String captureFailed(Object error) {
    return 'Error de captura: $error';
  }

  @override
  String get processingVideo => 'Procesando video...';

  @override
  String get videoFileNotExist => 'El archivo de video no existe';

  @override
  String get videoDataEmpty => 'Los datos del video estan vacios';

  @override
  String get videoTooLarge => 'El tamano del video no puede exceder 100MB';

  @override
  String get sendingVideo => 'Enviando video...';

  @override
  String sendVideoFailed(Object error) {
    return 'Error al enviar video: $error';
  }

  @override
  String get imageFileNotExist => 'El archivo de imagen no existe';

  @override
  String get imageDataEmpty => 'Los datos de la imagen estan vacios';

  @override
  String get sendingImage => 'Enviando imagen...';

  @override
  String sendImageFailed(Object error) {
    return 'Error al enviar imagen: $error';
  }

  @override
  String get sendLocation => 'Enviar ubicacion';

  @override
  String get selectLocationAndSend => 'Selecciona ubicacion y envia';

  @override
  String get shareRealTimeLocation => 'Compartir ubicacion en tiempo real';

  @override
  String get shareLocationForOneHour =>
      'Comparte tu ubicacion en tiempo real con un amigo por 1 hora';

  @override
  String get locationSent => 'Ubicacion enviada';

  @override
  String get selectMessages => 'Seleccionar mensajes';

  @override
  String selectedCount(int count) {
    return '$count seleccionados';
  }

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String groupChatCount(int count) {
    return 'Chat grupal ($count)';
  }

  @override
  String get privateChat => 'Chat privado';

  @override
  String get noMessages => 'Sin mensajes';

  @override
  String get sendFirstMessage => 'Envia el primer mensaje para iniciar el chat';

  @override
  String get encryptionNotice =>
      'Este chat tiene cifrado de extremo a extremo. Solo tu y el destinatario pueden leer los mensajes.';

  @override
  String replyTo(String name) {
    return 'Responder a $name';
  }

  @override
  String get multiForward => 'Reenviar';

  @override
  String get collect => 'Guardar';

  @override
  String get noMembers => 'Sin miembros';

  @override
  String get memberNotFound => 'Miembro no encontrado';

  @override
  String get voiceFileNotExist => 'El archivo de voz no existe';

  @override
  String get voiceFileEmpty => 'El archivo de voz esta vacio';

  @override
  String get sendingVoice => 'Enviando voz...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Error al enviar voz: $error';
  }

  @override
  String get messageCopied => 'Mensaje copiado';

  @override
  String get messageForwarded => 'Mensaje reenviado';

  @override
  String forwardFailed(Object error) {
    return 'Error al reenviar: $error';
  }

  @override
  String get unfavorited => 'Eliminado de favoritos';

  @override
  String get favorited => 'Agregado a favoritos';

  @override
  String get reactionAdded => 'Reaccion agregada';

  @override
  String get failedMessageDeleted => 'Mensaje fallido eliminado';

  @override
  String get deleteMessages => 'Eliminar mensajes';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Estas seguro de que quieres eliminar $count mensajes?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Nota: $count mensajes son de otros, solo se pueden eliminar localmente.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count mensajes tuyos seran retirados.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Retirados $count mensajes, eliminados $localCount localmente';
  }

  @override
  String recalledMessages(Object count) {
    return 'Retirados $count mensajes';
  }

  @override
  String deletedLocally(Object count) {
    return 'Eliminados $count mensajes (localmente)';
  }

  @override
  String forwardedCount(Object count) {
    return 'Reenviados $count mensajes';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Reenvio completo: $success exitosos, $failed fallidos';
  }

  @override
  String get remindOnlyInGroup =>
      'La funcion de recordatorio solo esta disponible en chat grupal';

  @override
  String get onlyTextSearchable =>
      'Solo los mensajes de texto se pueden buscar';

  @override
  String searchFor(Object text) {
    return 'Buscar \"$text\"';
  }

  @override
  String get baiduSearch => 'Busqueda Baidu';

  @override
  String get googleSearch => 'Busqueda Google';

  @override
  String get bingSearch => 'Busqueda Bing';

  @override
  String get calling => 'Llamando...';

  @override
  String get connecting => 'Conectando...';

  @override
  String get ringing => 'Sonando...';

  @override
  String get inCall => 'En llamada';

  @override
  String featureInDevelopment(String feature) {
    return 'Funcion en desarrollo...';
  }

  @override
  String collectMessages(Object count) {
    return 'Guardados $count mensajes';
  }

  @override
  String get voted => 'Votado';

  @override
  String get voteChanged => 'Voto cambiado';

  @override
  String get voteRemoved => 'Voto eliminado';

  @override
  String get endPoll => 'Finalizar encuesta';

  @override
  String get endPollConfirm =>
      'Estas seguro de que quieres finalizar esta encuesta? No se podran emitir mas votos despues de finalizar.';

  @override
  String memberCount(int count) {
    return '$count miembros';
  }

  @override
  String get videoChannels => 'Canales';

  @override
  String get live => 'En vivo';

  @override
  String get listen => 'Escuchar';

  @override
  String get watch => 'Ver';

  @override
  String get searchDiscover => 'Buscar';

  @override
  String get nearbyPeople => 'Cercanos';

  @override
  String get games => 'Juegos';

  @override
  String get miniPrograms => 'Mini programas';

  @override
  String done(int count) {
    return 'Listo($count)';
  }

  @override
  String get services => 'Servicios';

  @override
  String get favorites => 'Favoritos';

  @override
  String get ordersAndCards => 'Pedidos y tarjetas';

  @override
  String get stickers => 'Stickers';

  @override
  String statusSetTo(String status) {
    return 'Estado establecido: $status';
  }

  @override
  String get avatarUploadFailed => 'Error al subir avatar';

  @override
  String get personalProfile => 'Perfil personal';

  @override
  String get name => 'Nombre';

  @override
  String get gender => 'Genero';

  @override
  String get region => 'Region';

  @override
  String get myQrCode => 'Mi codigo QR';

  @override
  String get poke => 'Toque';

  @override
  String get ringtone => 'Tono';

  @override
  String get defaultRingtone => 'Tono predeterminado';

  @override
  String get myAddresses => 'Mis direcciones';

  @override
  String genderSetTo(String gender) {
    return 'Genero establecido: $gender';
  }

  @override
  String get selectRegion => 'Seleccionar region';

  @override
  String get selectCity => 'Seleccionar ciudad';

  @override
  String regionSetTo(String region) {
    return 'Region establecida: $region';
  }

  @override
  String get setPoke => 'Establecer toque';

  @override
  String get friendPokedMe => 'Un amigo me toco';

  @override
  String get enterPokeSuffix => 'Ingresa sufijo de toque, ej.: en el hombro';

  @override
  String get example => 'Ejemplo';

  @override
  String get onTheShoulder => ' en el hombro';

  @override
  String get pokeCleared => 'Toque borrado';

  @override
  String pokeSetTo(String suffix) {
    return 'Toque establecido: me toco$suffix';
  }

  @override
  String get editSignature => 'Editar firma';

  @override
  String get introduceYourself => 'Una frase para presentarte';

  @override
  String get signatureCleared => 'Firma borrada';

  @override
  String get signatureUpdated => 'Firma actualizada';

  @override
  String get scanToAddFriend =>
      'Escanea el codigo QR de arriba para agregarme como amigo';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Tono establecido: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return '¿Estás seguro de que quieres disolver \"$name\"? Esta acción no se puede deshacer.';
  }

  @override
  String get enterValidServerAddress =>
      'Por favor ingresa una direccion de servidor valida';

  @override
  String get emailOtp => 'OTP por correo';

  @override
  String get enterServerAddressFirst =>
      'Por favor ingresa la direccion del servidor primero';

  @override
  String get passkeyRequiresServer =>
      'El inicio de sesion con Passkey requiere soporte del servidor';

  @override
  String get loginAgreement => 'Al iniciar sesion, aceptas ';

  @override
  String get pleaseAgreeToTerms =>
      'Por favor lee y acepta los Terminos de servicio y Politica de privacidad';

  @override
  String get registerFailed => 'Error de registro';

  @override
  String get reenterPassword => 'Reingresa la contrasena';

  @override
  String get passwordsDoNotMatch => 'Las contrasenas no coinciden';

  @override
  String get inviteCodeBuiltIn => 'Codigo de invitacion (integrado)';

  @override
  String get inviteCodeBuiltInNote =>
      'El codigo de invitacion esta integrado, normalmente no es necesario modificarlo';

  @override
  String get iHaveReadAndAgree => 'He leido y acepto ';

  @override
  String get startGroupChat => 'Iniciar chat grupal';

  @override
  String get addFriends => 'Agregar amigos';

  @override
  String get paymentAndCollection => 'Pago';

  @override
  String messagesWithCount(int count) {
    return 'Mensajes($count)';
  }

  @override
  String contactCount(int count) {
    return '$count contactos';
  }

  @override
  String get addToHomeScreen => 'Agregar a pantalla de inicio';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Tarjeta de $contact recomendada a $recipient';
  }

  @override
  String get enterRemarkName => 'Ingresa nombre de nota';

  @override
  String remarkSetTo(String remark) {
    return 'Nota establecida: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Aceptaste la solicitud de amistad de $name';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Rechazaste la solicitud de amistad de $name';
  }

  @override
  String get groupInvites => 'Invitaciones a grupos';

  @override
  String myGroups(int count) {
    return 'Mis grupos ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Invitado a unirse al grupo';

  @override
  String confirmLeaveGroup(String name) {
    return '¿Estás seguro de que quieres salir de \"$name\"?';
  }

  @override
  String get leave => 'Salir';

  @override
  String get saveMedia => 'Guardar';

  @override
  String get recallThisMessage => 'Retirar este mensaje?';

  @override
  String get messageRecalled => 'Mensaje retirado';

  @override
  String get savedToGallery => 'Guardado en galeria';

  @override
  String get failedToSave => 'Error al guardar';

  @override
  String get saving => 'Guardando...';

  @override
  String get share => 'Compartir';

  @override
  String get saveToGallery => 'Guardar en galeria';

  @override
  String downloadFailed(String code) {
    return 'Descarga fallida: $code';
  }

  @override
  String get noMediaUrl => 'No hay URL de medios disponible';

  @override
  String shareFailed(String error) {
    return 'Error al compartir: $error';
  }

  @override
  String get failedToLoadImage => 'Error al cargar imagen';

  @override
  String get failedToLoadMoreMessages => 'Error al cargar mas mensajes';

  @override
  String get failedToSend => 'Error al enviar';

  @override
  String get failedToSendImage => 'Error al enviar imagen';

  @override
  String get failedToSendVoice => 'Error al enviar voz';

  @override
  String get failedToSendFile => 'Error al enviar archivo';

  @override
  String get failedToSendVideo => 'Error al enviar video';

  @override
  String get failedToSendLocation => 'Error al enviar ubicacion';

  @override
  String get failedToResend => 'Error al reenviar';

  @override
  String get failedToRecall => 'Error al retirar';

  @override
  String get failedToReply => 'Error al responder';

  @override
  String get failedToAddReaction => 'Error al agregar reaccion';

  @override
  String get failedToSendPoll => 'Error al enviar encuesta';

  @override
  String get failedToVote => 'Error al votar';

  @override
  String get failedToLoadMessages => 'Error al cargar mensajes';

  @override
  String get callFeatureComingSoon =>
      'Funcion de llamada de voz y video proximamente';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Los sobres rojos y transferencias no se pueden reenviar';

  @override
  String get videoRecordingFailed =>
      'Error de grabacion de video. Por favor intenta de nuevo.';

  @override
  String get redPacket => 'Sobre rojo';

  @override
  String get music => 'Musica';

  @override
  String get coupon => 'Cupon';

  @override
  String get gift => 'Regalo';

  @override
  String get poll => 'Encuesta';

  @override
  String get text => 'Texto';

  @override
  String get link => 'Enlace';

  @override
  String get note => 'Nota';

  @override
  String get myNotes => 'Mis notas';

  @override
  String get today => 'Hoy';

  @override
  String daysAgoText(int count) {
    return 'Hace $count dias';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Sin favoritos aun';

  @override
  String get longPressToFavorite =>
      'Manten presionado un mensaje para agregarlo a favoritos';

  @override
  String get newNote => 'Nueva nota';

  @override
  String get favoriteLink => 'Enlace favorito';

  @override
  String get editTags => 'Editar etiquetas';

  @override
  String get deleteFavorite => 'Eliminar favorito';

  @override
  String get deleteFavoriteConfirm =>
      'Estas seguro de que quieres eliminar este favorito?';

  @override
  String get noSearchResultsFound => 'No se encontraron resultados';

  @override
  String get sendRedPacket => 'Enviar sobre rojo';

  @override
  String get amount => 'Monto';

  @override
  String get redPacketCover => 'Portada del sobre rojo';

  @override
  String get redPacketType => 'Tipo de sobre rojo';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'De la suerte';

  @override
  String get redPacketCount => 'Cantidad de sobres rojos';

  @override
  String get pieces => 'piezas';

  @override
  String get putMoneyInRedPacket => 'Poner dinero en el sobre rojo';

  @override
  String get redPacketRefundNotice =>
      'Los sobres rojos no reclamados seran reembolsados despues de 24 horas';

  @override
  String get openRedPacket => 'Abrir';

  @override
  String get redPacketAllClaimed => 'Todos los sobres rojos reclamados';

  @override
  String get redPacketExpired => 'Sobre rojo expirado';

  @override
  String get addTransferNote => 'Agregar nota de transferencia';

  @override
  String get yuan => 'CNY';

  @override
  String get savedToChangeCanTransfer =>
      'Guardado en saldo, puedes transferir directamente';

  @override
  String get replyWithEmoji => 'Responder con este emoji';

  @override
  String get claimedYourRedPacket => 'reclamo tu';

  @override
  String get claimedRedPacket => 'reclamo';

  @override
  String get otherTyping => 'escribiendo...';

  @override
  String get processing => 'Procesando...';

  @override
  String get transferCancelled => 'Transferencia cancelada';

  @override
  String get transferFailed => 'Error de transferencia';

  @override
  String get creatingPaymentRequest => 'Creando solicitud de pago...';

  @override
  String get processingPayment => 'Procesando pago...';

  @override
  String get paymentFailed => 'Error de pago';

  @override
  String get clickRetry => 'Toca para reintentar';

  @override
  String get settingsTitle => 'Configuracion';

  @override
  String get editRemark => 'Editar nota';

  @override
  String get setPermissions => 'Establecer permisos';

  @override
  String get recommendToFriends => 'Recomendar a amigos';

  @override
  String get setStarFriend => 'Marcar como favorito';

  @override
  String get addToBlacklist => 'Agregar a lista negra';

  @override
  String get complain => 'Reportar';

  @override
  String get deleteContact => 'Eliminar contacto';

  @override
  String deleteContactConfirm(String name) {
    return 'Estas seguro de que quieres eliminar a $name?';
  }

  @override
  String get transferTitle => 'Transferir';

  @override
  String get receiverAddressLabel => 'Direccion del destinatario';

  @override
  String get selectTokenLabel => 'Seleccionar token';

  @override
  String get transferAmountLabel => 'Monto de transferencia';

  @override
  String get memoLabel => 'Memo (opcional)';

  @override
  String get enterOrPasteAddressHint => 'Ingresa o pega direccion de billetera';

  @override
  String get scanInDevelopment => 'Funcion de escaneo en desarrollo...';

  @override
  String get availableLabel => 'Disponible';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Disponible: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Agregar un memo';

  @override
  String get receiveTitle => 'Recibir';

  @override
  String get walletNotConnectedTitle => 'Billetera no conectada';

  @override
  String get connectWalletFirst => 'Por favor conecta tu billetera primero';

  @override
  String get sendPaymentRequest => 'Enviar solicitud de pago';

  @override
  String get qrCodeGenerateFailed => 'Error al generar codigo QR';

  @override
  String get scanQrToPayMe => 'Escanea el codigo QR para pagarme';

  @override
  String get myWalletAddress => 'Mi direccion de billetera';

  @override
  String get createPaymentRequest => 'Crear solicitud de pago';

  @override
  String get selectTokenHint => 'Seleccionar token';

  @override
  String get amountLabel => 'Monto';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get sendRequestButton => 'Enviar solicitud';

  @override
  String get allReadReceipt => 'Todo leido';

  @override
  String readCountReceipt(int count) {
    return '$count leidos';
  }

  @override
  String n42IdLabel(String id) {
    return 'ID N42: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Mejores deseos';

  @override
  String senderRedPacket(String name) {
    return 'Sobre rojo de $name';
  }

  @override
  String get allButton => 'Todo';

  @override
  String get enterValidAddress => 'Por favor ingresa una direccion valida';

  @override
  String get pleaseSelectToken => 'Por favor selecciona un token';

  @override
  String get receivedTransfer => 'Transferencia recibida';

  @override
  String get selectForwardRecipient => 'Seleccionar destinatario de reenvio';

  @override
  String get emojiFaces => 'Caras';

  @override
  String get emojiHearts => 'Corazones';

  @override
  String get emojiAnimals => 'Animales';

  @override
  String get emojiFood => 'Comida';

  @override
  String get emojiTransport => 'Transporte';

  @override
  String get emojiActivities => 'Actividades';

  @override
  String get emojiObjects => 'Objetos';

  @override
  String get emojiSymbols => 'Simbolos';

  @override
  String get transferProcessing => 'Procesando transferencia...';

  @override
  String senderSentRedPacket(String name) {
    return '$name envio un sobre rojo';
  }

  @override
  String get savedToBalance =>
      'Guardado en saldo, puedes transferir directamente';

  @override
  String get redPacketExpiredOrEmpty => 'Sobre rojo expirado/todos reclamados';

  @override
  String get scanFeatureComingSoon => 'Funcion de escaneo proximamente...';

  @override
  String get setAsStarred => 'Marcar como destacado';

  @override
  String get addToBlocklist => 'Agregar a lista de bloqueados';

  @override
  String get claimedYour => ' reclamo tu ';

  @override
  String get claimedText => ' reclamo ';

  @override
  String userTyping(String name) {
    return '$name esta escribiendo...';
  }

  @override
  String get typing => 'Escribiendo...';

  @override
  String get waitingToReceive => 'Esperando recibir';

  @override
  String get tapToClaim => 'Toca para reclamar';

  @override
  String get hasBeenReceived => 'Ha sido recibido';

  @override
  String get getLucky => 'Buena suerte';

  @override
  String get cameraStartFailed => 'Error al iniciar camara';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get placeQrCodeInFrame =>
      'Coloca el codigo QR dentro del marco para escanear';

  @override
  String get closeManualInput => 'Cerrar entrada manual';

  @override
  String get manualInputUserId => 'Ingresar ID de usuario manualmente';

  @override
  String get add => 'Agregar';

  @override
  String get ringtoneClear => 'Borrar';

  @override
  String get ringtonePhone => 'Telefono';

  @override
  String get ringtoneClassic => 'Clasico';

  @override
  String get ringtoneSoft => 'Suave';

  @override
  String get ringtoneVibrate => 'Vibrar';

  @override
  String get ringtoneSilent => 'Silencioso';

  @override
  String get stop => 'Detener';

  @override
  String get selectRingtone => 'Seleccionar tono';

  @override
  String get loadingRingtones => 'Cargando tonos...';

  @override
  String get noRingtonesFound => 'No se encontraron tonos';

  @override
  String get moodAndThoughts => 'Animo y pensamientos';

  @override
  String get statusHappy => 'Feliz';

  @override
  String get statusCracked => 'Destrozado';

  @override
  String get statusLucky => 'Con suerte';

  @override
  String get statusSunny => 'Soleado';

  @override
  String get statusTired => 'Cansado';

  @override
  String get statusDaydream => 'Sonando despierto';

  @override
  String get statusRushing => 'Apurado';

  @override
  String get statusOverthinking => 'Pensando demasiado';

  @override
  String get statusEnergized => 'Energizado';

  @override
  String get workAndStudy => 'Trabajo y estudio';

  @override
  String get statusWorking => 'Trabajando';

  @override
  String get statusStudying => 'Estudiando';

  @override
  String get statusBusy => 'Ocupado';

  @override
  String get statusSlacking => 'Holgazaneando';

  @override
  String get statusTraveling => 'Viajando';

  @override
  String get statusGoingHome => 'Yendo a casa';

  @override
  String get statusDnd => 'No molestar';

  @override
  String get statusHanging => 'Pasando el rato';

  @override
  String get statusCheckIn => 'Registrandome';

  @override
  String get statusExercising => 'Ejercitandome';

  @override
  String get statusCoffee => 'Cafe';

  @override
  String get statusBubbleTea => 'Te de burbujas';

  @override
  String get statusEating => 'Comiendo';

  @override
  String get statusParenting => 'Cuidando ninos';

  @override
  String get statusSavingWorld => 'Salvando el mundo';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Descanso';

  @override
  String get statusRetreat => 'Retiro';

  @override
  String get statusHome => 'En casa';

  @override
  String get statusSleeping => 'Durmiendo';

  @override
  String get statusCatLover => 'Amante de gatos';

  @override
  String get statusDogWalking => 'Paseando al perro';

  @override
  String get statusGaming => 'Jugando';

  @override
  String get statusListening => 'Escuchando';

  @override
  String get setStatus => 'Establecer estado';

  @override
  String get visibleToFriends24h => 'Visible para amigos por 24 horas';

  @override
  String get writeStatus => 'Escribir estado';

  @override
  String get enterYourStatus => 'Ingresa tu estado...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Se requiere permiso de camara para escanear codigo QR';

  @override
  String get cameraPermissionDenied =>
      'El permiso de camara fue denegado permanentemente. Por favor habilitalo en configuracion del sistema.';

  @override
  String get cannotGetCameraPermission =>
      'No se puede obtener permiso de camara';

  @override
  String permissionCheckError(String error) {
    return 'Error al verificar permiso: $error';
  }

  @override
  String get invalidQrCode => 'Codigo QR invalido';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Error al procesar codigo QR: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'No se puede agregar amigo: $error';
  }

  @override
  String get scanQrCode => 'Escanear codigo QR';

  @override
  String get checkingCameraPermission => 'Verificando permiso de camara...';

  @override
  String get needCameraPermission => 'Se requiere permiso de camara';

  @override
  String get retryPermission => 'Reintentar';

  @override
  String get openSettings => 'Abrir configuracion';

  @override
  String get inviteMembers => 'Invitar miembros';

  @override
  String inviteCount(int count) {
    return 'Invitar($count)';
  }

  @override
  String get noShippingAddress => 'Sin direccion de envio';

  @override
  String get defaultLabel => 'Predeterminado';

  @override
  String get editAddress => 'Editar direccion';

  @override
  String get recipient => 'Destinatario';

  @override
  String get enterRecipientName => 'Ingresa nombre del destinatario';

  @override
  String get phoneNumber => 'Numero de telefono';

  @override
  String get enterPhoneNumber => 'Ingresa numero de telefono';

  @override
  String get regionHint => 'Provincia/Ciudad/Distrito';

  @override
  String get detailedAddress => 'Direccion detallada';

  @override
  String get detailedAddressHint => 'Calle, numero de edificio, etc.';

  @override
  String get setAsDefaultAddress => 'Establecer como direccion predeterminada';

  @override
  String get pleaseCompleteInfo => 'Por favor completa todos los campos';

  @override
  String get noInvoice => 'Sin factura';

  @override
  String get company => 'Empresa';

  @override
  String get taxNumber => 'Numero fiscal';

  @override
  String get editInvoice => 'Editar factura';

  @override
  String get companyName => 'Nombre de empresa';

  @override
  String get enterCompanyName => 'Ingresa nombre de empresa';

  @override
  String get personalName => 'Nombre personal';

  @override
  String get enterName => 'Ingresa nombre';

  @override
  String get taxIdNumber => 'Numero de identificacion fiscal';

  @override
  String get enterTaxIdNumber => 'Ingresa numero de identificacion fiscal';

  @override
  String get bankNameOptional => 'Nombre del banco (opcional)';

  @override
  String get enterBankName => 'Ingresa nombre del banco';

  @override
  String get bankAccountOptional => 'Cuenta bancaria (opcional)';

  @override
  String get enterBankAccount => 'Ingresa cuenta bancaria';

  @override
  String get companyAddressOptional => 'Direccion de empresa (opcional)';

  @override
  String get enterCompanyAddress => 'Ingresa direccion de empresa';

  @override
  String get companyPhoneOptional => 'Telefono de empresa (opcional)';

  @override
  String get enterCompanyPhone => 'Ingresa telefono de empresa';

  @override
  String get setAsDefaultInvoice => 'Establecer como factura predeterminada';

  @override
  String get confirmDeleteAddress =>
      'Estas seguro de que quieres eliminar esta direccion?';

  @override
  String get confirmDeleteInvoice =>
      'Estas seguro de que quieres eliminar esta factura?';

  @override
  String get groupOwner => 'Propietario';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Buscar miembros';

  @override
  String totalMembers(int count) {
    return '$count miembros';
  }

  @override
  String get removeFromGroup => 'Eliminar del grupo';

  @override
  String confirmRemoveMember(String name) {
    return 'Estas seguro de que quieres eliminar a \"$name\" del grupo?';
  }

  @override
  String get setAsAdmin => 'Establecer como admin';

  @override
  String get removeAdmin => 'Quitar admin';

  @override
  String get deleteContactSuccess => 'Contacto eliminado';

  @override
  String get unknownSong => 'Cancion desconocida';

  @override
  String get unknownArtist => 'Artista desconocido';

  @override
  String get unknownContact => 'Contacto desconocido';

  @override
  String get personalCard => 'Tarjeta de contacto';

  @override
  String get singleChoice => 'Unica';

  @override
  String get multiChoice => 'Multiple';

  @override
  String get ended => 'Finalizada';

  @override
  String get endPollButton => 'Finalizar encuesta';

  @override
  String get createPoll => 'Crear encuesta';

  @override
  String get pollQuestion => 'Pregunta de la encuesta';

  @override
  String get pollOptions => 'Opciones de la encuesta';

  @override
  String optionPlaceholder(int index) {
    return 'Opcion $index';
  }

  @override
  String get addOption => 'Agregar opcion';

  @override
  String get pollSettings => 'Configuracion de encuesta';

  @override
  String get anonymousPoll => 'Encuesta anonima';

  @override
  String get pollHint =>
      'La encuesta se mostrara en el chat. Los miembros del grupo pueden votar.';

  @override
  String get searchSongOrArtist => 'Buscar cancion o artista';

  @override
  String get noSongsFound => 'No se encontraron canciones';

  @override
  String get supportedMusicPlatforms =>
      'Soporta enlaces de musica de NetEase, QQ Music, etc.';

  @override
  String get songNameOptional => 'Nombre de cancion (opcional)';

  @override
  String get enterSongName => 'Ingresa nombre de cancion';

  @override
  String get artistNameOptional => 'Nombre de artista (opcional)';

  @override
  String get enterArtistName => 'Ingresa nombre de artista';

  @override
  String get shareSong => 'Compartir cancion';

  @override
  String get realTimeLocationSharing =>
      'Compartir ubicacion en tiempo real en desarrollo...';

  @override
  String get voiceCallFeatureInDev =>
      'Funcion de llamada de voz en desarrollo...';

  @override
  String get reportFeatureInDev => 'Funcion de reporte en desarrollo...';

  @override
  String get shareFeatureInDev => 'Funcion de compartir en desarrollo...';

  @override
  String get qrCodeFeatureInDev => 'Funcion de codigo QR en desarrollo...';

  @override
  String get scanQrToAddMe =>
      'Escanea el codigo QR de arriba para agregarme como amigo';

  @override
  String get saveToAlbum => 'Guardar en album';

  @override
  String get changeStyle => 'Cambiar estilo';

  @override
  String get copyId => 'Copiar ID';

  @override
  String get idCopied => 'ID copiado';

  @override
  String get shareFeatureComingSoon => 'Funcion de compartir proximamente';

  @override
  String get saveFeatureComingSoon => 'Funcion de guardar proximamente';

  @override
  String get moreStylesFeatureComingSoon => 'Mas estilos proximamente';

  @override
  String get confirmEndPoll =>
      'Estas seguro de que quieres finalizar esta encuesta?';

  @override
  String get cannotVoteAfterEnd =>
      'No se pueden emitir mas votos despues de finalizar.';

  @override
  String get bio => 'Biografia';

  @override
  String get homeServer => 'Servidor';

  @override
  String get shareContactCard => 'Compartir tarjeta de contacto';

  @override
  String get removeFromBlacklist => 'Eliminar de lista negra';

  @override
  String get confirmAddBlacklist =>
      'Estas seguro de que quieres agregar a este usuario a la lista negra? No recibiras mensajes de el.';

  @override
  String get confirmRemoveBlacklist =>
      'Estas seguro de que quieres eliminar a este usuario de la lista negra?';

  @override
  String get remarkSaved => 'Nota guardada';

  @override
  String get remarkCleared => 'Nota borrada';

  @override
  String get receive => 'Recibir';

  @override
  String get pleaseConnectWallet => 'Por favor conecta tu billetera primero';

  @override
  String get sendRequest => 'Enviar solicitud';

  @override
  String get pleaseEnterValidAmount => 'Por favor ingresa un monto valido';

  @override
  String get searchPlaceholder => 'Buscar contactos, grupos, mensajes';

  @override
  String get enterKeywordToSearch => 'Ingresa palabras clave para buscar';

  @override
  String get clearHistory => 'Borrar';

  @override
  String noResultsForQuery(String query) {
    return 'No se encontraron resultados para \"$query\"';
  }

  @override
  String get allResults => 'Todo';

  @override
  String get searchInChat => 'Buscar en chat';

  @override
  String get contactLabel => 'Contacto';

  @override
  String get groupLabel => 'Grupo';

  @override
  String get conversationLabel => '会话';

  @override
  String get messageLabel => 'Mensaje';

  @override
  String get securityTitle => 'Seguridad';

  @override
  String get keyBackup => 'Respaldo de claves';

  @override
  String get backupEncryptionKeys => 'Respaldar claves de cifrado';

  @override
  String keysBackedUp(int count) {
    return '$count claves respaldadas';
  }

  @override
  String get backupNotSet => 'Respaldo no configurado';

  @override
  String get restoreKeys => 'Restaurar claves';

  @override
  String get restoreKeysFromBackup =>
      'Restaurar claves de cifrado desde respaldo';

  @override
  String get exportKeys => 'Exportar claves';

  @override
  String get exportKeysToFile => 'Exportar claves a archivo';

  @override
  String get loggedInDevices => 'Dispositivos conectados';

  @override
  String get noOtherDevices => 'Sin otros dispositivos';

  @override
  String get verified => 'Verificado';

  @override
  String get unverified => 'No verificado';

  @override
  String get advanced => 'Avanzado';

  @override
  String get crossSigning => 'Firma cruzada';

  @override
  String get enabled => 'Habilitado';

  @override
  String get notEnabled => 'No habilitado';

  @override
  String get resetEncryption => 'Restablecer cifrado';

  @override
  String get deleteAllEncryptionKeys => 'Eliminar todas las claves de cifrado';

  @override
  String get encryptionNotSupported => 'Cifrado no soportado';

  @override
  String get notInitialized => 'No inicializado';

  @override
  String get backupKeyTitle => 'Respaldar claves';

  @override
  String get backupKeyMessage =>
      'Crear un nuevo respaldo de claves? Esto te ayudara a restaurar mensajes cifrados en un nuevo dispositivo.';

  @override
  String get backup => 'Respaldar';

  @override
  String get restoreKeyTitle => 'Restaurar claves';

  @override
  String get restoreKeyMessage =>
      'Ingresa tu contrasena de recuperacion o clave de recuperacion para restaurar mensajes cifrados.';

  @override
  String get restore => 'Restaurar';

  @override
  String get exportKeyTitle => 'Exportar claves';

  @override
  String get exportKeyMessage =>
      'El archivo de claves exportado contiene todas tus claves de cifrado. Por favor guardalo de forma segura.';

  @override
  String get export => 'Exportar';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID de dispositivo: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Estado: Verificado';

  @override
  String get deviceStatusUnverified => 'Estado: No verificado';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Ultima actividad: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Verificar este dispositivo';

  @override
  String get crossSigningAlreadyEnabled =>
      'La firma cruzada ya esta habilitada';

  @override
  String get crossSigningSetupSuccess =>
      'Firma cruzada configurada exitosamente';

  @override
  String get resetEncryptionTitle => 'Restablecer cifrado';

  @override
  String get resetEncryptionWarning =>
      'Advertencia: Esto eliminara todas tus claves de cifrado. No podras descifrar mensajes cifrados anteriores. Esta accion no se puede deshacer.';

  @override
  String get reset => 'Restablecer';

  @override
  String get leaveMeetingConfirm =>
      'Estas seguro de que quieres salir de la reunion?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'toco a $name$suffix';
  }

  @override
  String get noContactsToAdd => 'No hay contactos disponibles para agregar';

  @override
  String get addMembers => 'Agregar miembros';

  @override
  String invitedMembers(int count) {
    return 'Invitados $count miembros';
  }

  @override
  String inviteFailed(String error) {
    return 'Error de invitacion: $error';
  }

  @override
  String get memberRemoved => 'Miembro eliminado';

  @override
  String removeFailed(String error) {
    return 'Error al eliminar: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Despues de compartir, la otra persona podra ver tu ubicacion en tiempo real por 1 hora.';

  @override
  String get startSharing => 'Iniciar compartir';

  @override
  String get locationServiceNotEnabled =>
      'El servicio de ubicacion no esta habilitado';

  @override
  String get enableLocationService =>
      'Por favor habilita el servicio de ubicacion para usar esta funcion';

  @override
  String get goToSettings => 'Ir a configuracion';

  @override
  String get locationPermissionRequired =>
      'Se requiere permiso de ubicacion para esta funcion';

  @override
  String get locationPermissionDeniedPermanent =>
      'El permiso de ubicacion ha sido denegado permanentemente. Por favor habilitalo en configuracion.';

  @override
  String get locationPermissionDenied => 'Permiso de ubicacion denegado';

  @override
  String get gettingLocation => 'Obteniendo ubicacion...';

  @override
  String getLocationFailed(String error) {
    return 'Error al obtener ubicacion: $error';
  }

  @override
  String get currentLocation => 'Ubicacion actual';

  @override
  String nearbyPlace(int index) {
    return 'Lugar cercano $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Aproximadamente $distance';
  }

  @override
  String get mapPreview => 'Vista previa del mapa';

  @override
  String get searchLocation => 'Buscar ubicacion';

  @override
  String redPacketSent(String amount, String token) {
    return 'Enviado sobre rojo de $amount $token';
  }

  @override
  String get transferDefault => 'Transferencia';

  @override
  String transferSent(String amount, String token) {
    return 'Enviada transferencia de $amount $token';
  }

  @override
  String pickFileFailed(String error) {
    return 'Error al seleccionar archivo: $error';
  }

  @override
  String get fileSizeLimit => 'El tamano del archivo no puede exceder 50MB';

  @override
  String fileSending(String filename) {
    return 'Enviando archivo: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Error al enviar archivo: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Enviada tarjeta de contacto de $name';
  }

  @override
  String get favoritesFeature => 'Favoritos';

  @override
  String get couponsFeature => 'Cupones';

  @override
  String get giftFeature => 'Regalo';

  @override
  String sharedMusic(String name) {
    return 'Compartido $name';
  }

  @override
  String get endPollTitle => 'Finalizar encuesta';

  @override
  String get endPollConfirmMessage =>
      'Estas seguro de que quieres finalizar esta encuesta? La votacion se cerrara despues de finalizar.';

  @override
  String get pollEndedMessage => 'Encuesta finalizada';

  @override
  String get connectingCall => 'Conectando...';

  @override
  String get muteCall => 'Silenciar';

  @override
  String get speakerOff => 'Altavoz apagado';

  @override
  String get speakerOn => 'Altavoz';

  @override
  String get cameraOn => 'Camara encendida';

  @override
  String get cameraOff => 'Camara apagada';

  @override
  String get hangUp => 'Colgar';

  @override
  String get selectForwardTargetTitle => 'Seleccionar destino de reenvio';

  @override
  String get noForwardableChat => 'No hay chats disponibles para reenviar';

  @override
  String get noMatchingChat => 'No se encontraron chats coincidentes';

  @override
  String get imagePreview => '[Imagen]';

  @override
  String get voicePreview => '[Voz]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[Archivo] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Ubicacion] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Musica] $title';
  }

  @override
  String get messagePreview => '[Mensaje]';

  @override
  String get locationTitle => 'Ubicacion';

  @override
  String get sendButton => 'Enviar';

  @override
  String get retryButton => 'Reintentar';

  @override
  String get selectContact => 'Seleccionar contacto';

  @override
  String get searchContactHint => 'Buscar contactos';

  @override
  String get shareMusic => 'Compartir musica';

  @override
  String get recentPlayed => 'Recientes';

  @override
  String get myFavorites => 'Favoritos';

  @override
  String get networkLink => 'Enlace';

  @override
  String get localFile => 'Local';

  @override
  String get musicLinkRequired => 'Enlace de musica *';

  @override
  String get pasteMusicLink => 'Pegar enlace de musica';

  @override
  String get enterSongNamePlaceholder => 'Ingresa nombre de cancion';

  @override
  String get enterArtistNamePlaceholder => 'Ingresa nombre de artista';

  @override
  String get shareMusicButton => 'Compartir musica';

  @override
  String get selectLocalAudio => 'Seleccionar archivo de audio local';

  @override
  String get supportedAudioFormats => 'Soporta MP3, M4A, WAV, FLAC, etc.';

  @override
  String get selectFileButton => 'Seleccionar archivo';

  @override
  String get pleaseEnterMusicLink => 'Por favor ingresa enlace de musica';

  @override
  String get pleaseEnterValidLink => 'Por favor ingresa una URL valida';

  @override
  String get sharedSong => 'Cancion compartida';

  @override
  String get selectMember => 'Seleccionar miembro';

  @override
  String get searchMemberHint => 'Buscar miembros';

  @override
  String get noMatchingMembers => 'No se encontraron miembros coincidentes';

  @override
  String get unknownMember => 'Desconocido';

  @override
  String selectedMessagesCount(int count) {
    return '$count mensajes seleccionados';
  }

  @override
  String get searchContactsOrGroups => 'Buscar contactos o grupos';

  @override
  String get noMatchingConversations =>
      'No se encontraron conversaciones coincidentes';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Cargando...';

  @override
  String get videoPlaybackFailed => 'Error de reproduccion de video';

  @override
  String get videoLoadFailed => 'Error al cargar video';

  @override
  String get playerInitFailed => 'Error de inicializacion del reproductor';

  @override
  String get createPollTitle => 'Crear encuesta';

  @override
  String get submitPoll => 'Enviar';

  @override
  String get pollQuestionLabel => 'Pregunta de la encuesta';

  @override
  String get enterPollQuestionHint =>
      'Por favor ingresa pregunta de la encuesta';

  @override
  String get pollOptionsLabel => 'Opciones de la encuesta';

  @override
  String optionHintWithIndex(int index) {
    return 'Opcion $index';
  }

  @override
  String get addOptionButton => 'Agregar opcion';

  @override
  String get pollSettingsLabel => 'Configuracion de encuesta';

  @override
  String get selectionType => 'Tipo de seleccion';

  @override
  String get singleChoiceLabel => 'Unica';

  @override
  String get multiChoiceLabel => 'Multiple';

  @override
  String get anonymousPollSwitch => 'Encuesta anonima';

  @override
  String get pleaseEnterQuestion => 'Por favor ingresa pregunta de la encuesta';

  @override
  String get atLeastTwoOptions => 'Se requieren al menos 2 opciones';

  @override
  String confirmWithCount(int count) {
    return 'Confirmar ($count)';
  }

  @override
  String get emailVerificationTitle => 'Verificacion de correo';

  @override
  String get enterValidEmailAddress =>
      'Por favor ingresa una direccion de correo valida';

  @override
  String verificationCodeSentTo(String email) {
    return 'Codigo de verificacion enviado a $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Error al enviar codigo: $error';
  }

  @override
  String get verificationSuccess => 'Verificacion exitosa';

  @override
  String get verificationFailed => 'Error de verificacion';

  @override
  String verificationCodeError(String error) {
    return 'Error de codigo de verificacion: $error';
  }

  @override
  String get enterVerificationCode => 'Ingresa codigo de verificacion';

  @override
  String get enterYourEmail => 'Ingresa correo';

  @override
  String weSentCodeTo(String email) {
    return 'Enviamos un codigo de 6 digitos a\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Ingresa tu direccion de correo, enviaremos codigo de verificacion';

  @override
  String get sendVerificationCode => 'Enviar codigo de verificacion';

  @override
  String get resendVerificationCode => 'Reenviar codigo de verificacion';

  @override
  String canResendAfter(int seconds) {
    return 'Puedes reenviar despues de $seconds segundos';
  }

  @override
  String get changeEmail => 'Cambiar correo';

  @override
  String get addToContacts => 'Agregar a contactos';

  @override
  String get addingToContacts => 'Agregando...';

  @override
  String get addedToContacts => 'Agregado a contactos';

  @override
  String addFailedWithError(String error) {
    return 'Error al agregar: $error';
  }

  @override
  String get addPhone => 'Agregar telefono';

  @override
  String get addTag => 'Agregar etiquetas';

  @override
  String get addText => 'Agregar texto';

  @override
  String get addPhoto => 'Agregar foto';

  @override
  String groupCountLabel(int count) {
    return '$count grupos';
  }

  @override
  String get addedViaSearch => 'Agregado via busqueda';

  @override
  String get addTime => 'Agregar hora';

  @override
  String get doneButton => 'Listo';

  @override
  String get waitingForParticipants =>
      'Esperando que los participantes se unan...';

  @override
  String participantMe(String name) {
    return '$name (Yo)';
  }

  @override
  String get sharingLabel => 'Compartiendo';

  @override
  String screenSharingBy(String name) {
    return '$name esta compartiendo pantalla';
  }

  @override
  String participantCount(int count) {
    return '$count participantes';
  }

  @override
  String get muteLabel => 'Silenciar';

  @override
  String get unmuteLabel => 'Activar sonido';

  @override
  String get turnOffVideo => 'Apagar video';

  @override
  String get turnOnVideo => 'Encender video';

  @override
  String get shareScreen => 'Compartir pantalla';

  @override
  String get stopSharing => 'Dejar de compartir';

  @override
  String get switchCameraLabel => 'Cambiar';

  @override
  String get leaveLabel => 'Salir';

  @override
  String get participantsLabel => 'Participantes';

  @override
  String get joiningMeeting => 'Uniendose a la reunion...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count votos ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count participantes';
  }

  @override
  String get tapToRetry => 'Toca para reintentar';

  @override
  String get noConversationsToForward => 'No hay conversaciones para reenviar';

  @override
  String get defaultRedPacketGreeting => 'Que la prosperidad te acompañe';

  @override
  String get emojiCategoryFace => 'Emoticonos';

  @override
  String get emojiCategoryHeart => 'Corazones';

  @override
  String get emojiCategoryAnimal => 'Animales';

  @override
  String get emojiCategoryFood => 'Comida';

  @override
  String get emojiCategoryTransport => 'Transporte';

  @override
  String get emojiCategoryActivity => 'Actividades';

  @override
  String get emojiCategoryObject => 'Objetos';

  @override
  String get emojiCategorySymbol => 'Símbolos';

  @override
  String get allowOthersToSearchAndJoin =>
      'Permitir que otros busquen y se unan';

  @override
  String get allowStrangerMessages => 'Permitir mensajes de extraños';

  @override
  String get alwaysUseDarkTheme => 'Usar siempre tema oscuro';

  @override
  String get alwaysUseLightTheme => 'Usar siempre tema claro';

  @override
  String get autoSwitchBySystem =>
      'Cambiar automaticamente segun configuracion del sistema';

  @override
  String get bubbleStyle => 'Estilo de burbuja';

  @override
  String get bubbleStyleClassic => 'Estilo clasico';

  @override
  String get bubbleStyleClassicDesc => 'Estilo de burbuja tradicional';

  @override
  String get bubbleStyleModern => 'Estilo moderno';

  @override
  String get bubbleStyleModernDesc => 'Estilo de burbuja moderno y limpio';

  @override
  String get bubbleStyleWechat => 'Estilo WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Estilo de burbuja clasico de WeChat';

  @override
  String get callEnded => 'Llamada terminada';

  @override
  String get callFailed => 'Llamada fallida';

  @override
  String get checkForUpdates => 'Buscar actualizaciones';

  @override
  String get confirmClearChatHistory =>
      '¿Estás seguro de que deseas borrar el historial de chat?';

  @override
  String get createGroupToChat => 'Crea un grupo para comenzar a chatear';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get darkModeOption => 'Modo oscuro';

  @override
  String get doNotDisturbDescription =>
      'No recibir notificaciones durante el tiempo especificado';

  @override
  String get doNotDisturbMode => 'No molestar';

  @override
  String get editGroupAnnouncement => 'Editar anuncio del grupo';

  @override
  String get editGroupDescription => 'Editar descripción del grupo';

  @override
  String get enterGroupAnnouncement => 'Ingresa el anuncio del grupo';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Comentarios y sugerencias';

  @override
  String get followSystem => 'Seguir sistema';

  @override
  String get fontSize => 'Tamano de fuente';

  @override
  String get fontSizeExtraLarge => 'Extra grande';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeSmall => 'Pequeno';

  @override
  String get fontSizeStandard => 'Estandar';

  @override
  String get incomingVideoCall => 'Videollamada entrante';

  @override
  String get incomingVoiceCall => 'Llamada de voz entrante';

  @override
  String get letOthersKnowYouRead =>
      'Permitir que otros sepan que leiste sus mensajes';

  @override
  String get letOthersKnowYouTyping =>
      'Permitir que otros sepan que estas escribiendo';

  @override
  String get lightMode => 'Modo claro';

  @override
  String memberCountClickToCopy(int count) {
    return '$count miembros, haz clic para copiar el ID del grupo';
  }

  @override
  String get messageNotifications => 'Notificaciones de mensajes';

  @override
  String get messagesLabel => 'Mensajes';

  @override
  String get musicLinkLabel => 'Enlace de musica';

  @override
  String get noMediaUrlAvailable => 'URL de medios no disponible';

  @override
  String get noPermissionToEditGroupName =>
      'No tienes permiso para editar el nombre del grupo';

  @override
  String get receiveMessagesFromNonContacts =>
      'Recibir mensajes de no contactos';

  @override
  String get receiveNewMessageNotifications =>
      'Recibir notificaciones de nuevos mensajes';

  @override
  String get reconnectingCall => 'Reconectando...';

  @override
  String get redPacketTransferCannotForward =>
      'Los sobres rojos y transferencias no se pueden reenviar';

  @override
  String get showMessageContentInNotification =>
      'Mostrar contenido del mensaje en notificaciones';

  @override
  String get showMessagePreview => 'Mostrar vista previa del mensaje';

  @override
  String get typingIndicator => 'Indicador de escritura';

  @override
  String versionInfo(String version) {
    return 'Versión $version';
  }

  @override
  String get vibration => 'Vibracion';

  @override
  String get videoCallInProgress => 'Videollamada';

  @override
  String get voiceCallInProgress => 'Llamada de voz';

  @override
  String whoCanSeeTitle(String title) {
    return 'Quien puede ver $title';
  }
}
