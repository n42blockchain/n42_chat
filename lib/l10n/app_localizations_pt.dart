// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class SPt extends S {
  SPt([String locale = 'pt']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Falha na inicialização do módulo de chat';

  @override
  String get checkNetworkRetry =>
      'Verifique sua conexão de rede e tente novamente';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get unknownUser => 'Usuário desconhecido';

  @override
  String get walletNotConnected => 'Carteira não conectada';

  @override
  String get cannotGetWalletAddress =>
      'Não foi possível obter o endereço da carteira';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Solicitação de pagamento: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Serviço de chamada não inicializado';

  @override
  String get alreadyInCall => 'Já está em uma chamada';

  @override
  String get meetingServiceNotInitialized =>
      'Serviço de reunião não inicializado';

  @override
  String get livekitNotConfigured => 'LiveKit não configurado';

  @override
  String get unknownConversation => 'Conversa desconhecida';

  @override
  String startCallFailed(String error) {
    return 'Falha ao iniciar chamada: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Falha ao atender: $error';
  }

  @override
  String get connectionFailed => 'Falha na conexão';

  @override
  String get callRejected => 'Chamada recusada';

  @override
  String get noAnswer => 'Sem resposta';

  @override
  String get invalidLoginResponse => 'Resposta de login inválida';

  @override
  String loginFailed(String error) {
    return 'Falha no login: $error';
  }

  @override
  String get sessionRestoreFailed => 'Falha ao restaurar sessão';

  @override
  String get additionalVerificationRequired =>
      'Verificação adicional necessária';

  @override
  String registrationFailed(String error) {
    return 'Falha no cadastro: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Não foi possível conectar ao servidor: $error';
  }

  @override
  String get wrongUsernamePassword => 'Nome de usuário ou senha incorretos';

  @override
  String get usernameTaken => 'Nome de usuário já está em uso';

  @override
  String get invalidUsernameFormat => 'Formato de nome de usuário inválido';

  @override
  String get rateLimitExceeded =>
      'Muitas solicitações, tente novamente mais tarde';

  @override
  String get loginExpired => 'Login expirado';

  @override
  String joinMeetingFailed(String error) {
    return 'Falha ao entrar na reunião: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Falha no compartilhamento de tela: $error';
  }

  @override
  String get answer => 'Atender';

  @override
  String get decline => 'Recusar';

  @override
  String get missedCall => 'Chamada perdida';

  @override
  String get callBack => 'Retornar chamada';

  @override
  String get incomingCall => 'Chamada recebida';

  @override
  String get missedVideoCall => 'Videochamada perdida';

  @override
  String get missedVoiceCall => 'Chamada de voz perdida';

  @override
  String get passkeyNotInitialized => 'Passkey não inicializada';

  @override
  String get googleSignInNotConfigured => 'Login com Google não configurado';

  @override
  String get encryptedMessage => '[Mensagem criptografada]';

  @override
  String get sticker => '[Figurinha]';

  @override
  String get groupCreated => 'Grupo criado';

  @override
  String get groupNameChanged => 'Nome do grupo alterado';

  @override
  String get groupAvatarChanged => 'Avatar do grupo alterado';

  @override
  String get groupAnnouncementChanged => 'Anúncio do grupo alterado';

  @override
  String get image => '[Imagem]';

  @override
  String get video => '[Vídeo]';

  @override
  String get voice => '[Áudio]';

  @override
  String get file => '[Arquivo]';

  @override
  String get location => '[Localização]';

  @override
  String get unknownMessage => '[Mensagem desconhecida]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName entrou no grupo';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName saiu do grupo';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName foi convidado(a)';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName foi removido(a)';
  }

  @override
  String get avatarDataEmpty => 'Dados do avatar estão vazios';

  @override
  String get avatarTooLarge => 'Arquivo de avatar muito grande, máximo 10MB';

  @override
  String get uploadAvatarFailed => 'Falha ao enviar avatar';

  @override
  String get delete => 'Excluir';

  @override
  String get notLoggedIn => 'Não conectado';

  @override
  String roomNotExist(String roomId) {
    return 'Sala não encontrada: $roomId';
  }

  @override
  String get uploadImageFailed => 'Falha ao enviar imagem';

  @override
  String get matrixClientNotInitialized => 'Cliente Matrix não inicializado';

  @override
  String get uploadVoiceFailed =>
      'Falha ao enviar áudio: Não foi possível obter URI MXC';

  @override
  String get uploadVideoFailed =>
      'Falha ao enviar vídeo: Não foi possível obter URI MXC';

  @override
  String get uploadFileFailed =>
      'Falha ao enviar arquivo: Não foi possível obter URI MXC';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Localização: $lat, $lon';
  }

  @override
  String get myLocation => 'Minha localização';

  @override
  String get pollEnded => 'Enquete encerrada';

  @override
  String get groupChat => 'Chat em Grupo';

  @override
  String get search => 'Pesquisar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get userCancelled => 'Usuário cancelou';

  @override
  String get noData => 'Sem dados';

  @override
  String get noSearchResults => 'Nenhum resultado encontrado';

  @override
  String get tryDifferentKeyword => 'Tente uma palavra-chave diferente';

  @override
  String get loadFailed => 'Falha ao carregar';

  @override
  String get checkNetwork => 'Verifique sua conexão de rede';

  @override
  String get networkConnectionFailed => 'Falha na conexão de rede';

  @override
  String get checkNetworkSettings => 'Verifique suas configurações de rede';

  @override
  String get messages => 'Mensagens';

  @override
  String get contacts => 'Contatos';

  @override
  String get discover => 'Descobrir';

  @override
  String get me => 'Eu';

  @override
  String get voiceLoading => 'Carregando áudio, tente novamente mais tarde';

  @override
  String get voiceToTextFailed => 'Falha na conversão de voz para texto';

  @override
  String get converting => 'Convertendo...';

  @override
  String get convertToText => 'Para texto';

  @override
  String get convertToTextTitle => 'Converter para Texto';

  @override
  String get selectEmoji => 'Selecionar emoji';

  @override
  String get frequentlyUsed => 'Usados frequentemente';

  @override
  String get copy => 'Copiar';

  @override
  String get forward => 'Encaminhar';

  @override
  String get unfavorite => 'Remover favorito';

  @override
  String get favorite => 'Favoritar';

  @override
  String get resend => 'Reenviar';

  @override
  String get recall => 'Desfazer envio';

  @override
  String get multiSelect => 'Selecionar vários';

  @override
  String get quote => 'Citar';

  @override
  String get remind => 'Lembrar';

  @override
  String get searchThis => 'Pesquisar';

  @override
  String get recallMessageConfirm => 'Desfazer envio desta mensagem?';

  @override
  String get youRecalledMessage => 'Você desfez o envio de uma mensagem';

  @override
  String get otherRecalledMessage => 'Mensagem removida';

  @override
  String get reEdit => 'Editar novamente';

  @override
  String get copied => 'Copiado';

  @override
  String get sendMessageHint => 'Enviar uma mensagem';

  @override
  String get microphonePermissionRequired =>
      'Por favor, permita o acesso ao microfone';

  @override
  String startRecordingFailed(String error) {
    return 'Falha ao iniciar gravação: $error';
  }

  @override
  String get recordingTooShort => 'Gravação muito curta';

  @override
  String stopRecordingFailed(String error) {
    return 'Falha ao parar gravação: $error';
  }

  @override
  String get releaseToCancel => 'Solte para cancelar';

  @override
  String get releaseToSend =>
      'Solte para enviar, deslize para cima para cancelar';

  @override
  String get holdToTalk => 'Segure para falar';

  @override
  String get send => 'Enviar';

  @override
  String conversationWithId(String roomId) {
    return 'Conversa: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Contato: $userId';
  }

  @override
  String get addFriend => 'Adicionar Amigo';

  @override
  String get chatServiceNotConnected => 'Serviço de chat não conectado';

  @override
  String userNotFoundHint(String query) {
    return 'Usuário \"$query\" não encontrado\n\nDicas:\n• Tente inserir o ID completo do usuário, ex: @usuario:servidor.com\n• Verifique a ortografia do nome de usuário';
  }

  @override
  String createChatFailed(String error) {
    return 'Falha ao criar chat: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Falha na pesquisa: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Digite o ID ou nome de usuário para pesquisar';

  @override
  String get searching => 'Pesquisando...';

  @override
  String get searchUserToChat =>
      'Pesquise um usuário para iniciar uma conversa';

  @override
  String get matrixIdExample =>
      'Você pode inserir um ID Matrix completo\nex: @usuario:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Usuário \"$username\" não encontrado';
  }

  @override
  String get chat => 'Chat';

  @override
  String get settings => 'Configurações';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get login => 'Entrar';

  @override
  String get createGroup => 'Criar Grupo';

  @override
  String developing(String title) {
    return '$title\n(Em breve)';
  }

  @override
  String get error => 'Erro';

  @override
  String get pageNotFound => 'Página não encontrada';

  @override
  String get backToHome => 'Voltar ao Início';

  @override
  String get allRead => 'Todas lidas';

  @override
  String readCount(int count) {
    return '$count lida(s)';
  }

  @override
  String get transfer => 'Transferir';

  @override
  String get pendingReceipt => 'Pendente';

  @override
  String get tapToReceive => 'Toque para receber';

  @override
  String get received => 'Recebido';

  @override
  String get paymentReceived => 'Pagamento recebido';

  @override
  String get refunded => 'Reembolsado';

  @override
  String get expired => 'Expirado';

  @override
  String get redPacketGreeting => 'Felicidades';

  @override
  String get n42RedPacket => 'Envelope Vermelho N42';

  @override
  String get goodLuck => 'Boa sorte';

  @override
  String get claimed => 'Resgatado';

  @override
  String get allClaimed => 'Todos resgatados';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Amor';

  @override
  String get animals => 'Animais';

  @override
  String get food => 'Comida';

  @override
  String get travel => 'Viagem';

  @override
  String get activities => 'Atividades';

  @override
  String get objects => 'Objetos';

  @override
  String get symbols => 'Símbolos';

  @override
  String get reply => 'Responder';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get edit => 'Editar';

  @override
  String get more => 'Mais';

  @override
  String get selectForwardTarget => 'Selecionar destinatário';

  @override
  String sendCount(int count) {
    return 'Enviar ($count)';
  }

  @override
  String get draft => '[Rascunho] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Info do Amigo';

  @override
  String get friendInfoDesc =>
      'Adicione observação, telefone, tags, notas, fotos e defina permissões.';

  @override
  String get moments => 'Momentos';

  @override
  String get sendMessage => 'Mensagem';

  @override
  String get audioVideoCall => 'Chamada de Áudio/Vídeo';

  @override
  String get videoChannel => 'Canal de Vídeo';

  @override
  String get remark => 'Observação';

  @override
  String get remarkName => 'Nome de Observação';

  @override
  String get phone => 'Telefone';

  @override
  String get tags => 'Tags';

  @override
  String get notes => 'Notas';

  @override
  String get photos => 'Fotos';

  @override
  String get permissions => 'Permissões';

  @override
  String get chatMomentsEtc => 'Chat, Momentos, Esportes, etc.';

  @override
  String get moreInfo => 'Mais Informações';

  @override
  String get commonGroups => 'Grupos em comum';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Origem';

  @override
  String get notificationSettings => 'Notificações';

  @override
  String get receiveNotifications => 'Receber notificações de novas mensagens';

  @override
  String get showPreview => 'Mostrar prévia da mensagem';

  @override
  String get showContentInNotification =>
      'Mostrar conteúdo da mensagem nas notificações';

  @override
  String get notificationSound => 'Som de notificação';

  @override
  String get playSoundOnMessage => 'Reproduzir som ao receber mensagens';

  @override
  String get vibrate => 'Vibrar';

  @override
  String get vibrateOnMessage => 'Vibrar ao receber mensagens';

  @override
  String get doNotDisturb => 'Não Perturbe';

  @override
  String get dndDescription =>
      'Silenciar notificações durante horários específicos';

  @override
  String get startTime => 'Horário de início';

  @override
  String get endTime => 'Horário de término';

  @override
  String get privacy => 'Privacidade';

  @override
  String get appearance => 'Aparência';

  @override
  String get about => 'Sobre';

  @override
  String get logout => 'Sair';

  @override
  String get logoutConfirm => 'Tem certeza que deseja sair?';

  @override
  String get exit => 'Sair';

  @override
  String get save => 'Salvar';

  @override
  String get nickname => 'Apelido';

  @override
  String get enterNickname => 'Digite o apelido';

  @override
  String get signature => 'Assinatura';

  @override
  String get addSignature => 'Adicionar uma assinatura';

  @override
  String get takePhoto => 'Tirar Foto';

  @override
  String get chooseFromGallery => 'Escolher da Galeria';

  @override
  String saveFailed(String error) {
    return 'Falha ao salvar: $error';
  }

  @override
  String get secureDecentralizedChat => 'Mensagens seguras e descentralizadas';

  @override
  String get endToEndEncryption => 'Criptografia de ponta a ponta';

  @override
  String get messagesOnlyYouCanSee =>
      'Mensagens visíveis apenas para você e o destinatário';

  @override
  String get decentralized => 'Descentralizado';

  @override
  String get basedOnMatrix => 'Construído no protocolo aberto Matrix';

  @override
  String get walletIntegration => 'Integração com Carteira';

  @override
  String get easyCryptoTransfer => 'Transferências de criptomoedas fáceis';

  @override
  String get register => 'Cadastrar';

  @override
  String get agreeTerms => 'Ao entrar, você concorda com';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get and => 'e';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get serverAddress => 'Endereço do Servidor';

  @override
  String get enterServerAddress => 'Digite o endereço do servidor';

  @override
  String get validServerAddress =>
      'Por favor, digite um endereço de servidor válido';

  @override
  String connectedTo(String serverName) {
    return 'Conectado a $serverName';
  }

  @override
  String get username => 'Nome de usuário';

  @override
  String get enterUsername => 'Digite o nome de usuário';

  @override
  String get password => 'Senha';

  @override
  String get enterPassword => 'Digite a senha';

  @override
  String get registerAccount => 'Cadastrar';

  @override
  String get forgotPassword => 'Esqueci a Senha';

  @override
  String get otherLoginMethods => 'Outros métodos de login';

  @override
  String get emailVerification => 'Código de verificação por e-mail';

  @override
  String get enterServerFirst =>
      'Por favor, digite o endereço do servidor primeiro';

  @override
  String get passkeyNeedsServer =>
      'Login com Passkey requer suporte do servidor';

  @override
  String googleLoginSuccess(String email) {
    return 'Login com Google bem-sucedido: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Falha no login com Google: $error';
  }

  @override
  String get appleLoginSuccess => 'Login com Apple bem-sucedido';

  @override
  String appleLoginFailed(String error) {
    return 'Falha no login com Apple: $error';
  }

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get joinN42Chat => 'Junte-se ao N42 Chat para começar a conversar';

  @override
  String get usernameHint => '3-20 caracteres, letras/números/_';

  @override
  String get usernameMinLength =>
      'Nome de usuário deve ter pelo menos 3 caracteres';

  @override
  String get usernameMaxLength =>
      'Nome de usuário deve ter no máximo 20 caracteres';

  @override
  String get usernameFormat =>
      'Nome de usuário só pode conter letras, números e underscores';

  @override
  String get passwordHint => 'Mínimo 8 caracteres';

  @override
  String get passwordMinLength => 'Senha deve ter pelo menos 8 caracteres';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get reEnterPassword => 'Digite a senha novamente';

  @override
  String get passwordsNotMatch => 'As senhas não coincidem';

  @override
  String get inviteCode => 'Código de convite (integrado)';

  @override
  String get filled => 'Preenchido';

  @override
  String get enterInviteCode => 'Digite o código de convite';

  @override
  String get inviteCodeHint =>
      'O código de convite é integrado, geralmente não precisa modificar';

  @override
  String get agreeTermsFirst =>
      'Por favor, leia e aceite os termos e política de privacidade primeiro';

  @override
  String get iAgree => 'Li e aceito';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get loginNow => 'Entrar agora';

  @override
  String get whoCanSee => 'Quem pode ver';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Status';

  @override
  String get lastSeen => 'Visto por último';

  @override
  String get messageSettings => 'Mensagens';

  @override
  String get allowStrangerMessage => 'Permitir mensagens de desconhecidos';

  @override
  String get receiveNonContact => 'Receber mensagens de não-contatos';

  @override
  String get readReceipts => 'Confirmação de leitura';

  @override
  String get letOthersKnowRead =>
      'Permitir que outros saibam que você leu as mensagens';

  @override
  String get typingStatus => 'Status de digitação';

  @override
  String get letOthersKnowTyping =>
      'Permitir que outros saibam que você está digitando';

  @override
  String get everyone => 'Todos';

  @override
  String get contactsOnly => 'Apenas contatos';

  @override
  String get nobody => 'Ninguém';

  @override
  String whoCanSeeItem(String title) {
    return 'Quem pode ver $title';
  }

  @override
  String version(String version) {
    return 'Versão $version';
  }

  @override
  String get checkUpdate => 'Verificar atualizações';

  @override
  String get openSourceLicenses => 'Licenças de código aberto';

  @override
  String get feedback => 'Feedback';

  @override
  String get builtOnMatrix => 'Construído no protocolo Matrix';

  @override
  String get loading => 'Carregando...';

  @override
  String get noConversations => 'Nenhuma conversa';

  @override
  String get tapToChat =>
      'Toque no canto superior direito para iniciar uma conversa';

  @override
  String get startGroup => 'Iniciar Chat em Grupo';

  @override
  String get scan => 'Escanear';

  @override
  String get payment => 'Pagamento';

  @override
  String featureComingSoon(String feature) {
    return '$feature em breve';
  }

  @override
  String get markAsRead => 'Marcar como lida';

  @override
  String get unmute => 'Ativar som';

  @override
  String get mute => 'Silenciar';

  @override
  String get unpin => 'Desafixar';

  @override
  String get pin => 'Fixar';

  @override
  String get deleteConversation => 'Excluir Conversa';

  @override
  String deleteConversationConfirm(String name) {
    return 'Excluir conversa com \"$name\"?';
  }

  @override
  String get noContacts => 'Nenhum contato';

  @override
  String get addFriendsToChat => 'Adicione amigos para começar a conversar';

  @override
  String get contactNotFound => 'Contato não encontrado';

  @override
  String get tryOtherKeywords =>
      'Tente outras palavras-chave ou pesquisa global';

  @override
  String get searchResults => 'Resultados da pesquisa';

  @override
  String get newFriends => 'Novos Amigos';

  @override
  String get chatOnlyFriends => 'Amigos apenas para chat';

  @override
  String get officialAccounts => 'Contas Oficiais';

  @override
  String get serviceAccounts => 'Contas de Serviço';

  @override
  String get enterpriseContacts => 'Contatos Empresariais';

  @override
  String contactsCount(int count) {
    return '$count contatos';
  }

  @override
  String get recommendToFriend => 'Compartilhar contato';

  @override
  String get setRemark => 'Definir observação';

  @override
  String get addToHome => 'Adicionar à tela inicial';

  @override
  String get sendingCard => 'Enviando cartão de contato...';

  @override
  String get contactCard => '[Cartão de Contato]';

  @override
  String get fileLabel => 'Arquivo';

  @override
  String get locationLabel => 'Localização';

  @override
  String cardSent(String contact, String friend) {
    return 'Enviado cartão de $contact para $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Falha na recomendação: $error';
  }

  @override
  String get enterRemark => 'Digite a observação';

  @override
  String remarkSet(String remark) {
    return 'Observação definida como: $remark';
  }

  @override
  String get openingChat => 'Abrindo chat...';

  @override
  String openChatFailed(String error) {
    return 'Falha ao abrir chat: $error';
  }

  @override
  String get addContact => 'Adicionar Contato';

  @override
  String get enterUserId => 'Digite o ID do usuário';

  @override
  String get noFriendRequests => 'Nenhuma solicitação de amizade';

  @override
  String get accept => 'Aceitar';

  @override
  String get reject => 'Recusar';

  @override
  String acceptedRequest(String name) {
    return 'Solicitação de amizade de $name aceita';
  }

  @override
  String rejectedRequest(String name) {
    return 'Solicitação de amizade de $name recusada';
  }

  @override
  String get noGroups => 'Nenhum grupo';

  @override
  String get creatingGroup => 'Criação de grupos em breve...';

  @override
  String get selectFriendToRecommend => 'Selecione um amigo para recomendar';

  @override
  String get searchContacts => 'Pesquisar contatos';

  @override
  String get noContactsFound => 'Nenhum contato encontrado';

  @override
  String get yesterday => 'Ontem';

  @override
  String get monday => 'Seg';

  @override
  String get tuesday => 'Ter';

  @override
  String get wednesday => 'Qua';

  @override
  String get thursday => 'Qui';

  @override
  String get friday => 'Sex';

  @override
  String get saturday => 'Sáb';

  @override
  String get sunday => 'Dom';

  @override
  String get justNow => 'Agora mesmo';

  @override
  String minutesAgo(int count) {
    return '$count min atrás';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h atrás';
  }

  @override
  String daysAgo(int count) {
    return '${count}d atrás';
  }

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String minutesAgoOnline(int count) {
    return 'Online há $count min';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Online há ${count}h';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Online há ${count}d';
  }

  @override
  String get searchContactsGroupsMessages =>
      'Pesquisar contatos, grupos, mensagens';

  @override
  String get searchError => 'Erro na pesquisa';

  @override
  String get searchHint => 'Pesquisar contatos, grupos e mensagens';

  @override
  String get enterKeyword => 'Digite palavras-chave para pesquisar';

  @override
  String get searchHistory => 'Histórico de Pesquisa';

  @override
  String get clear => 'Limpar';

  @override
  String noResultsFor(String query) {
    return 'Nenhum resultado para \"$query\"';
  }

  @override
  String get all => 'Todos';

  @override
  String get groups => 'Grupos';

  @override
  String get noResults => 'Nenhum resultado';

  @override
  String get groupInfo => 'Info do Grupo';

  @override
  String groupMembers(int count) {
    return 'Membros ($count)';
  }

  @override
  String get groupMembersTitle => 'Membros do grupo';

  @override
  String get viewAll => 'Ver todos';

  @override
  String get owner => 'Dono';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Convidar';

  @override
  String get groupAnnouncement => 'Anúncio do Grupo';

  @override
  String get notSet => 'Não definido';

  @override
  String get groupDescription => 'Descrição do Grupo';

  @override
  String get publicGroup => 'Grupo Público';

  @override
  String get allowSearchJoin => 'Permitir que outros pesquisem e entrem';

  @override
  String get clearChatHistory => 'Limpar Histórico de Chat';

  @override
  String get dissolveGroup => 'Dissolver Grupo';

  @override
  String get leaveGroup => 'Sair do Grupo';

  @override
  String get changeGroupName => 'Alterar Nome do Grupo';

  @override
  String get enterGroupName => 'Digite o nome do grupo';

  @override
  String get confirm => 'Confirmar';

  @override
  String get changeGroupDescription => 'Alterar Descrição do Grupo';

  @override
  String get enterGroupDescription => 'Digite a descrição do grupo';

  @override
  String get editAnnouncement => 'Editar Anúncio';

  @override
  String get enterAnnouncement => 'Digite o anúncio';

  @override
  String get publish => 'Publicar';

  @override
  String get clearHistoryConfirm =>
      'Limpar todo o histórico de chat? Esta ação não pode ser desfeita.';

  @override
  String get clearAction => 'Limpar';

  @override
  String get chatHistoryCleared => 'Histórico de chat limpo';

  @override
  String leaveGroupConfirm(String name) {
    return 'Sair de \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Dissolver \"$name\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get dissolve => 'Dissolver';

  @override
  String get groupQrCode => 'QR Code do Grupo';

  @override
  String get searchChatHistory => 'Pesquisar Histórico de Chat';

  @override
  String get groupIdCopied => 'ID do grupo copiado';

  @override
  String tapCopyGroupId(int count) {
    return '$count membros · Toque para copiar ID do Grupo';
  }

  @override
  String get receiverAddress => 'Endereço do Destinatário';

  @override
  String get enterOrPasteAddress => 'Digite ou cole o endereço da carteira';

  @override
  String get selectToken => 'Selecionar Token';

  @override
  String get transferAmount => 'Valor da Transferência';

  @override
  String get available => 'Disponível';

  @override
  String get allAmount => 'Tudo';

  @override
  String get memoOptional => 'Observação (opcional)';

  @override
  String get addMemo => 'Adicionar uma observação';

  @override
  String get confirmTransfer => 'Confirmar Transferência';

  @override
  String get invalidAddress =>
      'Por favor, digite um endereço de destinatário válido';

  @override
  String get invalidAmount => 'Por favor, digite um valor válido';

  @override
  String get selectTokenPlease => 'Por favor, selecione um token';

  @override
  String get addressVerified => 'Endereço verificado';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Disponível: $balance $symbol';
  }

  @override
  String get scanningInDevelopment =>
      'Recurso de escaneamento em desenvolvimento...';

  @override
  String get enterAmount => 'Digite o valor';

  @override
  String get redPacketCountMin => 'É necessário pelo menos 1 envelope vermelho';

  @override
  String get viewRedPacketDetails => 'Ver detalhes do envelope vermelho';

  @override
  String get enterTransferAmount => 'Digite o valor da transferência';

  @override
  String get transferTo => 'Transferir para';

  @override
  String get selectCurrency => 'Selecionar moeda';

  @override
  String get receiveTransfer => 'Transferência recebida';

  @override
  String fromSender(String name, Object senderName) {
    return 'De $senderName';
  }

  @override
  String get confirmReceive => 'Confirmar Recebimento';

  @override
  String get groupProfile => 'Info do Grupo';

  @override
  String get viewProfile => 'Ver Perfil';

  @override
  String get removeMember => 'Remover do Grupo';

  @override
  String removeMemberConfirm(String name) {
    return 'Remover \"$name\" do grupo?';
  }

  @override
  String get remove => 'Remover';

  @override
  String get clearStatus => 'Limpar Status';

  @override
  String get clearStatusConfirm => 'Limpar status atual?';

  @override
  String get statusCleared => 'Status limpo';

  @override
  String statusSet(String result) {
    return 'Status definido como: $result';
  }

  @override
  String get userNotExist => 'Usuário não existe';

  @override
  String get userIdCopied => 'ID do usuário copiado';

  @override
  String get voiceCallInDevelopment => 'Chamada de voz em desenvolvimento...';

  @override
  String get report => 'Denunciar';

  @override
  String get reportInDevelopment => 'Recurso de denúncia em desenvolvimento...';

  @override
  String get shareCard => 'Compartilhar Cartão';

  @override
  String get shareInDevelopment =>
      'Recurso de compartilhamento em desenvolvimento...';

  @override
  String get qrCode => 'QR Code';

  @override
  String get qrCodeInDevelopment => 'Recurso de QR code em desenvolvimento...';

  @override
  String get avatarUpdated => 'Avatar atualizado';

  @override
  String selectImageFailed(String error) {
    return 'Falha ao selecionar imagem: $error';
  }

  @override
  String get changeName => 'Alterar Nome';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Feminino';

  @override
  String genderSet(String gender) {
    return 'Gênero definido como: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Região definida como: $region';
  }

  @override
  String get setPatText => 'Definir Texto de Cutucada';

  @override
  String get changeSignature => 'Alterar Assinatura';

  @override
  String ringtoneSet(String result) {
    return 'Toque definido como: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature em desenvolvimento...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Falha ao salvar endereço: $error';
  }

  @override
  String get myAddress => 'Meu Endereço';

  @override
  String get addNew => 'Adicionar';

  @override
  String get addAddress => 'Adicionar Endereço';

  @override
  String get addressAdded => 'Endereço adicionado';

  @override
  String get addressUpdated => 'Endereço atualizado';

  @override
  String get deleteAddress => 'Excluir Endereço';

  @override
  String get deleteAddressConfirm => 'Excluir este endereço?';

  @override
  String get addressDeleted => 'Endereço excluído';

  @override
  String get setDefaultAddress => 'Definir como padrão';

  @override
  String get fillCompleteInfo => 'Por favor, preencha todos os campos';

  @override
  String saveInvoiceFailed(String error) {
    return 'Falha ao salvar fatura: $error';
  }

  @override
  String get myInvoices => 'Minhas Faturas';

  @override
  String get addInvoice => 'Adicionar Fatura';

  @override
  String get invoiceAdded => 'Fatura adicionada';

  @override
  String get invoiceUpdated => 'Fatura atualizada';

  @override
  String get deleteInvoice => 'Excluir Fatura';

  @override
  String get deleteInvoiceConfirm => 'Excluir esta fatura?';

  @override
  String get invoiceDeleted => 'Fatura excluída';

  @override
  String get invoiceType => 'Tipo de fatura: ';

  @override
  String get personal => 'Pessoal';

  @override
  String get enterprise => 'Empresa';

  @override
  String get setDefaultInvoice => 'Definir como padrão';

  @override
  String get enterTaxId => 'Digite o CNPJ/CPF';

  @override
  String get vibrateMode => 'Modo vibração';

  @override
  String get silentMode => 'Modo silencioso';

  @override
  String playing(String ringtoneName) {
    return 'Reproduzindo: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Falha ao reproduzir: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Por favor, digite o nome do grupo';

  @override
  String get selectAtLeastOne => 'Por favor, selecione pelo menos um membro';

  @override
  String get fillStatus => 'Escrever Status';

  @override
  String get fileNotExist => 'Arquivo não existe';

  @override
  String sendFailed(String error) {
    return 'Falha ao enviar: $error';
  }

  @override
  String get cannotOpenBrowser => 'Não foi possível abrir o navegador';

  @override
  String selectFileFailed(String error) {
    return 'Falha ao selecionar arquivo: $error';
  }

  @override
  String get enterMusicLink => 'Digite o link da música';

  @override
  String get enterValidLink => 'Por favor, digite um link válido';

  @override
  String get enterPollQuestion => 'Digite a pergunta da enquete';

  @override
  String get minTwoOptions => 'São necessárias pelo menos 2 opções';

  @override
  String get crossDeviceEnabled => 'Assinatura entre dispositivos ativada';

  @override
  String get crossDeviceSet =>
      'Assinatura entre dispositivos configurada com sucesso';

  @override
  String setupFailed(String error) {
    return 'Falha na configuração: $error';
  }

  @override
  String get receiveAmount => 'Valor a Receber';

  @override
  String get enterValidAmount => 'Por favor, digite um valor válido';

  @override
  String get addressCopied => 'Endereço copiado';

  @override
  String openItem(String content) {
    return 'Abrir: $content';
  }

  @override
  String get newNoteComingSoon => 'Recurso de nova nota em breve';

  @override
  String get addLinkComingSoon => 'Recurso de adicionar link em breve';

  @override
  String get deleted => 'Excluído';

  @override
  String get shareComingSoon => 'Recurso de compartilhamento em breve';

  @override
  String get saveComingSoon => 'Recurso de salvar em breve';

  @override
  String get moreStylesComingSoon => 'Mais estilos em breve';

  @override
  String get wallet => 'Carteira';

  @override
  String get walletArea => 'Área da carteira';

  @override
  String get recording => 'Gravando';

  @override
  String get invalidVideoUrl => 'URL de vídeo inválida';

  @override
  String get downloadFile => 'Baixar arquivo';

  @override
  String get clearChatHistoryTitle => 'Limpar Histórico de Chat';

  @override
  String get cannotUndo => 'Esta ação não pode ser desfeita';

  @override
  String get videoCall => 'Videochamada';

  @override
  String get voiceCall => 'Chamada de Voz';

  @override
  String get leaveMeeting => 'Sair da Reunião';

  @override
  String get chatDetails => 'Detalhes do Chat';

  @override
  String get viewAllGroupMembers => 'Ver todos os membros';

  @override
  String get groupName => 'Nome do Grupo';

  @override
  String get groupNameUpdated => 'Nome do grupo atualizado';

  @override
  String get updateFailed => 'Falha na atualização';

  @override
  String get noPermissionToModify => 'Você não tem permissão para modificar';

  @override
  String get groupManagement => 'Gerenciamento do Grupo';

  @override
  String get myNicknameInGroup => 'Meu Apelido no Grupo';

  @override
  String get pinChat => 'Fixar Chat';

  @override
  String get strongReminder => 'Lembrete Forte';

  @override
  String get setChatBackground => 'Definir Plano de Fundo do Chat';

  @override
  String get unknownFile => 'Arquivo desconhecido';

  @override
  String get download => 'Baixar';

  @override
  String get invalidLocation => 'Localização inválida';

  @override
  String get address => 'Endereço';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get close => 'Fechar';

  @override
  String get tapToCancel => 'Toque para cancelar';

  @override
  String captureFailed(Object error) {
    return 'Falha na captura: $error';
  }

  @override
  String get processingVideo => 'Processando vídeo...';

  @override
  String get videoFileNotExist => 'Arquivo de vídeo não existe';

  @override
  String get videoDataEmpty => 'Dados do vídeo estão vazios';

  @override
  String get videoTooLarge => 'O tamanho do vídeo não pode exceder 100MB';

  @override
  String get sendingVideo => 'Enviando vídeo...';

  @override
  String sendVideoFailed(Object error) {
    return 'Falha ao enviar vídeo: $error';
  }

  @override
  String get imageFileNotExist => 'Arquivo de imagem não existe';

  @override
  String get imageDataEmpty => 'Dados da imagem estão vazios';

  @override
  String get sendingImage => 'Enviando imagem...';

  @override
  String sendImageFailed(Object error) {
    return 'Falha ao enviar imagem: $error';
  }

  @override
  String get sendLocation => 'Enviar Localização';

  @override
  String get selectLocationAndSend => 'Selecione a localização e envie';

  @override
  String get shareRealTimeLocation => 'Compartilhar Localização em Tempo Real';

  @override
  String get shareLocationForOneHour =>
      'Compartilhe sua localização em tempo real com amigo por 1 hora';

  @override
  String get locationSent => 'Localização enviada';

  @override
  String get selectMessages => 'Selecionar mensagens';

  @override
  String selectedCount(int count) {
    return '$count selecionada(s)';
  }

  @override
  String get selectAll => 'Selecionar Todas';

  @override
  String groupChatCount(int count) {
    return 'Chat em Grupo ($count)';
  }

  @override
  String get privateChat => 'Chat Privado';

  @override
  String get noMessages => 'Nenhuma mensagem';

  @override
  String get sendFirstMessage =>
      'Envie a primeira mensagem para iniciar a conversa';

  @override
  String get encryptionNotice =>
      'Este chat é criptografado de ponta a ponta. Apenas você e o destinatário podem ler as mensagens.';

  @override
  String replyTo(String name) {
    return 'Responder a $name';
  }

  @override
  String get multiForward => 'Encaminhar';

  @override
  String get collect => 'Coletar';

  @override
  String get noMembers => 'Nenhum membro';

  @override
  String get memberNotFound => 'Membro não encontrado';

  @override
  String get voiceFileNotExist => 'Arquivo de áudio não existe';

  @override
  String get voiceFileEmpty => 'Arquivo de áudio está vazio';

  @override
  String get sendingVoice => 'Enviando áudio...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Falha ao enviar áudio: $error';
  }

  @override
  String get messageCopied => 'Mensagem copiada';

  @override
  String get messageForwarded => 'Mensagem encaminhada';

  @override
  String forwardFailed(Object error) {
    return 'Falha ao encaminhar: $error';
  }

  @override
  String get unfavorited => 'Removido dos favoritos';

  @override
  String get favorited => 'Adicionado aos favoritos';

  @override
  String get reactionAdded => 'Reação adicionada';

  @override
  String get failedMessageDeleted => 'Mensagem com falha excluída';

  @override
  String get deleteMessages => 'Excluir mensagens';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Tem certeza que deseja excluir $count mensagens?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Nota: $count mensagens são de outros, só podem ser excluídas localmente.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count mensagens suas serão desfeitas.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Desfeitas $count mensagens, excluídas $localCount localmente';
  }

  @override
  String recalledMessages(Object count) {
    return 'Desfeitas $count mensagens';
  }

  @override
  String deletedLocally(Object count) {
    return 'Excluídas $count mensagens (localmente)';
  }

  @override
  String forwardedCount(Object count) {
    return 'Encaminhadas $count mensagens';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Encaminhamento completo: $success sucesso(s), $failed falha(s)';
  }

  @override
  String get remindOnlyInGroup =>
      'Recurso de lembrete disponível apenas em chat em grupo';

  @override
  String get onlyTextSearchable =>
      'Apenas mensagens de texto podem ser pesquisadas';

  @override
  String searchFor(Object text) {
    return 'Pesquisar \"$text\"';
  }

  @override
  String get baiduSearch => 'Pesquisa Baidu';

  @override
  String get googleSearch => 'Pesquisa Google';

  @override
  String get bingSearch => 'Pesquisa Bing';

  @override
  String get calling => 'Chamando...';

  @override
  String get connecting => 'Conectando...';

  @override
  String get ringing => 'Tocando...';

  @override
  String get inCall => 'Em chamada';

  @override
  String featureInDevelopment(String feature) {
    return 'Recurso em desenvolvimento...';
  }

  @override
  String collectMessages(Object count) {
    return 'Coletadas $count mensagens';
  }

  @override
  String get voted => 'Votou';

  @override
  String get voteChanged => 'Voto alterado';

  @override
  String get voteRemoved => 'Voto removido';

  @override
  String get endPoll => 'Encerrar Enquete';

  @override
  String get endPollConfirm =>
      'Tem certeza que deseja encerrar esta enquete? Nenhum voto poderá ser feito após o encerramento.';

  @override
  String memberCount(int count) {
    return '$count membros';
  }

  @override
  String get videoChannels => 'Canais';

  @override
  String get live => 'Ao Vivo';

  @override
  String get listen => 'Ouvir';

  @override
  String get watch => 'Assistir';

  @override
  String get searchDiscover => 'Pesquisar';

  @override
  String get nearbyPeople => 'Pessoas Próximas';

  @override
  String get games => 'Jogos';

  @override
  String get miniPrograms => 'Mini Programas';

  @override
  String done(int count) {
    return 'Concluído($count)';
  }

  @override
  String get services => 'Serviços';

  @override
  String get favorites => 'Favoritos';

  @override
  String get ordersAndCards => 'Pedidos e Cartões';

  @override
  String get stickers => 'Figurinhas';

  @override
  String statusSetTo(String status) {
    return 'Status definido como: $status';
  }

  @override
  String get avatarUploadFailed => 'Falha no envio do avatar';

  @override
  String get personalProfile => 'Perfil Pessoal';

  @override
  String get name => 'Nome';

  @override
  String get gender => 'Gênero';

  @override
  String get region => 'Região';

  @override
  String get myQrCode => 'Meu QR Code';

  @override
  String get poke => 'Cutucar';

  @override
  String get ringtone => 'Toque';

  @override
  String get defaultRingtone => 'Toque Padrão';

  @override
  String get myAddresses => 'Meus Endereços';

  @override
  String genderSetTo(String gender) {
    return 'Gênero definido como: $gender';
  }

  @override
  String get selectRegion => 'Selecionar Região';

  @override
  String get selectCity => 'Selecionar Cidade';

  @override
  String regionSetTo(String region) {
    return 'Região definida como: $region';
  }

  @override
  String get setPoke => 'Definir Cutucada';

  @override
  String get friendPokedMe => 'Amigo me cutucou';

  @override
  String get enterPokeSuffix => 'Digite o sufixo da cutucada, ex.: no ombro';

  @override
  String get example => 'Exemplo';

  @override
  String get onTheShoulder => ' no ombro';

  @override
  String get pokeCleared => 'Cutucada limpa';

  @override
  String pokeSetTo(String suffix) {
    return 'Cutucada definida como: me cutucou$suffix';
  }

  @override
  String get editSignature => 'Editar Assinatura';

  @override
  String get introduceYourself => 'Uma frase para se apresentar';

  @override
  String get signatureCleared => 'Assinatura limpa';

  @override
  String get signatureUpdated => 'Assinatura atualizada';

  @override
  String get scanToAddFriend =>
      'Escaneie o QR code acima para me adicionar como amigo';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Toque definido como: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Tem certeza de que deseja dissolver \"$name\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get enterValidServerAddress =>
      'Por favor, digite um endereço de servidor válido';

  @override
  String get emailOtp => 'Código por E-mail';

  @override
  String get enterServerAddressFirst =>
      'Por favor, digite o endereço do servidor primeiro';

  @override
  String get passkeyRequiresServer =>
      'Login com Passkey requer suporte do servidor';

  @override
  String get loginAgreement => 'Ao entrar, você concorda com ';

  @override
  String get pleaseAgreeToTerms =>
      'Por favor, leia e aceite os Termos de Serviço e Política de Privacidade';

  @override
  String get registerFailed => 'Falha no cadastro';

  @override
  String get reenterPassword => 'Digite a senha novamente';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get inviteCodeBuiltIn => 'Código de Convite (Integrado)';

  @override
  String get inviteCodeBuiltInNote =>
      'O código de convite é integrado, geralmente não precisa modificar';

  @override
  String get iHaveReadAndAgree => 'Li e aceito ';

  @override
  String get startGroupChat => 'Iniciar Chat em Grupo';

  @override
  String get addFriends => 'Adicionar Amigos';

  @override
  String get paymentAndCollection => 'Pagamento';

  @override
  String messagesWithCount(int count) {
    return 'Mensagens($count)';
  }

  @override
  String contactCount(int count) {
    return '$count contatos';
  }

  @override
  String get addToHomeScreen => 'Adicionar à tela inicial';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Recomendou cartão de $contact para $recipient';
  }

  @override
  String get enterRemarkName => 'Digite o nome de observação';

  @override
  String remarkSetTo(String remark) {
    return 'Observação definida como: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Solicitação de amizade de $name aceita';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Solicitação de amizade de $name recusada';
  }

  @override
  String get groupInvites => 'Convites para Grupos';

  @override
  String myGroups(int count) {
    return 'Meus grupos ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Convidado para entrar no grupo';

  @override
  String confirmLeaveGroup(String name) {
    return 'Tem certeza de que deseja sair de \"$name\"?';
  }

  @override
  String get leave => 'Sair';

  @override
  String get saveMedia => 'Salvar';

  @override
  String get recallThisMessage => 'Desfazer envio desta mensagem?';

  @override
  String get messageRecalled => 'Mensagem removida';

  @override
  String get savedToGallery => 'Salvo na galeria';

  @override
  String get failedToSave => 'Falha ao salvar';

  @override
  String get saving => 'Salvando...';

  @override
  String get share => 'Compartilhar';

  @override
  String get saveToGallery => 'Salvar na Galeria';

  @override
  String downloadFailed(String code) {
    return 'Falha no download: $code';
  }

  @override
  String get noMediaUrl => 'Nenhuma URL de mídia disponível';

  @override
  String shareFailed(String error) {
    return 'Falha ao compartilhar: $error';
  }

  @override
  String get failedToLoadImage => 'Falha ao carregar imagem';

  @override
  String get failedToLoadMoreMessages => 'Falha ao carregar mais mensagens';

  @override
  String get failedToSend => 'Falha ao enviar';

  @override
  String get failedToSendImage => 'Falha ao enviar imagem';

  @override
  String get failedToSendVoice => 'Falha ao enviar áudio';

  @override
  String get failedToSendFile => 'Falha ao enviar arquivo';

  @override
  String get failedToSendVideo => 'Falha ao enviar vídeo';

  @override
  String get failedToSendLocation => 'Falha ao enviar localização';

  @override
  String get failedToResend => 'Falha ao reenviar';

  @override
  String get failedToRecall => 'Falha ao desfazer envio';

  @override
  String get failedToReply => 'Falha ao responder';

  @override
  String get failedToAddReaction => 'Falha ao adicionar reação';

  @override
  String get failedToSendPoll => 'Falha ao enviar enquete';

  @override
  String get failedToVote => 'Falha ao votar';

  @override
  String get failedToLoadMessages => 'Falha ao carregar mensagens';

  @override
  String get callFeatureComingSoon =>
      'Recurso de chamada de voz e vídeo em breve';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Envelopes vermelhos e transferências não podem ser encaminhados';

  @override
  String get videoRecordingFailed =>
      'Falha na gravação de vídeo. Por favor, tente novamente.';

  @override
  String get redPacket => 'Envelope Vermelho';

  @override
  String get music => 'Música';

  @override
  String get coupon => 'Cupom';

  @override
  String get gift => 'Presente';

  @override
  String get poll => 'Enquete';

  @override
  String get text => 'Texto';

  @override
  String get link => 'Link';

  @override
  String get note => 'Nota';

  @override
  String get myNotes => 'Minhas Notas';

  @override
  String get today => 'Hoje';

  @override
  String daysAgoText(int count) {
    return 'há $count dias';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Nenhum favorito ainda';

  @override
  String get longPressToFavorite =>
      'Pressione e segure a mensagem para favoritar';

  @override
  String get newNote => 'Nova Nota';

  @override
  String get favoriteLink => 'Link Favorito';

  @override
  String get editTags => 'Editar Tags';

  @override
  String get deleteFavorite => 'Excluir Favorito';

  @override
  String get deleteFavoriteConfirm =>
      'Tem certeza que deseja excluir este favorito?';

  @override
  String get noSearchResultsFound => 'Nenhum resultado encontrado';

  @override
  String get sendRedPacket => 'Enviar Envelope Vermelho';

  @override
  String get amount => 'Valor';

  @override
  String get redPacketCover => 'Capa do Envelope Vermelho';

  @override
  String get redPacketType => 'Tipo de Envelope Vermelho';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'Sorte';

  @override
  String get redPacketCount => 'Quantidade de Envelopes';

  @override
  String get pieces => 'unidades';

  @override
  String get putMoneyInRedPacket => 'Colocar dinheiro no envelope vermelho';

  @override
  String get redPacketRefundNotice =>
      'Envelopes não resgatados serão reembolsados após 24 horas';

  @override
  String get openRedPacket => 'Abrir';

  @override
  String get redPacketAllClaimed => 'Todos os envelopes resgatados';

  @override
  String get redPacketExpired => 'Envelope vermelho expirado';

  @override
  String get addTransferNote => 'Adicionar nota de transferência';

  @override
  String get yuan => 'BRL';

  @override
  String get savedToChangeCanTransfer =>
      'Salvo no saldo, pode transferir diretamente';

  @override
  String get replyWithEmoji => 'Responder com este emoji';

  @override
  String get claimedYourRedPacket => 'resgatou seu';

  @override
  String get claimedRedPacket => 'resgatou';

  @override
  String get otherTyping => 'digitando...';

  @override
  String get processing => 'Processando...';

  @override
  String get transferCancelled => 'Transferência cancelada';

  @override
  String get transferFailed => 'Falha na transferência';

  @override
  String get creatingPaymentRequest => 'Criando solicitação de pagamento...';

  @override
  String get processingPayment => 'Processando pagamento...';

  @override
  String get paymentFailed => 'Falha no pagamento';

  @override
  String get clickRetry => 'Toque para tentar novamente';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get editRemark => 'Editar Observação';

  @override
  String get setPermissions => 'Definir Permissões';

  @override
  String get recommendToFriends => 'Recomendar para Amigos';

  @override
  String get setStarFriend => 'Definir como Amigo Favorito';

  @override
  String get addToBlacklist => 'Adicionar à Lista Negra';

  @override
  String get complain => 'Denunciar';

  @override
  String get deleteContact => 'Excluir Contato';

  @override
  String deleteContactConfirm(String name) {
    return 'Tem certeza que deseja excluir $name?';
  }

  @override
  String get transferTitle => 'Transferência';

  @override
  String get receiverAddressLabel => 'Endereço do Destinatário';

  @override
  String get selectTokenLabel => 'Selecionar Token';

  @override
  String get transferAmountLabel => 'Valor da Transferência';

  @override
  String get memoLabel => 'Observação (opcional)';

  @override
  String get enterOrPasteAddressHint => 'Digite ou cole o endereço da carteira';

  @override
  String get scanInDevelopment =>
      'Recurso de escaneamento em desenvolvimento...';

  @override
  String get availableLabel => 'Disponível';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Disponível: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Adicionar uma observação';

  @override
  String get receiveTitle => 'Receber';

  @override
  String get walletNotConnectedTitle => 'Carteira não conectada';

  @override
  String get connectWalletFirst => 'Por favor, conecte a carteira primeiro';

  @override
  String get sendPaymentRequest => 'Enviar Solicitação de Pagamento';

  @override
  String get qrCodeGenerateFailed => 'Falha na geração do QR code';

  @override
  String get scanQrToPayMe => 'Escaneie o QR code para me pagar';

  @override
  String get myWalletAddress => 'Meu Endereço de Carteira';

  @override
  String get createPaymentRequest => 'Criar Solicitação de Pagamento';

  @override
  String get selectTokenHint => 'Selecionar Token';

  @override
  String get amountLabel => 'Valor';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get sendRequestButton => 'Enviar Solicitação';

  @override
  String get allReadReceipt => 'Todas lidas';

  @override
  String readCountReceipt(int count) {
    return '$count lida(s)';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Felicidades';

  @override
  String senderRedPacket(String name) {
    return 'Envelope Vermelho de $name';
  }

  @override
  String get allButton => 'Todos';

  @override
  String get enterValidAddress => 'Por favor, digite um endereço válido';

  @override
  String get pleaseSelectToken => 'Por favor, selecione um token';

  @override
  String get receivedTransfer => 'Transferência Recebida';

  @override
  String get selectForwardRecipient => 'Selecionar destinatário';

  @override
  String get emojiFaces => 'Rostos';

  @override
  String get emojiHearts => 'Corações';

  @override
  String get emojiAnimals => 'Animais';

  @override
  String get emojiFood => 'Comida';

  @override
  String get emojiTransport => 'Transporte';

  @override
  String get emojiActivities => 'Atividades';

  @override
  String get emojiObjects => 'Objetos';

  @override
  String get emojiSymbols => 'Símbolos';

  @override
  String get transferProcessing => 'Processando transferência...';

  @override
  String senderSentRedPacket(String name) {
    return '$name enviou um envelope vermelho';
  }

  @override
  String get savedToBalance => 'Salvo no saldo, pode transferir diretamente';

  @override
  String get redPacketExpiredOrEmpty =>
      'Envelope vermelho expirado/todos resgatados';

  @override
  String get scanFeatureComingSoon => 'Recurso de escaneamento em breve...';

  @override
  String get setAsStarred => 'Definir como Favorito';

  @override
  String get addToBlocklist => 'Adicionar à Lista de Bloqueio';

  @override
  String get claimedYour => ' resgatou seu ';

  @override
  String get claimedText => ' resgatou ';

  @override
  String userTyping(String name) {
    return '$name está digitando...';
  }

  @override
  String get typing => 'Digitando...';

  @override
  String get waitingToReceive => 'Aguardando recebimento';

  @override
  String get tapToClaim => 'Toque para resgatar';

  @override
  String get hasBeenReceived => 'Foi recebido';

  @override
  String get getLucky => 'Boa sorte';

  @override
  String get cameraStartFailed => 'Falha ao iniciar câmera';

  @override
  String get unknownError => 'Erro desconhecido';

  @override
  String get placeQrCodeInFrame =>
      'Coloque o QR code dentro do quadro para escanear';

  @override
  String get closeManualInput => 'Fechar Entrada Manual';

  @override
  String get manualInputUserId => 'Inserir ID do Usuário Manualmente';

  @override
  String get add => 'Adicionar';

  @override
  String get ringtoneClear => 'Limpar';

  @override
  String get ringtonePhone => 'Telefone';

  @override
  String get ringtoneClassic => 'Clássico';

  @override
  String get ringtoneSoft => 'Suave';

  @override
  String get ringtoneVibrate => 'Vibrar';

  @override
  String get ringtoneSilent => 'Silencioso';

  @override
  String get stop => 'Parar';

  @override
  String get selectRingtone => 'Selecionar Toque';

  @override
  String get loadingRingtones => 'Carregando toques...';

  @override
  String get noRingtonesFound => 'Nenhum toque encontrado';

  @override
  String get moodAndThoughts => 'Humor e Pensamentos';

  @override
  String get statusHappy => 'Feliz';

  @override
  String get statusCracked => 'Arrasado';

  @override
  String get statusLucky => 'Com sorte';

  @override
  String get statusSunny => 'Ensolarado';

  @override
  String get statusTired => 'Cansado';

  @override
  String get statusDaydream => 'Sonhando acordado';

  @override
  String get statusRushing => 'Correndo';

  @override
  String get statusOverthinking => 'Pensando demais';

  @override
  String get statusEnergized => 'Energizado';

  @override
  String get workAndStudy => 'Trabalho e Estudo';

  @override
  String get statusWorking => 'Trabalhando';

  @override
  String get statusStudying => 'Estudando';

  @override
  String get statusBusy => 'Ocupado';

  @override
  String get statusSlacking => 'Relaxando';

  @override
  String get statusTraveling => 'Viajando';

  @override
  String get statusGoingHome => 'Indo para Casa';

  @override
  String get statusDnd => 'Não Perturbe';

  @override
  String get statusHanging => 'Saindo';

  @override
  String get statusCheckIn => 'Check-in';

  @override
  String get statusExercising => 'Exercitando';

  @override
  String get statusCoffee => 'Café';

  @override
  String get statusBubbleTea => 'Chá de Bolhas';

  @override
  String get statusEating => 'Comendo';

  @override
  String get statusParenting => 'Cuidando dos Filhos';

  @override
  String get statusSavingWorld => 'Salvando o Mundo';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Descanso';

  @override
  String get statusRetreat => 'Retiro';

  @override
  String get statusHome => 'Em Casa';

  @override
  String get statusSleeping => 'Dormindo';

  @override
  String get statusCatLover => 'Amante de Gatos';

  @override
  String get statusDogWalking => 'Passeando com Cachorro';

  @override
  String get statusGaming => 'Jogando';

  @override
  String get statusListening => 'Ouvindo';

  @override
  String get setStatus => 'Definir Status';

  @override
  String get visibleToFriends24h => 'Visível para amigos por 24 horas';

  @override
  String get writeStatus => 'Escrever Status';

  @override
  String get enterYourStatus => 'Digite seu status...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Permissão de câmera necessária para escanear QR code';

  @override
  String get cameraPermissionDenied =>
      'Permissão de câmera negada permanentemente. Por favor, ative nas configurações do sistema.';

  @override
  String get cannotGetCameraPermission =>
      'Não foi possível obter permissão da câmera';

  @override
  String permissionCheckError(String error) {
    return 'Erro ao verificar permissão: $error';
  }

  @override
  String get invalidQrCode => 'QR code inválido';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Falha ao processar QR code: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Não foi possível adicionar amigo: $error';
  }

  @override
  String get scanQrCode => 'Escanear QR Code';

  @override
  String get checkingCameraPermission => 'Verificando permissão da câmera...';

  @override
  String get needCameraPermission => 'Permissão de Câmera Necessária';

  @override
  String get retryPermission => 'Tentar Novamente';

  @override
  String get openSettings => 'Abrir Configurações';

  @override
  String get inviteMembers => 'Convidar Membros';

  @override
  String inviteCount(int count) {
    return 'Convidar($count)';
  }

  @override
  String get noShippingAddress => 'Nenhum endereço de entrega';

  @override
  String get defaultLabel => 'Padrão';

  @override
  String get editAddress => 'Editar Endereço';

  @override
  String get recipient => 'Destinatário';

  @override
  String get enterRecipientName => 'Digite o nome do destinatário';

  @override
  String get phoneNumber => 'Número de Telefone';

  @override
  String get enterPhoneNumber => 'Digite o número de telefone';

  @override
  String get regionHint => 'Estado/Cidade/Bairro';

  @override
  String get detailedAddress => 'Endereço Detalhado';

  @override
  String get detailedAddressHint => 'Rua, número, etc.';

  @override
  String get setAsDefaultAddress => 'Definir como endereço padrão';

  @override
  String get pleaseCompleteInfo => 'Por favor, preencha todos os campos';

  @override
  String get noInvoice => 'Nenhuma fatura';

  @override
  String get company => 'Empresa';

  @override
  String get taxNumber => 'CNPJ';

  @override
  String get editInvoice => 'Editar Fatura';

  @override
  String get companyName => 'Nome da Empresa';

  @override
  String get enterCompanyName => 'Digite o nome da empresa';

  @override
  String get personalName => 'Nome Pessoal';

  @override
  String get enterName => 'Digite o nome';

  @override
  String get taxIdNumber => 'CNPJ/CPF';

  @override
  String get enterTaxIdNumber => 'Digite o CNPJ/CPF';

  @override
  String get bankNameOptional => 'Nome do Banco (Opcional)';

  @override
  String get enterBankName => 'Digite o nome do banco';

  @override
  String get bankAccountOptional => 'Conta Bancária (Opcional)';

  @override
  String get enterBankAccount => 'Digite a conta bancária';

  @override
  String get companyAddressOptional => 'Endereço da Empresa (Opcional)';

  @override
  String get enterCompanyAddress => 'Digite o endereço da empresa';

  @override
  String get companyPhoneOptional => 'Telefone da Empresa (Opcional)';

  @override
  String get enterCompanyPhone => 'Digite o telefone da empresa';

  @override
  String get setAsDefaultInvoice => 'Definir como fatura padrão';

  @override
  String get confirmDeleteAddress =>
      'Tem certeza que deseja excluir este endereço?';

  @override
  String get confirmDeleteInvoice =>
      'Tem certeza que deseja excluir esta fatura?';

  @override
  String get groupOwner => 'Dono';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Pesquisar membros';

  @override
  String totalMembers(int count) {
    return '$count membros';
  }

  @override
  String get removeFromGroup => 'Remover do Grupo';

  @override
  String confirmRemoveMember(String name) {
    return 'Tem certeza que deseja remover \"$name\" do grupo?';
  }

  @override
  String get setAsAdmin => 'Definir como Admin';

  @override
  String get removeAdmin => 'Remover Admin';

  @override
  String get deleteContactSuccess => 'Contato excluído';

  @override
  String get unknownSong => 'Música Desconhecida';

  @override
  String get unknownArtist => 'Artista Desconhecido';

  @override
  String get unknownContact => 'Contato Desconhecido';

  @override
  String get personalCard => 'Cartão de Contato';

  @override
  String get singleChoice => 'Única';

  @override
  String get multiChoice => 'Múltipla';

  @override
  String get ended => 'Encerrada';

  @override
  String get endPollButton => 'Encerrar Enquete';

  @override
  String get createPoll => 'Criar Enquete';

  @override
  String get pollQuestion => 'Pergunta da Enquete';

  @override
  String get pollOptions => 'Opções da Enquete';

  @override
  String optionPlaceholder(int index) {
    return 'Opção $index';
  }

  @override
  String get addOption => 'Adicionar Opção';

  @override
  String get pollSettings => 'Configurações da Enquete';

  @override
  String get anonymousPoll => 'Enquete Anônima';

  @override
  String get pollHint =>
      'A enquete será exibida no chat. Membros do grupo podem votar.';

  @override
  String get searchSongOrArtist => 'Pesquisar música ou artista';

  @override
  String get noSongsFound => 'Nenhuma música encontrada';

  @override
  String get supportedMusicPlatforms =>
      'Suporta links de música do Spotify, Deezer, etc.';

  @override
  String get songNameOptional => 'Nome da Música (Opcional)';

  @override
  String get enterSongName => 'Digite o nome da música';

  @override
  String get artistNameOptional => 'Nome do Artista (Opcional)';

  @override
  String get enterArtistName => 'Digite o nome do artista';

  @override
  String get shareSong => 'Compartilhar Música';

  @override
  String get realTimeLocationSharing =>
      'Compartilhamento de localização em tempo real em desenvolvimento...';

  @override
  String get voiceCallFeatureInDev =>
      'Recurso de chamada de voz em desenvolvimento...';

  @override
  String get reportFeatureInDev => 'Recurso de denúncia em desenvolvimento...';

  @override
  String get shareFeatureInDev =>
      'Recurso de compartilhamento em desenvolvimento...';

  @override
  String get qrCodeFeatureInDev => 'Recurso de QR code em desenvolvimento...';

  @override
  String get scanQrToAddMe =>
      'Escaneie o QR code acima para me adicionar como amigo';

  @override
  String get saveToAlbum => 'Salvar no Álbum';

  @override
  String get changeStyle => 'Alterar Estilo';

  @override
  String get copyId => 'Copiar ID';

  @override
  String get idCopied => 'ID copiado';

  @override
  String get shareFeatureComingSoon => 'Recurso de compartilhamento em breve';

  @override
  String get saveFeatureComingSoon => 'Recurso de salvar em breve';

  @override
  String get moreStylesFeatureComingSoon => 'Mais estilos em breve';

  @override
  String get confirmEndPoll => 'Tem certeza que deseja encerrar esta enquete?';

  @override
  String get cannotVoteAfterEnd =>
      'Nenhum voto poderá ser feito após o encerramento.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Servidor';

  @override
  String get shareContactCard => 'Compartilhar Cartão de Contato';

  @override
  String get removeFromBlacklist => 'Remover da Lista Negra';

  @override
  String get confirmAddBlacklist =>
      'Tem certeza que deseja adicionar este usuário à lista negra? Você não receberá mensagens dele.';

  @override
  String get confirmRemoveBlacklist =>
      'Tem certeza que deseja remover este usuário da lista negra?';

  @override
  String get remarkSaved => 'Observação salva';

  @override
  String get remarkCleared => 'Observação limpa';

  @override
  String get receive => 'Receber';

  @override
  String get pleaseConnectWallet => 'Por favor, conecte sua carteira primeiro';

  @override
  String get sendRequest => 'Enviar Solicitação';

  @override
  String get pleaseEnterValidAmount => 'Por favor, digite um valor válido';

  @override
  String get searchPlaceholder => 'Pesquisar contatos, grupos, mensagens';

  @override
  String get enterKeywordToSearch => 'Digite palavras-chave para pesquisar';

  @override
  String get clearHistory => 'Limpar';

  @override
  String noResultsForQuery(String query) {
    return 'Nenhum resultado encontrado para \"$query\"';
  }

  @override
  String get allResults => 'Todos';

  @override
  String get searchInChat => 'Pesquisar no chat';

  @override
  String get contactLabel => 'Contato';

  @override
  String get groupLabel => 'Grupo';

  @override
  String get conversationLabel => '会话';

  @override
  String get messageLabel => 'Mensagem';

  @override
  String get securityTitle => 'Segurança';

  @override
  String get keyBackup => 'Backup de Chaves';

  @override
  String get backupEncryptionKeys => 'Fazer Backup das Chaves de Criptografia';

  @override
  String keysBackedUp(int count) {
    return '$count chaves com backup';
  }

  @override
  String get backupNotSet => 'Backup não configurado';

  @override
  String get restoreKeys => 'Restaurar Chaves';

  @override
  String get restoreKeysFromBackup =>
      'Restaurar chaves de criptografia do backup';

  @override
  String get exportKeys => 'Exportar Chaves';

  @override
  String get exportKeysToFile => 'Exportar chaves para arquivo';

  @override
  String get loggedInDevices => 'Dispositivos Conectados';

  @override
  String get noOtherDevices => 'Nenhum outro dispositivo';

  @override
  String get verified => 'Verificado';

  @override
  String get unverified => 'Não verificado';

  @override
  String get advanced => 'Avançado';

  @override
  String get crossSigning => 'Assinatura Cruzada';

  @override
  String get enabled => 'Ativado';

  @override
  String get notEnabled => 'Não ativado';

  @override
  String get resetEncryption => 'Redefinir Criptografia';

  @override
  String get deleteAllEncryptionKeys =>
      'Excluir todas as chaves de criptografia';

  @override
  String get encryptionNotSupported => 'Criptografia não suportada';

  @override
  String get notInitialized => 'Não inicializado';

  @override
  String get backupKeyTitle => 'Fazer Backup das Chaves';

  @override
  String get backupKeyMessage =>
      'Criar um novo backup de chaves? Isso ajudará você a restaurar mensagens criptografadas em um novo dispositivo.';

  @override
  String get backup => 'Backup';

  @override
  String get restoreKeyTitle => 'Restaurar Chaves';

  @override
  String get restoreKeyMessage =>
      'Digite sua senha de recuperação ou chave de recuperação para restaurar mensagens criptografadas.';

  @override
  String get restore => 'Restaurar';

  @override
  String get exportKeyTitle => 'Exportar Chaves';

  @override
  String get exportKeyMessage =>
      'O arquivo de chaves exportado contém todas as suas chaves de criptografia. Por favor, guarde-o em segurança.';

  @override
  String get export => 'Exportar';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID do Dispositivo: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Status: Verificado';

  @override
  String get deviceStatusUnverified => 'Status: Não verificado';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Última atividade: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Verificar este dispositivo';

  @override
  String get crossSigningAlreadyEnabled => 'Assinatura cruzada já está ativada';

  @override
  String get crossSigningSetupSuccess =>
      'Assinatura cruzada configurada com sucesso';

  @override
  String get resetEncryptionTitle => 'Redefinir Criptografia';

  @override
  String get resetEncryptionWarning =>
      'Aviso: Isso excluirá todas as suas chaves de criptografia. Você não poderá descriptografar mensagens criptografadas anteriores. Esta ação não pode ser desfeita.';

  @override
  String get reset => 'Redefinir';

  @override
  String get leaveMeetingConfirm => 'Tem certeza que deseja sair da reunião?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'cutucou $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Nenhum contato disponível para adicionar';

  @override
  String get addMembers => 'Adicionar Membros';

  @override
  String invitedMembers(int count) {
    return '$count membros convidados';
  }

  @override
  String inviteFailed(String error) {
    return 'Falha ao convidar: $error';
  }

  @override
  String get memberRemoved => 'Membro removido';

  @override
  String removeFailed(String error) {
    return 'Falha ao remover: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Após compartilhar, a outra pessoa poderá ver sua localização em tempo real por 1 hora.';

  @override
  String get startSharing => 'Iniciar Compartilhamento';

  @override
  String get locationServiceNotEnabled =>
      'Serviço de localização não está ativado';

  @override
  String get enableLocationService =>
      'Por favor, ative o serviço de localização para usar este recurso';

  @override
  String get goToSettings => 'Ir para Configurações';

  @override
  String get locationPermissionRequired =>
      'Permissão de localização é necessária para este recurso';

  @override
  String get locationPermissionDeniedPermanent =>
      'Permissão de localização foi negada permanentemente. Por favor, ative nas configurações.';

  @override
  String get locationPermissionDenied => 'Permissão de localização negada';

  @override
  String get gettingLocation => 'Obtendo localização...';

  @override
  String getLocationFailed(String error) {
    return 'Falha ao obter localização: $error';
  }

  @override
  String get currentLocation => 'Localização Atual';

  @override
  String nearbyPlace(int index) {
    return 'Local Próximo $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Aproximadamente $distance';
  }

  @override
  String get mapPreview => 'Prévia do Mapa';

  @override
  String get searchLocation => 'Pesquisar localização';

  @override
  String redPacketSent(String amount, String token) {
    return 'Enviou envelope vermelho de $amount $token';
  }

  @override
  String get transferDefault => 'Transferência';

  @override
  String transferSent(String amount, String token) {
    return 'Enviou transferência de $amount $token';
  }

  @override
  String pickFileFailed(String error) {
    return 'Falha ao selecionar arquivo: $error';
  }

  @override
  String get fileSizeLimit => 'O tamanho do arquivo não pode exceder 50MB';

  @override
  String fileSending(String filename) {
    return 'Enviando arquivo: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Falha ao enviar arquivo: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Enviou cartão de contato de $name';
  }

  @override
  String get favoritesFeature => 'Favoritos';

  @override
  String get couponsFeature => 'Cupons';

  @override
  String get giftFeature => 'Presente';

  @override
  String sharedMusic(String name) {
    return 'Compartilhou $name';
  }

  @override
  String get endPollTitle => 'Encerrar Enquete';

  @override
  String get endPollConfirmMessage =>
      'Tem certeza que deseja encerrar esta enquete? A votação será fechada após o encerramento.';

  @override
  String get pollEndedMessage => 'Enquete encerrada';

  @override
  String get connectingCall => 'Conectando...';

  @override
  String get muteCall => 'Silenciar';

  @override
  String get speakerOff => 'Alto-falante Desligado';

  @override
  String get speakerOn => 'Alto-falante';

  @override
  String get cameraOn => 'Câmera Ligada';

  @override
  String get cameraOff => 'Câmera Desligada';

  @override
  String get hangUp => 'Encerrar';

  @override
  String get selectForwardTargetTitle => 'Selecionar Destino';

  @override
  String get noForwardableChat => 'Nenhum chat disponível para encaminhar';

  @override
  String get noMatchingChat => 'Nenhum chat correspondente encontrado';

  @override
  String get imagePreview => '[Imagem]';

  @override
  String get voicePreview => '[Áudio]';

  @override
  String get videoPreview => '[Vídeo]';

  @override
  String filePreviewWithName(String filename) {
    return '[Arquivo] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Localização] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Música] $title';
  }

  @override
  String get messagePreview => '[Mensagem]';

  @override
  String get locationTitle => 'Localização';

  @override
  String get sendButton => 'Enviar';

  @override
  String get retryButton => 'Tentar Novamente';

  @override
  String get selectContact => 'Selecionar Contato';

  @override
  String get searchContactHint => 'Pesquisar contatos';

  @override
  String get shareMusic => 'Compartilhar Música';

  @override
  String get recentPlayed => 'Recentes';

  @override
  String get myFavorites => 'Favoritos';

  @override
  String get networkLink => 'Link';

  @override
  String get localFile => 'Local';

  @override
  String get musicLinkRequired => 'Link da Música *';

  @override
  String get pasteMusicLink => 'Cole o link da música';

  @override
  String get enterSongNamePlaceholder => 'Digite o nome da música';

  @override
  String get enterArtistNamePlaceholder => 'Digite o nome do artista';

  @override
  String get shareMusicButton => 'Compartilhar Música';

  @override
  String get selectLocalAudio => 'Selecionar Arquivo de Áudio Local';

  @override
  String get supportedAudioFormats => 'Suporta MP3, M4A, WAV, FLAC, etc.';

  @override
  String get selectFileButton => 'Selecionar Arquivo';

  @override
  String get pleaseEnterMusicLink => 'Por favor, digite o link da música';

  @override
  String get pleaseEnterValidLink => 'Por favor, digite uma URL válida';

  @override
  String get sharedSong => 'Música Compartilhada';

  @override
  String get selectMember => 'Selecionar Membro';

  @override
  String get searchMemberHint => 'Pesquisar membros';

  @override
  String get noMatchingMembers => 'Nenhum membro correspondente encontrado';

  @override
  String get unknownMember => 'Desconhecido';

  @override
  String selectedMessagesCount(int count) {
    return '$count mensagens selecionadas';
  }

  @override
  String get searchContactsOrGroups => 'Pesquisar contatos ou grupos';

  @override
  String get noMatchingConversations =>
      'Nenhuma conversa correspondente encontrada';

  @override
  String get videoTitle => 'Vídeo';

  @override
  String get loadingText => 'Carregando...';

  @override
  String get videoPlaybackFailed => 'Falha na reprodução do vídeo';

  @override
  String get videoLoadFailed => 'Falha ao carregar vídeo';

  @override
  String get playerInitFailed => 'Falha na inicialização do player';

  @override
  String get createPollTitle => 'Criar Enquete';

  @override
  String get submitPoll => 'Enviar';

  @override
  String get pollQuestionLabel => 'Pergunta da Enquete';

  @override
  String get enterPollQuestionHint => 'Por favor, digite a pergunta da enquete';

  @override
  String get pollOptionsLabel => 'Opções da Enquete';

  @override
  String optionHintWithIndex(int index) {
    return 'Opção $index';
  }

  @override
  String get addOptionButton => 'Adicionar Opção';

  @override
  String get pollSettingsLabel => 'Configurações da Enquete';

  @override
  String get selectionType => 'Tipo de Seleção';

  @override
  String get singleChoiceLabel => 'Única';

  @override
  String get multiChoiceLabel => 'Múltipla';

  @override
  String get anonymousPollSwitch => 'Enquete Anônima';

  @override
  String get pleaseEnterQuestion => 'Por favor, digite a pergunta da enquete';

  @override
  String get atLeastTwoOptions => 'São necessárias pelo menos 2 opções';

  @override
  String confirmWithCount(int count) {
    return 'Confirmar ($count)';
  }

  @override
  String get emailVerificationTitle => 'Verificação por E-mail';

  @override
  String get enterValidEmailAddress =>
      'Por favor, digite um endereço de e-mail válido';

  @override
  String verificationCodeSentTo(String email) {
    return 'Código de verificação enviado para $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Falha ao enviar código: $error';
  }

  @override
  String get verificationSuccess => 'Verificação bem-sucedida';

  @override
  String get verificationFailed => 'Falha na verificação';

  @override
  String verificationCodeError(String error) {
    return 'Erro no código de verificação: $error';
  }

  @override
  String get enterVerificationCode => 'Digite o código de verificação';

  @override
  String get enterYourEmail => 'Digite o e-mail';

  @override
  String weSentCodeTo(String email) {
    return 'Enviamos um código de 6 dígitos para\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Digite seu endereço de e-mail, enviaremos o código de verificação';

  @override
  String get sendVerificationCode => 'Enviar código de verificação';

  @override
  String get resendVerificationCode => 'Reenviar código de verificação';

  @override
  String canResendAfter(int seconds) {
    return 'Pode reenviar após $seconds segundos';
  }

  @override
  String get changeEmail => 'Alterar e-mail';

  @override
  String get addToContacts => 'Adicionar aos Contatos';

  @override
  String get addingToContacts => 'Adicionando...';

  @override
  String get addedToContacts => 'Adicionado aos contatos';

  @override
  String addFailedWithError(String error) {
    return 'Falha ao adicionar: $error';
  }

  @override
  String get addPhone => 'Adicionar telefone';

  @override
  String get addTag => 'Adicionar tags';

  @override
  String get addText => 'Adicionar texto';

  @override
  String get addPhoto => 'Adicionar foto';

  @override
  String groupCountLabel(int count) {
    return '$count grupos';
  }

  @override
  String get addedViaSearch => 'Adicionado via pesquisa';

  @override
  String get addTime => 'Adicionar horário';

  @override
  String get doneButton => 'Concluído';

  @override
  String get waitingForParticipants => 'Aguardando participantes...';

  @override
  String participantMe(String name) {
    return '$name (Eu)';
  }

  @override
  String get sharingLabel => 'Compartilhando';

  @override
  String screenSharingBy(String name) {
    return '$name está compartilhando a tela';
  }

  @override
  String participantCount(int count) {
    return '$count participantes';
  }

  @override
  String get muteLabel => 'Silenciar';

  @override
  String get unmuteLabel => 'Ativar Som';

  @override
  String get turnOffVideo => 'Desligar vídeo';

  @override
  String get turnOnVideo => 'Ligar vídeo';

  @override
  String get shareScreen => 'Compartilhar tela';

  @override
  String get stopSharing => 'Parar compartilhamento';

  @override
  String get switchCameraLabel => 'Alternar';

  @override
  String get leaveLabel => 'Sair';

  @override
  String get participantsLabel => 'Participantes';

  @override
  String get joiningMeeting => 'Entrando na reunião...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count votos ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count participantes';
  }

  @override
  String get tapToRetry => 'Toque para tentar novamente';

  @override
  String get noConversationsToForward => 'Nenhuma conversa para encaminhar';

  @override
  String get defaultRedPacketGreeting => 'Desejo-lhe prosperidade e boa sorte';

  @override
  String get emojiCategoryFace => 'Emoticons';

  @override
  String get emojiCategoryHeart => 'Corações';

  @override
  String get emojiCategoryAnimal => 'Animais';

  @override
  String get emojiCategoryFood => 'Comida';

  @override
  String get emojiCategoryTransport => 'Transportes';

  @override
  String get emojiCategoryActivity => 'Atividades';

  @override
  String get emojiCategoryObject => 'Objetos';

  @override
  String get emojiCategorySymbol => 'Símbolos';

  @override
  String get allowOthersToSearchAndJoin =>
      'Permitir que outros pesquisem e se juntem';

  @override
  String get allowStrangerMessages => 'Permitir mensagens de estranhos';

  @override
  String get alwaysUseDarkTheme => 'Sempre usar tema escuro';

  @override
  String get alwaysUseLightTheme => 'Sempre usar tema claro';

  @override
  String get autoSwitchBySystem =>
      'Alternar automaticamente conforme configurações do sistema';

  @override
  String get bubbleStyle => 'Estilo do balão';

  @override
  String get bubbleStyleClassic => 'Estilo clássico';

  @override
  String get bubbleStyleClassicDesc => 'Estilo de balão tradicional';

  @override
  String get bubbleStyleModern => 'Estilo moderno';

  @override
  String get bubbleStyleModernDesc => 'Estilo de balão moderno e limpo';

  @override
  String get bubbleStyleWechat => 'Estilo WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Estilo de balão clássico do WeChat';

  @override
  String get callEnded => 'Chamada encerrada';

  @override
  String get callFailed => 'Chamada falhou';

  @override
  String get checkForUpdates => 'Verificar atualizações';

  @override
  String get confirmClearChatHistory =>
      'Tem certeza de que deseja limpar o histórico de chat?';

  @override
  String get createGroupToChat => 'Crie um grupo para começar a conversar';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get darkModeOption => 'Modo escuro';

  @override
  String get doNotDisturbDescription =>
      'Não receber notificações durante o período especificado';

  @override
  String get doNotDisturbMode => 'Não perturbe';

  @override
  String get editGroupAnnouncement => 'Editar anúncio do grupo';

  @override
  String get editGroupDescription => 'Editar descrição do grupo';

  @override
  String get enterGroupAnnouncement => 'Digite o anúncio do grupo';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Feedback e sugestões';

  @override
  String get followSystem => 'Seguir sistema';

  @override
  String get fontSize => 'Tamanho da fonte';

  @override
  String get fontSizeExtraLarge => 'Extra grande';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeSmall => 'Pequeno';

  @override
  String get fontSizeStandard => 'Padrão';

  @override
  String get incomingVideoCall => 'Chamada de vídeo recebida';

  @override
  String get incomingVoiceCall => 'Chamada de voz recebida';

  @override
  String get letOthersKnowYouRead =>
      'Permitir que outros saibam que você leu suas mensagens';

  @override
  String get letOthersKnowYouTyping =>
      'Permitir que outros saibam que você está digitando';

  @override
  String get lightMode => 'Modo claro';

  @override
  String memberCountClickToCopy(int count) {
    return '$count membros, clique para copiar ID do grupo';
  }

  @override
  String get messageNotifications => 'Notificações de mensagens';

  @override
  String get messagesLabel => 'Mensagens';

  @override
  String get musicLinkLabel => 'Link de música';

  @override
  String get noMediaUrlAvailable => 'URL de mídia não disponível';

  @override
  String get noPermissionToEditGroupName =>
      'Você não tem permissão para editar o nome do grupo';

  @override
  String get receiveMessagesFromNonContacts =>
      'Receber mensagens de não-contatos';

  @override
  String get receiveNewMessageNotifications =>
      'Receber notificações de novas mensagens';

  @override
  String get reconnectingCall => 'Reconectando...';

  @override
  String get redPacketTransferCannotForward =>
      'Envelopes vermelhos e transferências não podem ser encaminhados';

  @override
  String get showMessageContentInNotification =>
      'Mostrar conteúdo da mensagem nas notificações';

  @override
  String get showMessagePreview => 'Mostrar prévia da mensagem';

  @override
  String get typingIndicator => 'Indicador de digitação';

  @override
  String versionInfo(String version) {
    return 'Versão $version';
  }

  @override
  String get vibration => 'Vibração';

  @override
  String get videoCallInProgress => 'Chamada de vídeo';

  @override
  String get voiceCallInProgress => 'Chamada de voz';

  @override
  String whoCanSeeTitle(String title) {
    return 'Quem pode ver $title';
  }
}
