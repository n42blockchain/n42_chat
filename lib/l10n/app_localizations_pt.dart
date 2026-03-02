// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class SPt extends S {
  SPt([String locale = 'pt']) : super(locale);

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonUnknownUser => 'Usuário desconhecido';

  @override
  String get transferWalletNotConnected => 'Carteira não conectada';

  @override
  String get chatCallServiceNotInitialized =>
      'Serviço de chamada não inicializado';

  @override
  String authLoginFailed(String error) {
    return 'Falha no login: $error';
  }

  @override
  String get chatCallBack => 'Retornar chamada';

  @override
  String get chatMissedVideoCall => 'Videochamada perdida';

  @override
  String get chatMissedVoiceCall => 'Chamada de voz perdida';

  @override
  String get chatCallNotAnswered => 'Não atendida';

  @override
  String get chatCallDurationLabel => 'Duração da chamada';

  @override
  String get chatVoiceCallCancelled => 'Chamada de voz cancelada';

  @override
  String get chatVideoCallCancelled => 'Videochamada cancelada';

  @override
  String get commonImage => '[Imagem]';

  @override
  String get chatVideo => '[Vídeo]';

  @override
  String get chatVoice => '[Áudio]';

  @override
  String get commonFile => '[Arquivo]';

  @override
  String get chatLocation => '[Localização]';

  @override
  String get chatUnknownMessage => '[Mensagem desconhecida]';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get chatDeleteThisMessage => 'Excluir esta mensagem?';

  @override
  String get chatMessageDeleted => 'Mensagem excluída';

  @override
  String get profileNotLoggedIn => 'Não conectado';

  @override
  String get chatMyLocation => 'Minha localização';

  @override
  String get commonGroupChat => 'Chat em Grupo';

  @override
  String get commonSearch => 'Pesquisar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonLoadFailed => 'Falha ao carregar';

  @override
  String get commonMessages => 'Mensagens';

  @override
  String get commonContacts => 'Contatos';

  @override
  String get commonMe => 'Eu';

  @override
  String get commonVoiceLoading =>
      'Carregando áudio, tente novamente mais tarde';

  @override
  String get commonVoiceToTextFailed => 'Falha na conversão de voz para texto';

  @override
  String get commonConvertToText => 'Para texto';

  @override
  String get chatCopy => 'Copiar';

  @override
  String get commonForward => 'Encaminhar';

  @override
  String get commonUnfavorite => 'Remover favorito';

  @override
  String get commonFavorite => 'Favoritar';

  @override
  String get settingsResend => 'Reenviar';

  @override
  String get chatRecall => 'Desfazer envio';

  @override
  String get commonQuote => 'Citar';

  @override
  String get commonRemind => 'Lembrar';

  @override
  String get chatCopied => 'Copiado';

  @override
  String get storySendMessageHint => 'Enviar uma mensagem';

  @override
  String get commonMicrophonePermissionRequired =>
      'Por favor, permita o acesso ao microfone';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Falha ao iniciar gravação: $error';
  }

  @override
  String get commonRecordingTooShort => 'Gravação muito curta';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Falha ao parar gravação: $error';
  }

  @override
  String get chatReleaseToCancel => 'Solte para cancelar';

  @override
  String get chatReleaseToSend =>
      'Solte para enviar, deslize para cima para cancelar';

  @override
  String get commonHoldToTalk => 'Segure para falar';

  @override
  String get commonSend => 'Enviar';

  @override
  String get commonAddFriend => 'Adicionar Amigo';

  @override
  String get commonChatServiceNotConnected => 'Serviço de chat não conectado';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Usuário \"$query\" não encontrado\n\nDicas:\n• Tente inserir o ID completo do usuário, ex: @usuario:servidor.com\n• Verifique a ortografia do nome de usuário';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Falha ao criar chat: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Falha na pesquisa: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Digite o ID ou nome de usuário para pesquisar';

  @override
  String get contactSearching => 'Pesquisando...';

  @override
  String get contactSearchUserToChat =>
      'Pesquise um usuário para iniciar uma conversa';

  @override
  String get contactMatrixIdExample =>
      'Você pode inserir um ID Matrix completo\nex: @usuario:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Usuário \"$username\" não encontrado';
  }

  @override
  String get commonChat => 'Chat';

  @override
  String get commonSettings => 'Configurações';

  @override
  String get profileEditProfile => 'Editar Perfil';

  @override
  String get authLogin => 'Entrar';

  @override
  String get commonCreateGroup => 'Criar Grupo';

  @override
  String get chatError => 'Erro';

  @override
  String get commonTransfer => 'Transferir';

  @override
  String get commonReceived => 'Recebido';

  @override
  String get commonRefunded => 'Reembolsado';

  @override
  String get commonExpired => 'Expirado';

  @override
  String get chatRedPacketGreeting => 'Felicidades';

  @override
  String get commonN42RedPacket => 'Envelope Vermelho N42';

  @override
  String get commonClaimed => 'Resgatado';

  @override
  String get commonAllClaimed => 'Todos resgatados';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Responder';

  @override
  String get commonEdit => 'Editar';

  @override
  String get chatSelectForwardTarget => 'Selecionar destinatário';

  @override
  String commonSendCount(int count) {
    return 'Enviar ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Info do Amigo';

  @override
  String get contactFriendInfoDesc =>
      'Adicione observação, telefone, tags, notas, fotos e defina permissões.';

  @override
  String get commonMoments => 'Momentos';

  @override
  String get commonSendMessage => 'Mensagem';

  @override
  String get contactAudioVideoCall => 'Chamada de Áudio/Vídeo';

  @override
  String get contactVideoChannel => 'Canal de Vídeo';

  @override
  String get contactRemark => 'Observação';

  @override
  String get contactRemarkName => 'Nome de Observação';

  @override
  String get contactPhone => 'Telefone';

  @override
  String get contactTags => 'Tags';

  @override
  String get contactNotes => 'Notas';

  @override
  String get contactPhotos => 'Fotos';

  @override
  String get contactPermissions => 'Permissões';

  @override
  String get contactChatMomentsEtc => 'Chat, Momentos, Esportes, etc.';

  @override
  String get contactMoreInfo => 'Mais Informações';

  @override
  String get contactCommonGroups => 'Grupos em comum';

  @override
  String get contactSource => 'Origem';

  @override
  String get settingsNotificationSettings => 'Notificações';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get commonLogout => 'Sair';

  @override
  String get commonLogoutConfirm => 'Tem certeza que deseja sair?';

  @override
  String get commonSave => 'Salvar';

  @override
  String get profileNickname => 'Apelido';

  @override
  String get profileEnterNickname => 'Digite o apelido';

  @override
  String get profileSignature => 'Assinatura';

  @override
  String get profileAddSignature => 'Adicionar uma assinatura';

  @override
  String get commonTakePhoto => 'Tirar Foto';

  @override
  String get profileChooseFromGallery => 'Escolher da Galeria';

  @override
  String profileSaveFailed(String error) {
    return 'Falha ao salvar: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Mensagens seguras e descentralizadas';

  @override
  String get commonEndToEndEncryption => 'Criptografia de ponta a ponta';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Mensagens visíveis apenas para você e o destinatário';

  @override
  String get authDecentralized => 'Descentralizado';

  @override
  String get authBasedOnMatrix => 'Construído no protocolo aberto Matrix';

  @override
  String get authWalletIntegration => 'Integração com Carteira';

  @override
  String get authEasyCryptoTransfer => 'Transferências de criptomoedas fáceis';

  @override
  String get authRegister => 'Cadastrar';

  @override
  String get authAgreeTerms => 'Ao entrar, você concorda com';

  @override
  String get authTermsOfService => 'Termos de Serviço';

  @override
  String get authAnd => 'e';

  @override
  String get authPrivacyPolicy => 'Política de Privacidade';

  @override
  String get authServerAddress => 'Endereço do Servidor';

  @override
  String get authEnterServerAddress => 'Digite o endereço do servidor';

  @override
  String authConnectedTo(String serverName) {
    return 'Conectado a $serverName';
  }

  @override
  String get authUsername => 'Nome de usuário';

  @override
  String get authEnterUsername => 'Digite o nome de usuário';

  @override
  String get authUsernameOrEmail => 'Usuário ou Email';

  @override
  String get authEnterUsernameOrEmail => 'Digite usuário ou email';

  @override
  String get authPassword => 'Senha';

  @override
  String get authEnterPassword => 'Digite a senha';

  @override
  String get authRegisterAccount => 'Cadastrar';

  @override
  String get authForgotPassword => 'Esqueci a Senha';

  @override
  String get authOtherLoginMethods => 'Outros métodos de login';

  @override
  String get authCreateAccount => 'Criar Conta';

  @override
  String get authJoinN42Chat => 'Junte-se ao N42 Chat para começar a conversar';

  @override
  String get authUsernameHint => '3-20 caracteres, letras/números/_';

  @override
  String get authUsernameMinLength =>
      'Nome de usuário deve ter pelo menos 3 caracteres';

  @override
  String get authUsernameMaxLength =>
      'Nome de usuário deve ter no máximo 20 caracteres';

  @override
  String get authUsernameFormat =>
      'Nome de usuário só pode conter letras, números e underscores';

  @override
  String get authPasswordHint => 'Mínimo 8 caracteres';

  @override
  String get commonPasswordMinLength =>
      'Senha deve ter pelo menos 8 caracteres';

  @override
  String get authConfirmPassword => 'Confirmar Senha';

  @override
  String get authFilled => 'Preenchido';

  @override
  String get authEnterInviteCode => 'Digite o código de convite';

  @override
  String get authAlreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get authLoginNow => 'Entrar agora';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Status';

  @override
  String get commonLoading => 'Carregando...';

  @override
  String get conversationNoConversations => 'Nenhuma conversa';

  @override
  String get conversationTapToChat =>
      'Toque no canto superior direito para iniciar uma conversa';

  @override
  String get conversationStartGroup => 'Iniciar Chat em Grupo';

  @override
  String get commonScan => 'Escanear';

  @override
  String get commonPayment => 'Pagamento';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature em breve';
  }

  @override
  String get conversationMarkAsRead => 'Marcar como lida';

  @override
  String get commonUnmute => 'Ativar som';

  @override
  String get commonMute => 'Silenciar';

  @override
  String get conversationUnpin => 'Desafixar';

  @override
  String get conversationPin => 'Fixar';

  @override
  String get conversationDeleteConversation => 'Excluir Conversa';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Excluir conversa com \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Nenhum contato';

  @override
  String get contactAddFriendsToChat =>
      'Adicione amigos para começar a conversar';

  @override
  String get contactNotFound => 'Contato não encontrado';

  @override
  String get contactTryOtherKeywords =>
      'Tente outras palavras-chave ou pesquisa global';

  @override
  String get contactSearchResults => 'Resultados da pesquisa';

  @override
  String get contactNewFriends => 'Novos Amigos';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Contas Oficiais';

  @override
  String get contactServiceAccounts => 'Contas de Serviço';

  @override
  String get contactEnterpriseContacts => 'Contatos Empresariais';

  @override
  String get contactRecommendToFriend => 'Compartilhar contato';

  @override
  String get commonSetRemark => 'Definir observação';

  @override
  String get contactSendingCard => 'Enviando cartão de contato...';

  @override
  String get commonFileLabel => 'Arquivo';

  @override
  String get commonLocationLabel => 'Localização';

  @override
  String contactRecommendFailed(String error) {
    return 'Falha na recomendação: $error';
  }

  @override
  String get profileEnterRemark => 'Digite a observação';

  @override
  String get contactOpeningChat => 'Abrindo chat...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Falha ao abrir chat: $error';
  }

  @override
  String get contactAddContact => 'Adicionar Contato';

  @override
  String get contactEnterUserId => 'Digite o ID do usuário';

  @override
  String get contactNoFriendRequests => 'Nenhuma solicitação de amizade';

  @override
  String get commonAccept => 'Aceitar';

  @override
  String get commonReject => 'Recusar';

  @override
  String get commonNoGroups => 'Nenhum grupo';

  @override
  String get contactSelectFriendToRecommend =>
      'Selecione um amigo para recomendar';

  @override
  String get commonSearchContacts => 'Pesquisar contatos';

  @override
  String get contactNoContactsFound => 'Nenhum contato encontrado';

  @override
  String get favoriteYesterday => 'Ontem';

  @override
  String get chatJustNow => 'Agora mesmo';

  @override
  String get profileOnline => 'Online';

  @override
  String get profileOffline => 'Offline';

  @override
  String get searchContactsGroupsMessages =>
      'Pesquisar contatos, grupos, mensagens';

  @override
  String get searchError => 'Erro na pesquisa';

  @override
  String get chatSearchHint => 'Pesquisar contatos, grupos e mensagens';

  @override
  String get searchHistory => 'Histórico de Pesquisa';

  @override
  String get commonClear => 'Limpar';

  @override
  String get commonAll => 'Todos';

  @override
  String get searchGroups => 'Grupos';

  @override
  String get searchNoResults => 'Nenhum resultado';

  @override
  String commonGroupMembers(int count) {
    return 'Membros ($count)';
  }

  @override
  String get groupMembersTitle => 'Membros do grupo';

  @override
  String get groupViewAll => 'Ver todos';

  @override
  String get groupOwner => 'Dono';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Convidar';

  @override
  String get commonGroupAnnouncement => 'Anúncio do Grupo';

  @override
  String get commonNotSet => 'Não definido';

  @override
  String get groupDescription => 'Descrição do Grupo';

  @override
  String get groupPublicGroup => 'Grupo Público';

  @override
  String get commonClearChatHistory => 'Limpar Histórico de Chat';

  @override
  String get commonDissolveGroup => 'Dissolver Grupo';

  @override
  String get commonLeaveGroup => 'Sair do Grupo';

  @override
  String get groupChangeGroupName => 'Alterar Nome do Grupo';

  @override
  String get commonEnterGroupName => 'Digite o nome do grupo';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get groupEnterGroupDescription => 'Digite a descrição do grupo';

  @override
  String get groupPublish => 'Publicar';

  @override
  String get chatClearHistoryConfirm =>
      'Limpar todo o histórico de chat? Esta ação não pode ser desfeita.';

  @override
  String get chatClearAction => 'Limpar';

  @override
  String get commonChatHistoryCleared => 'Histórico de chat limpo';

  @override
  String get commonDissolve => 'Dissolver';

  @override
  String get groupQrCode => 'QR Code do Grupo';

  @override
  String get commonSearchChatHistory => 'Pesquisar Histórico de Chat';

  @override
  String get groupIdCopied => 'ID do grupo copiado';

  @override
  String get transferEnterOrPasteAddress =>
      'Digite ou cole o endereço da carteira';

  @override
  String get transferSelectToken => 'Selecionar Token';

  @override
  String get commonTransferAmount => 'Valor da Transferência';

  @override
  String get transferAvailable => 'Disponível';

  @override
  String get transferMemoOptional => 'Observação (opcional)';

  @override
  String get transferConfirmTransfer => 'Confirmar Transferência';

  @override
  String get transferAddressVerified => 'Endereço verificado';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Disponível: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Digite o valor';

  @override
  String get commonRedPacketCountMin =>
      'É necessário pelo menos 1 envelope vermelho';

  @override
  String get commonViewRedPacketDetails => 'Ver detalhes do envelope vermelho';

  @override
  String get commonEnterTransferAmount => 'Digite o valor da transferência';

  @override
  String get commonTransferTo => 'Transferir para';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'De $senderName';
  }

  @override
  String get commonConfirmReceive => 'Confirmar Recebimento';

  @override
  String get groupProfile => 'Info do Grupo';

  @override
  String get groupRemoveMember => 'Remover do Grupo';

  @override
  String get commonRemove => 'Remover';

  @override
  String get profileClearStatus => 'Limpar Status';

  @override
  String get profileClearStatusConfirm => 'Limpar status atual?';

  @override
  String get profileStatusCleared => 'Status limpo';

  @override
  String get profileUserNotExist => 'Usuário não existe';

  @override
  String get profileUserIdCopied => 'ID do usuário copiado';

  @override
  String get commonReport => 'Denunciar';

  @override
  String get profileQrCode => 'QR Code';

  @override
  String get profileAvatarUpdated => 'Avatar atualizado';

  @override
  String commonSelectImageFailed(String error) {
    return 'Falha ao selecionar imagem: $error';
  }

  @override
  String get profileChangeName => 'Alterar Nome';

  @override
  String get profileMale => 'Masculino';

  @override
  String get profileFemale => 'Feminino';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature em desenvolvimento...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Falha ao salvar endereço: $error';
  }

  @override
  String get profileAddNew => 'Adicionar';

  @override
  String get profileAddAddress => 'Adicionar Endereço';

  @override
  String get profileAddressAdded => 'Endereço adicionado';

  @override
  String get profileAddressUpdated => 'Endereço atualizado';

  @override
  String get profileDeleteAddress => 'Excluir Endereço';

  @override
  String get profileAddressDeleted => 'Endereço excluído';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Falha ao salvar fatura: $error';
  }

  @override
  String get profileMyInvoices => 'Minhas Faturas';

  @override
  String get profileAddInvoice => 'Adicionar Fatura';

  @override
  String get profileInvoiceAdded => 'Fatura adicionada';

  @override
  String get profileInvoiceUpdated => 'Fatura atualizada';

  @override
  String get profileDeleteInvoice => 'Excluir Fatura';

  @override
  String get profileInvoiceDeleted => 'Fatura excluída';

  @override
  String get profilePersonal => 'Pessoal';

  @override
  String get groupSelectAtLeastOne =>
      'Por favor, selecione pelo menos um membro';

  @override
  String get chatFileNotExist => 'Arquivo não existe';

  @override
  String chatSendFailed(String error) {
    return 'Falha ao enviar: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Não foi possível abrir o navegador';

  @override
  String chatSelectFileFailed(String error) {
    return 'Falha ao selecionar arquivo: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Falha na configuração: $error';
  }

  @override
  String get transferEnterValidAmount => 'Por favor, digite um valor válido';

  @override
  String get commonAddressCopied => 'Endereço copiado';

  @override
  String favoriteOpenItem(String content) {
    return 'Abrir: $content';
  }

  @override
  String get favoriteDeleted => 'Excluído';

  @override
  String get profileWallet => 'Carteira';

  @override
  String get chatRecording => 'Gravando';

  @override
  String get chatInvalidVideoUrl => 'URL de vídeo inválida';

  @override
  String get chatDownloadFile => 'Baixar arquivo';

  @override
  String get chatClearChatHistoryTitle => 'Limpar Histórico de Chat';

  @override
  String get chatVideoCall => 'Videochamada';

  @override
  String get commonVoiceCall => 'Chamada de Voz';

  @override
  String get callLeaveMeeting => 'Sair da Reunião';

  @override
  String get chatDetails => 'Detalhes do Chat';

  @override
  String get chatViewAllGroupMembers => 'Ver todos os membros';

  @override
  String get chatGroupName => 'Nome do Grupo';

  @override
  String get chatGroupNameUpdated => 'Nome do grupo atualizado';

  @override
  String get chatUpdateFailed => 'Falha na atualização';

  @override
  String get chatNoPermissionToModify =>
      'Você não tem permissão para modificar';

  @override
  String get chatGroupManagement => 'Gerenciamento do Grupo';

  @override
  String get chatMyNicknameInGroup => 'Meu Apelido no Grupo';

  @override
  String get chatPinChat => 'Fixar Chat';

  @override
  String get chatStrongReminder => 'Lembrete Forte';

  @override
  String get chatSetChatBackground => 'Definir Plano de Fundo do Chat';

  @override
  String get chatUnknownFile => 'Arquivo desconhecido';

  @override
  String get chatDownload => 'Baixar';

  @override
  String get chatInvalidLocation => 'Localização inválida';

  @override
  String get chatTapToCancel => 'Toque para cancelar';

  @override
  String chatCaptureFailed(Object error) {
    return 'Falha na captura: $error';
  }

  @override
  String get chatProcessingVideo => 'Processando vídeo...';

  @override
  String get chatVideoFileNotExist => 'Arquivo de vídeo não existe';

  @override
  String get chatVideoDataEmpty => 'Dados do vídeo estão vazios';

  @override
  String get chatVideoTooLarge => 'O tamanho do vídeo não pode exceder 100MB';

  @override
  String get chatSendingVideo => 'Enviando vídeo...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Falha ao enviar vídeo: $error';
  }

  @override
  String get chatImageFileNotExist => 'Arquivo de imagem não existe';

  @override
  String get commonImageDataEmpty => 'Dados da imagem estão vazios';

  @override
  String get chatSendingImage => 'Enviando imagem...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Falha ao enviar imagem: $error';
  }

  @override
  String get chatSendLocation => 'Enviar Localização';

  @override
  String get chatSelectLocationAndSend => 'Selecione a localização e envie';

  @override
  String get chatShareRealTimeLocation =>
      'Compartilhar Localização em Tempo Real';

  @override
  String get chatShareLocationForOneHour =>
      'Compartilhe sua localização em tempo real com amigo por 1 hora';

  @override
  String get chatLocationSent => 'Localização enviada';

  @override
  String get chatSelectMessages => 'Selecionar mensagens';

  @override
  String chatSelectedCount(int count) {
    return '$count selecionada(s)';
  }

  @override
  String get chatSelectAll => 'Selecionar Todas';

  @override
  String chatGroupChatCount(int count) {
    return 'Chat em Grupo ($count)';
  }

  @override
  String get chatPrivateChat => 'Chat Privado';

  @override
  String get chatNoMessages => 'Nenhuma mensagem';

  @override
  String get chatSendFirstMessage =>
      'Envie a primeira mensagem para iniciar a conversa';

  @override
  String get chatEncryptionNotice =>
      'Este chat é criptografado de ponta a ponta. Apenas você e o destinatário podem ler as mensagens.';

  @override
  String get chatMultiForward => 'Encaminhar';

  @override
  String get chatCollect => 'Coletar';

  @override
  String get chatNoMembers => 'Nenhum membro';

  @override
  String get chatMemberNotFound => 'Membro não encontrado';

  @override
  String get chatVoiceFileNotExist => 'Arquivo de áudio não existe';

  @override
  String get chatVoiceFileEmpty => 'Arquivo de áudio está vazio';

  @override
  String get chatSendingVoice => 'Enviando áudio...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Falha ao enviar áudio: $error';
  }

  @override
  String get chatMessageForwarded => 'Mensagem encaminhada';

  @override
  String chatForwardFailed(Object error) {
    return 'Falha ao encaminhar: $error';
  }

  @override
  String get chatUnfavorited => 'Removido dos favoritos';

  @override
  String get chatFavorited => 'Adicionado aos favoritos';

  @override
  String get chatReactionAdded => 'Reação adicionada';

  @override
  String get chatReactionRemoved => 'Reação removida';

  @override
  String get chatFailedMessageDeleted => 'Mensagem com falha excluída';

  @override
  String get chatDeleteMessages => 'Excluir mensagens';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Tem certeza que deseja excluir $count mensagens?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Nota: $count mensagens são de outros e serão excluídas apenas para você.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count mensagens suas serão desfeitas para todos.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Desfeitas $count mensagens, $localCount excluídas apenas para você';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Desfeitas $count mensagens';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count mensagens excluídas apenas para você';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Encaminhadas $count mensagens';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Encaminhamento completo: $success sucesso(s), $failed falha(s)';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Recurso de lembrete disponível apenas em chat em grupo';

  @override
  String get chatOnlyTextSearchable =>
      'Apenas mensagens de texto podem ser pesquisadas';

  @override
  String chatSearchFor(Object text) {
    return 'Pesquisar \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Pesquisa Baidu';

  @override
  String get chatGoogleSearch => 'Pesquisa Google';

  @override
  String get chatBingSearch => 'Pesquisa Bing';

  @override
  String get chatCalling => 'Chamando...';

  @override
  String get chatRinging => 'Tocando...';

  @override
  String get chatInCall => 'Em chamada';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Recurso em desenvolvimento...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Coletadas $count mensagens';
  }

  @override
  String commonMemberCount(int count) {
    return '$count membros';
  }

  @override
  String groupDone(int count) {
    return 'Concluído($count)';
  }

  @override
  String get profileServices => 'Serviços';

  @override
  String get commonFavorites => 'Favoritos';

  @override
  String get profileOrdersAndCards => 'Pedidos e Cartões';

  @override
  String get profileStickers => 'Figurinhas';

  @override
  String profileStatusSetTo(String status) {
    return 'Status definido como: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Falha no envio do avatar';

  @override
  String get profilePersonalProfile => 'Perfil Pessoal';

  @override
  String get profileName => 'Nome';

  @override
  String get profileGender => 'Gênero';

  @override
  String get profileRegion => 'Região';

  @override
  String get commonMyQrCode => 'Meu QR Code';

  @override
  String get profilePoke => 'Cutucar';

  @override
  String get profileRingtone => 'Toque';

  @override
  String get profileDefaultRingtone => 'Toque Padrão';

  @override
  String get profileMyAddresses => 'Meus Endereços';

  @override
  String profileGenderSetTo(String gender) {
    return 'Gênero definido como: $gender';
  }

  @override
  String get profileSelectRegion => 'Selecionar Região';

  @override
  String get profileSelectCity => 'Selecionar Cidade';

  @override
  String profileRegionSetTo(String region) {
    return 'Região definida como: $region';
  }

  @override
  String get profileSetPoke => 'Definir Cutucada';

  @override
  String get profileFriendPokedMe => 'Amigo me cutucou';

  @override
  String get profileExample => 'Exemplo';

  @override
  String get profileOnTheShoulder => ' no ombro';

  @override
  String get profilePokeCleared => 'Cutucada limpa';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Cutucada definida como: me cutucou$suffix';
  }

  @override
  String get profileEditSignature => 'Editar Assinatura';

  @override
  String get profileIntroduceYourself => 'Uma frase para se apresentar';

  @override
  String get profileSignatureCleared => 'Assinatura limpa';

  @override
  String get profileSignatureUpdated => 'Assinatura atualizada';

  @override
  String get profileScanToAddFriend =>
      'Escaneie o QR code acima para me adicionar como amigo';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Toque definido como: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Tem certeza de que deseja dissolver \"$name\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Por favor, digite um endereço de servidor válido';

  @override
  String get authEmailOtp => 'Código por E-mail';

  @override
  String get authEnterServerAddressFirst =>
      'Por favor, digite o endereço do servidor primeiro';

  @override
  String get authPasskeyRequiresServer =>
      'Login com Passkey requer suporte do servidor';

  @override
  String get authLoginAgreement => 'Ao entrar, você concorda com ';

  @override
  String get authPleaseAgreeToTerms =>
      'Por favor, leia e aceite os Termos de Serviço e Política de Privacidade';

  @override
  String get authRegisterFailed => 'Falha no cadastro';

  @override
  String get commonReenterPassword => 'Digite a senha novamente';

  @override
  String get commonPasswordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get authInviteCodeBuiltIn => 'Código de Convite (Integrado)';

  @override
  String get authInviteCodeBuiltInNote =>
      'O código de convite é integrado, geralmente não precisa modificar';

  @override
  String get authIHaveReadAndAgree => 'Li e aceito ';

  @override
  String get mainStartGroupChat => 'Iniciar Chat em Grupo';

  @override
  String get mainAddFriends => 'Adicionar Amigos';

  @override
  String get mainPaymentAndCollection => 'Pagamento';

  @override
  String contactCount(int count) {
    return '$count contatos';
  }

  @override
  String get contactAddToHomeScreen => 'Adicionar à tela inicial';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Recomendou cartão de $contact para $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Digite o nome de observação';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Observação definida como: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Solicitação de amizade de $name aceita';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Solicitação de amizade de $name recusada';
  }

  @override
  String get commonGroupInvites => 'Convites para Grupos';

  @override
  String commonMyGroups(int count) {
    return 'Meus grupos ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Convidado para entrar no grupo';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Tem certeza de que deseja sair de \"$name\"?';
  }

  @override
  String get commonLeave => 'Sair';

  @override
  String get commonRecallThisMessage => 'Desfazer envio desta mensagem?';

  @override
  String get commonSavedToGallery => 'Salvo na galeria';

  @override
  String get commonFailedToSave => 'Falha ao salvar';

  @override
  String get chatSaving => 'Salvando...';

  @override
  String get commonShare => 'Compartilhar';

  @override
  String get chatSaveToGallery => 'Salvar na Galeria';

  @override
  String chatDownloadFailed(String code) {
    return 'Falha no download: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Falha ao compartilhar: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Falha ao carregar imagem';

  @override
  String get chatVideoRecordingFailed =>
      'Falha na gravação de vídeo. Por favor, tente novamente.';

  @override
  String get profileRedPacket => 'Envelope Vermelho';

  @override
  String get commonMusic => 'Música';

  @override
  String get commonCoupon => 'Cupom';

  @override
  String get commonGift => 'Presente';

  @override
  String get commonPoll => 'Enquete';

  @override
  String get favoriteText => 'Texto';

  @override
  String get favoriteLinkLabel => 'Link';

  @override
  String get favoriteNote => 'Nota';

  @override
  String get favoriteMyNotes => 'Minhas Notas';

  @override
  String get favoriteToday => 'Hoje';

  @override
  String favoriteDaysAgoText(int count) {
    return 'há $count dias';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Nenhum favorito ainda';

  @override
  String get favoriteLongPressToFavorite =>
      'Pressione e segure a mensagem para favoritar';

  @override
  String get favoriteNewNote => 'Nova Nota';

  @override
  String get favoriteLink => 'Link Favorito';

  @override
  String get favoriteEditTags => 'Editar Tags';

  @override
  String get favoriteDeleteFavorite => 'Excluir Favorito';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Tem certeza que deseja excluir este favorito?';

  @override
  String get favoriteNoSearchResultsFound => 'Nenhum resultado encontrado';

  @override
  String get commonSendRedPacket => 'Enviar Envelope Vermelho';

  @override
  String get transferAmount => 'Valor';

  @override
  String get commonRedPacketCover => 'Capa do Envelope Vermelho';

  @override
  String get commonRedPacketType => 'Tipo de Envelope Vermelho';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'Sorte';

  @override
  String get commonRedPacketCount => 'Quantidade de Envelopes';

  @override
  String get commonPieces => 'unidades';

  @override
  String get commonPutMoneyInRedPacket =>
      'Colocar dinheiro no envelope vermelho';

  @override
  String get commonRedPacketRefundNotice =>
      'Envelopes não resgatados serão reembolsados após 24 horas';

  @override
  String get commonOpenRedPacket => 'Abrir';

  @override
  String get commonRedPacketAllClaimed => 'Todos os envelopes resgatados';

  @override
  String get commonRedPacketExpired => 'Envelope vermelho expirado';

  @override
  String get commonAddTransferNote => 'Adicionar nota de transferência';

  @override
  String get commonYuan => 'BRL';

  @override
  String get commonReplyWithEmoji => 'Responder com este emoji';

  @override
  String get contactEditRemark => 'Editar Observação';

  @override
  String get contactSetPermissions => 'Definir Permissões';

  @override
  String get profileAddToBlacklist => 'Adicionar à Lista Negra';

  @override
  String get contactDeleteContact => 'Excluir Contato';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Tem certeza que deseja excluir $name?';
  }

  @override
  String get transferTitle => 'Transferência';

  @override
  String get transferReceiverAddressLabel => 'Endereço do Destinatário';

  @override
  String get transferSelectTokenLabel => 'Selecionar Token';

  @override
  String get transferAmountLabel => 'Valor da Transferência';

  @override
  String get transferMemoLabel => 'Observação (opcional)';

  @override
  String get transferAddMemoHint => 'Adicionar uma observação';

  @override
  String get transferSendPaymentRequest => 'Enviar Solicitação de Pagamento';

  @override
  String get transferQrCodeGenerateFailed => 'Falha na geração do QR code';

  @override
  String get transferScanQrToPayMe => 'Escaneie o QR code para me pagar';

  @override
  String get transferMyWalletAddress => 'Meu Endereço de Carteira';

  @override
  String get transferCreatePaymentRequest => 'Criar Solicitação de Pagamento';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Felicidades';

  @override
  String commonSenderRedPacket(String name) {
    return 'Envelope Vermelho de $name';
  }

  @override
  String get transferEnterValidAddress =>
      'Por favor, digite um endereço válido';

  @override
  String get transferPleaseSelectToken => 'Por favor, selecione um token';

  @override
  String get commonReceivedTransfer => 'Transferência Recebida';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name enviou um envelope vermelho';
  }

  @override
  String get commonSavedToBalance =>
      'Salvo no saldo, pode transferir diretamente';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Envelope vermelho expirado/todos resgatados';

  @override
  String get transferScanFeatureComingSoon =>
      'Recurso de escaneamento em breve...';

  @override
  String get contactSetAsStarred => 'Definir como Favorito';

  @override
  String get contactAddToBlocklist => 'Adicionar à Lista de Bloqueio';

  @override
  String get commonClaimedYour => ' resgatou seu ';

  @override
  String get commonClaimedText => ' resgatou ';

  @override
  String commonUserTyping(String name) {
    return '$name está digitando...';
  }

  @override
  String get commonTyping => 'Digitando...';

  @override
  String get commonWaitingToReceive => 'Aguardando recebimento';

  @override
  String get commonTapToClaim => 'Toque para resgatar';

  @override
  String get commonHasBeenReceived => 'Foi recebido';

  @override
  String get commonGetLucky => 'Boa sorte';

  @override
  String get qrcodeCameraStartFailed => 'Falha ao iniciar câmera';

  @override
  String get qrcodeUnknownError => 'Erro desconhecido';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Coloque o QR code dentro do quadro para escanear';

  @override
  String get qrcodeCloseManualInput => 'Fechar Entrada Manual';

  @override
  String get qrcodeManualInputUserId => 'Inserir ID do Usuário Manualmente';

  @override
  String get commonAdd => 'Adicionar';

  @override
  String get profileSetStatus => 'Definir Status';

  @override
  String get profileVisibleToFriends24h => 'Visível para amigos por 24 horas';

  @override
  String get profileWriteStatus => 'Escrever Status';

  @override
  String get profileEnterYourStatus => 'Digite seu status...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Permissão de câmera necessária para escanear QR code';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Permissão de câmera negada permanentemente. Por favor, ative nas configurações do sistema.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Erro ao verificar permissão: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'QR code inválido';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Não foi possível adicionar amigo: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Escanear QR Code';

  @override
  String get qrcodeCheckingCameraPermission =>
      'Verificando permissão da câmera...';

  @override
  String get qrcodeNeedCameraPermission => 'Permissão de Câmera Necessária';

  @override
  String get qrcodeRetryPermission => 'Tentar Novamente';

  @override
  String get qrcodeOpenSettings => 'Abrir Configurações';

  @override
  String get groupInviteMembers => 'Convidar Membros';

  @override
  String groupInviteCount(int count) {
    return 'Convidar($count)';
  }

  @override
  String get profileNoShippingAddress => 'Nenhum endereço de entrega';

  @override
  String get profileDefaultLabel => 'Padrão';

  @override
  String get profileNoInvoice => 'Nenhuma fatura';

  @override
  String get profileCompany => 'Empresa';

  @override
  String get profileTaxNumber => 'CNPJ';

  @override
  String get profileConfirmDeleteAddress =>
      'Tem certeza que deseja excluir este endereço?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Tem certeza que deseja excluir esta fatura?';

  @override
  String get commonGroupOwner => 'Dono';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Pesquisar membros';

  @override
  String groupTotalMembers(int count) {
    return '$count membros';
  }

  @override
  String get chatRemoveFromGroup => 'Remover do Grupo';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Tem certeza que deseja remover \"$name\" do grupo?';
  }

  @override
  String get chatUnknownSong => 'Música Desconhecida';

  @override
  String get chatUnknownArtist => 'Artista Desconhecido';

  @override
  String get chatUnknownContact => 'Contato Desconhecido';

  @override
  String get chatPersonalCard => 'Cartão de Contato';

  @override
  String get chatSingleChoice => 'Única';

  @override
  String get chatMultiChoice => 'Múltipla';

  @override
  String get chatEnded => 'Encerrada';

  @override
  String get chatEndPollButton => 'Encerrar Enquete';

  @override
  String get chatPollHint =>
      'A enquete será exibida no chat. Membros do grupo podem votar.';

  @override
  String get chatSearchSongOrArtist => 'Pesquisar música ou artista';

  @override
  String get chatNoSongsFound => 'Nenhuma música encontrada';

  @override
  String get chatSongNameOptional => 'Nome da Música (Opcional)';

  @override
  String get chatEnterSongName => 'Digite o nome da música';

  @override
  String get chatArtistNameOptional => 'Nome do Artista (Opcional)';

  @override
  String get chatEnterArtistName => 'Digite o nome do artista';

  @override
  String get chatRealTimeLocationSharing =>
      'Compartilhamento de localização em tempo real em desenvolvimento...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Recurso de chamada de voz em desenvolvimento...';

  @override
  String get profileReportFeatureInDev =>
      'Recurso de denúncia em desenvolvimento...';

  @override
  String get profileShareFeatureInDev =>
      'Recurso de compartilhamento em desenvolvimento...';

  @override
  String get profileQrCodeFeatureInDev =>
      'Recurso de QR code em desenvolvimento...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Escaneie o QR code acima para me adicionar como amigo';

  @override
  String get qrcodeSaveToAlbum => 'Salvar no Álbum';

  @override
  String get qrcodeChangeStyle => 'Alterar Estilo';

  @override
  String get qrcodeCopyId => 'Copiar ID';

  @override
  String get qrcodeIdCopied => 'ID copiado';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'Mais estilos em breve';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Servidor';

  @override
  String get profileShareContactCard => 'Compartilhar Cartão de Contato';

  @override
  String get profileRemoveFromBlacklist => 'Remover da Lista Negra';

  @override
  String get profileConfirmAddBlacklist =>
      'Tem certeza que deseja adicionar este usuário à lista negra? Você não receberá mensagens dele.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Tem certeza que deseja remover este usuário da lista negra?';

  @override
  String get profileRemarkSaved => 'Observação salva';

  @override
  String get profileRemarkCleared => 'Observação limpa';

  @override
  String get transferReceive => 'Receber';

  @override
  String get transferPleaseConnectWallet =>
      'Por favor, conecte sua carteira primeiro';

  @override
  String get transferSendRequest => 'Enviar Solicitação';

  @override
  String get transferPleaseEnterValidAmount =>
      'Por favor, digite um valor válido';

  @override
  String get searchPlaceholder => 'Pesquisar contatos, grupos, mensagens';

  @override
  String get searchEnterKeywordToSearch =>
      'Digite palavras-chave para pesquisar';

  @override
  String get searchClearHistory => 'Limpar';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Nenhum resultado encontrado para \"$query\"';
  }

  @override
  String get searchAllResults => 'Todos';

  @override
  String get searchInChat => 'Pesquisar no chat';

  @override
  String get searchContactLabel => 'Contato';

  @override
  String get searchGroupLabel => 'Grupo';

  @override
  String get searchConversationLabel => 'Conversa';

  @override
  String get searchMessageLabel => 'Mensagem';

  @override
  String get settingsSecurityTitle => 'Segurança';

  @override
  String get settingsKeyBackup => 'Backup de Chaves';

  @override
  String get settingsBackupEncryptionKeys =>
      'Fazer Backup das Chaves de Criptografia';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count chaves com backup';
  }

  @override
  String get settingsBackupNotSet => 'Backup não configurado';

  @override
  String get settingsRestoreKeys => 'Restaurar Chaves';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Restaurar chaves de criptografia do backup';

  @override
  String get settingsExportKeys => 'Exportar Chaves';

  @override
  String get settingsExportKeysToFile => 'Exportar chaves para arquivo';

  @override
  String get settingsLoggedInDevices => 'Dispositivos Conectados';

  @override
  String get settingsNoOtherDevices => 'Nenhum outro dispositivo';

  @override
  String get settingsVerified => 'Verificado';

  @override
  String get settingsUnverified => 'Não verificado';

  @override
  String get settingsAdvanced => 'Avançado';

  @override
  String get settingsCrossSigning => 'Assinatura Cruzada';

  @override
  String get settingsEnabled => 'Ativado';

  @override
  String get settingsNotEnabled => 'Não ativado';

  @override
  String get settingsResetEncryption => 'Redefinir Criptografia';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Excluir todas as chaves de criptografia';

  @override
  String get settingsEncryptionNotSupported => 'Criptografia não suportada';

  @override
  String get settingsNotInitialized => 'Não inicializado';

  @override
  String get settingsBackupKeyTitle => 'Fazer Backup das Chaves';

  @override
  String get settingsBackupKeyMessage =>
      'Criar um novo backup de chaves? Isso ajudará você a restaurar mensagens criptografadas em um novo dispositivo.';

  @override
  String get settingsBackup => 'Backup';

  @override
  String get settingsRestoreKeyTitle => 'Restaurar Chaves';

  @override
  String get settingsRestoreKeyMessage =>
      'Digite sua senha de recuperação ou chave de recuperação para restaurar mensagens criptografadas.';

  @override
  String get settingsRestore => 'Restaurar';

  @override
  String get settingsExportKeyTitle => 'Exportar Chaves';

  @override
  String get settingsExportKeyMessage =>
      'O arquivo de chaves exportado contém todas as suas chaves de criptografia. Por favor, guarde-o em segurança.';

  @override
  String get settingsExport => 'Exportar';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID do Dispositivo: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Status: Verificado';

  @override
  String get settingsDeviceStatusUnverified => 'Status: Não verificado';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Última atividade: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Verificar este dispositivo';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Assinatura cruzada já está ativada';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Assinatura cruzada configurada com sucesso';

  @override
  String get settingsResetEncryptionTitle => 'Redefinir Criptografia';

  @override
  String get settingsResetEncryptionWarning =>
      'Aviso: Isso excluirá todas as suas chaves de criptografia. Você não poderá descriptografar mensagens criptografadas anteriores. Esta ação não pode ser desfeita.';

  @override
  String get settingsReset => 'Redefinir';

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
      'Tem certeza que deseja sair da reunião?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'cutucou $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Nenhum contato disponível para adicionar';

  @override
  String get chatAddMembers => 'Adicionar Membros';

  @override
  String chatInvitedMembers(int count) {
    return '$count membros convidados';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Falha ao convidar: $error';
  }

  @override
  String get chatMemberRemoved => 'Membro removido';

  @override
  String chatRemoveFailed(String error) {
    return 'Falha ao remover: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Após compartilhar, a outra pessoa poderá ver sua localização em tempo real por 1 hora.';

  @override
  String get chatStartSharing => 'Iniciar Compartilhamento';

  @override
  String get chatLocationServiceNotEnabled =>
      'Serviço de localização não está ativado';

  @override
  String get chatEnableLocationService =>
      'Por favor, ative o serviço de localização para usar este recurso';

  @override
  String get chatGoToSettings => 'Ir para Configurações';

  @override
  String get chatLocationPermissionRequired =>
      'Permissão de localização é necessária para este recurso';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Permissão de localização foi negada permanentemente. Por favor, ative nas configurações.';

  @override
  String get chatLocationPermissionDenied => 'Permissão de localização negada';

  @override
  String get chatGettingLocation => 'Obtendo localização...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Falha ao obter localização: $error';
  }

  @override
  String get chatMapPreview => 'Prévia do Mapa';

  @override
  String get chatSearchLocation => 'Pesquisar localização';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Enviou envelope vermelho de $amount $token';
  }

  @override
  String get chatTransferDefault => 'Transferência';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Enviou transferência de $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Falha ao selecionar arquivo: $error';
  }

  @override
  String get chatFileSizeLimit => 'O tamanho do arquivo não pode exceder 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Enviando arquivo: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Falha ao enviar arquivo: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Enviou cartão de contato de $name';
  }

  @override
  String get chatFavoritesFeature => 'Favoritos';

  @override
  String get chatCouponsFeature => 'Cupons';

  @override
  String get chatGiftFeature => 'Presente';

  @override
  String chatSharedMusic(String name) {
    return 'Compartilhou $name';
  }

  @override
  String get chatEndPollTitle => 'Encerrar Enquete';

  @override
  String get chatEndPollConfirmMessage =>
      'Tem certeza que deseja encerrar esta enquete? A votação será fechada após o encerramento.';

  @override
  String get chatPollEndedMessage => 'Enquete encerrada';

  @override
  String get chatConnectingCall => 'Conectando...';

  @override
  String get chatMuteCall => 'Silenciar';

  @override
  String get chatSpeakerOff => 'Alto-falante Desligado';

  @override
  String get chatSpeakerOn => 'Alto-falante';

  @override
  String get chatCameraOn => 'Câmera Ligada';

  @override
  String get chatCameraOff => 'Câmera Desligada';

  @override
  String get chatHangUp => 'Encerrar';

  @override
  String get chatSelectForwardTargetTitle => 'Selecionar Destino';

  @override
  String get chatNoForwardableChat => 'Nenhum chat disponível para encaminhar';

  @override
  String get chatNoMatchingChat => 'Nenhum chat correspondente encontrado';

  @override
  String get chatLocationTitle => 'Localização';

  @override
  String get chatSendButton => 'Enviar';

  @override
  String get chatRetryButton => 'Tentar Novamente';

  @override
  String get chatSearchContactHint => 'Pesquisar contatos';

  @override
  String get chatShareMusic => 'Compartilhar Música';

  @override
  String get chatRecentPlayed => 'Recentes';

  @override
  String get chatMyFavorites => 'Favoritos';

  @override
  String get chatNetworkLink => 'Link';

  @override
  String get chatLocalFile => 'Local';

  @override
  String get chatPasteMusicLink => 'Cole o link da música';

  @override
  String get chatShareMusicButton => 'Compartilhar Música';

  @override
  String get chatSelectLocalAudio => 'Selecionar Arquivo de Áudio Local';

  @override
  String get chatSupportedAudioFormats => 'Suporta MP3, M4A, WAV, FLAC, etc.';

  @override
  String get chatSelectFileButton => 'Selecionar Arquivo';

  @override
  String get chatPleaseEnterMusicLink => 'Por favor, digite o link da música';

  @override
  String get chatPleaseEnterValidLink => 'Por favor, digite uma URL válida';

  @override
  String get chatSharedSong => 'Música Compartilhada';

  @override
  String get chatSelectMember => 'Selecionar Membro';

  @override
  String get chatSearchMemberHint => 'Pesquisar membros';

  @override
  String get chatNoMatchingMembers => 'Nenhum membro correspondente encontrado';

  @override
  String get commonUnknownMember => 'Desconhecido';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count mensagens selecionadas';
  }

  @override
  String get chatSearchContactsOrGroups => 'Pesquisar contatos ou grupos';

  @override
  String get chatVideoTitle => 'Vídeo';

  @override
  String get chatLoadingText => 'Carregando...';

  @override
  String get chatVideoLoadFailed => 'Falha ao carregar vídeo';

  @override
  String get chatPlayerInitFailed => 'Falha na inicialização do player';

  @override
  String get chatCreatePollTitle => 'Criar Enquete';

  @override
  String get chatSubmitPoll => 'Enviar';

  @override
  String get chatPollQuestionLabel => 'Pergunta da Enquete';

  @override
  String get chatEnterPollQuestionHint =>
      'Por favor, digite a pergunta da enquete';

  @override
  String get chatPollOptionsLabel => 'Opções da Enquete';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Opção $index';
  }

  @override
  String get chatAddOptionButton => 'Adicionar Opção';

  @override
  String get chatPollSettingsLabel => 'Configurações da Enquete';

  @override
  String get chatSelectionType => 'Tipo de Seleção';

  @override
  String get chatSingleChoiceLabel => 'Única';

  @override
  String get chatMultiChoiceLabel => 'Múltipla';

  @override
  String get chatAnonymousPollSwitch => 'Enquete Anônima';

  @override
  String get chatPleaseEnterQuestion =>
      'Por favor, digite a pergunta da enquete';

  @override
  String get chatAtLeastTwoOptions => 'São necessárias pelo menos 2 opções';

  @override
  String chatConfirmWithCount(int count) {
    return 'Confirmar ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Verificação por E-mail';

  @override
  String get authEnterValidEmailAddress =>
      'Por favor, digite um endereço de e-mail válido';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Código de verificação enviado para $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Falha ao enviar código: $error';
  }

  @override
  String get authVerificationSuccess => 'Verificação bem-sucedida';

  @override
  String get authVerificationFailed => 'Falha na verificação';

  @override
  String authVerificationCodeError(String error) {
    return 'Erro no código de verificação: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Digite o código de verificação';

  @override
  String get authEnterYourEmail => 'Digite o e-mail';

  @override
  String authWeSentCodeTo(String email) {
    return 'Enviamos um código de 6 dígitos para\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Digite seu endereço de e-mail, enviaremos o código de verificação';

  @override
  String get commonSendVerificationCode => 'Enviar código de verificação';

  @override
  String get authResendVerificationCode => 'Reenviar código de verificação';

  @override
  String authCanResendAfter(int seconds) {
    return 'Pode reenviar após $seconds segundos';
  }

  @override
  String get commonChangeEmail => 'Alterar e-mail';

  @override
  String get contactAddToContacts => 'Adicionar aos Contatos';

  @override
  String get contactAddingToContacts => 'Adicionando...';

  @override
  String get contactAddedToContacts => 'Adicionado aos contatos';

  @override
  String contactAddFailedWithError(String error) {
    return 'Falha ao adicionar: $error';
  }

  @override
  String get contactAddPhone => 'Adicionar telefone';

  @override
  String get contactAddTag => 'Adicionar tags';

  @override
  String get contactAddText => 'Adicionar texto';

  @override
  String get contactAddPhoto => 'Adicionar foto';

  @override
  String contactGroupCountLabel(int count) {
    return '$count grupos';
  }

  @override
  String get contactAddedViaSearch => 'Adicionado via pesquisa';

  @override
  String get contactAddTime => 'Adicionar horário';

  @override
  String get contactDoneButton => 'Concluído';

  @override
  String get callWaitingForParticipants => 'Aguardando participantes...';

  @override
  String callParticipantMe(String name) {
    return '$name (Eu)';
  }

  @override
  String get callSharingLabel => 'Compartilhando';

  @override
  String callScreenSharingBy(String name) {
    return '$name está compartilhando a tela';
  }

  @override
  String callParticipantCount(int count) {
    return '$count participantes';
  }

  @override
  String get callMuteLabel => 'Silenciar';

  @override
  String get callUnmuteLabel => 'Ativar Som';

  @override
  String get callTurnOffVideo => 'Desligar vídeo';

  @override
  String get callTurnOnVideo => 'Ligar vídeo';

  @override
  String get callShareScreen => 'Compartilhar tela';

  @override
  String get callStopSharing => 'Parar compartilhamento';

  @override
  String get callSwitchCameraLabel => 'Alternar';

  @override
  String get callLeaveLabel => 'Sair';

  @override
  String get callParticipantsLabel => 'Participantes';

  @override
  String get callJoiningMeeting => 'Entrando na reunião...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count votos ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count participantes';
  }

  @override
  String get commonTapToRetry => 'Toque para tentar novamente';

  @override
  String get chatDefaultRedPacketGreeting =>
      'Desejo-lhe prosperidade e boa sorte';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Permitir que outros pesquisem e se juntem';

  @override
  String get groupConfirmClearChatHistory =>
      'Tem certeza de que deseja limpar o histórico de chat?';

  @override
  String get groupCreateGroupToChat => 'Crie um grupo para começar a conversar';

  @override
  String get groupEditGroupAnnouncement => 'Editar anúncio do grupo';

  @override
  String get groupEditGroupDescription => 'Editar descrição do grupo';

  @override
  String get groupEnterGroupAnnouncement => 'Digite o anúncio do grupo';

  @override
  String chatErrorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count membros, clique para copiar ID do grupo';
  }

  @override
  String get chatMusicLinkLabel => 'Link de música';

  @override
  String get chatNoMediaUrlAvailable => 'URL de mídia não disponível';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Você não tem permissão para editar o nome do grupo';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Envelopes vermelhos e transferências não podem ser encaminhados';

  @override
  String get authEmailAddress => 'Endereço de e-mail';

  @override
  String get commonEnterEmailAddress => 'Digite o endereço de e-mail';

  @override
  String get authEmailRecoveryHint => 'Usado para recuperação de senha';

  @override
  String get commonInvalidEmailFormat => 'Digite um endereço de e-mail válido';

  @override
  String get authOptional => 'Opcional';

  @override
  String get authResetPassword => 'Redefinir senha';

  @override
  String get authEnterRegisteredEmail =>
      'Digite o endereço de e-mail com o qual você se registrou';

  @override
  String get authSendResetCode => 'Enviar código de redefinição';

  @override
  String authResetCodeSent(String email) {
    return 'Código de redefinição enviado para $email';
  }

  @override
  String get authEnterResetCode => 'Digite o código de redefinição';

  @override
  String get authSetNewPassword => 'Definir nova senha';

  @override
  String get commonConfirmNewPassword => 'Confirmar nova senha';

  @override
  String get commonNewPassword => 'Nova senha';

  @override
  String get authPasswordResetSuccess =>
      'Senha redefinida com sucesso. Entre com sua nova senha.';

  @override
  String get authResetPasswordFailed => 'Falha ao redefinir senha';

  @override
  String get settingsChangePassword => 'Alterar senha';

  @override
  String get settingsCurrentPassword => 'Senha atual';

  @override
  String get settingsEnterCurrentPassword => 'Digite a senha atual';

  @override
  String get settingsEnterNewPassword => 'Digite a nova senha';

  @override
  String get settingsPasswordChanged =>
      'Senha alterada com sucesso. Entre com sua nova senha.';

  @override
  String get settingsChangePasswordFailed => 'Falha ao alterar senha';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'A nova senha deve ser diferente da senha atual';

  @override
  String get settingsChangePasswordInfo =>
      'Após alterar a senha, você será desconectado e precisará entrar com a nova senha.';

  @override
  String get settingsPasswordRequirements => 'Requisitos de senha:';

  @override
  String get settingsSecurityNote =>
      'Por segurança, você precisará entrar novamente em todos os dispositivos após alterar a senha.';

  @override
  String get settingsSecurity => 'Segurança';

  @override
  String get settingsCurrentBoundEmail => 'E-mail atualmente vinculado';

  @override
  String get settingsNewEmailAddress => 'Novo endereço de e-mail';

  @override
  String get settingsEnterNewEmail => 'Digite o novo endereço de e-mail';

  @override
  String get settingsVerificationCode => 'Código de verificação';

  @override
  String get settingsVerificationCodeSent => 'Código de verificação enviado';

  @override
  String get settingsCodeSentTo => 'Código de verificação enviado para';

  @override
  String get settingsDidNotReceiveCode => 'Não recebeu o código?';

  @override
  String get settingsEmailChangedSuccess => 'E-mail alterado com sucesso';

  @override
  String get settingsChangeEmailFailed => 'Falha ao alterar e-mail';

  @override
  String get settingsEmailSecurityNote =>
      'Seu e-mail é usado para recuperação de senha. Mantenha-o seguro.';

  @override
  String get commonGoogleLogin => 'Entrar com Google';

  @override
  String get commonAppleLogin => 'Entrar com Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageChanged => 'Idioma alterado';

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
  String get settingsBiometricLogin => 'Login biométrico';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Entrar com $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Login biométrico ativado';

  @override
  String get settingsBiometricLoginDisabled => 'Login biométrico desativado';

  @override
  String get settingsEnableBiometricLogin => 'Ativar login biométrico';

  @override
  String get settingsBiometricEnabled => 'Ativado - Usar biometria para entrar';

  @override
  String get settingsBiometricDisabled => 'Desativado - Toque para ativar';

  @override
  String get settingsBiometricNeedRelogin =>
      'Por favor, saia e entre novamente para ativar o login biométrico';

  @override
  String get authOr => 'OU';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'O acesso à câmera está restrito neste dispositivo';

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
      'Digite o sufixo da cutucada, ex.: no ombro';

  @override
  String get groupAlbum => 'Álbum do grupo';

  @override
  String get groupFiles => 'Arquivos do grupo';

  @override
  String get groupImages => 'Imagens';

  @override
  String get groupVideos => 'Vídeos';

  @override
  String get groupTotal => 'Total';

  @override
  String get groupSize => 'Tamanho';

  @override
  String get groupNoMedia => 'Sem mídia';

  @override
  String get groupNoMediaDescription =>
      'Nenhuma foto ou vídeo neste grupo ainda';

  @override
  String get groupDocuments => 'Documentos';

  @override
  String get groupNoFiles => 'Sem arquivos';

  @override
  String get groupNoFilesDescription => 'Nenhum arquivo neste grupo ainda';

  @override
  String groupDownloadStarted(String filename) {
    return 'Baixando $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Sem grupos em comum';

  @override
  String get contactNoCommonGroupsDescription =>
      'Vocês não têm grupos em comum';

  @override
  String get chatVoiceMessage => 'Voz';

  @override
  String get chatMessage => 'Mensagem';

  @override
  String get conversationHideChat => 'Ocultar';

  @override
  String get settingsQuickReply => 'Resposta rápida';

  @override
  String get commonTranslate => 'Traduzir';

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
    return 'Conversa: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Contato: $userId';
  }

  @override
  String get commonDiscover => 'Descobrir';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Em breve)';
  }

  @override
  String get commonPageNotFound => 'Página não encontrada';

  @override
  String get commonBackToHome => 'Voltar ao Início';

  @override
  String get settingsMessageNotifications => 'Notificações de mensagens';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Receber notificações de novas mensagens';

  @override
  String get settingsShowMessagePreview => 'Mostrar prévia da mensagem';

  @override
  String get settingsShowMessageContentInNotification =>
      'Mostrar conteúdo da mensagem nas notificações';

  @override
  String get settingsNotificationSound => 'Som de notificação';

  @override
  String get settingsPlaySoundOnMessage =>
      'Reproduzir som ao receber mensagens';

  @override
  String get commonVibration => 'Vibração';

  @override
  String get settingsVibrateOnMessage => 'Vibrar ao receber mensagens';

  @override
  String get settingsDoNotDisturbMode => 'Não perturbe';

  @override
  String get settingsDoNotDisturbDescription =>
      'Não receber notificações durante o período especificado';

  @override
  String get settingsStartTime => 'Horário de início';

  @override
  String get settingsEndTime => 'Horário de término';

  @override
  String get settingsDeleteQuickReply => 'Excluir resposta rápida';

  @override
  String get settingsEditQuickReply => 'Editar resposta rápida';

  @override
  String get settingsAddQuickReply => 'Adicionar resposta rápida';

  @override
  String get settingsManageQuickReplies => 'Gerenciar respostas rápidas';

  @override
  String get settingsNoQuickReplies => 'Sem respostas rápidas';

  @override
  String get settingsDefaultQuickReplies =>
      'As respostas rápidas padrão serão exibidas';

  @override
  String get settingsWhoCanSee => 'Quem pode ver';

  @override
  String get settingsLastSeen => 'Visto por último';

  @override
  String get settingsHiddenChats => 'Chats ocultos';

  @override
  String get settingsMessagesLabel => 'Mensagens';

  @override
  String get settingsAllowStrangerMessages => 'Permitir mensagens de estranhos';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Receber mensagens de não-contatos';

  @override
  String get settingsReadReceipts => 'Confirmação de leitura';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Permitir que outros saibam que você leu suas mensagens';

  @override
  String get settingsTypingIndicator => 'Indicador de digitação';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Permitir que outros saibam que você está digitando';

  @override
  String get settingsEveryone => 'Todos';

  @override
  String get settingsContactsOnly => 'Apenas contatos';

  @override
  String get settingsNobody => 'Ninguém';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Quem pode ver $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Versão $version';
  }

  @override
  String get settingsCheckForUpdates => 'Verificar atualizações';

  @override
  String get settingsOpenSourceLicenses => 'Licenças de código aberto';

  @override
  String get settingsFeedbackAndSuggestions => 'Feedback e sugestões';

  @override
  String get settingsBuiltOnMatrix => 'Construído no protocolo Matrix';

  @override
  String get settingsNoHiddenChats => 'Sem chats ocultos';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Os chats que você ocultar aparecerão aqui';

  @override
  String get settingsUnhideChat => 'Reexibir';

  @override
  String get settingsDarkMode => 'Modo escuro';

  @override
  String get settingsFontSize => 'Tamanho da fonte';

  @override
  String get settingsBubbleStyle => 'Estilo do balão';

  @override
  String get settingsFollowSystem => 'Seguir sistema';

  @override
  String get settingsAutoSwitchBySystem =>
      'Alternar automaticamente conforme configurações do sistema';

  @override
  String get settingsLightMode => 'Modo claro';

  @override
  String get settingsAlwaysUseLightTheme => 'Sempre usar tema claro';

  @override
  String get settingsDarkModeOption => 'Modo escuro';

  @override
  String get settingsAlwaysUseDarkTheme => 'Sempre usar tema escuro';

  @override
  String get settingsFontSizeSmall => 'Pequeno';

  @override
  String get settingsFontSizeStandard => 'Padrão';

  @override
  String get settingsFontSizeLarge => 'Grande';

  @override
  String get settingsFontSizeExtraLarge => 'Extra grande';

  @override
  String get settingsBubbleStyleWechat => 'Estilo WeChat';

  @override
  String get settingsBubbleStyleWechatDesc =>
      'Estilo de balão clássico do WeChat';

  @override
  String get settingsBubbleStyleModern => 'Estilo moderno';

  @override
  String get settingsBubbleStyleModernDesc => 'Estilo de balão moderno e limpo';

  @override
  String get settingsBubbleStyleClassic => 'Estilo clássico';

  @override
  String get settingsBubbleStyleClassicDesc => 'Estilo de balão tradicional';

  @override
  String get discoverVideoChannels => 'Canais';

  @override
  String get discoverLive => 'Ao Vivo';

  @override
  String get discoverListen => 'Ouvir';

  @override
  String get discoverWatch => 'Assistir';

  @override
  String get discoverSearchDiscover => 'Pesquisar';

  @override
  String get discoverNearbyPeople => 'Pessoas Próximas';

  @override
  String get discoverGames => 'Jogos';

  @override
  String get discoverMiniPrograms => 'Mini Programas';

  @override
  String get chatAlreadyInCall => 'Já está em uma chamada';

  @override
  String get commonConnectionFailed => 'Falha na conexão';

  @override
  String get chatCallRejected => 'Chamada recusada';

  @override
  String get chatNoAnswer => 'Sem resposta';

  @override
  String get commonClose => 'Fechar';

  @override
  String get chatSelectContact => 'Selecionar Contato';

  @override
  String get chatVoteRemoved => 'Voto removido';

  @override
  String get chatVoteChanged => 'Voto alterado';

  @override
  String get chatVoted => 'Votou';

  @override
  String chatReplyTo(String name) {
    return 'Responder a $name';
  }

  @override
  String get chatCurrentLocation => 'Localização Atual';

  @override
  String chatNearbyPlace(int index) {
    return 'Local Próximo $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Aproximadamente $distance';
  }

  @override
  String get chatAddress => 'Endereço';

  @override
  String get chatLatitude => 'Latitude';

  @override
  String get chatLongitude => 'Longitude';

  @override
  String get groupDescriptionUpdated => 'Descrição do grupo atualizada';

  @override
  String get groupAvatarUpdated => 'Avatar do grupo atualizado';

  @override
  String get callDecline => 'Recusar';

  @override
  String get callAnswer => 'Atender';

  @override
  String get callIncomingVideoCall => 'Chamada de vídeo recebida';

  @override
  String get callIncomingVoiceCall => 'Chamada de voz recebida';

  @override
  String get callVideoCallInProgress => 'Chamada de vídeo';

  @override
  String get callVoiceCallInProgress => 'Chamada de voz';

  @override
  String get callReconnectingCall => 'Reconectando...';

  @override
  String get callEnded => 'Chamada encerrada';

  @override
  String get callFailed => 'Chamada falhou';

  @override
  String get callLivekitNotConfigured => 'LiveKit não configurado';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Falha ao entrar na reunião: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Falha no compartilhamento de tela: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Sem N42 Bean';

  @override
  String get profileN42BeanDetails => 'Detalhes do N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean é um token para resgatar itens virtuais e serviços no N42. Atualmente disponível para:';

  @override
  String get profileN42BeanFeature1 =>
      'Figurinhas e temas exclusivos para membros';

  @override
  String get profileN42BeanFeature2 => 'Personalização de balões de chat';

  @override
  String get profileN42BeanFeature3 =>
      'Personalização de capas de envelope vermelho';

  @override
  String get profileN42BeanFeature4 => 'Distintivo de apelido exclusivo';

  @override
  String get profileN42BeanFeature5 => 'Privilégios de chat em grupo';

  @override
  String get profileN42BeanFeature6 => 'Expansão de armazenamento em nuvem';

  @override
  String get profileN42BeanFeature7 => 'Filtros de beleza para videochamadas';

  @override
  String get profileN42BeanFeature8 => 'Personalização de fundo dos Moments';

  @override
  String get profileN42BeanFeature9 => 'Prioridade no atendimento VIP';

  @override
  String get profileGotIt => 'Entendi';

  @override
  String get profileNoN42BeanRecords => 'Sem registros de N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Humor e Pensamentos';

  @override
  String get profileStatusHappy => 'Feliz';

  @override
  String get profileStatusCracked => 'Arrasado';

  @override
  String get profileStatusLucky => 'Com sorte';

  @override
  String get profileStatusSunny => 'Ensolarado';

  @override
  String get profileStatusTired => 'Cansado';

  @override
  String get profileStatusDaydream => 'Sonhando acordado';

  @override
  String get profileStatusRushing => 'Correndo';

  @override
  String get profileStatusOverthinking => 'Pensando demais';

  @override
  String get profileStatusEnergized => 'Energizado';

  @override
  String get profileWorkAndStudy => 'Trabalho e Estudo';

  @override
  String get profileStatusWorking => 'Trabalhando';

  @override
  String get profileStatusStudying => 'Estudando';

  @override
  String get profileStatusBusy => 'Ocupado';

  @override
  String get profileStatusSlacking => 'Relaxando';

  @override
  String get profileStatusTraveling => 'Viajando';

  @override
  String get profileStatusGoingHome => 'Indo para Casa';

  @override
  String get profileStatusDnd => 'Não Perturbe';

  @override
  String get profileActivities => 'Atividades';

  @override
  String get profileStatusHanging => 'Saindo';

  @override
  String get profileStatusCheckIn => 'Check-in';

  @override
  String get profileStatusExercising => 'Exercitando';

  @override
  String get profileStatusCoffee => 'Café';

  @override
  String get profileStatusBubbleTea => 'Chá de Bolhas';

  @override
  String get profileStatusEating => 'Comendo';

  @override
  String get profileStatusParenting => 'Cuidando dos Filhos';

  @override
  String get profileStatusSavingWorld => 'Salvando o Mundo';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Descanso';

  @override
  String get profileStatusRetreat => 'Retiro';

  @override
  String get profileStatusHome => 'Em Casa';

  @override
  String get profileStatusSleeping => 'Dormindo';

  @override
  String get profileStatusCatLover => 'Amante de Gatos';

  @override
  String get profileStatusDogWalking => 'Passeando com Cachorro';

  @override
  String get profileStatusGaming => 'Jogando';

  @override
  String get profileStatusListening => 'Ouvindo';

  @override
  String get profileEditAddress => 'Editar Endereço';

  @override
  String get profileRecipient => 'Destinatário';

  @override
  String get profileEnterRecipientName => 'Digite o nome do destinatário';

  @override
  String get profilePhoneNumber => 'Número de Telefone';

  @override
  String get profileEnterPhoneNumber => 'Digite o número de telefone';

  @override
  String get profileRegionHint => 'Estado/Cidade/Bairro';

  @override
  String get profileDetailedAddress => 'Endereço Detalhado';

  @override
  String get profileDetailedAddressHint => 'Rua, número, etc.';

  @override
  String get profileSetAsDefaultAddress => 'Definir como endereço padrão';

  @override
  String get profilePleaseCompleteInfo => 'Por favor, preencha todos os campos';

  @override
  String get profileEditInvoice => 'Editar Fatura';

  @override
  String get profileInvoiceType => 'Tipo de fatura: ';

  @override
  String get profileCompanyName => 'Nome da Empresa';

  @override
  String get profilePersonalName => 'Nome Pessoal';

  @override
  String get profileEnterCompanyName => 'Digite o nome da empresa';

  @override
  String get profileEnterName => 'Digite o nome';

  @override
  String get profileTaxIdNumber => 'CNPJ/CPF';

  @override
  String get profileEnterTaxIdNumber => 'Digite o CNPJ/CPF';

  @override
  String get profileBankNameOptional => 'Nome do Banco (Opcional)';

  @override
  String get profileEnterBankName => 'Digite o nome do banco';

  @override
  String get profileBankAccountOptional => 'Conta Bancária (Opcional)';

  @override
  String get profileEnterBankAccount => 'Digite a conta bancária';

  @override
  String get profileCompanyAddressOptional => 'Endereço da Empresa (Opcional)';

  @override
  String get profileEnterCompanyAddress => 'Digite o endereço da empresa';

  @override
  String get profileCompanyPhoneOptional => 'Telefone da Empresa (Opcional)';

  @override
  String get profileEnterCompanyPhone => 'Digite o telefone da empresa';

  @override
  String get profileSetAsDefaultInvoice => 'Definir como fatura padrão';

  @override
  String get profileRingtoneVibrate => 'Vibrar';

  @override
  String get profileRingtoneSilent => 'Silencioso';

  @override
  String get profileVibrateMode => 'Modo vibração';

  @override
  String get profileSilentMode => 'Modo silencioso';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Falha ao reproduzir: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Reproduzindo: $ringtoneName';
  }

  @override
  String get profileStop => 'Parar';

  @override
  String get profileSelectRingtone => 'Selecionar Toque';

  @override
  String get profileLoadingRingtones => 'Carregando toques...';

  @override
  String get profileNoRingtonesFound => 'Nenhum toque encontrado';

  @override
  String mainMessagesWithCount(int count) {
    return 'Mensagens($count)';
  }

  @override
  String get storyViewers => 'Visualizadores';

  @override
  String get storyNoViewers => 'Nenhum visualizador ainda';

  @override
  String get storyReplyToStory => 'Responder à história...';

  @override
  String get commonCopiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get commonMore => 'Mais';

  @override
  String get commonTranslating => 'Traduzindo...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Traduzido de $language';
  }

  @override
  String get commonTranslation => 'Tradução';

  @override
  String get commonTranslationFailed => 'Falha na tradução';

  @override
  String get commonAllRead => 'Todas lidas';

  @override
  String commonReadCount(int count) {
    return '$count lida(s)';
  }

  @override
  String get commonYouRecalledMessage => 'Você desfez o envio de uma mensagem';

  @override
  String get commonMessageRecalled => 'Mensagem removida';

  @override
  String get commonReEdit => 'Editar novamente';

  @override
  String get commonWalletArea => 'Área da carteira';

  @override
  String get callIncomingCall => 'Chamada recebida';

  @override
  String get callMissedCall => 'Chamada perdida';

  @override
  String get groupRemoveAdmin => 'Remover Admin';

  @override
  String get chatSelectCurrency => 'Selecionar moeda';

  @override
  String get chatSelectEmoji => 'Selecionar emoji';

  @override
  String get chatSelectRedPacketCover => 'Selecionar capa';

  @override
  String get groupSetAsAdmin => 'Definir como Admin';

  @override
  String get chatVideoPlaybackFailed => 'Falha na reprodução do vídeo';

  @override
  String get groupViewProfile => 'Ver Perfil';

  @override
  String get favoriteAddLinkComingSoon => 'Recurso de adicionar link em breve';

  @override
  String get favoriteNewNoteComingSoon => 'Recurso de nova nota em breve';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Recurso de salvar em breve';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Recurso de compartilhamento em breve';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Falha ao processar QR code: $error';
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
  String get gameCenter => 'Jogos';

  @override
  String get gameHighScore => 'Recorde';

  @override
  String get gameScore => 'Pontuação';

  @override
  String get gameOver => 'Fim de jogo';

  @override
  String get gamePlayAgain => 'Jogar novamente';

  @override
  String get gameLeaderboard => 'Classificação';

  @override
  String get gamePause => 'Pausado';

  @override
  String get gameResume => 'Toque para continuar';

  @override
  String get gameConfirmExit => 'Sair do jogo?';

  @override
  String get gameNoScores => 'Sem pontuações';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Combine peças até chegar a 2048';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Solte e elimine linhas';

  @override
  String get gameMinesweeper => 'Campo Minado';

  @override
  String get gameMinesweeperDesc => 'Encontre todas as células seguras';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => 'Combine 3 ou mais gemas';

  @override
  String get gameMinesweeperEasy => 'Fácil';

  @override
  String get gameMinesweeperMedium => 'Médio';

  @override
  String get gameMinesLeft => 'Minas restantes';

  @override
  String get gameTimeLeft => 'Tempo';

  @override
  String get gameLevel => 'Nível';

  @override
  String get gameNext => 'Próximo';

  @override
  String get gameBestTime => 'Melhor tempo';

  @override
  String get gameNewRecord => 'Novo recorde!';

  @override
  String get gameLines => 'Linhas';

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
  String get onChainNotificationsTitle => 'Eventos On-chain';

  @override
  String get onChainMarkAllRead => 'Marcar todos como lidos';

  @override
  String get onChainNoNotifications => 'Nenhum evento on-chain ainda';

  @override
  String get onChainNoNotificationsDesc =>
      'Eventos dos canais inscritos aparecerão aqui';

  @override
  String get onChainViewDetails => 'Ver detalhes';

  @override
  String get chatCommandHelp => '/help — Ver todos os comandos';

  @override
  String get chatCommandPrice => '/price — Obter preço do token';

  @override
  String get chatCommandBalance => '/balance — Ver saldo da carteira';

  @override
  String get chatCommandChains => '/chains — Listar 236+ redes suportadas';

  @override
  String get chatMiniApps => 'Apps';

  @override
  String get miniAppMarketTitle => 'Mini Apps';

  @override
  String get miniAppCategoryAll => 'Todos';

  @override
  String get miniAppSearch => 'Pesquisar apps...';

  @override
  String get miniAppFeatured => 'Destaque';

  @override
  String get miniAppAllApps => 'Todos os Apps';

  @override
  String get miniAppNoResults => 'Nenhum app encontrado';

  @override
  String get slideToPayLabel => '→→→  Deslize para confirmar';

  @override
  String get slideToPayConfirming => 'Confirmando...';

  @override
  String get redPacketBestLuck => 'Melhor sorte';

  @override
  String get redPacketBestLuckCongrats => 'Melhor sorte! Você recebeu mais!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total resgatados';
  }

  @override
  String get redPacketStatsTotal => 'total';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 Recebeu um envelope vermelho • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  endereço 0x  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'Pesquisar por ID, carteira ou ENS...';

  @override
  String get web3WalletAddress => 'Endereço da carteira';

  @override
  String get web3AddressCopied => 'Endereço copiado';

  @override
  String get web3Copy => 'Copiar';

  @override
  String get web3SendMessage => 'Enviar mensagem';

  @override
  String get web3SendToWallet => 'Mensagem para carteira';

  @override
  String get web3WalletOnlyHint =>
      'Este endereço não tem conta N42. A mensagem será entregue quando entrar.';

  @override
  String get web3NftAvatar => 'Avatar NFT';

  @override
  String get web3ResolveFailed => 'Falha ao resolver identidade';

  @override
  String web3EnsNotFound(String name) {
    return 'Nome ENS \"$name\" não encontrado';
  }

  @override
  String get web3NoN42AccountTitle => 'Sem conta N42';

  @override
  String get web3NoN42AccountDesc =>
      'This wallet address has no N42 account yet. You can share your N42 invite link with them to get started.';

  @override
  String get web3ShareInvite => 'Partilhar convite';

  @override
  String get nftPickerTitle => 'Selecionar avatar NFT';

  @override
  String get nftPickerTabPopular => 'Popular';

  @override
  String get nftPickerTabCustom => 'Personalizado';

  @override
  String get nftPickerChain => 'Chain';

  @override
  String get nftPickerContract => 'Contract Address';

  @override
  String get nftPickerTokenId => 'Token ID';

  @override
  String get nftPickerVerifyOwnership =>
      'Verificar propriedade e pré-visualizar';

  @override
  String get nftPickerUseAsAvatar => 'Usar como avatar';

  @override
  String get nftPickerPreview => 'Preview';

  @override
  String get nftPickerNotOwned => 'Você não possui este NFT';

  @override
  String get nftPickerInvalidTokenId => 'Invalid token ID';

  @override
  String get nftPickerEnterBoth => 'Enter contract address and token ID';

  @override
  String get nftPickerInfoTitle => 'Avatar NFT — Verificado na chain';

  @override
  String get nftPickerInfoDesc =>
      'Bind an NFT you own as your avatar. Anyone can verify ownership on-chain. Displayed with a gold ring across N42.';

  @override
  String get nftPickerPopularCollections => 'Coleções populares';

  @override
  String get nftPickerWalletHint =>
      'Conecte sua carteira N42 para descobrir seus NFTs em mais de 236 cadeias.';

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

  @override
  String get blocAuthSendVerificationCodeFailed => '发送验证码失败';

  @override
  String get blocAuthServerNoEmailPasswordReset => '该服务器不支持通过邮箱重置密码';

  @override
  String get blocAuthResetPasswordFailed => '重置密码失败';

  @override
  String get blocAuthChangePasswordFailed => '修改密码失败';

  @override
  String get blocAuthOldPasswordWrong => '原密码错误';

  @override
  String get blocAuthLoginCancelled => '登录已取消';

  @override
  String get blocAuthGoogleLoginFailed => 'Google 登录失败';

  @override
  String get blocAuthAppleLoginFailed => 'Apple 登录失败';

  @override
  String get blocAuthSsoLoginFailed => 'SSO 登录失败';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook 登录失败';

  @override
  String get blocAuthTwitterLoginFailed => 'Twitter 登录失败';

  @override
  String get blocAuthWeChatLoginFailed => '微信登录失败';

  @override
  String get blocAuthWeChatNotConfigured => '微信登录未配置';

  @override
  String get blocAuthWeChatNotInstalled => '请先安装微信';

  @override
  String get blocAuthPasswordWrong => '密码错误';

  @override
  String get blocAuthEmailAlreadyBound => '该邮箱已被其他账号绑定';

  @override
  String get blocAuthChangeEmailFailed => '修改邮箱失败';

  @override
  String get blocAuthVerificationCodeInvalid => '验证码错误或已过期';

  @override
  String get blocAuthSessionExpired => '会话已失效，请重新登录';

  @override
  String get blocAuthSessionIncomplete => '会话数据不完整，请重新登录';

  @override
  String get blocAuthPasskeyNotImplemented => 'Passkey 登录功能尚未实现';

  @override
  String get blocAuthPasskeyRegisterNotImplemented => 'Passkey 注册功能尚未实现';

  @override
  String get blocAuthEmailOtpNotImplemented => '邮箱 OTP 登录功能尚未实现';
}
