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
  String authLoginFailed(Object error) {
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
      'A permissão do microfone foi negada. Ative-o nas configurações do sistema para usar mensagens de voz.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Falha ao iniciar gravação: $error';
  }

  @override
  String get commonRecordingTooShort => 'Gravação muito curta';

  @override
  String commonStopRecordingFailed(Object error) {
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
  String get commonChat => 'Bate-papo';

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
  String get chatReadAloud => 'Leia em voz alta';

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
  String contactN42Id(Object id) {
    return 'ID N42: $id';
  }

  @override
  String get profileN42IdTitle => 'ID N42';

  @override
  String get profileN42Bean => 'Feijão N42';

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
  String get contactTags => 'Etiquetas';

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
  String profileSaveFailed(Object error) {
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
  String get authAnd => ' e ';

  @override
  String get authPrivacyPolicy => 'Política de Privacidade';

  @override
  String get authServerAddress => 'Endereço do Servidor';

  @override
  String get authEnterServerAddress => 'Digite o endereço do servidor';

  @override
  String authConnectedTo(Object serverName) {
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
  String get profileAvatar => 'avatar';

  @override
  String get profileStatus => 'Estado';

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
  String commonFeatureComingSoon(Object feature) {
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
  String conversationDeleteConversationConfirm(Object name) {
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
  String get contactChatOnlyFriends => 'Amigos apenas para bate-papo';

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
  String contactRecommendFailed(Object error) {
    return 'Falha na recomendação: $error';
  }

  @override
  String get profileEnterRemark => 'Digite a observação';

  @override
  String get contactOpeningChat => 'Abrindo chat...';

  @override
  String contactOpenChatFailed(Object error) {
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
  String get profileOnline => 'On-line';

  @override
  String get profileOffline => 'Off-line';

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
  String commonGroupMembers(Object count) {
    return 'Membros ($count)';
  }

  @override
  String get groupMembersTitle => 'Membros do grupo';

  @override
  String get groupViewAll => 'Ver todos';

  @override
  String get groupOwner => 'Dono';

  @override
  String get groupAdmin => 'Administrador';

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
  String transferAvailableBalance(Object balance, Object symbol) {
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
  String commonFromSender(String name) {
    return 'De $name';
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
  String get profileQrCode => 'Código QR';

  @override
  String get profileAvatarUpdated => 'Avatar atualizado';

  @override
  String commonSelectImageFailed(Object error) {
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
  String profileSaveAddressFailed(Object error) {
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
  String profileSaveInvoiceFailed(Object error) {
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
  String favoriteOpenItem(Object content) {
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
  String commonFeatureInDevelopment(Object feature) {
    return 'A funcionalidade $feature está em desenvolvimento…';
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
  String get authRegistrationDisabled =>
      'O registo neste servidor está desativado. Contacte o administrador para o ativar.';

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
  String get favoriteLinkLabel => 'Ligação';

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
  String get commonNormalRedPacket => 'Normais';

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
    return 'ID N42: $id';
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
  String get commonGroupAdmin => 'Administrador';

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
  String get profileBio => 'Biografia';

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
  String get searchClearHistoryConfirm => 'Limpar todas as pesquisas recentes?';

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
  String get settingsDeleteAccountTitle => 'Eliminar conta';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Desativar esta conta Matrix e limpar seus dados locais de conversa';

  @override
  String get settingsDeleteAccountExplanation =>
      'Esta ação solicita a desativação permanente da conta Matrix. Após a confirmação do servidor, o aplicação remove a sessão local de conversa e as chaves de encriptação desta conta quando for seguro. As outras contas e sua carteira são mantidas. A federação e as políticas de retenção dos servidores podem limitar a exclusão de dados.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Palavra-passe do Matrix, se solicitada';

  @override
  String get settingsDeleteAccountServerErase =>
      'Solicitar exclusão de dados do servidor';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Peça a este servidor de origem que exclua os dados da conta, quando houver suporte. Cópias mantidas por outros servidores ou exigidas por políticas de retenção podem permanecer.';

  @override
  String get settingsDeleteAccountChooseStage => 'Verificar esta conta Matrix';

  @override
  String get settingsDeleteAccountUsePassword => 'Usar palavra-passe do Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'Continuar no navegador';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Retornar da verificação do Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Retornar do navegador não confirma a exclusão. Verifique a solicitação original com o servidor Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'Verificar com o servidor';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'O servidor Matrix não confirmou a exclusão da conta.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Limpeza local da conta pendente';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Revisar a limpeza de uma conta Matrix desativada anteriormente';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Não foi possível ler os registos de limpeza pendentes. Toque para tentar novamente.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'A conta Matrix foi desativada, mas a limpeza local ainda está pendente. As outras contas continuam disponíveis.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'O gestão da conta foi aberto no navegador. A exclusão não foi confirmada neste aplicação, portanto sua sessão de conversa permanece disponível.';

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
  String get settingsBackup => 'Cópia de segurança';

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
  String get settingsBackupSuccess => 'Chaves salvas em backup com sucesso';

  @override
  String get settingsBackupFailed => 'Falha no backup';

  @override
  String get settingsRecoveryKey => 'Chave de recuperação';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Salve esta chave de recuperação em um local seguro. Você precisará dele para restaurar suas mensagens criptografadas em um novo dispositivo.';

  @override
  String get settingsRecoveryKeySaved => 'eu salvei';

  @override
  String get settingsRestoreSuccess => 'Chaves restauradas com sucesso';

  @override
  String get settingsRestoreEmpty =>
      'Não foram encontradas chaves de mensagens nesta cópia de segurança.';

  @override
  String settingsRestoreSessions(int count) {
    return 'Foram restauradas $count sessões de chaves. As mensagens sem chaves podem permanecer encriptadas.';
  }

  @override
  String get settingsRestoreFailed => 'Falha na restauração';

  @override
  String get settingsPassword => 'Senha';

  @override
  String get settingsEnterRecoveryKey => 'Insira a chave de recuperação';

  @override
  String get settingsEnterPassword => 'Digite a senha';

  @override
  String get settingsExportSuccess =>
      'Chaves exportadas para backup do servidor com sucesso';

  @override
  String get settingsExportNeedBackupFirst =>
      'Crie um backup de chave primeiro';

  @override
  String get settingsExportFailed => 'Falha na exportação';

  @override
  String get settingsResetSuccess => 'Redefinição de criptografia bem-sucedida';

  @override
  String get settingsResetFailed => 'Falha na redefinição';

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
  String get chatNetworkLink => 'Ligação';

  @override
  String get chatLocalFile => 'locais';

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
  String get chatNoMediaUrlAvailable => 'URL de mídia não disponível';

  @override
  String chatDownloadFailed(String code) {
    return 'Falha no download: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Link de música';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Envelopes vermelhos e transferências não podem ser encaminhados';

  @override
  String commonShareFailed(String error) {
    return 'Falha ao compartilhar: $error';
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
  String groupMemberCountClickToCopy(Object count) {
    return '$count membros, clique para copiar ID do grupo';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Você não tem permissão para editar o nome do grupo';

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
  String get settingsTranslation => 'Tradução';

  @override
  String get settingsTranslateTextTo => 'Traduzir texto para';

  @override
  String get settingsTranslateDescription =>
      'Selecione o idioma para o qual deseja que as mensagens sejam traduzidas.';

  @override
  String get settingsAutoTranslate =>
      'Traduzir automaticamente mensagens recebidas';

  @override
  String get settingsAutoTranslateDescription =>
      'Traduza automaticamente as mensagens recebidas no chat para o idioma selecionado.';

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
  String get authPasskeyLabel => 'Chave de acesso';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'maçã';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Este servidor não configurou provedores de login SSO';

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
  String get contactCreateTag => 'Criar etiqueta';

  @override
  String get contactEnterTagName => 'Insira o nome da etiqueta';

  @override
  String get contactEditTag => 'Editar etiqueta';

  @override
  String get contactDeleteTag => 'Excluir etiqueta';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Tem certeza de que deseja excluir a tag \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'Ainda não há tags';

  @override
  String get contactFriendPermissions => 'Permissões de amigos';

  @override
  String get contactSetChatOnly => 'Definir como somente bate-papo';

  @override
  String get contactChatOnlyDesc =>
      'Só pode conversar com você, outros conteúdos ficarão ocultos';

  @override
  String get contactHideMyMoments => 'Esconder meus momentos';

  @override
  String get contactHideMyMomentsDesc =>
      'Este amigo não pode ver meus momentos';

  @override
  String get contactHideTheirMoments => 'Esconda seus momentos';

  @override
  String get contactHideTheirMomentsDesc => 'Não vejo os momentos deste amigo';

  @override
  String get contactHideMyStatus => 'Ocultar meu status';

  @override
  String get contactHideMyStatusDesc =>
      'Este amigo não pode ver minhas atualizações de status';

  @override
  String get contactNoChatOnlyFriends => 'Sem amigos apenas para bate-papo';

  @override
  String get contactNoOfficialAccounts => 'Sem contas oficiais';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Siga as contas oficiais para obter as atualizações mais recentes';

  @override
  String get contactNoServiceAccounts => 'Nenhuma conta de serviço';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Assine contas de serviço para serviços convenientes';

  @override
  String get contactNoEnterpriseContacts => 'Nenhum contato empresarial';

  @override
  String get contactEnterpriseContactsDesc =>
      'Os contatos corporativos serão exibidos aqui';

  @override
  String get profileCardPack => 'Pacote de cartas';

  @override
  String get profileOrders => 'Pedidos';

  @override
  String get profileNoOrders => 'Sem pedidos';

  @override
  String get profileOrdersDesc => 'Seus pedidos serão exibidos aqui';

  @override
  String get profileNoCards => 'Sem cartões';

  @override
  String get profileCardsDesc => 'Seus cartões serão exibidos aqui';

  @override
  String get favoriteEnterTagsHint => 'Insira tags separadas por vírgulas';

  @override
  String get favoriteTagsUpdated => 'Etiquetas atualizadas';

  @override
  String get favoriteForwardedContent => 'Conteúdo encaminhado';

  @override
  String get favoriteEnterNoteContent => 'Insira o conteúdo da nota';

  @override
  String get favoriteNoteAdded => 'Nota adicionada';

  @override
  String get favoriteLinkTitle => 'Título do link';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Link adicionado';

  @override
  String get contactPhotoAdded => 'Foto adicionada';

  @override
  String get contactEnterPhone => 'Digite o número de telefone';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Conversa: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Contato: $userId';
  }

  @override
  String get commonDiscover => 'Descobrir';

  @override
  String commonDeveloping(Object title) {
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
  String get groupVisibilityUpdated => 'Visibilidade do grupo atualizada';

  @override
  String get groupChannelCreated => 'Canal criado';

  @override
  String get groupChannelUpdated => 'Canal atualizado';

  @override
  String get groupChannelDeleted => 'Canal excluído';

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
  String callJoinMeetingFailed(Object error) {
    return 'Falha ao entrar na reunião: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Falha no compartilhamento de tela: $error';
  }

  @override
  String get profileN42BeanTitle => 'Feijão N42';

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
  String profilePlayFailed(Object ringtoneName) {
    return 'Falha ao reproduzir: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
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
  String commonReadCount(Object count) {
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
  String get securityDeviceIdRequired => 'O ID do dispositivo é obrigatório';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Falha ao iniciar a verificação: $error';
  }

  @override
  String get securityVerificationFailed => 'Falha na verificação';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Falha na verificação: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Verificação rejeitada – emoji não corresponde';

  @override
  String get securityWaitingForDeviceAccept =>
      'Aguardando que o outro dispositivo aceite...';

  @override
  String get securityVerifyDevice => 'Verifique este dispositivo';

  @override
  String get securityConfirmEmojiMatch =>
      'Confirme se os emojis abaixo são exibidos em ambos os dispositivos, na mesma ordem';

  @override
  String get securityEmojiDontMatch => 'Eles não combinam';

  @override
  String get securityEmojiMatch => 'Eles combinam';

  @override
  String get securityWaitingForDeviceConfirm =>
      'Aguardando a confirmação do outro dispositivo...';

  @override
  String get securityVerificationSuccess => 'Verificação bem-sucedida!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Este dispositivo agora foi verificado e confiável.';

  @override
  String get securityCompareEmoji => 'Compare o emoji em ambos os dispositivos';

  @override
  String get securityCompareNumbers =>
      'Compare os números em ambos os dispositivos';

  @override
  String get commonTryAgain => 'Tente novamente';

  @override
  String get commonDone => 'Concluído';

  @override
  String get chatExportTitle => 'Exportar bate-papo';

  @override
  String get chatExportSuccess => 'Exportação bem-sucedida';

  @override
  String chatExportFailed(String error) {
    return 'Falha na exportação: $error';
  }

  @override
  String get chatExportFormat => 'Formato de exportação';

  @override
  String get chatExportHtmlDesc =>
      'Legível em qualquer navegador com layout estilizado';

  @override
  String get chatExportJsonDesc =>
      'Formato de dados estruturados legível por máquina';

  @override
  String get chatExportDateRange => 'Período';

  @override
  String get chatExportAll => 'Todas as mensagens';

  @override
  String get chatExportLastWeek => 'Últimos 7 dias';

  @override
  String get chatExportLastMonth => 'Último mês';

  @override
  String get chatExportLast3Months => 'Últimos 3 meses';

  @override
  String get chatExportMessageCount => 'Mensagens para exportar';

  @override
  String get chatExportButton => 'Exportar e compartilhar';

  @override
  String get chatMediaGallery => 'Galeria de mídia';

  @override
  String get chatExportHistory => 'Exportar histórico de bate-papo';

  @override
  String get pdfLoadFailed => 'Falha ao carregar o PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'Todos';

  @override
  String get mediaImages => 'Imagens';

  @override
  String get mediaVideos => 'Vídeos';

  @override
  String get mediaFiles => 'Arquivos';

  @override
  String get mediaAudio => 'Áudio';

  @override
  String mediaItemsCount(int count) {
    return 'Itens $count';
  }

  @override
  String get mediaNoMediaFound => 'Nenhuma mídia encontrada';

  @override
  String get spacesTitle => 'Comunidades';

  @override
  String get spacesCreate => 'Criar comunidade';

  @override
  String get spacesJoined => 'Ingressou';

  @override
  String get spacesDiscover => 'Descubra';

  @override
  String get spacesNoJoined => 'Nenhuma comunidade aderiu ainda';

  @override
  String get spacesExplore => 'Explorar comunidades';

  @override
  String get spacesNoPublic => 'Nenhuma comunidade pública encontrada';

  @override
  String get spacesJoin => 'Junte-se';

  @override
  String get spacesSubSpaces => 'Subcomunidades';

  @override
  String get spacesChannels => 'Canais';

  @override
  String spacesMembersCount(int count) {
    return 'Membros $count';
  }

  @override
  String get spacesPublic => 'Público';

  @override
  String get spacesPrivate => 'Privado';

  @override
  String get spacesSuggested => 'Sugerido';

  @override
  String spacesChannelsCount(int count) {
    return 'Canais $count';
  }

  @override
  String get callInCallChat => 'Bate-papo durante a chamada';

  @override
  String callMessagesCount(int count) {
    return 'Mensagens $count';
  }

  @override
  String get callNoMessagesYet =>
      'Nenhuma mensagem ainda.\nEnvie uma mensagem para começar.';

  @override
  String get callTypeMessage => 'Digite uma mensagem...';

  @override
  String get callYouSender => 'Você';

  @override
  String get callChatLabel => 'Bate-papo';

  @override
  String get chatEdited => 'Editado';

  @override
  String get chatEditHistory => 'Editar histórico';

  @override
  String get chatOriginalMessage => 'Originais';

  @override
  String chatEditedAt(String time) {
    return 'Editado em $time';
  }

  @override
  String get chatViewOnce => 'Ver uma vez';

  @override
  String get chatViewOncePhoto => 'Ver uma vez foto';

  @override
  String get chatViewOnceVideo => 'Ver vídeo uma vez';

  @override
  String get chatViewOnceViewed => 'Visto';

  @override
  String get chatViewOnceExpired => 'Expirado';

  @override
  String get chatViewOnceTap => 'Toque para visualizar';

  @override
  String get chatAutoFaceBlur => 'Desfoque automático de rosto';

  @override
  String get chatAutoFaceBlurDesc =>
      'Desfocar rostos automaticamente ao enviar fotos';

  @override
  String get threadReplyInThread => 'Responder no tópico';

  @override
  String threadReplies(int count) {
    return 'Respostas $count';
  }

  @override
  String get threadReply => '1 resposta';

  @override
  String threadLatestReply(String preview) {
    return 'Mais recente: $preview';
  }

  @override
  String get threadTitle => 'Tópico';

  @override
  String get threadReplyPlaceholder => 'Responder no tópico...';

  @override
  String threadParticipants(int count) {
    return 'Participantes $count';
  }

  @override
  String get voiceRoomTitle => 'Sala de Voz';

  @override
  String get voiceRoomCreate => 'Criar sala de voz';

  @override
  String get voiceRoomJoin => 'Junte-se';

  @override
  String get voiceRoomLeave => 'Sair';

  @override
  String get voiceRoomEnd => 'Sala final';

  @override
  String get voiceRoomRaiseHand => 'Levante a mão';

  @override
  String get voiceRoomLowerHand => 'Mão Inferior';

  @override
  String get voiceRoomMute => 'Mudo';

  @override
  String get voiceRoomUnmute => 'Ativar som';

  @override
  String get voiceRoomHost => 'Anfitrião';

  @override
  String get voiceRoomSpeakers => 'Alto-falantes';

  @override
  String get voiceRoomListeners => 'Ouvintes';

  @override
  String get voiceRoomLive => 'AO VIVO';

  @override
  String get voiceRoomEnded => 'Terminou';

  @override
  String get voiceRoomScheduled => 'Agendado';

  @override
  String get voiceRoomApprove => 'Aprovar';

  @override
  String get voiceRoomDemote => 'Mover para ouvinte';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name levantou a mão';
  }

  @override
  String get voiceRoomName => 'Nome da sala';

  @override
  String get voiceRoomTopic => 'Tópico (opcional)';

  @override
  String get voiceRoomNoActive => 'Nenhuma sala de voz ativa';

  @override
  String get voiceRoomConnecting => 'Conectando...';

  @override
  String get usernameTitle => 'Nome de usuário';

  @override
  String get usernameSet => 'Definir nome de usuário';

  @override
  String get usernameChange => 'Alterar nome de usuário';

  @override
  String get usernamePlaceholder => 'Digite o nome de usuário';

  @override
  String get usernameAvailable => 'Nome de usuário disponível';

  @override
  String get usernameUnavailable => 'Nome de usuário já utilizado';

  @override
  String get usernameInvalid =>
      '3 a 30 caracteres, letras minúsculas, números, sublinhado. Deve começar com uma carta.';

  @override
  String get usernameReserved => 'Este nome de usuário está reservado';

  @override
  String get usernameSaved => 'Nome de usuário salvo';

  @override
  String get usernameSearchHint => 'Pesquisar por @nomedeusuário';

  @override
  String get ensName => 'Nome ENS';

  @override
  String get ensLinked => 'Vinculado ao ENS';

  @override
  String get ensResolving => 'Resolvendo ENS...';

  @override
  String get ensNotFound => 'Nome ENS não encontrado';

  @override
  String get tokenGateTitle => 'Portão de Token';

  @override
  String get tokenGateEnable => 'Habilitar Token Gate';

  @override
  String get tokenGateDisable => 'Desativar Token Gate';

  @override
  String get tokenGateAddRule => 'Adicionar regra';

  @override
  String get tokenGateRemoveRule => 'Remover regra';

  @override
  String get tokenGateContractAddress => 'Endereço do contrato';

  @override
  String get tokenGateMinBalance => 'Saldo Mínimo';

  @override
  String get tokenGateTokenId => 'ID do token (ERC-1155)';

  @override
  String get tokenGateChainId => 'ID da cadeia';

  @override
  String get tokenGateVerifying => 'Verificando acervos de tokens...';

  @override
  String get tokenGateVerified => 'Verificação aprovada';

  @override
  String get tokenGateDenied => 'Você não atende aos requisitos de token';

  @override
  String get tokenGateOperatorAnd => 'Deve atender TODAS as regras';

  @override
  String get tokenGateOperatorOr => 'Deve atender a QUALQUER regra';

  @override
  String get tokenGateRuleErc20 => 'Token ERC-20';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Multitoken (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Token Nativo';

  @override
  String get tokenGateSaved => 'Portão de token salvo';

  @override
  String get tokenGateEnableDescription =>
      'Exigir que os membros tenham tokens para ingressar';

  @override
  String get tokenGateOperator => 'Lógica de regras';

  @override
  String get tokenGateRules => 'Regras';

  @override
  String get tokenGateSymbol => 'Símbolo (opcional)';

  @override
  String get tokenGateChain => 'Corrente';

  @override
  String get tokenGateTokenStandard => 'Padrão de token';

  @override
  String get tokenGateDenialMessage => 'Mensagem de negação';

  @override
  String get tokenGateDenialMessageHint =>
      'Mensagem mostrada quando a verificação falha';

  @override
  String get tokenGateVerifyTitle => 'Verificação de token';

  @override
  String get tokenGateVerifyPassed => 'Verificação aprovada';

  @override
  String get tokenGateVerifyFailed => 'Falha na verificação';

  @override
  String get tokenGateRetryVerify => 'Tentar novamente';

  @override
  String get tokenGateRequired => 'Obrigatório';

  @override
  String get tokenGateYourBalance => 'Seu saldo';

  @override
  String get tokenGateRulesActive => 'regras ativas';

  @override
  String get tokenGateDisabled => 'Desativado';

  @override
  String get ensNotBound => 'Não vinculado';

  @override
  String get liveLocation => 'Localização ao vivo';

  @override
  String get stopLiveLocation => 'Pare de compartilhar';

  @override
  String get startLiveLocation => 'Comece a compartilhar';

  @override
  String get selectDuration => 'Selecione Duração';

  @override
  String get groupChatFiles => 'Arquivos de bate-papo';

  @override
  String get groupLinks => 'Ligações';

  @override
  String get groupNoLinks => 'Ainda não há links';

  @override
  String get chatBackground => 'Plano de fundo do bate-papo';

  @override
  String get solidColors => 'Cores Sólidas';

  @override
  String get gradients => 'Gradientes';

  @override
  String get defaultBackground => 'Padrão';

  @override
  String get settingsFontSizeSlider => 'Tamanho da fonte';

  @override
  String get autoDownload => 'Download automático';

  @override
  String get images => 'Imagens';

  @override
  String get voice => 'Voz';

  @override
  String get video => 'Vídeo';

  @override
  String get files => 'Arquivos';

  @override
  String get mobileData => 'Dados móveis';

  @override
  String get roaming => 'Itinerância';

  @override
  String get storageManagement => 'Armazenamento';

  @override
  String get totalUsage => 'Uso total';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Outro';

  @override
  String get clearCache => 'Limpar Cache';

  @override
  String get cacheCleared => 'Cache limpo';

  @override
  String get clearCacheFailed => 'Falha ao limpar o cache';

  @override
  String get confirmClearCache => 'Limpar todos os dados do cache?';

  @override
  String get mapView => 'Visualização do mapa';

  @override
  String liveLocationSharingCount(int count) {
    return '$count pessoas compartilhando localização';
  }

  @override
  String get minutes15 => '15 minutos';

  @override
  String get minutes30 => '30 minutos';

  @override
  String get hour1 => '1 hora';

  @override
  String get hours8 => '8 horas';

  @override
  String get personalCard => 'Cartão Pessoal';

  @override
  String get downloadFailed => 'Falha no download';

  @override
  String get locationExpired => 'Expirado';

  @override
  String secondsRemaining(int count) {
    return '$count segundos';
  }

  @override
  String minutesRemaining(int count) {
    return '$count minutos';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours horas $minutes minutos';
  }

  @override
  String get favoriteMessages => 'Favoritos';

  @override
  String get linksCopied => 'Link copiado';

  @override
  String get noLinksFound => 'Nenhum link encontrado';

  @override
  String get roomStorageRanking => 'Classificação de armazenamento de sala';

  @override
  String get downloadComplete => 'Download concluído';

  @override
  String get downloading => 'Baixando...';

  @override
  String get draftSaved => 'Rascunho salvo';

  @override
  String get voiceRecording => 'Gravação de voz';

  @override
  String get searchLocation => 'Local de pesquisa';

  @override
  String get tapToSearch => 'Toque para pesquisar';

  @override
  String get settingsThisDevice => 'Este dispositivo';

  @override
  String get settingsJustNow => 'Agora mesmo';

  @override
  String get settingsDeviceId => 'ID do dispositivo';

  @override
  String get settingsStatus => 'Estado';

  @override
  String get settingsLastActive => 'Último ativo';

  @override
  String get settingsIpAddress => 'Endereço IP';

  @override
  String get settingsRenameDevice => 'Renomear dispositivo';

  @override
  String get settingsDeviceNameHint => 'Digite o nome do dispositivo';

  @override
  String get settingsDeviceRenamed => 'Dispositivo renomeado';

  @override
  String get settingsRenameFailed => 'Falha ao renomear';

  @override
  String get settingsRemoteLogout => 'Logout remoto';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Tem certeza de que deseja sair de \"$deviceName\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Dispositivo desconectado';

  @override
  String get settingsLogoutFailed => 'Falha ao sair';

  @override
  String get settingsLogout => 'Sair';

  @override
  String get settingsVerifyIdentity => 'Verifique a identidade';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Digite sua senha para confirmar esta ação.';

  @override
  String get scheduledSendTitle => 'Agendar mensagem';

  @override
  String get scheduledSendInOneHour => 'Em 1 hora';

  @override
  String get scheduledSendTonight => 'Hoje à noite (20:00)';

  @override
  String get scheduledSendTomorrowMorning => 'Amanhã de manhã (9h00)';

  @override
  String get scheduledSendCustom => 'Escolha uma data e hora';

  @override
  String get scheduledMessageLabel => 'Agendado';

  @override
  String get scheduledMessageCancel => 'Cancelar mensagem agendada';

  @override
  String get chatLockTitle => 'Bloqueio de bate-papo';

  @override
  String get chatLockEnable => 'Bloquear este bate-papo';

  @override
  String get chatLockDisable => 'Desbloquear este bate-papo';

  @override
  String get chatLockDescription =>
      'Bate-papos bloqueados exigem verificação biométrica ou PIN para serem abertos';

  @override
  String get chatLockVerifyTitle => 'Bate-papo bloqueado';

  @override
  String get chatLockVerifySubtitle => 'Verifique para acessar este chat';

  @override
  String get chatLockVerifyFailed => 'Falha na verificação';

  @override
  String get chatLockEnabled => 'Bate-papo bloqueado';

  @override
  String get chatLockDisabled => 'Bate-papo desbloqueado';

  @override
  String get chatLockPinTitle => 'Insira o PIN';

  @override
  String get chatLockPinSetTitle => 'Definir PIN';

  @override
  String get chatLockPinConfirmTitle => 'Confirmar PIN';

  @override
  String get chatLockPinMismatch => 'PIN não corresponde';

  @override
  String get chatLockUseBiometric => 'Usar biometria';

  @override
  String get chatLockUsePin => 'Usar PIN';

  @override
  String get mediaEditorUndo => 'Desfazer';

  @override
  String get mediaEditorRedo => 'Refazer';

  @override
  String get mediaEditorCrop => 'Cortar';

  @override
  String get mediaEditorFilter => 'Filtro';

  @override
  String get mediaEditorDraw => 'Desenhar';

  @override
  String get mediaEditorText => 'Texto';

  @override
  String get aiAssistant => 'Assistente de IA';

  @override
  String get aiAssistantWelcome =>
      'Olá! Sou o assistente de IA do N42. Como posso ajudá-lo?';

  @override
  String get aiAssistantNotConfigured => 'Serviço de IA não configurado';

  @override
  String get aiAssistantSettings => 'Configurações de IA';

  @override
  String get aiAssistantClearHistory => 'Limpar histórico de bate-papo';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Tem certeza de que deseja limpar todo o histórico de bate-papo da IA?';

  @override
  String get aiAssistantStopGenerating => 'Pare de gerar';

  @override
  String get aiAssistantModel => 'Modelo';

  @override
  String get aiAssistantTemperature => 'Temperatura';

  @override
  String get aiAssistantMaxTokens => 'Máximo de tokens';

  @override
  String get aiAssistantContextWindow => 'Janela de contexto';

  @override
  String get aiAssistantServiceStatus => 'Status do serviço';

  @override
  String get aiAssistantAvailable => 'Disponível';

  @override
  String get aiAssistantUnavailable => 'Indisponível';

  @override
  String get aiSummarize => 'Resumo de IA';

  @override
  String aiSummarizeUnread(int count) {
    return 'Resumir mensagens não lidas $count';
  }

  @override
  String get aiSummarizeLoading => 'Resumindo...';

  @override
  String get aiSummarizeError => 'Falha ao resumir';

  @override
  String get aiRewrite => 'Reescrita de IA';

  @override
  String get aiRewriteFormal => 'Formal';

  @override
  String get aiRewriteCasual => 'Informal';

  @override
  String get aiRewritePlayful => 'Brincalhão';

  @override
  String get aiRewriteProfessional => 'Profissional';

  @override
  String get aiRewriteAccept => 'Usar';

  @override
  String get aiRewriteCancel => 'Cancelar';

  @override
  String get aiRewriteLoading => 'Reescrevendo...';

  @override
  String get aiLinkSummary => 'Resumo de IA';

  @override
  String get aiLinkSummaryAnalyzing => 'Analisando...';

  @override
  String get chatFolderManagement => 'Gerenciar pastas';

  @override
  String get chatFolderSystem => 'Pastas do sistema';

  @override
  String get chatFolderCustom => 'Pastas personalizadas';

  @override
  String get chatFolderEmpty => 'Ainda não há pastas personalizadas';

  @override
  String get chatFolderCreate => 'Criar pasta';

  @override
  String get chatFolderEdit => 'Editar pasta';

  @override
  String get chatFolderNameHint => 'Nome da pasta';

  @override
  String get chatFolderAll => 'Todos';

  @override
  String get chatFolderUnread => 'Não lido';

  @override
  String get chatFolderPersonal => 'Pessoal';

  @override
  String get chatFolderGroups => 'Grupos';

  @override
  String get chatFolderChannels => 'Canais';

  @override
  String get chatFolderMuted => 'Silenciado';

  @override
  String get storyAddMusic => 'Adicionar música';

  @override
  String get storyChangeMusic => 'Mudar música';

  @override
  String get storyBackgroundMusic => 'Música de fundo';

  @override
  String get storyMusicPreview => 'Pré-visualização (máx. 15s)';

  @override
  String get storyChooseFromDevice => 'Escolha do dispositivo';

  @override
  String get storyUseThisMusic => 'Use esta música';

  @override
  String get authPasskeyNotSupported =>
      'A senha não é compatível com este dispositivo';

  @override
  String get authPasskeyRegister => 'Registrar senha';

  @override
  String get authPasskeyNoRegistered => 'Nenhuma senha registrada';

  @override
  String get authPasskeyRegisterHint =>
      'Registre uma senha para esta conta. O login autônomo com senha será ativado posteriormente.';

  @override
  String get authPasskeyNameYours => 'Dê um nome à sua chave de acesso';

  @override
  String get authPasskeyRegistered => 'Chave de acesso salva nesta conta';

  @override
  String get authPasskeyDeleted => 'Chave de acesso removida desta conta';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Excluir a senha \"$name\"? Você precisará registrá-lo novamente antes de usar o login com senha posteriormente.';
  }

  @override
  String get momentVisibilityPublic => 'Público';

  @override
  String get momentVisibilityPrivate => 'Privado';

  @override
  String get momentVisibilityPartial => 'Amigos selecionados';

  @override
  String get momentVisibilityExcluded => 'Excluir alguns amigos';

  @override
  String momentUserMoments(String userName) {
    return 'Momentos de $userName';
  }

  @override
  String get momentForwardTo => 'Encaminhar para';

  @override
  String get momentForwardSuccess => 'Encaminhado com sucesso';

  @override
  String get momentSelectFriends => 'Selecione amigos';

  @override
  String get momentSelectTags => 'Selecione por tags';

  @override
  String momentSelectedCount(int count) {
    return 'Selecionado ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Ainda não há momentos';

  @override
  String get momentForwardMoment => 'Momento Avançar';

  @override
  String get momentAddComment => 'Adicione um comentário...';

  @override
  String momentForwardContent(String content) {
    return '[Momento] $content';
  }

  @override
  String get momentDeleteMoment => 'Excluir momento';

  @override
  String get momentDeleteConfirm =>
      'Tem certeza de que deseja excluir este momento?';

  @override
  String get momentComment => 'Comentário';

  @override
  String get momentWriteComment => 'Escreva um comentário...';

  @override
  String get momentLike => 'Gosto';

  @override
  String get momentUnlike => 'Ao contrário';

  @override
  String get momentForward => 'Avançar';

  @override
  String get momentDelete => 'Excluir';

  @override
  String get momentReply => 'responder';

  @override
  String get momentMoment => 'Momento';

  @override
  String momentLikesCount(int count) {
    return '$count gosta';
  }

  @override
  String momentCommentsCount(int count) {
    return 'Comentários $count';
  }

  @override
  String get momentNoComments => 'Ainda não há comentários';

  @override
  String get momentFailedToLoad => 'Falha ao carregar imagem';

  @override
  String momentReplyTo(String userName) {
    return 'Responder a $userName...';
  }

  @override
  String get momentNoConversations => 'Sem conversas';

  @override
  String get momentJustNow => 'agora mesmo';

  @override
  String momentMinutesAgo(int count) {
    return '${count}m atrás';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h atrás';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}d atrás';
  }

  @override
  String get chatGroupAnnouncementHint => 'Insira o anúncio do grupo';

  @override
  String get chatGroupAnnouncementEmpty => 'Nenhum anúncio';

  @override
  String get chatEditNickname => 'Editar apelido';

  @override
  String get chatNicknameHint => 'Digite seu apelido neste grupo';

  @override
  String get contactAddPhoneHint => 'Digite o número de telefone';

  @override
  String get contactNotesHint => 'Adicione notas sobre este contato';

  @override
  String get reportTitle => 'Relatório';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Assédio';

  @override
  String get reportReasonFraud => 'Fraude';

  @override
  String get reportReasonOther => 'Outro';

  @override
  String get reportSubmitted => 'Relatório enviado';

  @override
  String get reportDescription => 'Descrição adicional (opcional)';

  @override
  String get qrcodeSaved => 'Código QR salvo no álbum';

  @override
  String get chatSendRedPacketInChat =>
      'Por favor, envie pacote vermelho no chat';

  @override
  String get commonSaveFailed => 'Falha ao salvar';

  @override
  String get reportSelectReason => 'Selecione um motivo';

  @override
  String get reportUnavailable => 'Entre na conta para enviar uma denúncia.';

  @override
  String get reportAccountChanged =>
      'A conta foi alterada. Abra esta denúncia novamente para enviá-la.';

  @override
  String get reportUnsupported =>
      'Este servidor de origem não oferece suporte a denúncias de utilizadores.';

  @override
  String get reportRoomUnsupported =>
      'Este servidor de origem não oferece suporte a denúncias de salas.';

  @override
  String get reportRateLimited => 'Muitas denúncias. Tente de novo mais tarde.';

  @override
  String get reportCouldNotSend =>
      'Não foi possível enviar a denúncia. Tente de novo.';

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
  String get gameBlockDrop => 'Queda de bloco';

  @override
  String get gameBlockDropDesc => 'Solte e elimine linhas';

  @override
  String get gameMinesweeper => 'Campo Minado';

  @override
  String get gameMinesweeperDesc => 'Encontre todas as células seguras';

  @override
  String get gameMatch3 => 'Correspondência 3';

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
  String get storyMyStory => 'Minha história';

  @override
  String get storageSmartCleanup => 'Limpeza Inteligente';

  @override
  String get storageOldMediaFiles => 'Arquivos de mídia antigos';

  @override
  String get storageLargeFiles => 'Arquivos grandes';

  @override
  String get storageAppCache => 'Cache de aplicativos';

  @override
  String get storageSettings => 'Configurações de armazenamento';

  @override
  String get storageAutoCleanup => 'Limpeza automática';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Limpe automaticamente arquivos anteriores a $days dias';
  }

  @override
  String get storageCleanupPeriod => 'Período de limpeza';

  @override
  String get storagePreserveThumbnails => 'Preservar miniaturas';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Mantenha miniaturas de imagens durante a limpeza';

  @override
  String get storageWarningHigh =>
      'O uso de armazenamento é alto. Considere limpar arquivos antigos.';

  @override
  String get storageWarningCritical =>
      'O armazenamento está criticamente baixo. Limpe para liberar espaço.';

  @override
  String storageFreed(String size, int count) {
    return '$size liberado (arquivos $count)';
  }

  @override
  String storageDays(int days) {
    return '$days dias';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Ver todos os quartos $count';
  }

  @override
  String get storageNoFiles => 'Nenhum arquivo encontrado';

  @override
  String get storageFilePinned => 'Fixado';

  @override
  String storageDeleteSelected(int count) {
    return 'Excluir arquivos selecionados $count? Eles podem ser baixados novamente do servidor.';
  }

  @override
  String get backupRestore => 'Backup e restauração';

  @override
  String get backupCreate => 'Criar backup';

  @override
  String get backupCreateDesc =>
      'Faça backup de suas configurações e chaves de criptografia. As mensagens serão restauradas do servidor após o novo login.';

  @override
  String get backupIncludeKeys => 'Incluir chaves de criptografia';

  @override
  String get backupIncludeKeysDesc =>
      'Necessário para ler mensagens criptografadas';

  @override
  String get backupPasswordProtect => 'Proteger por senha';

  @override
  String get backupEnterPassword => 'Digite a senha de backup';

  @override
  String get backupHistory => 'Histórico de backup';

  @override
  String get backupNoBackups => 'Ainda não há backups';

  @override
  String get backupRestore2 => 'Restaurar';

  @override
  String get backupDelete => 'Excluir';

  @override
  String get backupDeleteConfirm =>
      'Tem certeza de que deseja excluir este backup? Isto não pode ser desfeito.';

  @override
  String get backupRestoreFromFile => 'Restaurar do arquivo';

  @override
  String get backupRestoreFromFileDesc =>
      'Importe um arquivo .n42backup de outro dispositivo ou backup anterior.';

  @override
  String get backupChooseFile => 'Escolha o arquivo de backup';

  @override
  String get backupRestoring => 'Restaurando...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Backup criado: salas $rooms, mensagens $messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Configurações $settings restauradas das salas $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Falha no backup: $error';
  }

  @override
  String get backupPasswordRequired => 'Este backup é protegido por senha';

  @override
  String get blocGroupNotFound => 'Grupo não encontrado';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Membro(s) $count convidado(s)';
  }

  @override
  String get blocGroupMemberRemoved => 'Membro removido';

  @override
  String get blocGroupAdminRemoved => 'Administrador removido';

  @override
  String get blocGroupLeft => 'Saiu do grupo';

  @override
  String get blocGroupDisbanded => 'Grupo dissolvido';

  @override
  String get blocGroupJoined => 'Entrou no grupo';

  @override
  String get blocGroupInviteDeclined => 'Convite recusado';

  @override
  String get blocGroupTokenGateUpdated => 'Portão de token atualizado';

  @override
  String get blocTransferProcessing => 'Processando transferência...';

  @override
  String get blocTransferCancelled => 'Transferência cancelada';

  @override
  String get blocTransferFailed => 'Falha na transferência';

  @override
  String get blocPaymentProcessing => 'Processando pagamento...';

  @override
  String get blocPaymentFailed => 'Falha no pagamento';

  @override
  String get groupMaxMembers => 'Limite de membros';

  @override
  String get groupMaxMembersUnlimited => 'Ilimitado';

  @override
  String get groupMaxMembersHint =>
      'Insira o limite (deixe em branco para ilimitado)';

  @override
  String get groupMaxMembersUpdated => 'Limite de membros atualizado';

  @override
  String get groupFull => 'O grupo está lotado';

  @override
  String get groupChannels => 'Canais de tópico';

  @override
  String get groupChannelsEmpty => 'Ainda não há canais';

  @override
  String get groupChannelsCount => 'canais';

  @override
  String get groupChannelCreate => 'Novo canal';

  @override
  String get groupChannelName => 'Nome do canal';

  @override
  String get groupChannelTopic => 'Tópico do canal (opcional)';

  @override
  String get groupChannelDelete => 'Excluir canal';

  @override
  String get groupChannelDeleteConfirm =>
      'Excluir este canal? Todas as mensagens serão perdidas.';

  @override
  String get groupBotSettings => 'Configurações do bot';

  @override
  String get groupBotEnabled => 'Habilitar bot';

  @override
  String get groupBotWelcomeMessage => 'Modelo de mensagem de boas-vindas';

  @override
  String get groupBotWelcomeHint =>
      'Use \'nome\' como espaço reservado para o nome do novo membro';

  @override
  String get groupBotConfigUpdated => 'Configurações do bot atualizadas';

  @override
  String get groupContentFilter => 'Filtro de conteúdo';

  @override
  String get groupContentFilterEnabled => 'Ativar filtro de palavras-chave';

  @override
  String get groupContentFilterReplace => 'Substitua por ***';

  @override
  String get groupContentFilterHide => 'Ocultar mensagem';

  @override
  String get groupContentFilterAddWord => 'Adicionar palavra-chave';

  @override
  String get groupContentFilterUpdated => 'Filtro de conteúdo atualizado';

  @override
  String get chatSlashCommands => 'Comandos';

  @override
  String get chatCommandPoll => '/poll — Crie uma enquete';

  @override
  String get chatCommandAnnounce => '/anunciar — Enviar anúncio';

  @override
  String get chatCommandWelcome => '/welcome — Definir mensagem de boas-vindas';

  @override
  String get chatReportMessage => 'Relatório';

  @override
  String get chatReportReason => 'Motivo do relatório';

  @override
  String get chatReportSpam => 'Spam';

  @override
  String get chatReportHarassment => 'Assédio';

  @override
  String get chatReportInappropriate => 'Conteúdo impróprio';

  @override
  String get chatReportOther => 'Outro';

  @override
  String get chatReportSuccess => 'Relatório enviado';

  @override
  String get spacesName => 'Nome da comunidade';

  @override
  String get spacesNameHint => 'por exemplo Comerciantes de criptografia';

  @override
  String get spacesNameRequired => 'O nome é obrigatório';

  @override
  String get spacesDescription => 'Descrição';

  @override
  String get spacesDescriptionHint => 'Do que se trata esta comunidade?';

  @override
  String get spacesType => 'Tipo de comunidade';

  @override
  String get spacesPublicDesc => 'Qualquer pessoa pode descobrir e participar';

  @override
  String get spacesPrivateDesc => 'Somente membros convidados podem participar';

  @override
  String get spacesNotFound => 'Comunidade não encontrada';

  @override
  String get spacesSearch => 'Pesquisar comunidades...';

  @override
  String get spacesMembers => 'Membros';

  @override
  String get spacesNoChannels => 'Ainda não há canais';

  @override
  String get spacesLeave => 'Sair da comunidade';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Tem certeza de que deseja sair de \"$name\"?';
  }

  @override
  String get spacesDelete => 'Excluir comunidade';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Isso excluirá permanentemente \"$name\" e todos os seus canais. Esta ação não pode ser desfeita.';
  }

  @override
  String get spacesCreateChannel => 'Adicionar canal';

  @override
  String get spacesChannelName => 'Nome do canal';

  @override
  String get spacesChannelTopic => 'Tópico (opcional)';

  @override
  String get spacesDeleteChannel => 'Excluir canal';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Tem certeza de que deseja excluir \"#$name\"?';
  }

  @override
  String get spacesEditName => 'Editar nome';

  @override
  String get spacesEditDescription => 'Editar descrição';

  @override
  String spacesViewAllMembers(int count) {
    return 'Ver todos os membros do $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Chute $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Banimento $name';
  }

  @override
  String get spacesPromoteAdmin => 'Promover a administrador';

  @override
  String get spacesDemoteAdmin => 'Remover administrador';

  @override
  String get spacesInviteMember => 'Convidar membro';

  @override
  String get spacesInviteMemberUserId =>
      'ID do usuário (por exemplo, @user:server.com)';

  @override
  String get spacesSave => 'Salvar';

  @override
  String get settingsScreenshotProtection => 'Proteção de captura de tela';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Impedir capturas de tela e gravação de tela';

  @override
  String get chatSelfDestructTimer => 'Autodestruição';

  @override
  String get chatTimerPickerTitle => 'Temporizador de autodestruição';

  @override
  String get chatTimerOff => 'Desligado';

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
  String get chatMiniApps => 'Aplicativos';

  @override
  String get miniAppMarketTitle => 'Miniaplicativos';

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
      'Este endereço de carteira ainda não possui conta N42. Você pode compartilhar seu link de convite do N42 com eles para começar.';

  @override
  String get web3ShareInvite => 'Partilhar convite';

  @override
  String get nftPickerTitle => 'Selecionar avatar NFT';

  @override
  String get nftPickerTabPopular => 'Populares';

  @override
  String get nftPickerTabCustom => 'Personalizado';

  @override
  String get nftPickerChain => 'Corrente';

  @override
  String get nftPickerContract => 'Endereço do contrato';

  @override
  String get nftPickerTokenId => 'ID do token';

  @override
  String get nftPickerVerifyOwnership =>
      'Verificar propriedade e pré-visualizar';

  @override
  String get nftPickerUseAsAvatar => 'Usar como avatar';

  @override
  String get nftPickerPreview => 'Visualização';

  @override
  String get nftPickerNotOwned => 'Você não possui este NFT';

  @override
  String get nftPickerInvalidTokenId => 'ID do token inválido';

  @override
  String get nftPickerEnterBoth =>
      'Insira o endereço do contrato e o ID do token';

  @override
  String get nftPickerInfoTitle => 'Avatar NFT — Verificado na chain';

  @override
  String get nftPickerInfoDesc =>
      'Vincule um NFT que você possui como seu avatar. Qualquer pessoa pode verificar a propriedade na rede. Exibido com um anel de ouro no N42.';

  @override
  String get nftPickerPopularCollections => 'Coleções populares';

  @override
  String get nftPickerWalletHint =>
      'Conecte sua carteira N42 para descobrir seus NFTs em mais de 236 cadeias.';

  @override
  String get profileBindNftAvatar => 'Vincular avatar NFT';

  @override
  String get profileChangeAvatar => 'Alterar avatar';

  @override
  String get groupTopics => 'Tópicos';

  @override
  String get groupTopicsEmpty => 'Ainda não há tópicos';

  @override
  String get syncInProgress => 'Sincronizando histórico de mensagens...';

  @override
  String get recoveryKeyReminderTitle => 'Proteja suas mensagens';

  @override
  String get recoveryKeyReminderDesc =>
      'Crie uma chave de recuperação para sincronizar com segurança mensagens criptografadas entre dispositivos';

  @override
  String get recoveryKeySetupNow => 'Configurar agora';

  @override
  String get recoveryKeyRemindLater => 'Lembre-me mais tarde';

  @override
  String get channelReadOnly =>
      'Somente administradores podem postar neste canal';

  @override
  String get channelSubscribers => 'assinantes';

  @override
  String get channelVerified => 'Canal verificado';

  @override
  String get redPacketHistory => 'História do Pacote Vermelho';

  @override
  String get redPacketSent => 'Enviado';

  @override
  String get redPacketReceived => 'Recebido';

  @override
  String get redPacketExpired => 'Expirado';

  @override
  String get redPacketClaimed => 'Reivindicado';

  @override
  String get redPacketInsufficientBalance => 'Saldo insuficiente';

  @override
  String selfDestructCountdown(String time) {
    return 'Autodestruição em $time';
  }

  @override
  String get messageDestroyed => 'Mensagem destruída';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Permissão negada: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'O que é taxa de gás?';

  @override
  String get aiSuggestionDefi => 'Guia para iniciantes em DeFi';

  @override
  String get aiSuggestionSecurity => 'Como verificar a segurança do contrato';

  @override
  String get aiSuggestionBridge => 'Ponte entre cadeias';

  @override
  String get channelDiscoverTitle => 'Descubra canais';

  @override
  String get channelDiscoverSearch => 'Pesquisar canais...';

  @override
  String get channelJoin => 'Junte-se';

  @override
  String get channelJoined => 'Ingressou';

  @override
  String get channelCategory => 'Categoria';

  @override
  String slowModeCooldown(int seconds) {
    return 'Modo lento: espere ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Copiar endereço';

  @override
  String get addressSendMessage => 'Enviar mensagem';

  @override
  String get addressViewProfile => 'Ver perfil';

  @override
  String get sendToAddress => 'Enviar para o endereço da carteira';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Falha ao enviar o código de verificação';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Este servidor não suporta redefinição de senha de e-mail';

  @override
  String get blocAuthResetPasswordFailed => 'Falha ao redefinir a senha';

  @override
  String get blocAuthChangePasswordFailed => 'Falha ao alterar a senha';

  @override
  String get blocAuthOldPasswordWrong => 'Senha atual incorreta';

  @override
  String get blocAuthLoginCancelled => 'Login cancelado';

  @override
  String get blocAuthGoogleLoginFailed => 'Falha no login do Google';

  @override
  String get blocAuthAppleLoginFailed => 'Falha no login da Apple';

  @override
  String get blocAuthSsoLoginFailed => 'Falha no login SSO';

  @override
  String get blocAuthFacebookLoginFailed => 'Falha no login do Facebook';

  @override
  String get blocAuthTwitterLoginFailed => 'Falha no login do Twitter';

  @override
  String get blocAuthWeChatLoginFailed => 'Falha no login do WeChat';

  @override
  String get blocAuthWeChatNotConfigured => 'Login do WeChat não configurado';

  @override
  String get blocAuthWeChatNotInstalled => 'Instale o WeChat primeiro';

  @override
  String get blocAuthPasswordWrong => 'Senha incorreta';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Este e-mail já está vinculado a outra conta';

  @override
  String get blocAuthChangeEmailFailed => 'Falha ao alterar e-mail';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'O código de verificação está incorreto ou expirou';

  @override
  String get blocAuthSessionExpired => 'A sessão expirou, faça login novamente';

  @override
  String get blocAuthSessionIncomplete =>
      'Dados da sessão incompletos, faça login novamente';

  @override
  String get chatReadingMode => 'Modo de leitura';

  @override
  String get groupPoints => 'Pontos';

  @override
  String get settingsPrivacySecurity => 'Privacidade e segurança';

  @override
  String get settingsSystemAccounts => 'Sistema e contas';

  @override
  String get settingsNotificationPrivacy => 'Privacidade das notificações';

  @override
  String get settingsSenderOnly => 'Mostrar apenas o remetente';

  @override
  String get settingsHiddenNotification => 'Ocultar remetente e mensagem';

  @override
  String get settingsSmartFilter => 'Filtro inteligente';

  @override
  String get settingsEmailVerificationSent => 'E-mail de verificação enviado';

  @override
  String get settingsEmailLinkInstructions =>
      'Abra a ligação de verificação no seu e-mail, depois volte aqui e confirme.';

  @override
  String get settingsSendVerificationEmail => 'Enviar e-mail de verificação';

  @override
  String get chatLogoutKeyWarning =>
      'Faça uma cópia de segurança das chaves de encriptação antes de terminar sessão, ou poderá perder o acesso às mensagens encriptadas.';

  @override
  String get settingsBiometricUnavailable =>
      'A autenticação biométrica não está disponível. Verifique o registo e as permissões nas definições do dispositivo.';

  @override
  String get chatEncryptionNotReady =>
      'A ligação segura não está pronta. Mensagem não enviada. Verifique a ligação e a verificação dos dispositivos de ambas as contas e tente de novo.';

  @override
  String get contactRequestPending => 'A aguardar aceitação';

  @override
  String get chatFriendRequestPending =>
      'A amizade não foi confirmada. Verifique Contactos > Novos amigos antes de enviar mensagens.';

  @override
  String contactPhotoCount(int count) {
    return '$count fotos';
  }

  @override
  String get videoPublish => 'Publicar vídeo';

  @override
  String get videoGoLive => 'Iniciar transmissão ao vivo';

  @override
  String get videoSelect => 'Selecionar vídeo';

  @override
  String get videoLiveUnavailable =>
      'A transmissão ao vivo não está disponível';

  @override
  String get qrcodeAlbum => 'Álbum';

  @override
  String get settingsSwitchAccount => 'Mudar de conta';

  @override
  String get chatFilterUnread => 'Não lidas';

  @override
  String get chatFilterEmpty => 'Sem conversas neste filtro';

  @override
  String get accountAdd => 'Adicionar conta';

  @override
  String get accountCurrent => 'Conta atual';

  @override
  String get accountSwitching => 'A mudar de conta…';

  @override
  String get accountSwitchFailed =>
      'Não foi possível mudar de conta. Tenta novamente ou adiciona a conta para iniciar sessão de novo.';

  @override
  String get accountSessionsHint =>
      'Muda de conta aqui para manter separadas as mensagens e a sessão segura de cada conta.';

  @override
  String get accountNoSaved => 'Ainda não há contas guardadas';

  @override
  String get contactRequestSent => 'Pedido enviado';

  @override
  String get contactRequestsIncoming => 'Pedidos recebidos';

  @override
  String get contactRequestsOutgoing => 'Pedidos enviados';

  @override
  String get contactRequestHint =>
      'Podes conversar e ligar depois de o pedido ser aceite.';

  @override
  String get callReturnToCall => 'Voltar à chamada';

  @override
  String get chatMessageSending => 'A enviar';

  @override
  String get chatMessageSent => 'Enviada';

  @override
  String get chatMessageDelivered => 'Entregue';

  @override
  String get chatMessageRead => 'Lida';

  @override
  String get chatMessageFailed => 'Não enviada. Toca para tentar novamente.';

  @override
  String get chatMessageUnavailable =>
      'Mensagem indisponível neste dispositivo. Toca para ver as opções de recuperação.';

  @override
  String get contactStarredFriends => 'Contactos favoritos';

  @override
  String get chatRecipientKeysMissing =>
      'Este contacto não tem uma sessão encriptada disponível. Peça-lhe para iniciar sessão e abrir a aplicação e tente novamente. Para mudar de conta, use «Mudar de conta» em vez de terminar sessão.';

  @override
  String get chatSwitchForMessaging =>
      'Quer mudar de conta? Use «Mudar de conta» para manter as mensagens e sessões seguras. Terminar sessão revoga este dispositivo e pode impedir a leitura de mensagens encriptadas recebidas.';

  @override
  String get aiServiceUnavailable =>
      'Os resumos de IA estão indisponíveis. Tente novamente quando o acesso ao serviço for restabelecido.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Resumir $count mensagens recentes';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined participantes · $invited convidados';
  }

  @override
  String contactPendingCount(int count) {
    return '$count pedidos pendentes';
  }

  @override
  String get chatDraftLabel => 'Rascunho';

  @override
  String get contactIndexLabel => 'Índice de contactos';

  @override
  String get transferAssetUnavailable =>
      'O ativo de pagamento não está disponível';

  @override
  String get transferPaymentRequestUnavailable =>
      'O pedido de pagamento não está disponível';

  @override
  String get chatCatchUp => 'Colocar em dia';

  @override
  String get chatCatchUpMentions => 'Menções';

  @override
  String get chatCatchUpReplies => 'Respostas às minhas mensagens';

  @override
  String get chatCatchUpPinned => 'Mensagens fixadas';

  @override
  String get chatCatchUpScope =>
      'As menções e respostas usam as mensagens carregadas, inclusive as já lidas. Carregue mensagens mais antigas para encontrar respostas anteriores.';

  @override
  String get chatCatchUpLoadMore => 'Carregar mensagens mais antigas';

  @override
  String get chatActionPreview => 'Revisar sugestão de calendário';

  @override
  String get chatActionPrivacy =>
      'Somente o título e o horário abaixo serão partilhados com seu aplicação de calendário após a confirmação. Verifique o fuso horário. Sua conta de calendário pode sincronizar este evento.';

  @override
  String get chatActionTitle => 'Evento da conversa';

  @override
  String get chatActionSuggestion => 'Sugestão de calendário';

  @override
  String get chatUnreadAttention => 'Menções e respostas não lidas';

  @override
  String get chatScanAgain => 'Pesquisar novamente';

  @override
  String get chatUnreadScope =>
      'Examina o histórico do servidor até seu marcador de leitura. Abra uma conversa para lê-la; atualize para reconstruir os resultados.';

  @override
  String get chatScanIncomplete =>
      'Incompleto: histórico, desencriptação ou marcador de leitura indisponível. Tente de novo após a sincronização.';

  @override
  String get chatHistoryShare => 'Partilhar histórico selecionado';

  @override
  String get chatHistoryExplanation =>
      'Somente administradores. Selecione texto simples e uma conversa direta encriptada existente com um membro que tenha entrado no grupo. O partilha cria mensagens de auditoria visíveis no grupo.';

  @override
  String get chatHistoryEnable => 'Ativar partilha';

  @override
  String get chatHistoryDisable => 'Desativar partilha';

  @override
  String get chatHistoryPolicy => 'Política de partilha do histórico do grupo';

  @override
  String get chatHistoryPolicyDetail =>
      'Somente administradores podem partilhar. A ativação também restringe a visibilidade do histórico do grupo aos eventos posteriores à entrada. Defina abaixo os limites de mensagens de texto e confirme.';

  @override
  String get chatHistoryPolicySaved => 'Política guardada';

  @override
  String get chatHistoryRecipient => 'Conversa encriptada do destinatário';

  @override
  String get chatHistoryReview => 'Revisar mensagens selecionadas';

  @override
  String get chatHistoryMessages => 'mensagens';

  @override
  String get chatHistoryConfirmDetail =>
      'Antes de partilhar, confirme o destinatário, cada mensagem e seu horário. Um resultado de falha ou desconhecido pode já ter enviado conteúdo: verifique o resultado antes de continuar.';

  @override
  String get chatHistoryCompleted =>
      'Histórico selecionado enviado e auditoria do grupo confirmada';

  @override
  String get chatHistoryPending =>
      'Pendente: verifique o resultado e confirme novamente para continuar. Envios com resultado desconhecido nunca são repetidos.';

  @override
  String get chatHistoryReconcile => 'Verificar resultado do envio';

  @override
  String get chatHistoryFailed =>
      'Não foi possível concluir. Verifique o acesso de administrador, a política do grupo, a encriptação, a participação do destinatário e a seleção. Se o envio começou, verifique seu resultado.';

  @override
  String get chatDeviceActions => 'Ações no dispositivo';

  @override
  String get chatDeviceActionsReview =>
      'Após a confirmação, somente esta mensagem é fornecida às sugestões de ações do sistema no dispositivo. Escolha uma ação para abrir Calendário, Lembretes ou Mapas.';

  @override
  String get chatHistoryMaxMessages => 'Limite de mensagens (1–50)';

  @override
  String get chatHistoryMaxHours => 'Período do histórico em horas (1–720)';

  @override
  String get chatNotifyAll => 'Todas as mensagens';

  @override
  String get chatNotifyAllDescription =>
      'Notificar cada nova mensagem nesta conversa';

  @override
  String get chatNotifyMentions => 'Apenas menções';

  @override
  String get chatNotifyMentionsDescription =>
      'Notificar apenas quando houver uma menção a si ou for usado @room';

  @override
  String get chatNotifyMutedDescription =>
      'Desativar as notificações desta conversa em todos os dispositivos';

  @override
  String get scheduledMessagesTitle => 'Mensagens agendadas';

  @override
  String get scheduledMessagesEmpty => 'Ainda não há mensagens agendadas';

  @override
  String get scheduledMessagesHint =>
      'Mantenha premido Enviar, Fotografias, Ficheiros, um GIF ou um autocolante para agendar uma mensagem.';

  @override
  String get scheduledMessageCancelled => 'Mensagem agendada cancelada';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Criado em $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Entrega não confirmada';

  @override
  String get scheduledRecoveryCopy => 'Guardar cópia de recuperação';

  @override
  String get scheduledRecoveryCopyHint =>
      'Guardada neste dispositivo sem alterar nem enviar mensagens. A pré-visualização mostra até 8.000 caracteres.';

  @override
  String get scheduledRecoveryCopies => 'Cópias de recuperação';

  @override
  String get scheduledRecoveryReset => 'Repor fila danificada';

  @override
  String get scheduledRecoveryResetHint =>
      'Foi guardada uma cópia exata neste dispositivo. Repor todas as mensagens agendadas desta conta? Algumas podem já ter sido enviadas. As cópias e os anexos serão mantidos. Nada será reenviado.';

  @override
  String get scheduledRecoveryExportHint =>
      'Este ficheiro contém texto de rascunhos e dados da conta não encriptados. Os anexos não estão incluídos. Escolha um destino de confiança.';

  @override
  String get scheduledRecoveryImport => 'Importar cópia de recuperação';

  @override
  String get scheduledRecoveryImportHint =>
      'Guardar esta pré-visualização apenas como cópia de recuperação. Nenhuma mensagem será agendada ou enviada. Os anexos não estão incluídos. O autor do ficheiro não foi verificado.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Acrescente o texto ao rascunho atual para revisão. Nada será enviado. Anexos, menções e temporizadores não serão restaurados. Verifique se esta mensagem já foi entregue.';

  @override
  String get backupRecoverLegacyArchive => 'Recuperar histórico local anterior';

  @override
  String get backupLegacyArchiveWarning =>
      'O proprietário deste histórico não foi verificado. Copie apenas as suas salas para a conta abaixo. O original é mantido.';

  @override
  String get backupOlderFiles => 'Ficheiros de cópia anteriores';

  @override
  String get backupOlderFilesWarning =>
      'Estes ficheiros podem pertencer a outra conta. Selecione um ficheiro para verificar o conteúdo e o proprietário antes de restaurar.';

  @override
  String get stickerImportTitle => 'Importar pacote de autocolantes';

  @override
  String get stickerImportLinkHint =>
      'Ligação do pacote de autocolantes Matrix';

  @override
  String get stickerImportPreview => 'Pré-visualização';

  @override
  String get stickerImportUnavailable =>
      'Este pacote não está disponível ou não tem acesso.';

  @override
  String get stickerImportCopyNotice =>
      'Adicione uma cópia privada deste pacote. As imagens e os metadados não são encriptados ponto a ponto.';

  @override
  String get stickerImportFailed =>
      'Não foi possível adicionar este pacote. Tente novamente.';

  @override
  String get stickerImportAccountChanged =>
      'A conta mudou ou a sessão expirou. Volte a abrir a importação de autocolantes.';

  @override
  String get stickerPackSourceRoom => 'Conversa de origem';

  @override
  String get stickerPackImages => 'Imagens';

  @override
  String get stickerPublishNotice =>
      'Publique este pacote no grupo selecionado. As imagens e os metadados não têm encriptação ponto a ponto. Quem puder ler o estado do grupo poderá aceder-lhes.';

  @override
  String get stickerPublishFailed =>
      'A publicação não foi confirmada. Verifique o grupo antes de tentar novamente.';

  @override
  String get stickerPublishReceiptMissing =>
      'Publicado, mas a ligação não foi guardada. Partilhe-a ou copie-a antes de sair desta página.';

  @override
  String get stickerSubscribe => 'Subscrever atualizações';

  @override
  String get stickerSubscribeNotice =>
      'Receba futuras alterações dos administradores do pacote. As imagens e os metadados não têm encriptação ponto a ponto. Pode cancelar a subscrição mais tarde; isto não o faz aderir à conversa de origem.';

  @override
  String get stickerSubscriptions => 'Subscrições de autocolantes';

  @override
  String get stickerUnsubscribe => 'Cancelar subscrição';

  @override
  String get stickerSubscriptionsEmpty => 'Sem subscrições de autocolantes';

  @override
  String get chatAttachmentEvent => 'Evento';

  @override
  String get chatRecentMedia => 'Fotografias e vídeos recentes';

  @override
  String get chatRecentMediaLoadFailed =>
      'Não foi possível carregar os conteúdos recentes';

  @override
  String get chatRecentMediaPermission =>
      'É necessário acesso às fotografias para mostrar os conteúdos recentes';

  @override
  String get chatRecentMediaEmpty => 'Sem fotografias ou vídeos recentes';

  @override
  String get chatRecentPhoto => 'Fotografia recente';

  @override
  String get chatRecentVideo => 'Vídeo recente';

  @override
  String get chatAttachmentTip => 'Gorjeta';

  @override
  String get chatAttachmentWhiteboard => 'Quadro branco';

  @override
  String get chatAttachmentVideoNote => 'Mensagem de vídeo';

  @override
  String get chatAttachmentCode => 'Código';

  @override
  String get chatAttachmentShop => 'Loja';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Limite de seleção: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Hoje à noite ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Amanhã de manhã ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Deslocar para o fim';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Introduza uma mensagem antes de agendar';

  @override
  String get ui3SendCode => 'Enviar código';

  @override
  String get ui3CodeLanguage => 'Linguagem';

  @override
  String get ui3PasteCodeHere => 'Cole o código aqui';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Lembrete definido · $time';
  }

  @override
  String get ui3RedPacketCreateFailed =>
      'Não foi possível criar o envelope vermelho';

  @override
  String get ui3SendTip => 'Enviar gorjeta';

  @override
  String get ui3TokenLabel => 'Criptomoeda';

  @override
  String get ui3NoteOptional => 'Nota (opcional)';

  @override
  String ui3TipFailed(String error) {
    return 'Falha na gorjeta: $error';
  }

  @override
  String get ui3GiftNftTitle => 'Oferecer um NFT';

  @override
  String get ui3TokenId => 'ID do token';

  @override
  String ui3NftGiftFailed(String error) {
    return 'Falha ao oferecer o NFT: $error';
  }

  @override
  String get ui3AiAgentSubtitle => 'Descreva uma tarefa e abra a miniapp certa';

  @override
  String get ui3GiftNft => 'Oferecer NFT';

  @override
  String get ui3GiftNftSubtitle => 'Enviar um NFT a este contacto';

  @override
  String get ui3MiniAppUnavailable => 'A miniapp não está disponível';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'Não foi possível enviar $count item(ns) multimédia selecionado(s)';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Enviar fotos e vídeos num formato adequado ao chat';

  @override
  String get ui3OriginalImages => 'Imagens originais';

  @override
  String get ui3OriginalImagesSubtitle =>
      'Enviar fotos sem compressão como ficheiros';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename agendado para $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'A enviar imagem original: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Imagem original agendada: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Pagamento já enviado';

  @override
  String get ui3PaymentProcessing => 'O pagamento está a ser processado';

  @override
  String ui3ChainStatus(String status) {
    return 'Estado na cadeia: $status';
  }

  @override
  String get ui3NotChecked => 'Não verificado';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Confirmado: $confirmations / $required blocos';
  }

  @override
  String get ui3CopyTxHash => 'Copiar hash da transação';

  @override
  String get ui3VerifyAgain => 'Verificar novamente';

  @override
  String get ui3VerifyOnChain => 'Verificar na cadeia';

  @override
  String get ui3TransferMissingChainDetails =>
      'Esta transferência não inclui os detalhes exatos da cadeia e do ativo.';

  @override
  String get ui3ReceiptPending => 'Pendente na cadeia';

  @override
  String get ui3ReceiptConfirmed => 'Confirmado';

  @override
  String get ui3ReceiptFailed => 'Falhou na cadeia';

  @override
  String get ui3ReceiptMismatch => 'Os detalhes da transação não coincidem';

  @override
  String get ui3ReceiptUnsupported => 'Verificação na cadeia não suportada';

  @override
  String get ui3ReceiptUnavailable => 'Verificação indisponível';

  @override
  String get ui3OpenOrSave => 'Abrir / Guardar';

  @override
  String get ui3UnableToOpenFile => 'Não é possível abrir este ficheiro.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'Falha na reescrita com IA: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Partilhar mensagens com a IA?';

  @override
  String get ui3AiShareMessagesBody =>
      'Selecione as mensagens que a IA pode usar para esta resposta. Esta autorização de pedido único expira após dois minutos. Fechar a Resposta rápida cancela os resultados pendentes. Não permite pagamentos nem exportações.';

  @override
  String get ui3OtherParticipant => 'Outra pessoa';

  @override
  String get ui3ShareSelected => 'Partilhar selecionadas';

  @override
  String get ui3BotCommandError => 'Erro de comando';

  @override
  String get ui3BotUnknownCommand => 'Comando desconhecido';

  @override
  String get ui3BotTypeHelp =>
      'Escreva /help para ver os comandos disponíveis.';

  @override
  String get ui3FilesMediaLinks => 'Ficheiros, multimédia e ligações';

  @override
  String get ui3ChatStorage => 'Armazenamento do chat';

  @override
  String get ui3EncryptionKeysDevices => 'Chaves de encriptação e dispositivos';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'O serviço de encriptação ainda não está disponível';

  @override
  String get ui3ExportLoadingHistory =>
      'A carregar mais histórico do chat para exportação...';

  @override
  String get ui3ExportTxtDesc =>
      'Transcrição em texto simples para notas, cópia de segurança ou revisão de conformidade';

  @override
  String get ui3ExportCustomRange => 'Intervalo personalizado';

  @override
  String get ui3ExportStart => 'Início';

  @override
  String get ui3ExportEnd => 'Fim';

  @override
  String get ui3ExportSelectDate => 'Selecionar data';

  @override
  String get ui3FolderFilterUnreadOnly => 'Apenas não lidas';

  @override
  String get ui3FolderFilterMutedOnly => 'Apenas silenciadas';

  @override
  String get ui3FolderFilterNoDms => 'Sem mensagens diretas';

  @override
  String get ui3FolderFilterNoGroups => 'Sem grupos';

  @override
  String get ui3FolderFilterNoChannels => 'Sem canais';

  @override
  String get ui3FolderFilterAllChats => 'Todos os chats';

  @override
  String get ui3Create => 'Criar';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Eliminar a pasta \"$name\"?';
  }

  @override
  String get a11yDecreaseTextSize => 'Diminuir tamanho do texto';

  @override
  String get a11yIncreaseTextSize => 'Aumentar tamanho do texto';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes min de leitura';
  }

  @override
  String get ui3TipOnChain => 'Na cadeia ✓';

  @override
  String get ui3ViewSource => 'Ver código-fonte';

  @override
  String get a11yPreviousPage => 'Página anterior';

  @override
  String get a11yNextPage => 'Página seguinte';

  @override
  String get ui3OpenExternalLinkTitle => 'Abrir ligação externa?';

  @override
  String get ui3Open => 'Abrir';

  @override
  String get ui3UnableToOpenLink => 'Não é possível abrir esta ligação.';

  @override
  String get ui3ImageUnavailable => 'Imagem indisponível';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Carregar imagem de $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Tentar novamente a imagem de $host';
  }

  @override
  String get ui3TranslatedByN42 => 'Traduzido por N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Traduzido de $language por N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Limpar o quadro branco?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Todos os traços serão removidos para todos. Esta ação não pode ser anulada.';

  @override
  String get ui3WhiteboardLive => 'Quadro branco · Em direto';

  @override
  String get a11yPenColor => 'Cor da caneta';

  @override
  String get ui3AiDescribeOcr => 'Descrição por IA / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Não é possível pré-visualizar este documento com segurança. Verifique a ligação e o tamanho do ficheiro (máx. 2 MB).';

  @override
  String get ui3AiConsentMessage =>
      'Selecione as mensagens que a IA pode usar para este resumo. Esta autorização de pedido único expira após dois minutos. Não permite pagamentos nem exportações.';

  @override
  String get ui3AiSuggestedReplies => 'Respostas sugeridas';

  @override
  String get ui3AiGeneratingSuggestions => 'A gerar sugestões...';

  @override
  String get ui3StickersEmpty => 'Ainda não há autocolantes';

  @override
  String get ui3StickersGet => 'Obter autocolantes';

  @override
  String get a11yFormatBold => 'Negrito';

  @override
  String get a11yFormatItalic => 'Itálico';

  @override
  String get a11yFormatStrikethrough => 'Rasurado';

  @override
  String get a11yFormatInlineCode => 'Código em linha';

  @override
  String get a11yFormatCodeBlock => 'Bloco de código';

  @override
  String get a11yFormatChecklistItem => 'Item de lista de verificação';

  @override
  String get a11yFormatBulletList => 'Lista com marcadores';

  @override
  String get a11yFormatNumberedList => 'Lista numerada';

  @override
  String get a11yFormatLink => 'Ligação';

  @override
  String get a11yFormatTable => 'Tabela';

  @override
  String get a11yFormatMeetingTemplate => 'Modelo de reunião';

  @override
  String get a11yEmojiSmileys => 'Smileys e pessoas';

  @override
  String get a11yEmojiHearts => 'Corações';

  @override
  String get a11yEmojiAnimals => 'Animais e natureza';

  @override
  String get a11yEmojiFood => 'Comida e bebida';

  @override
  String get a11yEmojiTravel => 'Viagens e locais';

  @override
  String get a11yEmojiActivities => 'Atividades';

  @override
  String get a11yEmojiObjects => 'Objetos';

  @override
  String get a11yEmojiSymbols => 'Símbolos';

  @override
  String get ui3FrequentlyUsed => 'Usados frequentemente';

  @override
  String get ui3NoEditHistory => 'Sem histórico de edições';

  @override
  String get ui3EventNew => 'Novo evento';

  @override
  String get ui3EventTitleLabel => 'Título';

  @override
  String get ui3EventLocationOptional => 'Local (opcional)';

  @override
  String get ui3EventDescriptionOptional => 'Descrição (opcional)';

  @override
  String get ui3EventSend => 'Enviar evento';

  @override
  String get ui3EventTitleRequired => 'O título é obrigatório';

  @override
  String get ui3EventEndAfterStart =>
      'A hora de fim tem de ser posterior ao início';

  @override
  String get ui3MiniAppAgentIntro =>
      'Descreva o que pretende fazer e eu abro a mini app certa.';

  @override
  String get ui3MiniAppAgentExample => 'p. ex., trocar ETH por USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Nenhuma mini app correspondente. Tente reformular.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Abrir $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Suporta ligações de músicas do NetEase Cloud Music, QQ Music, Kugou, Kuwo e outros';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'Marque uma resposta correta não vazia';

  @override
  String get ui3PollQuizMode => 'Modo questionário';

  @override
  String get ui3PollAnswerExplanationHint =>
      'Explicação da resposta (opcional)';

  @override
  String get a11yCorrectAnswer => 'Resposta correta';

  @override
  String get ui3AiSuggestions => 'Sugestões de IA';

  @override
  String get a11yPaste => 'Colar';

  @override
  String get a11yRefresh => 'Atualizar';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Guarde esta chave em segurança. É a única forma de recuperar as suas mensagens encriptadas se perder o acesso a todos os dispositivos.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Guardado: $path';
  }

  @override
  String get ui3UnknownAccount => 'Conta desconhecida';

  @override
  String get ui3UnknownHomeserver => 'Servidor desconhecido';

  @override
  String get ui3ImportRecoveryKey => 'Importar chave de recuperação';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Introduza ou cole a sua chave de recuperação para restaurar as chaves das salas do histórico de mensagens encriptadas.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Conta: $account\\nServidor: $homeserver';
  }

  @override
  String get ui3Import => 'Importar';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Formato de chave de recuperação inválido';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '$restored de $total chaves restauradas. Falharam $failed chaves. Verifique a conta, a rede e a cópia de segurança e tente novamente. Parte do histórico pode continuar ilegível.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '$restored de $total chaves restauradas com êxito';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Falha na importação: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Falha ao registar a chave de acesso: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'A minha chave de acesso';

  @override
  String get ui3PasskeyNameHint => 'p. ex., iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Falha ao eliminar a chave de acesso';

  @override
  String get ui3TwoFactorAuth => 'Autenticação de dois fatores';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'Ativada — é necessário o código da app de autenticação';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Desativada — proteja com uma app de autenticação (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Mostrar chave de recuperação';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Mostre a sua chave de recuperação para cópia de segurança';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Restaurar mensagens com uma chave de recuperação';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Falha ao criar a chave de recuperação';

  @override
  String get ui3TotpIncorrectCode => 'Código incorreto, tente novamente';

  @override
  String get ui3TwoFactorEnabled => 'Autenticação de dois fatores ativada';

  @override
  String get ui3TwoFactorDisabled => 'Autenticação de dois fatores desativada';

  @override
  String get ui3TwoFactorTurnOffTitle =>
      'Desativar a autenticação de dois fatores?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'A app de autenticação deixará de ser necessária. Pode configurá-la novamente mais tarde com uma nova chave.';

  @override
  String get ui3TurnOff => 'Desativar';

  @override
  String get ui3TwoFactorTotpTitle => 'Dois fatores (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'A autenticação de dois fatores está ativada';

  @override
  String get ui3TwoFactorCodeRequired =>
      'É necessário um código da sua app de autenticação.';

  @override
  String get ui3TotpStepScan =>
      '1. Leia este código QR com uma app de autenticação (Google Authenticator, Authy, 1Password…) ou introduza a chave manualmente.';

  @override
  String get ui3TotpKeyCopied => 'Chave copiada';

  @override
  String get ui3TotpStepConfirm =>
      '2. Introduza o código de 6 dígitos para confirmar.';

  @override
  String get ui3Enable => 'Ativar';

  @override
  String get ui3BackupSettingsDesc =>
      'Faça uma cópia de segurança das definições de chat locais. As mensagens serão restauradas a partir do servidor depois de voltar a iniciar sessão.';

  @override
  String get ui3BackupKeysSeparate =>
      'As chaves de encriptação são geridas separadamente';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Use Segurança > Chave de recuperação para fazer cópia de segurança do acesso às mensagens encriptadas.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms salas  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Importe um ficheiro .n42backup de outro dispositivo ou de uma cópia anterior. As chaves de encriptação são restauradas separadamente com a sua chave de recuperação.';

  @override
  String get ui3UsernameSessionRequired =>
      'O nome de utilizador requer uma sessão ativa';

  @override
  String get ui3SecuritySessionRequired =>
      'As definições de segurança requerem uma sessão ativa';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'As contas associadas requerem uma sessão ativa';

  @override
  String get ui3SystemAccounts => 'Sistema e contas';

  @override
  String get ui3AccountIdentity => 'Conta e identidade';

  @override
  String get ui3Accounts => 'Contas';

  @override
  String get ui3DevicesSessions => 'Dispositivos e sessões';

  @override
  String get ui3Integrations => 'Integrações';

  @override
  String get ui3ConnectedAccounts => 'Contas associadas';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Integrações com Telegram, WhatsApp, Discord e pontes de API';

  @override
  String get ui3SystemOverview => 'Visão geral do sistema';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas',
      one: '1 conta',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dispositivos',
      one: '1 dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Encriptação ponto a ponto, proteção contra capturas de ecrã e controlo de proxy';

  @override
  String get ui3ConversationPrivacy => 'Privacidade das conversas';

  @override
  String get ui3NetworkPrivacy => 'Privacidade da rede';

  @override
  String get ui3IdentityPrivacy => 'Privacidade da identidade';

  @override
  String get ui3EncryptionKeyBackup =>
      'Encriptação e cópia de segurança de chaves';

  @override
  String get ui3DevicesVerification => 'Dispositivos e verificação';

  @override
  String get ui3ChipE2eeDefault => 'E2EE por predefinição';

  @override
  String get ui3ChipManualE2ee => 'E2EE manual';

  @override
  String get ui3ChipSelfDestruct => 'Autodestruição';

  @override
  String get ui3ChipScreenshotGuard => 'Proteção de capturas';

  @override
  String get ui3ChipIpProxy => 'IP / servidor proxy';

  @override
  String get ui3ChipLinkPreviewsOff =>
      'Pré-visualizações de ligações desativadas';

  @override
  String get ui3ChipPublicHandle => 'Nome de utilizador público';

  @override
  String get a11yShowPassword => 'Mostrar palavra-passe';

  @override
  String get a11yHidePassword => 'Ocultar palavra-passe';

  @override
  String get a11yCheckServer => 'Verificar servidor';

  @override
  String get ui3AuthAnonymousRegistration => 'Registo anónimo';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Crie uma conta sem associar telemóvel ou e-mail. Será gerado automaticamente um nome de utilizador.';

  @override
  String get ui3AuthAnonymousModeOn => 'O modo anónimo está ativado';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'A app vai criar um nome de utilizador Matrix aleatório para si. Poderá iniciar sessão mais tarde com a conta e a palavra-passe geradas.';

  @override
  String get ui3AuthChooseLoginMethod => 'Escolher método de início de sessão';

  @override
  String get ui3AuthSsoOpenFailed =>
      'Não foi possível abrir a página de início de sessão SSO';

  @override
  String get ui3AuthWalletUnavailable => 'A carteira não está disponível';

  @override
  String get ui3ProfileSubscriptions => 'Subscrições';

  @override
  String get ui3ProfileBuySellCrypto => 'Comprar / vender cripto';

  @override
  String get ui3ProfileOnDeviceAi => 'IA no dispositivo';

  @override
  String get ui3ProfileSetAUsername => 'Definir um nome de utilizador';

  @override
  String get ui3ProfileAvatarStudio => 'Estúdio de avatar';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'Avatar NFT / Decorações';

  @override
  String get ui3ProfileCustomize => 'Personalizar';

  @override
  String get ui3ProfileQrSubtitle =>
      'Leia o código para abrir este perfil ou iniciar uma conversa';

  @override
  String get ui3PrivacyHardening => 'Reforço da privacidade';

  @override
  String get ui3HidePhoneNumber => 'Ocultar número de telemóvel';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Ocultar o número de telemóvel associado nos ecrãs de perfil deste dispositivo';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'Encriptar novas conversas por predefinição';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Iniciar novas conversas diretas e salas privadas com E2EE ativada';

  @override
  String get ui3PrivateChatMode => 'Modo de conversa privada';

  @override
  String get ui3PrivateChatModeDesc =>
      'Bloquear temporariamente capturas de ecrã ao ver conversas privadas ou encriptadas';

  @override
  String get ui3DefaultSelfDestructTimer =>
      'Temporizador de autodestruição predefinido';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Aplicar um temporizador de autodestruição predefinido às novas mensagens enviadas';

  @override
  String get ui3LinkPreviews => 'Pré-visualizações de ligações';

  @override
  String get ui3LinkPreviewsDesc =>
      'Obter títulos, descrições e miniaturas quando as mensagens contêm URL';

  @override
  String get ui3IpAddressProtection => 'Proteção do endereço IP';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Encaminhar os pedidos Matrix e de pré-visualização através do proxy HTTP de privacidade configurado, quando disponível';

  @override
  String get ui3UseTorProxy => 'Usar proxy HTTP Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Use um endpoint de proxy HTTP local, como o Privoxy em 127.0.0.1:8118. O encaminhamento Tor nativo por SOCKS5 não é suportado aqui.';

  @override
  String get ui3CustomProxy => 'Proxy personalizado';

  @override
  String get ui3CustomProxyDesc =>
      'Usar um proxy HTTP ou HTTPS personalizado para o tráfego Matrix e as pré-visualizações de ligações';

  @override
  String get ui3ProxyEndpoint => 'Endereço do proxy';

  @override
  String get ui3ProxyEndpointDesc =>
      'Endereço de proxy HTTP/HTTPS (SOCKS não suportado)';

  @override
  String get ui3InvalidEndpoint => 'Endereço inválido';

  @override
  String get ui3CustomProxyStaysOff =>
      'O proxy personalizado permanece desativado até definir um endereço válido';

  @override
  String get ui3NotificationFilterNote =>
      'As regras prioritárias notificam sempre (ignorando silêncio, só menções e Não incomodar). As palavras-chave silenciadas suprimem as notificações.';

  @override
  String get ui3PriorityKeywords => 'Palavras-chave prioritárias';

  @override
  String get ui3PriorityKeywordHint => 'p. ex., urgente';

  @override
  String get ui3MutedKeywords => 'Palavras-chave silenciadas';

  @override
  String get ui3MutedKeywordHint => 'p. ex., spam';

  @override
  String get ui3PrioritySenders => 'Remetentes prioritários';

  @override
  String get ui3CaseSensitive => 'Distinguir maiúsculas e minúsculas';

  @override
  String get ui3None => 'Nenhuma';

  @override
  String get ui3SmartReplyTranslation => 'Tradução de respostas inteligentes';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Traduzir automaticamente as suas mensagens para o idioma do destinatário antes de enviar.';

  @override
  String get ui3FromPhotos => 'Das Fotografias';

  @override
  String get ui3ChangePhoto => 'Alterar fotografia';

  @override
  String get ui3RoamingUsesMobileData =>
      'O roaming usa as regras de dados móveis';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'A deteção de roaming ainda não está disponível, pelo que o roaming segue atualmente as definições de transferência automática dos dados móveis.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Eliminar \"$content\"?';
  }

  @override
  String get ui3ResetToDefaults => 'Repor predefinições';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Isto irá remover todas as respostas rápidas personalizadas e repor as predefinidas. Continuar?';

  @override
  String get ui3LocalLlmUnavailable => 'Não suportado neste dispositivo';

  @override
  String get ui3LocalLlmNotDownloaded => 'Modelo não transferido';

  @override
  String get ui3LocalLlmReady => 'Pronto (no dispositivo)';

  @override
  String get ui3LocalLlmDescription =>
      'Quando ativadas e prontas, as funcionalidades de IA (resumir, reescrever, traduzir, responder) são executadas totalmente no dispositivo — os dados nunca saem do seu telemóvel. Caso contrário, usam o fornecedor na nuvem.';

  @override
  String get ui3UseOnDeviceAi => 'Usar IA no dispositivo';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'Preferir inferência local quando estiver pronta';

  @override
  String get ui3DownloadModel => 'Transferir modelo';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'A inferência no dispositivo requer o runtime nativo (Android MediaPipe / iOS Core ML). Será ativada automaticamente assim que o handler da plataforma estiver disponível.';

  @override
  String get ui3PhotoAvatar => 'Avatar de fotografia';

  @override
  String get ui3AvatarStyles => 'Estilos de avatar';

  @override
  String get ui3AvatarStylesDesc =>
      'Usar um único seletor de decorações para o perfil e os pontos de acesso ao avatar.';

  @override
  String get ui3ReplaceNftAvatar => 'Substituir avatar NFT';

  @override
  String get ui3NftAvatarDesc => 'Use um colecionável on-chain como avatar.';

  @override
  String get ui3UsePhotoAvatar => 'Usar avatar de fotografia';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Manter o avatar carregado e remover a associação ao NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Estilo de avatar definido para: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'Avatar NFT atualizado';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Voltou ao avatar de fotografia';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Inicie sessão para ver o histórico de envelopes vermelhos';

  @override
  String get ui3RedPacketActive => 'Ativos';

  @override
  String get ui3RedPacketCompleted => 'Concluídos';

  @override
  String get ui3CardsAndPasses => 'Cartões e passes';

  @override
  String get ui3CardsAndPassesDesc =>
      'Os cartões da carteira, cupões e passes são geridos na app principal.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'O pacote de cartões requer a app principal';

  @override
  String get ui3OpenCardPack => 'Abrir pacote de cartões';

  @override
  String get ui3UnableToOpenChat =>
      'Não é possível abrir uma conversa com este contacto';

  @override
  String get ui3WalletManagedInMainApp =>
      'A carteira é gerida na app principal';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Planos';
  }

  @override
  String get ui3NewPlan => 'Novo plano';

  @override
  String get ui3MySubscriptions => 'As minhas subscrições';

  @override
  String get ui3AvailablePlans => 'Planos disponíveis';

  @override
  String get ui3NoPlansYet =>
      'Ainda sem planos · toque em \"Novo plano\" para criar um';

  @override
  String ui3DaysLeft(Object days) {
    return 'Faltam $days d';
  }

  @override
  String get ui3SubscriptionCancelled => 'Cancelada';

  @override
  String get ui3AutoRenewOn => 'Renovação automática: ativada';

  @override
  String get ui3AutoRenewOff => 'Renovação automática: desativada';

  @override
  String get ui3CancelSubscriptionTitle => 'Cancelar subscrição?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'A sua subscrição de $name mantém-se ativa até expirar e não será renovada.';
  }

  @override
  String get ui3Subscribe => 'Subscrever';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Subscreveu $name';
  }

  @override
  String get ui3PlanPriceLabel => 'Preço (ex.: 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Descrição (opcional)';

  @override
  String get ui3PlanBenefitsLabel => 'Benefícios (separados por vírgulas)';

  @override
  String get ui3PlanPeriod => 'Período:';

  @override
  String get ui3Monthly => 'Mensal';

  @override
  String get ui3Yearly => 'Anual';

  @override
  String get ui3SaveRemarkFailed => 'Falha ao guardar a nota';

  @override
  String get ui3CopyLink => 'Copiar ligação';

  @override
  String get ui3Connect => 'Ligar';

  @override
  String get ui3CommonTokens => 'Tokens em comum';

  @override
  String get ui3SharedNfts => 'NFT em comum';

  @override
  String get ui3TransactionHistory => 'Histórico de transações';

  @override
  String get ui3CommonDaos => 'DAO em comum';

  @override
  String get ui3SameChains => 'Mesmas cadeias';

  @override
  String get ui3ChatInitFailed => 'Falha ao iniciar o chat';

  @override
  String get ui3CheckNetworkRetry =>
      'Verifique a sua ligação de rede e tente novamente';

  @override
  String get ui3FromContacts => 'A partir dos contactos';

  @override
  String get ui3FindFriendsFromContacts =>
      'Encontre amigos nos contactos do telemóvel';

  @override
  String get ui3EnsOrDomain => 'ENS / Domínio';

  @override
  String get ui3LoadingContacts => 'A carregar contactos...';

  @override
  String get ui3ContactsPermissionRequired =>
      'É necessária permissão de contactos';

  @override
  String get ui3ContactsPermissionMessage =>
      'Para encontrar amigos nos seus contactos, permita o acesso aos contactos.';

  @override
  String get ui3AllowAccess => 'Permitir acesso';

  @override
  String get ui3NoContactMatches => 'Nenhuma correspondência encontrada';

  @override
  String get ui3NoContactMatchesMessage =>
      'Nenhum dos seus contactos usa esta app ainda. Convide-os a aderir!';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count contactos analisados';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'Encontradas $count correspondências nos seus contactos';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'Nos contactos: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Eliminar esta foto?';

  @override
  String get ui3InviteLink => 'Ligação de convite';

  @override
  String get ui3ShareJoinLink => 'Partilhar uma ligação para entrar nesta sala';

  @override
  String get ui3ShareRoomReference =>
      'Partilhar uma referência da sala com membros convidados';

  @override
  String get ui3ScanToJoinGroup =>
      'Leia o código para entrar diretamente neste grupo';

  @override
  String get ui3ScanToShareRoomReference =>
      'Leia o código para partilhar a referência desta sala com membros convidados';

  @override
  String get ui3InviteLinkLoadFailed =>
      'Falha ao carregar a ligação de convite';

  @override
  String get ui3InviteLinkCopied => 'Ligação de convite copiada';

  @override
  String get ui3ChannelCategoryOptional => 'Categoria (opcional)';

  @override
  String get ui3ChannelCategoryHint => 'Anúncios / Produto / Suporte';

  @override
  String get ui3DescriptionOptional => 'Descrição (opcional)';

  @override
  String get ui3WebhookEnable => 'Ativar automatização por webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'Envia eventos de entrada de membros e boas-vindas para o seu endpoint de integração.';

  @override
  String get ui3WebhookUrl => 'URL do webhook';

  @override
  String get ui3WebhookSecretOptional => 'Segredo de assinatura (opcional)';

  @override
  String get ui3WebhookSecretHint => 'Usado para X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => 'Notificar quando um membro entra';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'Notificar quando as boas-vindas são enviadas';

  @override
  String get ui3WebhookTestSend => 'Enviar webhook de teste';

  @override
  String get ui3WebhookTestSending => 'A enviar webhook de teste...';

  @override
  String get ui3WebhookTestSent => 'Webhook de teste enviado com sucesso';

  @override
  String get ui3WebhookTestFailed => 'Falha ao enviar o webhook de teste';

  @override
  String get ui3WebhookUrlInvalid =>
      'O URL do webhook tem de ser um endereço HTTPS público';

  @override
  String get ui3WebhookSelectEvent =>
      'Selecione pelo menos um evento de webhook';

  @override
  String get ui3SensitiveDataDetection => 'Deteção de dados sensíveis';

  @override
  String get ui3Email => 'E-mail';

  @override
  String get ui3CreditCard => 'Cartão de crédito';

  @override
  String get ui3DetectEmailDesc =>
      'Detetar endereços de e-mail em mensagens de texto';

  @override
  String get ui3DetectPhoneDesc =>
      'Detetar números de telefone e internacionais';

  @override
  String get ui3DetectCardDesc =>
      'Detetar prováveis números bancários e de cartão';

  @override
  String get ui3DetectWalletDesc =>
      'Detetar endereços de carteira ao estilo Ethereum';

  @override
  String get ui3GeneralTopic => 'Geral';

  @override
  String get a11yPreviousResult => 'Resultado anterior';

  @override
  String get a11yNextResult => 'Resultado seguinte';

  @override
  String get ui3TryDifferentKeywords => 'Experimente outras palavras-chave';

  @override
  String ui3FiltersActive(Object count) {
    return 'Filtros ativos: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Filtros de mensagens ativos: $count';
  }

  @override
  String get ui3LoadMore => 'Carregar mais';

  @override
  String get ui3MessageFilters => 'Filtros de mensagens';

  @override
  String get ui3SenderUserId => 'ID de utilizador do remetente';

  @override
  String get ui3FilterType => 'Tipo';

  @override
  String get ui3FilterAny => 'Qualquer';

  @override
  String get ui3FilterImage => 'Imagem';

  @override
  String get ui3FilterTime => 'Data';

  @override
  String get ui3AnyTime => 'Qualquer data';

  @override
  String get ui3OnlyMyMessages => 'Apenas as minhas mensagens';

  @override
  String get ui3MediaOnly => 'Apenas multimédia';

  @override
  String get ui3Apply => 'Aplicar';

  @override
  String get ui3QrStyleClassic => 'Clássico';

  @override
  String get ui3QrStyleOcean => 'Oceano';

  @override
  String get ui3QrStyleBerry => 'Baga';

  @override
  String get a11yFlashlightOn => 'Ligar lanterna';

  @override
  String get a11yFlashlightOff => 'Desligar lanterna';

  @override
  String get ui3SocialGraph => 'Grafo social';

  @override
  String get ui3RecommendedConnections => 'Ligações recomendadas';

  @override
  String get ui3Portfolio => 'Carteira';

  @override
  String get ui3Chains => 'Cadeias';

  @override
  String get ui3Tokens => 'Tokens digitais';

  @override
  String get ui3NoConnectionsFound => 'Nenhuma ligação encontrada';

  @override
  String get ui3ConnectionsHint =>
      'As ligações surgem à medida que cria atividade on-chain';

  @override
  String get ui3SocialGraphLoadFailed => 'Falha ao carregar o grafo social';

  @override
  String get ui3Similarity => 'Semelhança';

  @override
  String get ui3Breakdown => 'Detalhe';

  @override
  String get ui3TokenHoldings => 'Tokens detidos';

  @override
  String get ui3NftCollections => 'Coleções NFT';

  @override
  String get ui3ChainUsage => 'Utilização de redes';

  @override
  String get ui3Transactions => 'Transações';

  @override
  String get ui3DaoMembership => 'Adesão a DAO';

  @override
  String get ui3NotWeighted => 'Sem ponderação';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (peso: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Atividade on-chain em comum';

  @override
  String get ui3SharedTokens => 'Tokens em comum';

  @override
  String get ui3SharedNftCollections => 'Coleções NFT em comum';

  @override
  String get ui3SharedChains => 'Redes em comum';

  @override
  String get ui3NoSharedTokens => 'Nenhum token em comum encontrado';

  @override
  String get ui3NoSharedNftCollections =>
      'Nenhuma coleção NFT em comum encontrada';

  @override
  String get ui3NoSharedChains => 'Nenhuma rede em comum encontrada';

  @override
  String get ui3SimilarityFailed => 'Não foi possível calcular a semelhança';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +$count outros';
  }

  @override
  String get a11yGovernance => 'Governação';

  @override
  String get ui3CommunityLink => 'Link da comunidade';

  @override
  String get ui3CommunityQrCode => 'Código QR da comunidade';

  @override
  String get ui3CommunityQrSubtitle =>
      'Leia para aderir a esta comunidade e explorar os seus canais';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Não foi possível carregar o link da comunidade';

  @override
  String get ui3CommunityLinkCopied => 'Link da comunidade copiado';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name será removido desta comunidade.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name será removido e não poderá voltar a aderir.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Inicie sessão para descobrir canais públicos';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Não foi possível aderir a $name: $error';
  }

  @override
  String get ui3CategoryTech => 'Tecnologia';

  @override
  String get ui3CategorySocial => 'Redes sociais';

  @override
  String get ui3NoPublicChannels => 'Nenhum canal público encontrado';

  @override
  String get ui3StoriesAndFun => 'Histórias e diversão';

  @override
  String get ui3SearchMusicHint => 'Pesquisar músicas, artistas ou amigos';

  @override
  String get ui3ForYou => 'Para si';

  @override
  String get ui3Liked => 'Gostos';

  @override
  String get ui3NoLikedMusic => 'Ainda não há músicas com gosto';

  @override
  String get ui3NoMusicStories => 'Ainda não há histórias com música';

  @override
  String get ui3LikedMusicHint =>
      'Toque no coração junto a uma música para a guardar aqui.';

  @override
  String get ui3MusicStoriesHint =>
      'A música partilhada em histórias aparecerá aqui.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · partilhado por $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Não é possível reproduzir $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'Faixa anterior';

  @override
  String get a11yNextTrack => 'Faixa seguinte';

  @override
  String get a11yPlay => 'Reproduzir';

  @override
  String get a11yPause => 'Pausa';

  @override
  String get ui3Refresh => 'Atualizar';

  @override
  String get ui3NearbyIntroTitle => 'Descubra publicações públicas por perto';

  @override
  String get ui3NearbyIntroBody =>
      'A sua localização é usada uma vez neste dispositivo para ordenar os Momentos públicos. Não é carregada, difundida nem mostrada a outras pessoas.';

  @override
  String get ui3UseMyLocation => 'Usar a minha localização';

  @override
  String get ui3NearbyUnavailable => 'Por perto não está disponível';

  @override
  String get ui3NoNearbyPosts => 'Ainda não há publicações por perto';

  @override
  String get ui3NoNearbyPostsHint =>
      'Os Momentos públicos com localização aparecerão aqui.';

  @override
  String get ui3NearbyDistanceNote =>
      'Distância aproximada · apenas publicações públicas com localização';

  @override
  String get ui3PublicLocationPost => 'Publicação pública com localização';

  @override
  String get ui3LocationServicesOff =>
      'Os serviços de localização estão desativados';

  @override
  String get ui3LocationPermissionDenied =>
      'A permissão de localização foi recusada';

  @override
  String get ui3EnableLocationInSettings =>
      'Ative a permissão de localização nas definições do sistema';

  @override
  String get ui3CreateStory => 'Criar história';

  @override
  String get ui3CreateStoryDesc => 'Publique um estado de texto ou foto.';

  @override
  String get ui3StoryCamera => 'Câmara de histórias';

  @override
  String get ui3StoryCameraDesc =>
      'Aceda diretamente aos filtros e à edição de fotos.';

  @override
  String get ui3MomentsDesc => 'Abra o feed completo e os comentários.';

  @override
  String get ui3MomentCamera => 'Câmara de Momentos';

  @override
  String get ui3MomentCameraDesc =>
      'Crie uma publicação e escolha multimédia de imediato.';

  @override
  String get ui3GamesDesc => 'Abra o centro de jogos casuais integrado.';

  @override
  String get ui3AvatarStudio => 'Estúdio de avatares';

  @override
  String get ui3AvatarStudioDesc =>
      'Decorações, avatar NFT e estilo de identidade.';

  @override
  String get ui3SocialGraphDesc => 'Seguimentos, fãs e ligações on-chain.';

  @override
  String get ui3SocialHubHeroTitle => 'Histórias, momentos, jogos e avatares';

  @override
  String get ui3SocialHubHeroBody =>
      'Todas as funcionalidades sociais num só lugar, em vez de espalhadas pelo chat, perfil e descobrir.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'O grafo social não está configurado nesta versão';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Ligue uma carteira para ver o seu grafo social';

  @override
  String get ui3AvatarStudioSignIn =>
      'O estúdio de avatares requer sessão iniciada';

  @override
  String get a11yRemoveImage => 'Remover imagem';

  @override
  String get a11yBack => 'Voltar';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Confirmar transação';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Uma mini app está a pedir para enviar uma transação em seu nome.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Abrir $name?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Abrir';

  @override
  String get ui3StoryReplySendFailed =>
      'Não foi possível enviar a resposta à história';

  @override
  String get ui3RedPacketDemoNotice =>
      'Envelope vermelho de demonstração — apenas um registo no chat, nenhum ativo on-chain real é transferido.';

  @override
  String get ui3RedPacketCoverClassic => 'Vermelho clássico';

  @override
  String get ui3RedPacketCoverGolden => 'Dourado';

  @override
  String get ui3RedPacketCoverPurple => 'Roxo';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Azul oceano';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Verde natureza';

  @override
  String get ui3RedPacketCoverRosePink => 'Rosa';

  @override
  String get ui3RedPacketHistoryEmpty => 'Ainda não há envelopes vermelhos';

  @override
  String get ui3TransferMerchantQrWithAmount => 'QR de comerciante (com valor)';

  @override
  String get ui3TransferMerchantQrTitle => 'QR de comerciante';

  @override
  String get ui3TransferOpenAmountHint => 'Deixe vazio para valor livre';

  @override
  String get ui3FiatRampTitle => 'Comprar / vender cripto';

  @override
  String get ui3FiatRampBuy => 'Comprar';

  @override
  String get ui3FiatRampSell => 'Vender';

  @override
  String get ui3FiatRampNotConfigured =>
      'A rampa fiat de entrada/saída não está configurada';

  @override
  String get a11yPointsAddRule => 'Adicionar regra de recompensa';

  @override
  String get a11yGovernanceRemoveChoice => 'Remover opção';

  @override
  String get a11yGovernanceCreateProposal => 'Criar proposta';

  @override
  String get ui3MiniAppUpdateN42 => 'Atualizar N42';

  @override
  String get ui3MiniAppOfficial => 'Oficial';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count utilizadores';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Cor de fundo $index';
  }

  @override
  String get a11yStoryAdd => 'Adicionar história';

  @override
  String get ui3StoryPostFailed => 'Falha ao publicar a história';

  @override
  String get ui3StoryTapToSelectImage => 'Toque para selecionar uma imagem';

  @override
  String get ui3StoryChangeImage => 'Alterar';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Não foi possível ler a música selecionada: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Eliminar esta história?';

  @override
  String get ui3StoryDeleteFailed => 'Falha ao eliminar a história';

  @override
  String get ui3MomentCreateTitle => 'Criar momento';

  @override
  String get ui3MomentContentHint => 'Em que está a pensar?';

  @override
  String get ui3MomentAddPhotos => 'Adicionar fotografias';

  @override
  String get ui3MomentAddLocation => 'Adicionar localização';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Multimédia selecionado ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Limpar tudo';

  @override
  String get ui3MomentClearMediaConfirm =>
      'Remover todas as fotografias/vídeos selecionados?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Visível para todos os amigos';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Visível apenas para si';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Escolher quem pode ver';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Ocultar de amigos específicos';

  @override
  String get ui3MomentVideos => 'Vídeos';

  @override
  String get ui3MomentNoVideos => 'Ainda não há vídeos';

  @override
  String get a11yCallMinimize => 'Minimizar';

  @override
  String get a11yCallGridView => 'Vista em grelha';

  @override
  String get a11yCallFocusView => 'Vista em destaque';

  @override
  String get ui3CallTools => 'Ferramentas de chamada';

  @override
  String get ui3CallMeetingTools => 'Ferramentas de reunião';

  @override
  String get ui3CallToolsSubtitle =>
      'Ajuste a qualidade de áudio e vídeo sem sair da chamada.';

  @override
  String get ui3CallAudioEnhancement => 'Melhoria de áudio';

  @override
  String get ui3CallNoiseSuppression => 'Supressão de ruído';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Reduz o ruído do teclado e de fundo.';

  @override
  String get ui3CallEchoCancellation => 'Cancelamento de eco';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Impede que o som do altifalante volte a entrar no microfone.';

  @override
  String get ui3CallAutoGainControl => 'Controlo automático de ganho';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Mantém o volume do microfone mais estável.';

  @override
  String get ui3CallVoiceIsolation => 'Isolamento de voz melhorado';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Utilizar um perfil de redução de ruído mais forte.';

  @override
  String get ui3CallVideoSection => 'Vídeo';

  @override
  String get ui3CallBackgroundBlur => 'Desfocagem do fundo (beta)';

  @override
  String get ui3CallBlurDescReady =>
      'A preferência está ativa. A desfocagem visual ainda depende da disponibilização do processador de vídeo.';

  @override
  String get ui3CallBlurDescSaved =>
      'A preferência de desfocagem foi guardada e será aplicada quando o processamento da câmara estiver disponível.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Ligue a câmara quando o processamento do fundo estiver disponível.';

  @override
  String get ui3CallRecordingSection => 'Gravação';

  @override
  String get ui3CallRecordingDesc =>
      'Requer saída do lado do servidor para guardar gravações.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Falha ao atualizar as definições da chamada: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Gravação iniciada';

  @override
  String get ui3VoiceRoomNotFound => 'Sala não encontrada';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Tem a certeza de que pretende terminar esta sala de voz?';

  @override
  String get a11yGameMoveUp => 'Mover para cima';

  @override
  String get a11yGameMoveDown => 'Mover para baixo';

  @override
  String get a11yGameMoveLeft => 'Mover para a esquerda';

  @override
  String get a11yGameMoveRight => 'Mover para a direita';

  @override
  String get a11yGameRotate => 'Rodar';

  @override
  String get a11yGameDrop => 'Largar';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count autocolante(s) adicionado(s)';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Falha ao adicionar: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Remover autocolante';

  @override
  String get ui3StickerRemoveConfirm => 'Remover este autocolante do pacote?';

  @override
  String get ui3StickerRemoveFailed => 'Falha ao remover';

  @override
  String get ui3StickerRenamePack => 'Mudar o nome do pacote';

  @override
  String get ui3StickerPackName => 'Nome do pacote';

  @override
  String get ui3StickerRenameFailed => 'Falha ao mudar o nome';

  @override
  String get ui3StickerDeletePack => 'Eliminar pacote';

  @override
  String get ui3StickerThisPack => 'este pacote';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Eliminar \"$name\" e todos os respetivos autocolantes? Esta ação não pode ser anulada.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Falha ao eliminar';

  @override
  String get ui3StickerPack => 'Pacote de autocolantes';

  @override
  String get ui3StickerAdding => 'A adicionar…';

  @override
  String get ui3StickerAddStickers => 'Adicionar autocolantes';

  @override
  String get ui3StickerPackNotFound => 'Pacote não encontrado';

  @override
  String get ui3StickerEmptyHint =>
      'Toque em \"Adicionar autocolantes\" para carregar imagens';

  @override
  String get ui3StickerNewPack => 'Novo pacote de autocolantes';

  @override
  String get ui3StickerCreate => 'Criar';

  @override
  String get ui3StickerCreateFailed => 'Falha ao criar o pacote';

  @override
  String ui3StickerInstalled(Object name) {
    return '\"$name\" instalado';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Remover pacote de autocolantes';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Remover \"$name\" dos seus autocolantes?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '\"$name\" removido';
  }

  @override
  String get ui3StickerAiSticker => 'Autocolante IA';

  @override
  String get ui3StickerStoreTab => 'Loja';

  @override
  String get ui3StickerMyStickersTab => 'Os meus autocolantes';

  @override
  String get ui3StickerNoneFound => 'Nenhum autocolante encontrado';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'por $author';
  }

  @override
  String get ui3StickerManage => 'Gerir';

  @override
  String ui3StickerCount(Object count) {
    return '$count autocolantes';
  }

  @override
  String get ui3StickerNoneInstalled => 'Nenhum autocolante instalado';

  @override
  String get ui3StickerGetFromStore => 'Obtenha autocolantes na loja';

  @override
  String get ui3StickerBrowseStore => 'Explorar loja';

  @override
  String get ui3StickerAddedToAi => 'Adicionado a \"Autocolantes IA\"';

  @override
  String get ui3StickerAddOneFailed => 'Falha ao adicionar o autocolante';

  @override
  String get ui3StickerPromptLabel => 'Descreva o seu autocolante';

  @override
  String get ui3StickerPromptHint =>
      'p. ex. um gato laranja feliz com óculos de sol';

  @override
  String get ui3StickerGenerating => 'A gerar…';

  @override
  String get ui3StickerGenerate => 'Gerar';

  @override
  String get ui3StickerAddToStickers => 'Adicionar aos autocolantes';

  @override
  String get ui3StickerGeneratingPreview => 'A gerar o seu autocolante…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Descreva um autocolante e toque em \"Gerar\"';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class SPtBr extends SPt {
  SPtBr() : super('pt_BR');

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
  String authLoginFailed(Object error) {
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
      'A permissão do microfone foi negada. Ative-o nas configurações do sistema para usar mensagens de voz.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Falha ao iniciar gravação: $error';
  }

  @override
  String get commonRecordingTooShort => 'Gravação muito curta';

  @override
  String commonStopRecordingFailed(Object error) {
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
  String get commonChat => 'Bate-papo';

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
  String get chatReadAloud => 'Leia em voz alta';

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
  String contactN42Id(Object id) {
    return 'ID N42: $id';
  }

  @override
  String get profileN42IdTitle => 'ID N42';

  @override
  String get profileN42Bean => 'Feijão N42';

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
  String get contactTags => 'Etiquetas';

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
  String profileSaveFailed(Object error) {
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
  String get authAnd => ' e ';

  @override
  String get authPrivacyPolicy => 'Política de Privacidade';

  @override
  String get authServerAddress => 'Endereço do Servidor';

  @override
  String get authEnterServerAddress => 'Digite o endereço do servidor';

  @override
  String authConnectedTo(Object serverName) {
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
  String get profileAvatar => 'avatar';

  @override
  String get profileStatus => 'Estado';

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
  String commonFeatureComingSoon(Object feature) {
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
  String conversationDeleteConversationConfirm(Object name) {
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
  String get contactChatOnlyFriends => 'Amigos apenas para bate-papo';

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
  String contactRecommendFailed(Object error) {
    return 'Falha na recomendação: $error';
  }

  @override
  String get profileEnterRemark => 'Digite a observação';

  @override
  String get contactOpeningChat => 'Abrindo chat...';

  @override
  String contactOpenChatFailed(Object error) {
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
  String get profileOnline => 'On-line';

  @override
  String get profileOffline => 'Off-line';

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
  String commonGroupMembers(Object count) {
    return 'Membros ($count)';
  }

  @override
  String get groupMembersTitle => 'Membros do grupo';

  @override
  String get groupViewAll => 'Ver todos';

  @override
  String get groupOwner => 'Dono';

  @override
  String get groupAdmin => 'Administrador';

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
  String transferAvailableBalance(Object balance, Object symbol) {
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
  String commonFromSender(String name) {
    return 'De $name';
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
  String get profileQrCode => 'Código QR';

  @override
  String get profileAvatarUpdated => 'Avatar atualizado';

  @override
  String commonSelectImageFailed(Object error) {
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
  String profileSaveAddressFailed(Object error) {
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
  String profileSaveInvoiceFailed(Object error) {
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
  String favoriteOpenItem(Object content) {
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
  String commonFeatureInDevelopment(Object feature) {
    return 'O recurso $feature está em desenvolvimento…';
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
  String get authRegistrationDisabled =>
      'O cadastro neste servidor está desativado. Entre em contato com o administrador para ativá-lo.';

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
  String get favoriteLinkLabel => 'Ligação';

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
  String get commonNormalRedPacket => 'Normais';

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
    return 'ID N42: $id';
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
  String get commonGroupAdmin => 'Administrador';

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
  String get profileBio => 'Biografia';

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
  String get searchClearHistoryConfirm => 'Limpar todas as pesquisas recentes?';

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
  String get settingsDeleteAccountTitle => 'Excluir conta';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Desativar esta conta Matrix e limpar seus dados locais de conversa';

  @override
  String get settingsDeleteAccountExplanation =>
      'Esta ação solicita a desativação permanente da conta Matrix. Após a confirmação do servidor, o aplicativo remove a sessão local de conversa e as chaves de criptografia desta conta quando for seguro. As outras contas e sua carteira são mantidas. A federação e as políticas de retenção dos servidores podem limitar a exclusão de dados.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Senha do Matrix, se solicitada';

  @override
  String get settingsDeleteAccountServerErase =>
      'Solicitar exclusão de dados do servidor';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Peça a este servidor de origem que exclua os dados da conta, quando houver suporte. Cópias mantidas por outros servidores ou exigidas por políticas de retenção podem permanecer.';

  @override
  String get settingsDeleteAccountChooseStage => 'Verificar esta conta Matrix';

  @override
  String get settingsDeleteAccountUsePassword => 'Usar senha do Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'Continuar no navegador';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Retornar da verificação do Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Retornar do navegador não confirma a exclusão. Verifique a solicitação original com o servidor Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'Verificar com o servidor';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'O servidor Matrix não confirmou a exclusão da conta.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Limpeza local da conta pendente';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Revisar a limpeza de uma conta Matrix desativada anteriormente';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Não foi possível ler os registros de limpeza pendentes. Toque para tentar novamente.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'A conta Matrix foi desativada, mas a limpeza local ainda está pendente. As outras contas continuam disponíveis.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'O gerenciamento da conta foi aberto no navegador. A exclusão não foi confirmada neste aplicativo, portanto sua sessão de conversa permanece disponível.';

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
  String get settingsBackup => 'Cópia de segurança';

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
  String get settingsBackupSuccess => 'Chaves salvas em backup com sucesso';

  @override
  String get settingsBackupFailed => 'Falha no backup';

  @override
  String get settingsRecoveryKey => 'Chave de recuperação';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Salve esta chave de recuperação em um local seguro. Você precisará dele para restaurar suas mensagens criptografadas em um novo dispositivo.';

  @override
  String get settingsRecoveryKeySaved => 'eu salvei';

  @override
  String get settingsRestoreSuccess => 'Chaves restauradas com sucesso';

  @override
  String get settingsRestoreEmpty =>
      'Nenhuma chave de mensagem foi encontrada neste backup.';

  @override
  String settingsRestoreSessions(int count) {
    return '$count sessões de chaves restauradas. Mensagens sem chaves podem continuar criptografadas.';
  }

  @override
  String get settingsRestoreFailed => 'Falha na restauração';

  @override
  String get settingsPassword => 'Senha';

  @override
  String get settingsEnterRecoveryKey => 'Insira a chave de recuperação';

  @override
  String get settingsEnterPassword => 'Digite a senha';

  @override
  String get settingsExportSuccess =>
      'Chaves exportadas para backup do servidor com sucesso';

  @override
  String get settingsExportNeedBackupFirst =>
      'Crie um backup de chave primeiro';

  @override
  String get settingsExportFailed => 'Falha na exportação';

  @override
  String get settingsResetSuccess => 'Redefinição de criptografia bem-sucedida';

  @override
  String get settingsResetFailed => 'Falha na redefinição';

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
  String get chatNetworkLink => 'Ligação';

  @override
  String get chatLocalFile => 'locais';

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
  String get chatNoMediaUrlAvailable => 'URL de mídia não disponível';

  @override
  String chatDownloadFailed(String code) {
    return 'Falha no download: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Link de música';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Envelopes vermelhos e transferências não podem ser encaminhados';

  @override
  String commonShareFailed(String error) {
    return 'Falha ao compartilhar: $error';
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
  String groupMemberCountClickToCopy(Object count) {
    return '$count membros, clique para copiar ID do grupo';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Você não tem permissão para editar o nome do grupo';

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
  String get settingsTranslation => 'Tradução';

  @override
  String get settingsTranslateTextTo => 'Traduzir texto para';

  @override
  String get settingsTranslateDescription =>
      'Selecione o idioma para o qual deseja que as mensagens sejam traduzidas.';

  @override
  String get settingsAutoTranslate =>
      'Traduzir automaticamente mensagens recebidas';

  @override
  String get settingsAutoTranslateDescription =>
      'Traduza automaticamente as mensagens recebidas no chat para o idioma selecionado.';

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
  String get authPasskeyLabel => 'Chave de acesso';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'maçã';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Este servidor não configurou provedores de login SSO';

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
  String get contactCreateTag => 'Criar etiqueta';

  @override
  String get contactEnterTagName => 'Insira o nome da etiqueta';

  @override
  String get contactEditTag => 'Editar etiqueta';

  @override
  String get contactDeleteTag => 'Excluir etiqueta';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Tem certeza de que deseja excluir a tag \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'Ainda não há tags';

  @override
  String get contactFriendPermissions => 'Permissões de amigos';

  @override
  String get contactSetChatOnly => 'Definir como somente bate-papo';

  @override
  String get contactChatOnlyDesc =>
      'Só pode conversar com você, outros conteúdos ficarão ocultos';

  @override
  String get contactHideMyMoments => 'Esconder meus momentos';

  @override
  String get contactHideMyMomentsDesc =>
      'Este amigo não pode ver meus momentos';

  @override
  String get contactHideTheirMoments => 'Esconda seus momentos';

  @override
  String get contactHideTheirMomentsDesc => 'Não vejo os momentos deste amigo';

  @override
  String get contactHideMyStatus => 'Ocultar meu status';

  @override
  String get contactHideMyStatusDesc =>
      'Este amigo não pode ver minhas atualizações de status';

  @override
  String get contactNoChatOnlyFriends => 'Sem amigos apenas para bate-papo';

  @override
  String get contactNoOfficialAccounts => 'Sem contas oficiais';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Siga as contas oficiais para obter as atualizações mais recentes';

  @override
  String get contactNoServiceAccounts => 'Nenhuma conta de serviço';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Assine contas de serviço para serviços convenientes';

  @override
  String get contactNoEnterpriseContacts => 'Nenhum contato empresarial';

  @override
  String get contactEnterpriseContactsDesc =>
      'Os contatos corporativos serão exibidos aqui';

  @override
  String get profileCardPack => 'Pacote de cartas';

  @override
  String get profileOrders => 'Pedidos';

  @override
  String get profileNoOrders => 'Sem pedidos';

  @override
  String get profileOrdersDesc => 'Seus pedidos serão exibidos aqui';

  @override
  String get profileNoCards => 'Sem cartões';

  @override
  String get profileCardsDesc => 'Seus cartões serão exibidos aqui';

  @override
  String get favoriteEnterTagsHint => 'Insira tags separadas por vírgulas';

  @override
  String get favoriteTagsUpdated => 'Etiquetas atualizadas';

  @override
  String get favoriteForwardedContent => 'Conteúdo encaminhado';

  @override
  String get favoriteEnterNoteContent => 'Insira o conteúdo da nota';

  @override
  String get favoriteNoteAdded => 'Nota adicionada';

  @override
  String get favoriteLinkTitle => 'Título do link';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Link adicionado';

  @override
  String get contactPhotoAdded => 'Foto adicionada';

  @override
  String get contactEnterPhone => 'Digite o número de telefone';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Conversa: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Contato: $userId';
  }

  @override
  String get commonDiscover => 'Descobrir';

  @override
  String commonDeveloping(Object title) {
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
  String get groupVisibilityUpdated => 'Visibilidade do grupo atualizada';

  @override
  String get groupChannelCreated => 'Canal criado';

  @override
  String get groupChannelUpdated => 'Canal atualizado';

  @override
  String get groupChannelDeleted => 'Canal excluído';

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
  String callJoinMeetingFailed(Object error) {
    return 'Falha ao entrar na reunião: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Falha no compartilhamento de tela: $error';
  }

  @override
  String get profileN42BeanTitle => 'Feijão N42';

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
  String profilePlayFailed(Object ringtoneName) {
    return 'Falha ao reproduzir: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
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
  String commonReadCount(Object count) {
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
  String get securityDeviceIdRequired => 'O ID do dispositivo é obrigatório';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Falha ao iniciar a verificação: $error';
  }

  @override
  String get securityVerificationFailed => 'Falha na verificação';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Falha na verificação: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Verificação rejeitada – emoji não corresponde';

  @override
  String get securityWaitingForDeviceAccept =>
      'Aguardando que o outro dispositivo aceite...';

  @override
  String get securityVerifyDevice => 'Verifique este dispositivo';

  @override
  String get securityConfirmEmojiMatch =>
      'Confirme se os emojis abaixo são exibidos em ambos os dispositivos, na mesma ordem';

  @override
  String get securityEmojiDontMatch => 'Eles não combinam';

  @override
  String get securityEmojiMatch => 'Eles combinam';

  @override
  String get securityWaitingForDeviceConfirm =>
      'Aguardando a confirmação do outro dispositivo...';

  @override
  String get securityVerificationSuccess => 'Verificação bem-sucedida!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Este dispositivo agora foi verificado e confiável.';

  @override
  String get securityCompareEmoji => 'Compare o emoji em ambos os dispositivos';

  @override
  String get securityCompareNumbers =>
      'Compare os números em ambos os dispositivos';

  @override
  String get commonTryAgain => 'Tente novamente';

  @override
  String get commonDone => 'Concluído';

  @override
  String get chatExportTitle => 'Exportar bate-papo';

  @override
  String get chatExportSuccess => 'Exportação bem-sucedida';

  @override
  String chatExportFailed(String error) {
    return 'Falha na exportação: $error';
  }

  @override
  String get chatExportFormat => 'Formato de exportação';

  @override
  String get chatExportHtmlDesc =>
      'Legível em qualquer navegador com layout estilizado';

  @override
  String get chatExportJsonDesc =>
      'Formato de dados estruturados legível por máquina';

  @override
  String get chatExportDateRange => 'Período';

  @override
  String get chatExportAll => 'Todas as mensagens';

  @override
  String get chatExportLastWeek => 'Últimos 7 dias';

  @override
  String get chatExportLastMonth => 'Último mês';

  @override
  String get chatExportLast3Months => 'Últimos 3 meses';

  @override
  String get chatExportMessageCount => 'Mensagens para exportar';

  @override
  String get chatExportButton => 'Exportar e compartilhar';

  @override
  String get chatMediaGallery => 'Galeria de mídia';

  @override
  String get chatExportHistory => 'Exportar histórico de bate-papo';

  @override
  String get pdfLoadFailed => 'Falha ao carregar o PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'Todos';

  @override
  String get mediaImages => 'Imagens';

  @override
  String get mediaVideos => 'Vídeos';

  @override
  String get mediaFiles => 'Arquivos';

  @override
  String get mediaAudio => 'Áudio';

  @override
  String mediaItemsCount(int count) {
    return 'Itens $count';
  }

  @override
  String get mediaNoMediaFound => 'Nenhuma mídia encontrada';

  @override
  String get spacesTitle => 'Comunidades';

  @override
  String get spacesCreate => 'Criar comunidade';

  @override
  String get spacesJoined => 'Ingressou';

  @override
  String get spacesDiscover => 'Descubra';

  @override
  String get spacesNoJoined => 'Nenhuma comunidade aderiu ainda';

  @override
  String get spacesExplore => 'Explorar comunidades';

  @override
  String get spacesNoPublic => 'Nenhuma comunidade pública encontrada';

  @override
  String get spacesJoin => 'Junte-se';

  @override
  String get spacesSubSpaces => 'Subcomunidades';

  @override
  String get spacesChannels => 'Canais';

  @override
  String spacesMembersCount(int count) {
    return 'Membros $count';
  }

  @override
  String get spacesPublic => 'Público';

  @override
  String get spacesPrivate => 'Privado';

  @override
  String get spacesSuggested => 'Sugerido';

  @override
  String spacesChannelsCount(int count) {
    return 'Canais $count';
  }

  @override
  String get callInCallChat => 'Bate-papo durante a chamada';

  @override
  String callMessagesCount(int count) {
    return 'Mensagens $count';
  }

  @override
  String get callNoMessagesYet =>
      'Nenhuma mensagem ainda.\nEnvie uma mensagem para começar.';

  @override
  String get callTypeMessage => 'Digite uma mensagem...';

  @override
  String get callYouSender => 'Você';

  @override
  String get callChatLabel => 'Bate-papo';

  @override
  String get chatEdited => 'Editado';

  @override
  String get chatEditHistory => 'Editar histórico';

  @override
  String get chatOriginalMessage => 'Originais';

  @override
  String chatEditedAt(String time) {
    return 'Editado em $time';
  }

  @override
  String get chatViewOnce => 'Ver uma vez';

  @override
  String get chatViewOncePhoto => 'Ver uma vez foto';

  @override
  String get chatViewOnceVideo => 'Ver vídeo uma vez';

  @override
  String get chatViewOnceViewed => 'Visto';

  @override
  String get chatViewOnceExpired => 'Expirado';

  @override
  String get chatViewOnceTap => 'Toque para visualizar';

  @override
  String get chatAutoFaceBlur => 'Desfoque automático de rosto';

  @override
  String get chatAutoFaceBlurDesc =>
      'Desfocar rostos automaticamente ao enviar fotos';

  @override
  String get threadReplyInThread => 'Responder no tópico';

  @override
  String threadReplies(int count) {
    return 'Respostas $count';
  }

  @override
  String get threadReply => '1 resposta';

  @override
  String threadLatestReply(String preview) {
    return 'Mais recente: $preview';
  }

  @override
  String get threadTitle => 'Tópico';

  @override
  String get threadReplyPlaceholder => 'Responder no tópico...';

  @override
  String threadParticipants(int count) {
    return 'Participantes $count';
  }

  @override
  String get voiceRoomTitle => 'Sala de Voz';

  @override
  String get voiceRoomCreate => 'Criar sala de voz';

  @override
  String get voiceRoomJoin => 'Junte-se';

  @override
  String get voiceRoomLeave => 'Sair';

  @override
  String get voiceRoomEnd => 'Sala final';

  @override
  String get voiceRoomRaiseHand => 'Levante a mão';

  @override
  String get voiceRoomLowerHand => 'Mão Inferior';

  @override
  String get voiceRoomMute => 'Mudo';

  @override
  String get voiceRoomUnmute => 'Ativar som';

  @override
  String get voiceRoomHost => 'Anfitrião';

  @override
  String get voiceRoomSpeakers => 'Alto-falantes';

  @override
  String get voiceRoomListeners => 'Ouvintes';

  @override
  String get voiceRoomLive => 'AO VIVO';

  @override
  String get voiceRoomEnded => 'Terminou';

  @override
  String get voiceRoomScheduled => 'Agendado';

  @override
  String get voiceRoomApprove => 'Aprovar';

  @override
  String get voiceRoomDemote => 'Mover para ouvinte';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name levantou a mão';
  }

  @override
  String get voiceRoomName => 'Nome da sala';

  @override
  String get voiceRoomTopic => 'Tópico (opcional)';

  @override
  String get voiceRoomNoActive => 'Nenhuma sala de voz ativa';

  @override
  String get voiceRoomConnecting => 'Conectando...';

  @override
  String get usernameTitle => 'Nome de usuário';

  @override
  String get usernameSet => 'Definir nome de usuário';

  @override
  String get usernameChange => 'Alterar nome de usuário';

  @override
  String get usernamePlaceholder => 'Digite o nome de usuário';

  @override
  String get usernameAvailable => 'Nome de usuário disponível';

  @override
  String get usernameUnavailable => 'Nome de usuário já utilizado';

  @override
  String get usernameInvalid =>
      '3 a 30 caracteres, letras minúsculas, números, sublinhado. Deve começar com uma carta.';

  @override
  String get usernameReserved => 'Este nome de usuário está reservado';

  @override
  String get usernameSaved => 'Nome de usuário salvo';

  @override
  String get usernameSearchHint => 'Pesquisar por @nomedeusuário';

  @override
  String get ensName => 'Nome ENS';

  @override
  String get ensLinked => 'Vinculado ao ENS';

  @override
  String get ensResolving => 'Resolvendo ENS...';

  @override
  String get ensNotFound => 'Nome ENS não encontrado';

  @override
  String get tokenGateTitle => 'Portão de Token';

  @override
  String get tokenGateEnable => 'Habilitar Token Gate';

  @override
  String get tokenGateDisable => 'Desativar Token Gate';

  @override
  String get tokenGateAddRule => 'Adicionar regra';

  @override
  String get tokenGateRemoveRule => 'Remover regra';

  @override
  String get tokenGateContractAddress => 'Endereço do contrato';

  @override
  String get tokenGateMinBalance => 'Saldo Mínimo';

  @override
  String get tokenGateTokenId => 'ID do token (ERC-1155)';

  @override
  String get tokenGateChainId => 'ID da cadeia';

  @override
  String get tokenGateVerifying => 'Verificando acervos de tokens...';

  @override
  String get tokenGateVerified => 'Verificação aprovada';

  @override
  String get tokenGateDenied => 'Você não atende aos requisitos de token';

  @override
  String get tokenGateOperatorAnd => 'Deve atender TODAS as regras';

  @override
  String get tokenGateOperatorOr => 'Deve atender a QUALQUER regra';

  @override
  String get tokenGateRuleErc20 => 'Token ERC-20';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Multitoken (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Token Nativo';

  @override
  String get tokenGateSaved => 'Portão de token salvo';

  @override
  String get tokenGateEnableDescription =>
      'Exigir que os membros tenham tokens para ingressar';

  @override
  String get tokenGateOperator => 'Lógica de regras';

  @override
  String get tokenGateRules => 'Regras';

  @override
  String get tokenGateSymbol => 'Símbolo (opcional)';

  @override
  String get tokenGateChain => 'Corrente';

  @override
  String get tokenGateTokenStandard => 'Padrão de token';

  @override
  String get tokenGateDenialMessage => 'Mensagem de negação';

  @override
  String get tokenGateDenialMessageHint =>
      'Mensagem mostrada quando a verificação falha';

  @override
  String get tokenGateVerifyTitle => 'Verificação de token';

  @override
  String get tokenGateVerifyPassed => 'Verificação aprovada';

  @override
  String get tokenGateVerifyFailed => 'Falha na verificação';

  @override
  String get tokenGateRetryVerify => 'Tentar novamente';

  @override
  String get tokenGateRequired => 'Obrigatório';

  @override
  String get tokenGateYourBalance => 'Seu saldo';

  @override
  String get tokenGateRulesActive => 'regras ativas';

  @override
  String get tokenGateDisabled => 'Desativado';

  @override
  String get ensNotBound => 'Não vinculado';

  @override
  String get liveLocation => 'Localização ao vivo';

  @override
  String get stopLiveLocation => 'Pare de compartilhar';

  @override
  String get startLiveLocation => 'Comece a compartilhar';

  @override
  String get selectDuration => 'Selecione Duração';

  @override
  String get groupChatFiles => 'Arquivos de bate-papo';

  @override
  String get groupLinks => 'Ligações';

  @override
  String get groupNoLinks => 'Ainda não há links';

  @override
  String get chatBackground => 'Plano de fundo do bate-papo';

  @override
  String get solidColors => 'Cores Sólidas';

  @override
  String get gradients => 'Gradientes';

  @override
  String get defaultBackground => 'Padrão';

  @override
  String get settingsFontSizeSlider => 'Tamanho da fonte';

  @override
  String get autoDownload => 'Download automático';

  @override
  String get images => 'Imagens';

  @override
  String get voice => 'Voz';

  @override
  String get video => 'Vídeo';

  @override
  String get files => 'Arquivos';

  @override
  String get mobileData => 'Dados móveis';

  @override
  String get roaming => 'Itinerância';

  @override
  String get storageManagement => 'Armazenamento';

  @override
  String get totalUsage => 'Uso total';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Outro';

  @override
  String get clearCache => 'Limpar Cache';

  @override
  String get cacheCleared => 'Cache limpo';

  @override
  String get clearCacheFailed => 'Falha ao limpar o cache';

  @override
  String get confirmClearCache => 'Limpar todos os dados do cache?';

  @override
  String get mapView => 'Visualização do mapa';

  @override
  String liveLocationSharingCount(int count) {
    return '$count pessoas compartilhando localização';
  }

  @override
  String get minutes15 => '15 minutos';

  @override
  String get minutes30 => '30 minutos';

  @override
  String get hour1 => '1 hora';

  @override
  String get hours8 => '8 horas';

  @override
  String get personalCard => 'Cartão Pessoal';

  @override
  String get downloadFailed => 'Falha no download';

  @override
  String get locationExpired => 'Expirado';

  @override
  String secondsRemaining(int count) {
    return '$count segundos';
  }

  @override
  String minutesRemaining(int count) {
    return '$count minutos';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours horas $minutes minutos';
  }

  @override
  String get favoriteMessages => 'Favoritos';

  @override
  String get linksCopied => 'Link copiado';

  @override
  String get noLinksFound => 'Nenhum link encontrado';

  @override
  String get roomStorageRanking => 'Classificação de armazenamento de sala';

  @override
  String get downloadComplete => 'Download concluído';

  @override
  String get downloading => 'Baixando...';

  @override
  String get draftSaved => 'Rascunho salvo';

  @override
  String get voiceRecording => 'Gravação de voz';

  @override
  String get searchLocation => 'Local de pesquisa';

  @override
  String get tapToSearch => 'Toque para pesquisar';

  @override
  String get settingsThisDevice => 'Este dispositivo';

  @override
  String get settingsJustNow => 'Agora mesmo';

  @override
  String get settingsDeviceId => 'ID do dispositivo';

  @override
  String get settingsStatus => 'Estado';

  @override
  String get settingsLastActive => 'Último ativo';

  @override
  String get settingsIpAddress => 'Endereço IP';

  @override
  String get settingsRenameDevice => 'Renomear dispositivo';

  @override
  String get settingsDeviceNameHint => 'Digite o nome do dispositivo';

  @override
  String get settingsDeviceRenamed => 'Dispositivo renomeado';

  @override
  String get settingsRenameFailed => 'Falha ao renomear';

  @override
  String get settingsRemoteLogout => 'Logout remoto';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Tem certeza de que deseja sair de \"$deviceName\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Dispositivo desconectado';

  @override
  String get settingsLogoutFailed => 'Falha ao sair';

  @override
  String get settingsLogout => 'Sair';

  @override
  String get settingsVerifyIdentity => 'Verifique a identidade';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Digite sua senha para confirmar esta ação.';

  @override
  String get scheduledSendTitle => 'Agendar mensagem';

  @override
  String get scheduledSendInOneHour => 'Em 1 hora';

  @override
  String get scheduledSendTonight => 'Hoje à noite (20:00)';

  @override
  String get scheduledSendTomorrowMorning => 'Amanhã de manhã (9h00)';

  @override
  String get scheduledSendCustom => 'Escolha uma data e hora';

  @override
  String get scheduledMessageLabel => 'Agendado';

  @override
  String get scheduledMessageCancel => 'Cancelar mensagem agendada';

  @override
  String get chatLockTitle => 'Bloqueio de bate-papo';

  @override
  String get chatLockEnable => 'Bloquear este bate-papo';

  @override
  String get chatLockDisable => 'Desbloquear este bate-papo';

  @override
  String get chatLockDescription =>
      'Bate-papos bloqueados exigem verificação biométrica ou PIN para serem abertos';

  @override
  String get chatLockVerifyTitle => 'Bate-papo bloqueado';

  @override
  String get chatLockVerifySubtitle => 'Verifique para acessar este chat';

  @override
  String get chatLockVerifyFailed => 'Falha na verificação';

  @override
  String get chatLockEnabled => 'Bate-papo bloqueado';

  @override
  String get chatLockDisabled => 'Bate-papo desbloqueado';

  @override
  String get chatLockPinTitle => 'Insira o PIN';

  @override
  String get chatLockPinSetTitle => 'Definir PIN';

  @override
  String get chatLockPinConfirmTitle => 'Confirmar PIN';

  @override
  String get chatLockPinMismatch => 'PIN não corresponde';

  @override
  String get chatLockUseBiometric => 'Usar biometria';

  @override
  String get chatLockUsePin => 'Usar PIN';

  @override
  String get mediaEditorUndo => 'Desfazer';

  @override
  String get mediaEditorRedo => 'Refazer';

  @override
  String get mediaEditorCrop => 'Cortar';

  @override
  String get mediaEditorFilter => 'Filtro';

  @override
  String get mediaEditorDraw => 'Desenhar';

  @override
  String get mediaEditorText => 'Texto';

  @override
  String get aiAssistant => 'Assistente de IA';

  @override
  String get aiAssistantWelcome =>
      'Olá! Sou o assistente de IA do N42. Como posso ajudá-lo?';

  @override
  String get aiAssistantNotConfigured => 'Serviço de IA não configurado';

  @override
  String get aiAssistantSettings => 'Configurações de IA';

  @override
  String get aiAssistantClearHistory => 'Limpar histórico de bate-papo';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Tem certeza de que deseja limpar todo o histórico de bate-papo da IA?';

  @override
  String get aiAssistantStopGenerating => 'Pare de gerar';

  @override
  String get aiAssistantModel => 'Modelo';

  @override
  String get aiAssistantTemperature => 'Temperatura';

  @override
  String get aiAssistantMaxTokens => 'Máximo de tokens';

  @override
  String get aiAssistantContextWindow => 'Janela de contexto';

  @override
  String get aiAssistantServiceStatus => 'Status do serviço';

  @override
  String get aiAssistantAvailable => 'Disponível';

  @override
  String get aiAssistantUnavailable => 'Indisponível';

  @override
  String get aiSummarize => 'Resumo de IA';

  @override
  String aiSummarizeUnread(int count) {
    return 'Resumir mensagens não lidas $count';
  }

  @override
  String get aiSummarizeLoading => 'Resumindo...';

  @override
  String get aiSummarizeError => 'Falha ao resumir';

  @override
  String get aiRewrite => 'Reescrita de IA';

  @override
  String get aiRewriteFormal => 'Formal';

  @override
  String get aiRewriteCasual => 'Informal';

  @override
  String get aiRewritePlayful => 'Brincalhão';

  @override
  String get aiRewriteProfessional => 'Profissional';

  @override
  String get aiRewriteAccept => 'Usar';

  @override
  String get aiRewriteCancel => 'Cancelar';

  @override
  String get aiRewriteLoading => 'Reescrevendo...';

  @override
  String get aiLinkSummary => 'Resumo de IA';

  @override
  String get aiLinkSummaryAnalyzing => 'Analisando...';

  @override
  String get chatFolderManagement => 'Gerenciar pastas';

  @override
  String get chatFolderSystem => 'Pastas do sistema';

  @override
  String get chatFolderCustom => 'Pastas personalizadas';

  @override
  String get chatFolderEmpty => 'Ainda não há pastas personalizadas';

  @override
  String get chatFolderCreate => 'Criar pasta';

  @override
  String get chatFolderEdit => 'Editar pasta';

  @override
  String get chatFolderNameHint => 'Nome da pasta';

  @override
  String get chatFolderAll => 'Todos';

  @override
  String get chatFolderUnread => 'Não lido';

  @override
  String get chatFolderPersonal => 'Pessoal';

  @override
  String get chatFolderGroups => 'Grupos';

  @override
  String get chatFolderChannels => 'Canais';

  @override
  String get chatFolderMuted => 'Silenciado';

  @override
  String get storyAddMusic => 'Adicionar música';

  @override
  String get storyChangeMusic => 'Mudar música';

  @override
  String get storyBackgroundMusic => 'Música de fundo';

  @override
  String get storyMusicPreview => 'Pré-visualização (máx. 15s)';

  @override
  String get storyChooseFromDevice => 'Escolha do dispositivo';

  @override
  String get storyUseThisMusic => 'Use esta música';

  @override
  String get authPasskeyNotSupported =>
      'A senha não é compatível com este dispositivo';

  @override
  String get authPasskeyRegister => 'Registrar senha';

  @override
  String get authPasskeyNoRegistered => 'Nenhuma senha registrada';

  @override
  String get authPasskeyRegisterHint =>
      'Registre uma senha para esta conta. O login autônomo com senha será ativado posteriormente.';

  @override
  String get authPasskeyNameYours => 'Dê um nome à sua chave de acesso';

  @override
  String get authPasskeyRegistered => 'Chave de acesso salva nesta conta';

  @override
  String get authPasskeyDeleted => 'Chave de acesso removida desta conta';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Excluir a senha \"$name\"? Você precisará registrá-lo novamente antes de usar o login com senha posteriormente.';
  }

  @override
  String get momentVisibilityPublic => 'Público';

  @override
  String get momentVisibilityPrivate => 'Privado';

  @override
  String get momentVisibilityPartial => 'Amigos selecionados';

  @override
  String get momentVisibilityExcluded => 'Excluir alguns amigos';

  @override
  String momentUserMoments(String userName) {
    return 'Momentos de $userName';
  }

  @override
  String get momentForwardTo => 'Encaminhar para';

  @override
  String get momentForwardSuccess => 'Encaminhado com sucesso';

  @override
  String get momentSelectFriends => 'Selecione amigos';

  @override
  String get momentSelectTags => 'Selecione por tags';

  @override
  String momentSelectedCount(int count) {
    return 'Selecionado ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Ainda não há momentos';

  @override
  String get momentForwardMoment => 'Momento Avançar';

  @override
  String get momentAddComment => 'Adicione um comentário...';

  @override
  String momentForwardContent(String content) {
    return '[Momento] $content';
  }

  @override
  String get momentDeleteMoment => 'Excluir momento';

  @override
  String get momentDeleteConfirm =>
      'Tem certeza de que deseja excluir este momento?';

  @override
  String get momentComment => 'Comentário';

  @override
  String get momentWriteComment => 'Escreva um comentário...';

  @override
  String get momentLike => 'Gosto';

  @override
  String get momentUnlike => 'Ao contrário';

  @override
  String get momentForward => 'Avançar';

  @override
  String get momentDelete => 'Excluir';

  @override
  String get momentReply => 'responder';

  @override
  String get momentMoment => 'Momento';

  @override
  String momentLikesCount(int count) {
    return '$count gosta';
  }

  @override
  String momentCommentsCount(int count) {
    return 'Comentários $count';
  }

  @override
  String get momentNoComments => 'Ainda não há comentários';

  @override
  String get momentFailedToLoad => 'Falha ao carregar imagem';

  @override
  String momentReplyTo(String userName) {
    return 'Responder a $userName...';
  }

  @override
  String get momentNoConversations => 'Sem conversas';

  @override
  String get momentJustNow => 'agora mesmo';

  @override
  String momentMinutesAgo(int count) {
    return '${count}m atrás';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h atrás';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}d atrás';
  }

  @override
  String get chatGroupAnnouncementHint => 'Insira o anúncio do grupo';

  @override
  String get chatGroupAnnouncementEmpty => 'Nenhum anúncio';

  @override
  String get chatEditNickname => 'Editar apelido';

  @override
  String get chatNicknameHint => 'Digite seu apelido neste grupo';

  @override
  String get contactAddPhoneHint => 'Digite o número de telefone';

  @override
  String get contactNotesHint => 'Adicione notas sobre este contato';

  @override
  String get reportTitle => 'Relatório';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Assédio';

  @override
  String get reportReasonFraud => 'Fraude';

  @override
  String get reportReasonOther => 'Outro';

  @override
  String get reportSubmitted => 'Relatório enviado';

  @override
  String get reportDescription => 'Descrição adicional (opcional)';

  @override
  String get qrcodeSaved => 'Código QR salvo no álbum';

  @override
  String get chatSendRedPacketInChat =>
      'Por favor, envie pacote vermelho no chat';

  @override
  String get commonSaveFailed => 'Falha ao salvar';

  @override
  String get reportSelectReason => 'Selecione um motivo';

  @override
  String get reportUnavailable => 'Entre na conta para enviar uma denúncia.';

  @override
  String get reportAccountChanged =>
      'A conta foi alterada. Abra esta denúncia novamente para enviá-la.';

  @override
  String get reportUnsupported =>
      'Este servidor de origem não oferece suporte a denúncias de usuários.';

  @override
  String get reportRoomUnsupported =>
      'Este servidor de origem não oferece suporte a denúncias de salas.';

  @override
  String get reportRateLimited =>
      'Muitas denúncias. Tente novamente mais tarde.';

  @override
  String get reportCouldNotSend =>
      'Não foi possível enviar a denúncia. Tente novamente.';

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
  String get gameBlockDrop => 'Queda de bloco';

  @override
  String get gameBlockDropDesc => 'Solte e elimine linhas';

  @override
  String get gameMinesweeper => 'Campo Minado';

  @override
  String get gameMinesweeperDesc => 'Encontre todas as células seguras';

  @override
  String get gameMatch3 => 'Correspondência 3';

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
  String get storyMyStory => 'Minha história';

  @override
  String get storageSmartCleanup => 'Limpeza Inteligente';

  @override
  String get storageOldMediaFiles => 'Arquivos de mídia antigos';

  @override
  String get storageLargeFiles => 'Arquivos grandes';

  @override
  String get storageAppCache => 'Cache de aplicativos';

  @override
  String get storageSettings => 'Configurações de armazenamento';

  @override
  String get storageAutoCleanup => 'Limpeza automática';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Limpe automaticamente arquivos anteriores a $days dias';
  }

  @override
  String get storageCleanupPeriod => 'Período de limpeza';

  @override
  String get storagePreserveThumbnails => 'Preservar miniaturas';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Mantenha miniaturas de imagens durante a limpeza';

  @override
  String get storageWarningHigh =>
      'O uso de armazenamento é alto. Considere limpar arquivos antigos.';

  @override
  String get storageWarningCritical =>
      'O armazenamento está criticamente baixo. Limpe para liberar espaço.';

  @override
  String storageFreed(String size, int count) {
    return '$size liberado (arquivos $count)';
  }

  @override
  String storageDays(int days) {
    return '$days dias';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Ver todos os quartos $count';
  }

  @override
  String get storageNoFiles => 'Nenhum arquivo encontrado';

  @override
  String get storageFilePinned => 'Fixado';

  @override
  String storageDeleteSelected(int count) {
    return 'Excluir arquivos selecionados $count? Eles podem ser baixados novamente do servidor.';
  }

  @override
  String get backupRestore => 'Backup e restauração';

  @override
  String get backupCreate => 'Criar backup';

  @override
  String get backupCreateDesc =>
      'Faça backup de suas configurações e chaves de criptografia. As mensagens serão restauradas do servidor após o novo login.';

  @override
  String get backupIncludeKeys => 'Incluir chaves de criptografia';

  @override
  String get backupIncludeKeysDesc =>
      'Necessário para ler mensagens criptografadas';

  @override
  String get backupPasswordProtect => 'Proteger por senha';

  @override
  String get backupEnterPassword => 'Digite a senha de backup';

  @override
  String get backupHistory => 'Histórico de backup';

  @override
  String get backupNoBackups => 'Ainda não há backups';

  @override
  String get backupRestore2 => 'Restaurar';

  @override
  String get backupDelete => 'Excluir';

  @override
  String get backupDeleteConfirm =>
      'Tem certeza de que deseja excluir este backup? Isto não pode ser desfeito.';

  @override
  String get backupRestoreFromFile => 'Restaurar do arquivo';

  @override
  String get backupRestoreFromFileDesc =>
      'Importe um arquivo .n42backup de outro dispositivo ou backup anterior.';

  @override
  String get backupChooseFile => 'Escolha o arquivo de backup';

  @override
  String get backupRestoring => 'Restaurando...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Backup criado: salas $rooms, mensagens $messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Configurações $settings restauradas das salas $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Falha no backup: $error';
  }

  @override
  String get backupPasswordRequired => 'Este backup é protegido por senha';

  @override
  String get blocGroupNotFound => 'Grupo não encontrado';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Membro(s) $count convidado(s)';
  }

  @override
  String get blocGroupMemberRemoved => 'Membro removido';

  @override
  String get blocGroupAdminRemoved => 'Administrador removido';

  @override
  String get blocGroupLeft => 'Saiu do grupo';

  @override
  String get blocGroupDisbanded => 'Grupo dissolvido';

  @override
  String get blocGroupJoined => 'Entrou no grupo';

  @override
  String get blocGroupInviteDeclined => 'Convite recusado';

  @override
  String get blocGroupTokenGateUpdated => 'Portão de token atualizado';

  @override
  String get blocTransferProcessing => 'Processando transferência...';

  @override
  String get blocTransferCancelled => 'Transferência cancelada';

  @override
  String get blocTransferFailed => 'Falha na transferência';

  @override
  String get blocPaymentProcessing => 'Processando pagamento...';

  @override
  String get blocPaymentFailed => 'Falha no pagamento';

  @override
  String get groupMaxMembers => 'Limite de membros';

  @override
  String get groupMaxMembersUnlimited => 'Ilimitado';

  @override
  String get groupMaxMembersHint =>
      'Insira o limite (deixe em branco para ilimitado)';

  @override
  String get groupMaxMembersUpdated => 'Limite de membros atualizado';

  @override
  String get groupFull => 'O grupo está lotado';

  @override
  String get groupChannels => 'Canais de tópico';

  @override
  String get groupChannelsEmpty => 'Ainda não há canais';

  @override
  String get groupChannelsCount => 'canais';

  @override
  String get groupChannelCreate => 'Novo canal';

  @override
  String get groupChannelName => 'Nome do canal';

  @override
  String get groupChannelTopic => 'Tópico do canal (opcional)';

  @override
  String get groupChannelDelete => 'Excluir canal';

  @override
  String get groupChannelDeleteConfirm =>
      'Excluir este canal? Todas as mensagens serão perdidas.';

  @override
  String get groupBotSettings => 'Configurações do bot';

  @override
  String get groupBotEnabled => 'Habilitar bot';

  @override
  String get groupBotWelcomeMessage => 'Modelo de mensagem de boas-vindas';

  @override
  String get groupBotWelcomeHint =>
      'Use \'nome\' como espaço reservado para o nome do novo membro';

  @override
  String get groupBotConfigUpdated => 'Configurações do bot atualizadas';

  @override
  String get groupContentFilter => 'Filtro de conteúdo';

  @override
  String get groupContentFilterEnabled => 'Ativar filtro de palavras-chave';

  @override
  String get groupContentFilterReplace => 'Substitua por ***';

  @override
  String get groupContentFilterHide => 'Ocultar mensagem';

  @override
  String get groupContentFilterAddWord => 'Adicionar palavra-chave';

  @override
  String get groupContentFilterUpdated => 'Filtro de conteúdo atualizado';

  @override
  String get chatSlashCommands => 'Comandos';

  @override
  String get chatCommandPoll => '/poll — Crie uma enquete';

  @override
  String get chatCommandAnnounce => '/anunciar — Enviar anúncio';

  @override
  String get chatCommandWelcome => '/welcome — Definir mensagem de boas-vindas';

  @override
  String get chatReportMessage => 'Relatório';

  @override
  String get chatReportReason => 'Motivo do relatório';

  @override
  String get chatReportSpam => 'Spam';

  @override
  String get chatReportHarassment => 'Assédio';

  @override
  String get chatReportInappropriate => 'Conteúdo impróprio';

  @override
  String get chatReportOther => 'Outro';

  @override
  String get chatReportSuccess => 'Relatório enviado';

  @override
  String get spacesName => 'Nome da comunidade';

  @override
  String get spacesNameHint => 'por exemplo Comerciantes de criptografia';

  @override
  String get spacesNameRequired => 'O nome é obrigatório';

  @override
  String get spacesDescription => 'Descrição';

  @override
  String get spacesDescriptionHint => 'Do que se trata esta comunidade?';

  @override
  String get spacesType => 'Tipo de comunidade';

  @override
  String get spacesPublicDesc => 'Qualquer pessoa pode descobrir e participar';

  @override
  String get spacesPrivateDesc => 'Somente membros convidados podem participar';

  @override
  String get spacesNotFound => 'Comunidade não encontrada';

  @override
  String get spacesSearch => 'Pesquisar comunidades...';

  @override
  String get spacesMembers => 'Membros';

  @override
  String get spacesNoChannels => 'Ainda não há canais';

  @override
  String get spacesLeave => 'Sair da comunidade';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Tem certeza de que deseja sair de \"$name\"?';
  }

  @override
  String get spacesDelete => 'Excluir comunidade';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Isso excluirá permanentemente \"$name\" e todos os seus canais. Esta ação não pode ser desfeita.';
  }

  @override
  String get spacesCreateChannel => 'Adicionar canal';

  @override
  String get spacesChannelName => 'Nome do canal';

  @override
  String get spacesChannelTopic => 'Tópico (opcional)';

  @override
  String get spacesDeleteChannel => 'Excluir canal';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Tem certeza de que deseja excluir \"#$name\"?';
  }

  @override
  String get spacesEditName => 'Editar nome';

  @override
  String get spacesEditDescription => 'Editar descrição';

  @override
  String spacesViewAllMembers(int count) {
    return 'Ver todos os membros do $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Chute $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Banimento $name';
  }

  @override
  String get spacesPromoteAdmin => 'Promover a administrador';

  @override
  String get spacesDemoteAdmin => 'Remover administrador';

  @override
  String get spacesInviteMember => 'Convidar membro';

  @override
  String get spacesInviteMemberUserId =>
      'ID do usuário (por exemplo, @user:server.com)';

  @override
  String get spacesSave => 'Salvar';

  @override
  String get settingsScreenshotProtection => 'Proteção de captura de tela';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Impedir capturas de tela e gravação de tela';

  @override
  String get chatSelfDestructTimer => 'Autodestruição';

  @override
  String get chatTimerPickerTitle => 'Temporizador de autodestruição';

  @override
  String get chatTimerOff => 'Desligado';

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
  String get chatMiniApps => 'Aplicativos';

  @override
  String get miniAppMarketTitle => 'Miniaplicativos';

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
      'Este endereço de carteira ainda não possui conta N42. Você pode compartilhar seu link de convite do N42 com eles para começar.';

  @override
  String get web3ShareInvite => 'Partilhar convite';

  @override
  String get nftPickerTitle => 'Selecionar avatar NFT';

  @override
  String get nftPickerTabPopular => 'Populares';

  @override
  String get nftPickerTabCustom => 'Personalizado';

  @override
  String get nftPickerChain => 'Corrente';

  @override
  String get nftPickerContract => 'Endereço do contrato';

  @override
  String get nftPickerTokenId => 'ID do token';

  @override
  String get nftPickerVerifyOwnership =>
      'Verificar propriedade e pré-visualizar';

  @override
  String get nftPickerUseAsAvatar => 'Usar como avatar';

  @override
  String get nftPickerPreview => 'Visualização';

  @override
  String get nftPickerNotOwned => 'Você não possui este NFT';

  @override
  String get nftPickerInvalidTokenId => 'ID do token inválido';

  @override
  String get nftPickerEnterBoth =>
      'Insira o endereço do contrato e o ID do token';

  @override
  String get nftPickerInfoTitle => 'Avatar NFT — Verificado na chain';

  @override
  String get nftPickerInfoDesc =>
      'Vincule um NFT que você possui como seu avatar. Qualquer pessoa pode verificar a propriedade na rede. Exibido com um anel de ouro no N42.';

  @override
  String get nftPickerPopularCollections => 'Coleções populares';

  @override
  String get nftPickerWalletHint =>
      'Conecte sua carteira N42 para descobrir seus NFTs em mais de 236 cadeias.';

  @override
  String get profileBindNftAvatar => 'Vincular avatar NFT';

  @override
  String get profileChangeAvatar => 'Alterar avatar';

  @override
  String get groupTopics => 'Tópicos';

  @override
  String get groupTopicsEmpty => 'Ainda não há tópicos';

  @override
  String get syncInProgress => 'Sincronizando histórico de mensagens...';

  @override
  String get recoveryKeyReminderTitle => 'Proteja suas mensagens';

  @override
  String get recoveryKeyReminderDesc =>
      'Crie uma chave de recuperação para sincronizar com segurança mensagens criptografadas entre dispositivos';

  @override
  String get recoveryKeySetupNow => 'Configurar agora';

  @override
  String get recoveryKeyRemindLater => 'Lembre-me mais tarde';

  @override
  String get channelReadOnly =>
      'Somente administradores podem postar neste canal';

  @override
  String get channelSubscribers => 'assinantes';

  @override
  String get channelVerified => 'Canal verificado';

  @override
  String get redPacketHistory => 'História do Pacote Vermelho';

  @override
  String get redPacketSent => 'Enviado';

  @override
  String get redPacketReceived => 'Recebido';

  @override
  String get redPacketExpired => 'Expirado';

  @override
  String get redPacketClaimed => 'Reivindicado';

  @override
  String get redPacketInsufficientBalance => 'Saldo insuficiente';

  @override
  String selfDestructCountdown(String time) {
    return 'Autodestruição em $time';
  }

  @override
  String get messageDestroyed => 'Mensagem destruída';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Permissão negada: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'O que é taxa de gás?';

  @override
  String get aiSuggestionDefi => 'Guia para iniciantes em DeFi';

  @override
  String get aiSuggestionSecurity => 'Como verificar a segurança do contrato';

  @override
  String get aiSuggestionBridge => 'Ponte entre cadeias';

  @override
  String get channelDiscoverTitle => 'Descubra canais';

  @override
  String get channelDiscoverSearch => 'Pesquisar canais...';

  @override
  String get channelJoin => 'Junte-se';

  @override
  String get channelJoined => 'Ingressou';

  @override
  String get channelCategory => 'Categoria';

  @override
  String slowModeCooldown(int seconds) {
    return 'Modo lento: espere ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Copiar endereço';

  @override
  String get addressSendMessage => 'Enviar mensagem';

  @override
  String get addressViewProfile => 'Ver perfil';

  @override
  String get sendToAddress => 'Enviar para o endereço da carteira';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Falha ao enviar o código de verificação';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Este servidor não suporta redefinição de senha de e-mail';

  @override
  String get blocAuthResetPasswordFailed => 'Falha ao redefinir a senha';

  @override
  String get blocAuthChangePasswordFailed => 'Falha ao alterar a senha';

  @override
  String get blocAuthOldPasswordWrong => 'Senha atual incorreta';

  @override
  String get blocAuthLoginCancelled => 'Login cancelado';

  @override
  String get blocAuthGoogleLoginFailed => 'Falha no login do Google';

  @override
  String get blocAuthAppleLoginFailed => 'Falha no login da Apple';

  @override
  String get blocAuthSsoLoginFailed => 'Falha no login SSO';

  @override
  String get blocAuthFacebookLoginFailed => 'Falha no login do Facebook';

  @override
  String get blocAuthTwitterLoginFailed => 'Falha no login do Twitter';

  @override
  String get blocAuthWeChatLoginFailed => 'Falha no login do WeChat';

  @override
  String get blocAuthWeChatNotConfigured => 'Login do WeChat não configurado';

  @override
  String get blocAuthWeChatNotInstalled => 'Instale o WeChat primeiro';

  @override
  String get blocAuthPasswordWrong => 'Senha incorreta';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Este e-mail já está vinculado a outra conta';

  @override
  String get blocAuthChangeEmailFailed => 'Falha ao alterar e-mail';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'O código de verificação está incorreto ou expirou';

  @override
  String get blocAuthSessionExpired => 'A sessão expirou, faça login novamente';

  @override
  String get blocAuthSessionIncomplete =>
      'Dados da sessão incompletos, faça login novamente';

  @override
  String get chatReadingMode => 'Modo de leitura';

  @override
  String get groupPoints => 'Pontos';

  @override
  String get settingsPrivacySecurity => 'Privacidade e segurança';

  @override
  String get settingsSystemAccounts => 'Sistema e contas';

  @override
  String get settingsNotificationPrivacy => 'Privacidade das notificações';

  @override
  String get settingsSenderOnly => 'Mostrar apenas o remetente';

  @override
  String get settingsHiddenNotification => 'Ocultar remetente e mensagem';

  @override
  String get settingsSmartFilter => 'Filtro inteligente';

  @override
  String get settingsEmailVerificationSent => 'E-mail de verificação enviado';

  @override
  String get settingsEmailLinkInstructions =>
      'Abra o link de verificação no seu e-mail, depois volte aqui e confirme.';

  @override
  String get settingsSendVerificationEmail => 'Enviar e-mail de verificação';

  @override
  String get chatLogoutKeyWarning =>
      'Faça backup das chaves de criptografia antes de sair, ou você poderá perder o acesso às mensagens criptografadas.';

  @override
  String get settingsBiometricUnavailable =>
      'A autenticação biométrica não está disponível. Verifique o cadastro e as permissões nas configurações do dispositivo.';

  @override
  String get chatEncryptionNotReady =>
      'A conexão segura não está pronta. Mensagem não enviada. Verifique a conexão e a verificação dos dispositivos de ambas as contas e tente novamente.';

  @override
  String get contactRequestPending => 'Aguardando aceitação';

  @override
  String get chatFriendRequestPending =>
      'A amizade não foi confirmada. Verifique Contatos > Novos amigos antes de enviar mensagens.';

  @override
  String contactPhotoCount(int count) {
    return '$count fotos';
  }

  @override
  String get videoPublish => 'Publicar vídeo';

  @override
  String get videoGoLive => 'Iniciar transmissão ao vivo';

  @override
  String get videoSelect => 'Selecionar vídeo';

  @override
  String get videoLiveUnavailable =>
      'A transmissão ao vivo não está disponível';

  @override
  String get qrcodeAlbum => 'Álbum';

  @override
  String get settingsSwitchAccount => 'Trocar de conta';

  @override
  String get chatFilterUnread => 'Não lidas';

  @override
  String get chatFilterEmpty => 'Nenhuma conversa neste filtro';

  @override
  String get accountAdd => 'Adicionar conta';

  @override
  String get accountCurrent => 'Conta atual';

  @override
  String get accountSwitching => 'Trocando de conta…';

  @override
  String get accountSwitchFailed =>
      'Não foi possível trocar de conta. Tente novamente ou adicione a conta para entrar de novo.';

  @override
  String get accountSessionsHint =>
      'Troque de conta aqui para manter separadas as mensagens e a sessão segura de cada conta.';

  @override
  String get accountNoSaved => 'Nenhuma conta salva';

  @override
  String get contactRequestSent => 'Solicitação enviada';

  @override
  String get contactRequestsIncoming => 'Solicitações recebidas';

  @override
  String get contactRequestsOutgoing => 'Solicitações enviadas';

  @override
  String get contactRequestHint =>
      'Você poderá conversar e ligar depois que a solicitação for aceita.';

  @override
  String get callReturnToCall => 'Voltar à chamada';

  @override
  String get chatMessageSending => 'Enviando';

  @override
  String get chatMessageSent => 'Enviada';

  @override
  String get chatMessageDelivered => 'Entregue';

  @override
  String get chatMessageRead => 'Lida';

  @override
  String get chatMessageFailed => 'Não enviada. Toque para tentar novamente.';

  @override
  String get chatMessageUnavailable =>
      'Mensagem indisponível neste dispositivo. Toque para ver as opções de recuperação.';

  @override
  String get contactStarredFriends => 'Contatos favoritos';

  @override
  String get chatRecipientKeysMissing =>
      'Este contato não tem uma sessão criptografada disponível. Peça que entre na conta e abra o aplicativo e tente novamente. Para trocar de conta, use «Trocar de conta» em vez de sair.';

  @override
  String get chatSwitchForMessaging =>
      'Quer trocar de conta? Use «Trocar de conta» para manter as mensagens e sessões seguras. Sair revoga este dispositivo e pode impedir a leitura de novas mensagens criptografadas.';

  @override
  String get aiServiceUnavailable =>
      'Os resumos de IA estão indisponíveis. Tente novamente quando o acesso ao serviço for restabelecido.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Resumir $count mensagens recentes';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined participantes · $invited convidados';
  }

  @override
  String contactPendingCount(int count) {
    return '$count solicitações pendentes';
  }

  @override
  String get chatDraftLabel => 'Rascunho';

  @override
  String get contactIndexLabel => 'Índice de contatos';

  @override
  String get transferAssetUnavailable =>
      'O ativo de pagamento não está disponível';

  @override
  String get transferPaymentRequestUnavailable =>
      'A solicitação de pagamento não está disponível';

  @override
  String get chatCatchUp => 'Colocar em dia';

  @override
  String get chatCatchUpMentions => 'Menções';

  @override
  String get chatCatchUpReplies => 'Respostas às minhas mensagens';

  @override
  String get chatCatchUpPinned => 'Mensagens fixadas';

  @override
  String get chatCatchUpScope =>
      'As menções e respostas usam as mensagens carregadas, inclusive as já lidas. Carregue mensagens mais antigas para encontrar respostas anteriores.';

  @override
  String get chatCatchUpLoadMore => 'Carregar mensagens mais antigas';

  @override
  String get chatActionPreview => 'Revisar sugestão de calendário';

  @override
  String get chatActionPrivacy =>
      'Somente o título e o horário abaixo serão compartilhados com seu aplicativo de calendário após a confirmação. Verifique o fuso horário. Sua conta de calendário pode sincronizar este evento.';

  @override
  String get chatActionTitle => 'Evento da conversa';

  @override
  String get chatActionSuggestion => 'Sugestão de calendário';

  @override
  String get chatUnreadAttention => 'Menções e respostas não lidas';

  @override
  String get chatScanAgain => 'Pesquisar novamente';

  @override
  String get chatUnreadScope =>
      'Examina o histórico do servidor até seu marcador de leitura. Abra uma conversa para lê-la; atualize para reconstruir os resultados.';

  @override
  String get chatScanIncomplete =>
      'Incompleto: histórico, descriptografia ou marcador de leitura indisponível. Tente novamente após a sincronização.';

  @override
  String get chatHistoryShare => 'Compartilhar histórico selecionado';

  @override
  String get chatHistoryExplanation =>
      'Somente administradores. Selecione texto simples e uma conversa direta criptografada existente com um membro que tenha entrado no grupo. O compartilhamento cria mensagens de auditoria visíveis no grupo.';

  @override
  String get chatHistoryEnable => 'Ativar compartilhamento';

  @override
  String get chatHistoryDisable => 'Desativar compartilhamento';

  @override
  String get chatHistoryPolicy =>
      'Política de compartilhamento do histórico do grupo';

  @override
  String get chatHistoryPolicyDetail =>
      'Somente administradores podem compartilhar. A ativação também restringe a visibilidade do histórico do grupo aos eventos posteriores à entrada. Defina abaixo os limites de mensagens de texto e confirme.';

  @override
  String get chatHistoryPolicySaved => 'Política salva';

  @override
  String get chatHistoryRecipient => 'Conversa criptografada do destinatário';

  @override
  String get chatHistoryReview => 'Revisar mensagens selecionadas';

  @override
  String get chatHistoryMessages => 'mensagens';

  @override
  String get chatHistoryConfirmDetail =>
      'Antes de compartilhar, confirme o destinatário, cada mensagem e seu horário. Um resultado de falha ou desconhecido pode já ter enviado conteúdo: verifique o resultado antes de continuar.';

  @override
  String get chatHistoryCompleted =>
      'Histórico selecionado enviado e auditoria do grupo confirmada';

  @override
  String get chatHistoryPending =>
      'Pendente: verifique o resultado e confirme novamente para continuar. Envios com resultado desconhecido nunca são repetidos.';

  @override
  String get chatHistoryReconcile => 'Verificar resultado do envio';

  @override
  String get chatHistoryFailed =>
      'Não foi possível concluir. Verifique o acesso de administrador, a política do grupo, a criptografia, a participação do destinatário e a seleção. Se o envio começou, verifique seu resultado.';

  @override
  String get chatDeviceActions => 'Ações no dispositivo';

  @override
  String get chatDeviceActionsReview =>
      'Após a confirmação, somente esta mensagem é fornecida às sugestões de ações do sistema no dispositivo. Escolha uma ação para abrir Calendário, Lembretes ou Mapas.';

  @override
  String get chatHistoryMaxMessages => 'Limite de mensagens (1–50)';

  @override
  String get chatHistoryMaxHours => 'Período do histórico em horas (1–720)';

  @override
  String get chatNotifyAll => 'Todas as mensagens';

  @override
  String get chatNotifyAllDescription =>
      'Notificar cada nova mensagem nesta conversa';

  @override
  String get chatNotifyMentions => 'Apenas menções';

  @override
  String get chatNotifyMentionsDescription =>
      'Notificar apenas quando você for mencionado ou @room for usado';

  @override
  String get chatNotifyMutedDescription =>
      'Desativar as notificações desta conversa em todos os dispositivos';

  @override
  String get scheduledMessagesTitle => 'Mensagens agendadas';

  @override
  String get scheduledMessagesEmpty => 'Ainda não há mensagens agendadas';

  @override
  String get scheduledMessagesHint =>
      'Mantenha pressionado Enviar, Fotos, Arquivos, um GIF ou uma figurinha para agendar uma mensagem.';

  @override
  String get scheduledMessageCancelled => 'Mensagem agendada cancelada';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Criado em $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Entrega não confirmada';

  @override
  String get scheduledRecoveryCopy => 'Salvar cópia de recuperação';

  @override
  String get scheduledRecoveryCopyHint =>
      'Salva neste dispositivo sem alterar nem enviar mensagens. A prévia mostra até 8.000 caracteres.';

  @override
  String get scheduledRecoveryCopies => 'Cópias de recuperação';

  @override
  String get scheduledRecoveryReset => 'Redefinir fila danificada';

  @override
  String get scheduledRecoveryResetHint =>
      'Uma cópia exata foi salva neste dispositivo. Redefinir todas as mensagens agendadas desta conta? Algumas podem já ter sido enviadas. As cópias e os anexos serão mantidos. Nada será reenviado.';

  @override
  String get scheduledRecoveryExportHint =>
      'Este arquivo contém texto de rascunhos e dados da conta não criptografados. Os anexos não estão incluídos. Escolha um destino confiável.';

  @override
  String get scheduledRecoveryImport => 'Importar cópia de recuperação';

  @override
  String get scheduledRecoveryImportHint =>
      'Salvar esta prévia apenas como cópia de recuperação. Nenhuma mensagem será agendada ou enviada. Os anexos não estão incluídos. O autor do arquivo não foi verificado.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Acrescente o texto ao rascunho atual para revisão. Nada será enviado. Anexos, menções e temporizadores não serão restaurados. Verifique se esta mensagem já foi entregue.';

  @override
  String get backupRecoverLegacyArchive => 'Recuperar histórico local anterior';

  @override
  String get backupLegacyArchiveWarning =>
      'O proprietário deste histórico não foi verificado. Copie apenas suas salas para a conta abaixo. O original será mantido.';

  @override
  String get backupOlderFiles => 'Arquivos de backup anteriores';

  @override
  String get backupOlderFilesWarning =>
      'Estes arquivos podem pertencer a outra conta. Selecione um arquivo para verificar o conteúdo e o proprietário antes de restaurar.';

  @override
  String get stickerImportTitle => 'Importar pacote de figurinhas';

  @override
  String get stickerImportLinkHint => 'Link do pacote de figurinhas Matrix';

  @override
  String get stickerImportPreview => 'Prévia';

  @override
  String get stickerImportUnavailable =>
      'Este pacote não está disponível ou você não tem acesso.';

  @override
  String get stickerImportCopyNotice =>
      'Adicione uma cópia privada deste pacote. As imagens e os metadados não têm criptografia de ponta a ponta.';

  @override
  String get stickerImportFailed =>
      'Não foi possível adicionar este pacote. Tente novamente.';

  @override
  String get stickerImportAccountChanged =>
      'A conta mudou ou a sessão expirou. Abra a importação de figurinhas novamente.';

  @override
  String get stickerPackSourceRoom => 'Conversa de origem';

  @override
  String get stickerPackImages => 'Imagens';

  @override
  String get stickerPublishNotice =>
      'Publique este pacote no grupo selecionado. As imagens e os metadados não têm criptografia de ponta a ponta. Quem puder ler o estado do grupo poderá acessá-los.';

  @override
  String get stickerPublishFailed =>
      'A publicação não foi confirmada. Verifique o grupo antes de tentar novamente.';

  @override
  String get stickerPublishReceiptMissing =>
      'Publicado, mas o link não foi salvo. Compartilhe ou copie o link antes de sair desta página.';

  @override
  String get stickerSubscribe => 'Assinar atualizações';

  @override
  String get stickerSubscribeNotice =>
      'Receba futuras alterações dos administradores do pacote. Imagens e metadados não têm criptografia de ponta a ponta. Você pode cancelar a assinatura depois; isso não faz você entrar na conversa de origem.';

  @override
  String get stickerSubscriptions => 'Assinaturas de figurinhas';

  @override
  String get stickerUnsubscribe => 'Cancelar assinatura';

  @override
  String get stickerSubscriptionsEmpty => 'Nenhuma assinatura de figurinhas';

  @override
  String get chatAttachmentEvent => 'Evento';

  @override
  String get chatRecentMedia => 'Fotos e vídeos recentes';

  @override
  String get chatRecentMediaLoadFailed =>
      'Não foi possível carregar as mídias recentes';

  @override
  String get chatRecentMediaPermission =>
      'É necessário acesso às fotos para mostrar as mídias recentes';

  @override
  String get chatRecentMediaEmpty => 'Nenhuma foto ou vídeo recente';

  @override
  String get chatRecentPhoto => 'Foto recente';

  @override
  String get chatRecentVideo => 'Vídeo recente';

  @override
  String get chatAttachmentTip => 'Gorjeta';

  @override
  String get chatAttachmentWhiteboard => 'Quadro branco';

  @override
  String get chatAttachmentVideoNote => 'Mensagem de vídeo';

  @override
  String get chatAttachmentCode => 'Código';

  @override
  String get chatAttachmentShop => 'Loja';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Limite de seleção: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Hoje à noite ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Amanhã de manhã ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Rolar até o fim';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Digite uma mensagem antes de agendar';

  @override
  String get ui3SendCode => 'Enviar código';

  @override
  String get ui3CodeLanguage => 'Linguagem';

  @override
  String get ui3PasteCodeHere => 'Cole o código aqui';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Lembrete definido · $time';
  }

  @override
  String get ui3RedPacketCreateFailed =>
      'Não foi possível criar o envelope vermelho';

  @override
  String get ui3SendTip => 'Enviar gorjeta';

  @override
  String get ui3TokenLabel => 'Criptomoeda';

  @override
  String get ui3NoteOptional => 'Observação (opcional)';

  @override
  String ui3TipFailed(String error) {
    return 'Falha na gorjeta: $error';
  }

  @override
  String get ui3GiftNftTitle => 'Presentear um NFT';

  @override
  String get ui3TokenId => 'ID do token';

  @override
  String ui3NftGiftFailed(String error) {
    return 'Falha ao presentear o NFT: $error';
  }

  @override
  String get ui3AiAgentSubtitle => 'Descreva uma tarefa e abra o miniapp certo';

  @override
  String get ui3GiftNft => 'Presentear NFT';

  @override
  String get ui3GiftNftSubtitle => 'Enviar um NFT para este contato';

  @override
  String get ui3MiniAppUnavailable => 'O miniapp não está disponível';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'Não foi possível enviar $count item(ns) de mídia selecionado(s)';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Envie fotos e vídeos em formato adequado para o chat';

  @override
  String get ui3OriginalImages => 'Imagens originais';

  @override
  String get ui3OriginalImagesSubtitle =>
      'Enviar fotos sem compressão como arquivos';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename agendado para $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Enviando imagem original: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Imagem original agendada: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Pagamento já enviado';

  @override
  String get ui3PaymentProcessing => 'O pagamento está sendo processado';

  @override
  String ui3ChainStatus(String status) {
    return 'Status na blockchain: $status';
  }

  @override
  String get ui3NotChecked => 'Não verificado';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Confirmado: $confirmations / $required blocos';
  }

  @override
  String get ui3CopyTxHash => 'Copiar hash da transação';

  @override
  String get ui3VerifyAgain => 'Verificar novamente';

  @override
  String get ui3VerifyOnChain => 'Verificar na blockchain';

  @override
  String get ui3TransferMissingChainDetails =>
      'Esta transferência não inclui os detalhes exatos da rede e do ativo.';

  @override
  String get ui3ReceiptPending => 'Pendente na blockchain';

  @override
  String get ui3ReceiptConfirmed => 'Confirmado';

  @override
  String get ui3ReceiptFailed => 'Falhou na blockchain';

  @override
  String get ui3ReceiptMismatch => 'Os detalhes da transação não conferem';

  @override
  String get ui3ReceiptUnsupported => 'Verificação na blockchain não suportada';

  @override
  String get ui3ReceiptUnavailable => 'Verificação indisponível';

  @override
  String get ui3OpenOrSave => 'Abrir / Salvar';

  @override
  String get ui3UnableToOpenFile => 'Não foi possível abrir este arquivo.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'Falha ao reescrever com IA: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Compartilhar mensagens com a IA?';

  @override
  String get ui3AiShareMessagesBody =>
      'Selecione as mensagens que a IA pode usar nesta resposta. Esta autorização única expira após dois minutos. Fechar a Resposta rápida cancela os resultados pendentes. Ela não permite pagamentos nem exportações.';

  @override
  String get ui3OtherParticipant => 'Outra pessoa';

  @override
  String get ui3ShareSelected => 'Compartilhar selecionadas';

  @override
  String get ui3BotCommandError => 'Erro de comando';

  @override
  String get ui3BotUnknownCommand => 'Comando desconhecido';

  @override
  String get ui3BotTypeHelp => 'Digite /help para ver os comandos disponíveis.';

  @override
  String get ui3FilesMediaLinks => 'Arquivos, mídia e links';

  @override
  String get ui3ChatStorage => 'Armazenamento da conversa';

  @override
  String get ui3EncryptionKeysDevices =>
      'Chaves de criptografia e dispositivos';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'O serviço de criptografia ainda não está disponível';

  @override
  String get ui3ExportLoadingHistory =>
      'Carregando mais histórico da conversa para exportação...';

  @override
  String get ui3ExportTxtDesc =>
      'Transcrição em texto simples para anotações, backup ou revisão de conformidade';

  @override
  String get ui3ExportCustomRange => 'Período personalizado';

  @override
  String get ui3ExportStart => 'Início';

  @override
  String get ui3ExportEnd => 'Fim';

  @override
  String get ui3ExportSelectDate => 'Selecionar data';

  @override
  String get ui3FolderFilterUnreadOnly => 'Somente não lidas';

  @override
  String get ui3FolderFilterMutedOnly => 'Somente silenciadas';

  @override
  String get ui3FolderFilterNoDms => 'Sem mensagens diretas';

  @override
  String get ui3FolderFilterNoGroups => 'Sem grupos';

  @override
  String get ui3FolderFilterNoChannels => 'Sem canais';

  @override
  String get ui3FolderFilterAllChats => 'Todas as conversas';

  @override
  String get ui3Create => 'Criar';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Excluir a pasta \"$name\"?';
  }

  @override
  String get a11yDecreaseTextSize => 'Diminuir tamanho do texto';

  @override
  String get a11yIncreaseTextSize => 'Aumentar tamanho do texto';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes min de leitura';
  }

  @override
  String get ui3TipOnChain => 'Na blockchain ✓';

  @override
  String get ui3ViewSource => 'Ver código-fonte';

  @override
  String get a11yPreviousPage => 'Página anterior';

  @override
  String get a11yNextPage => 'Próxima página';

  @override
  String get ui3OpenExternalLinkTitle => 'Abrir link externo?';

  @override
  String get ui3Open => 'Abrir';

  @override
  String get ui3UnableToOpenLink => 'Não foi possível abrir este link.';

  @override
  String get ui3ImageUnavailable => 'Imagem indisponível';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Carregar imagem de $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Tentar carregar a imagem de $host novamente';
  }

  @override
  String get ui3TranslatedByN42 => 'Traduzido por N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Traduzido de $language por N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Limpar o quadro branco?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Todos os traços serão removidos para todos. Essa ação não pode ser desfeita.';

  @override
  String get ui3WhiteboardLive => 'Quadro branco · Ao vivo';

  @override
  String get a11yPenColor => 'Cor da caneta';

  @override
  String get ui3AiDescribeOcr => 'Descrição por IA / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Não foi possível visualizar este documento com segurança. Verifique a conexão e o tamanho do arquivo (máx. 2 MB).';

  @override
  String get ui3AiConsentMessage =>
      'Selecione as mensagens que a IA pode usar neste resumo. Esta autorização única expira após dois minutos. Ela não permite pagamentos nem exportações.';

  @override
  String get ui3AiSuggestedReplies => 'Respostas sugeridas';

  @override
  String get ui3AiGeneratingSuggestions => 'Gerando sugestões...';

  @override
  String get ui3StickersEmpty => 'Nenhuma figurinha ainda';

  @override
  String get ui3StickersGet => 'Obter figurinhas';

  @override
  String get a11yFormatBold => 'Negrito';

  @override
  String get a11yFormatItalic => 'Itálico';

  @override
  String get a11yFormatStrikethrough => 'Tachado';

  @override
  String get a11yFormatInlineCode => 'Código embutido';

  @override
  String get a11yFormatCodeBlock => 'Bloco de código';

  @override
  String get a11yFormatChecklistItem => 'Item de checklist';

  @override
  String get a11yFormatBulletList => 'Lista com marcadores';

  @override
  String get a11yFormatNumberedList => 'Lista numerada';

  @override
  String get a11yFormatLink => 'Inserir link';

  @override
  String get a11yFormatTable => 'Tabela';

  @override
  String get a11yFormatMeetingTemplate => 'Modelo de reunião';

  @override
  String get a11yEmojiSmileys => 'Emojis e pessoas';

  @override
  String get a11yEmojiHearts => 'Corações';

  @override
  String get a11yEmojiAnimals => 'Animais e natureza';

  @override
  String get a11yEmojiFood => 'Comida e bebida';

  @override
  String get a11yEmojiTravel => 'Viagens e lugares';

  @override
  String get a11yEmojiActivities => 'Atividades';

  @override
  String get a11yEmojiObjects => 'Objetos';

  @override
  String get a11yEmojiSymbols => 'Símbolos';

  @override
  String get ui3FrequentlyUsed => 'Usados com frequência';

  @override
  String get ui3NoEditHistory => 'Nenhum histórico de edição';

  @override
  String get ui3EventNew => 'Novo evento';

  @override
  String get ui3EventTitleLabel => 'Título';

  @override
  String get ui3EventLocationOptional => 'Local (opcional)';

  @override
  String get ui3EventDescriptionOptional => 'Descrição (opcional)';

  @override
  String get ui3EventSend => 'Enviar evento';

  @override
  String get ui3EventTitleRequired => 'O título é obrigatório';

  @override
  String get ui3EventEndAfterStart =>
      'O horário de término deve ser após o início';

  @override
  String get ui3MiniAppAgentIntro =>
      'Descreva o que você quer fazer e eu abro o miniapp certo.';

  @override
  String get ui3MiniAppAgentExample => 'ex.: trocar ETH por USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Nenhum miniapp correspondente encontrado. Tente reformular.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Abrir $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Compatível com links de músicas do NetEase Cloud Music, QQ Music, Kugou, Kuwo e outros';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'Marque uma resposta correta não vazia';

  @override
  String get ui3PollQuizMode => 'Modo quiz';

  @override
  String get ui3PollAnswerExplanationHint =>
      'Explicação da resposta (opcional)';

  @override
  String get a11yCorrectAnswer => 'Resposta correta';

  @override
  String get ui3AiSuggestions => 'Sugestões de IA';

  @override
  String get a11yPaste => 'Colar';

  @override
  String get a11yRefresh => 'Atualizar';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Guarde esta chave em local seguro. Ela é a única forma de recuperar suas mensagens criptografadas se você perder o acesso a todos os dispositivos.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Salvo: $path';
  }

  @override
  String get ui3UnknownAccount => 'Conta desconhecida';

  @override
  String get ui3UnknownHomeserver => 'Servidor desconhecido';

  @override
  String get ui3ImportRecoveryKey => 'Importar chave de recuperação';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Digite ou cole sua chave de recuperação para restaurar as chaves das salas do histórico de mensagens criptografadas.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Conta: $account\\nServidor: $homeserver';
  }

  @override
  String get ui3Import => 'Importar';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Formato de chave de recuperação inválido';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '$restored de $total chaves restauradas. $failed chaves falharam. Verifique a conta, a rede e o backup e tente novamente. Parte do histórico pode continuar ilegível.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '$restored de $total chaves restauradas com sucesso';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Falha na importação: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Falha ao registrar a chave de acesso: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'Minha chave de acesso';

  @override
  String get ui3PasskeyNameHint => 'ex.: iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Falha ao excluir a chave de acesso';

  @override
  String get ui3TwoFactorAuth => 'Autenticação de dois fatores';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'Ativada — código do app autenticador obrigatório';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Desativada — proteja com um app autenticador (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Mostrar chave de recuperação';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Exibir sua chave de recuperação para backup';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Restaurar mensagens usando uma chave de recuperação';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Falha ao criar a chave de recuperação';

  @override
  String get ui3TotpIncorrectCode => 'Código incorreto, tente novamente';

  @override
  String get ui3TwoFactorEnabled => 'Autenticação de dois fatores ativada';

  @override
  String get ui3TwoFactorDisabled => 'Autenticação de dois fatores desativada';

  @override
  String get ui3TwoFactorTurnOffTitle =>
      'Desativar a autenticação de dois fatores?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'Seu app autenticador não será mais exigido. Você pode configurá-lo de novo depois com uma nova chave.';

  @override
  String get ui3TurnOff => 'Desativar';

  @override
  String get ui3TwoFactorTotpTitle => 'Dois fatores (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'A autenticação de dois fatores está ativada';

  @override
  String get ui3TwoFactorCodeRequired =>
      'É necessário um código do seu app autenticador.';

  @override
  String get ui3TotpStepScan =>
      '1. Escaneie este QR code com um app autenticador (Google Authenticator, Authy, 1Password…) ou digite a chave manualmente.';

  @override
  String get ui3TotpKeyCopied => 'Chave copiada';

  @override
  String get ui3TotpStepConfirm =>
      '2. Digite o código de 6 dígitos para confirmar.';

  @override
  String get ui3Enable => 'Ativar';

  @override
  String get ui3BackupSettingsDesc =>
      'Faça backup das configurações locais do chat. As mensagens serão restauradas do servidor depois de entrar novamente.';

  @override
  String get ui3BackupKeysSeparate =>
      'As chaves de criptografia são gerenciadas separadamente';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Use Segurança > Chave de recuperação para fazer backup do acesso às mensagens criptografadas.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms salas  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Importe um arquivo .n42backup de outro dispositivo ou de um backup anterior. As chaves de criptografia são restauradas separadamente com sua chave de recuperação.';

  @override
  String get ui3UsernameSessionRequired =>
      'O nome de usuário exige uma sessão ativa';

  @override
  String get ui3SecuritySessionRequired =>
      'As configurações de segurança exigem uma sessão ativa';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'As contas conectadas exigem uma sessão ativa';

  @override
  String get ui3SystemAccounts => 'Sistema e contas';

  @override
  String get ui3AccountIdentity => 'Conta e identidade';

  @override
  String get ui3Accounts => 'Contas';

  @override
  String get ui3DevicesSessions => 'Dispositivos e sessões';

  @override
  String get ui3Integrations => 'Integrações';

  @override
  String get ui3ConnectedAccounts => 'Contas conectadas';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Integrações com Telegram, WhatsApp, Discord e pontes de API';

  @override
  String get ui3SystemOverview => 'Visão geral do sistema';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas',
      one: '1 conta',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dispositivos',
      one: '1 dispositivo',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Criptografia de ponta a ponta, proteção contra capturas de tela e controle de proxy';

  @override
  String get ui3ConversationPrivacy => 'Privacidade das conversas';

  @override
  String get ui3NetworkPrivacy => 'Privacidade de rede';

  @override
  String get ui3IdentityPrivacy => 'Privacidade de identidade';

  @override
  String get ui3EncryptionKeyBackup => 'Criptografia e backup de chaves';

  @override
  String get ui3DevicesVerification => 'Dispositivos e verificação';

  @override
  String get ui3ChipE2eeDefault => 'E2EE por padrão';

  @override
  String get ui3ChipManualE2ee => 'E2EE manual';

  @override
  String get ui3ChipSelfDestruct => 'Autodestruição';

  @override
  String get ui3ChipScreenshotGuard => 'Proteção contra capturas';

  @override
  String get ui3ChipIpProxy => 'IP / servidor proxy';

  @override
  String get ui3ChipLinkPreviewsOff => 'Prévias de links desativadas';

  @override
  String get ui3ChipPublicHandle => 'Nome de usuário público';

  @override
  String get a11yShowPassword => 'Mostrar senha';

  @override
  String get a11yHidePassword => 'Ocultar senha';

  @override
  String get a11yCheckServer => 'Verificar servidor';

  @override
  String get ui3AuthAnonymousRegistration => 'Cadastro anônimo';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Crie uma conta sem vincular telefone ou e-mail. Um nome de usuário será gerado automaticamente.';

  @override
  String get ui3AuthAnonymousModeOn => 'O modo anônimo está ativado';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'O app vai criar um nome de usuário Matrix aleatório para você. Você ainda pode entrar depois com a conta e a senha geradas.';

  @override
  String get ui3AuthChooseLoginMethod => 'Escolha a forma de login';

  @override
  String get ui3AuthSsoOpenFailed =>
      'Não foi possível abrir a página de login SSO';

  @override
  String get ui3AuthWalletUnavailable => 'A carteira não está disponível';

  @override
  String get ui3ProfileSubscriptions => 'Assinaturas';

  @override
  String get ui3ProfileBuySellCrypto => 'Comprar / vender cripto';

  @override
  String get ui3ProfileOnDeviceAi => 'IA no dispositivo';

  @override
  String get ui3ProfileSetAUsername => 'Definir um nome de usuário';

  @override
  String get ui3ProfileAvatarStudio => 'Estúdio de avatar';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'Avatar NFT / Decorações';

  @override
  String get ui3ProfileCustomize => 'Personalizar';

  @override
  String get ui3ProfileQrSubtitle =>
      'Escaneie para abrir este perfil ou iniciar uma conversa';

  @override
  String get ui3PrivacyHardening => 'Reforço de privacidade';

  @override
  String get ui3HidePhoneNumber => 'Ocultar número de telefone';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Ocultar o número de telefone vinculado nas telas de perfil deste dispositivo';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'Criptografar novas conversas por padrão';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Iniciar novas conversas diretas e salas privadas com E2EE ativada';

  @override
  String get ui3PrivateChatMode => 'Modo de conversa privada';

  @override
  String get ui3PrivateChatModeDesc =>
      'Bloquear temporariamente capturas de tela ao ver conversas privadas ou criptografadas';

  @override
  String get ui3DefaultSelfDestructTimer => 'Timer de autodestruição padrão';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Aplicar um timer de autodestruição padrão às novas mensagens enviadas';

  @override
  String get ui3LinkPreviews => 'Prévias de links';

  @override
  String get ui3LinkPreviewsDesc =>
      'Buscar títulos, descrições e miniaturas quando as mensagens contêm URLs';

  @override
  String get ui3IpAddressProtection => 'Proteção de endereço IP';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Encaminhar as solicitações do Matrix e das prévias de links pelo proxy HTTP de privacidade configurado, quando disponível';

  @override
  String get ui3UseTorProxy => 'Usar proxy HTTP Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Use um endpoint de proxy HTTP local, como o Privoxy em 127.0.0.1:8118. O roteamento nativo do Tor via SOCKS5 não é compatível aqui.';

  @override
  String get ui3CustomProxy => 'Proxy personalizado';

  @override
  String get ui3CustomProxyDesc =>
      'Usar um proxy HTTP ou HTTPS personalizado para o tráfego do Matrix e as prévias de links';

  @override
  String get ui3ProxyEndpoint => 'Endereço do proxy';

  @override
  String get ui3ProxyEndpointDesc =>
      'Endereço de proxy HTTP/HTTPS (SOCKS não compatível)';

  @override
  String get ui3InvalidEndpoint => 'Endereço inválido';

  @override
  String get ui3CustomProxyStaysOff =>
      'O proxy personalizado fica desativado até você definir um endereço válido';

  @override
  String get ui3NotificationFilterNote =>
      'As regras prioritárias sempre notificam (ignorando silenciamento, só menções e Não perturbe). Palavras-chave silenciadas bloqueiam notificações.';

  @override
  String get ui3PriorityKeywords => 'Palavras-chave prioritárias';

  @override
  String get ui3PriorityKeywordHint => 'ex.: urgente';

  @override
  String get ui3MutedKeywords => 'Palavras-chave silenciadas';

  @override
  String get ui3MutedKeywordHint => 'ex.: spam';

  @override
  String get ui3PrioritySenders => 'Remetentes prioritários';

  @override
  String get ui3CaseSensitive => 'Diferenciar maiúsculas e minúsculas';

  @override
  String get ui3None => 'Nenhuma';

  @override
  String get ui3SmartReplyTranslation => 'Tradução de respostas inteligentes';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Traduza automaticamente suas mensagens para o idioma do destinatário antes de enviar.';

  @override
  String get ui3FromPhotos => 'Das Fotos';

  @override
  String get ui3ChangePhoto => 'Trocar foto';

  @override
  String get ui3RoamingUsesMobileData =>
      'Roaming usa as regras de dados móveis';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'A detecção de roaming ainda não está disponível, então o roaming segue por enquanto as configurações de download automático dos dados móveis.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Excluir \"$content\"?';
  }

  @override
  String get ui3ResetToDefaults => 'Restaurar padrões';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Isso vai remover todas as respostas rápidas personalizadas e restaurar as padrão. Continuar?';

  @override
  String get ui3LocalLlmUnavailable => 'Não compatível com este dispositivo';

  @override
  String get ui3LocalLlmNotDownloaded => 'Modelo não baixado';

  @override
  String get ui3LocalLlmReady => 'Pronto (no dispositivo)';

  @override
  String get ui3LocalLlmDescription =>
      'Quando ativados e prontos, os recursos de IA (resumir, reescrever, traduzir, responder) rodam totalmente no dispositivo — os dados nunca saem do seu celular. Caso contrário, usam o provedor em nuvem.';

  @override
  String get ui3UseOnDeviceAi => 'Usar IA no dispositivo';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'Preferir inferência local quando estiver pronta';

  @override
  String get ui3DownloadModel => 'Baixar modelo';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'A inferência no dispositivo exige o runtime nativo (Android MediaPipe / iOS Core ML). Ela será ativada automaticamente quando o handler da plataforma estiver disponível.';

  @override
  String get ui3PhotoAvatar => 'Avatar com foto';

  @override
  String get ui3AvatarStyles => 'Estilos de avatar';

  @override
  String get ui3AvatarStylesDesc =>
      'Usar um único seletor de decorações para o perfil e os acessos ao avatar.';

  @override
  String get ui3ReplaceNftAvatar => 'Substituir avatar NFT';

  @override
  String get ui3NftAvatarDesc =>
      'Use um colecionável on-chain como seu avatar.';

  @override
  String get ui3UsePhotoAvatar => 'Usar avatar com foto';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Manter o avatar enviado e remover o vínculo com o NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Estilo de avatar definido: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'Avatar NFT atualizado';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Voltou para o avatar com foto';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Entre para ver o histórico de envelopes vermelhos';

  @override
  String get ui3RedPacketActive => 'Ativos';

  @override
  String get ui3RedPacketCompleted => 'Concluídos';

  @override
  String get ui3CardsAndPasses => 'Cartões e passes';

  @override
  String get ui3CardsAndPassesDesc =>
      'Cartões da carteira, cupons e passes são gerenciados no app principal.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'O pacote de cartões exige o app principal';

  @override
  String get ui3OpenCardPack => 'Abrir pacote de cartões';

  @override
  String get ui3UnableToOpenChat =>
      'Não foi possível abrir uma conversa com este contato';

  @override
  String get ui3WalletManagedInMainApp =>
      'A carteira é gerenciada no app principal';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Planos';
  }

  @override
  String get ui3NewPlan => 'Novo plano';

  @override
  String get ui3MySubscriptions => 'Minhas assinaturas';

  @override
  String get ui3AvailablePlans => 'Planos disponíveis';

  @override
  String get ui3NoPlansYet =>
      'Nenhum plano ainda · toque em \"Novo plano\" para criar um';

  @override
  String ui3DaysLeft(Object days) {
    return 'Faltam $days d';
  }

  @override
  String get ui3SubscriptionCancelled => 'Cancelada';

  @override
  String get ui3AutoRenewOn => 'Renovação automática: ativada';

  @override
  String get ui3AutoRenewOff => 'Renovação automática: desativada';

  @override
  String get ui3CancelSubscriptionTitle => 'Cancelar assinatura?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Sua assinatura de $name continua ativa até expirar e não será renovada.';
  }

  @override
  String get ui3Subscribe => 'Assinar';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Você assinou $name';
  }

  @override
  String get ui3PlanPriceLabel => 'Preço (ex.: 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Descrição (opcional)';

  @override
  String get ui3PlanBenefitsLabel => 'Benefícios (separados por vírgula)';

  @override
  String get ui3PlanPeriod => 'Período:';

  @override
  String get ui3Monthly => 'Mensal';

  @override
  String get ui3Yearly => 'Anual';

  @override
  String get ui3SaveRemarkFailed => 'Falha ao salvar a observação';

  @override
  String get ui3CopyLink => 'Copiar link';

  @override
  String get ui3Connect => 'Conectar';

  @override
  String get ui3CommonTokens => 'Tokens em comum';

  @override
  String get ui3SharedNfts => 'NFTs em comum';

  @override
  String get ui3TransactionHistory => 'Histórico de transações';

  @override
  String get ui3CommonDaos => 'DAOs em comum';

  @override
  String get ui3SameChains => 'Mesmas redes';

  @override
  String get ui3ChatInitFailed => 'Falha ao iniciar o chat';

  @override
  String get ui3CheckNetworkRetry => 'Verifique sua conexão e tente novamente';

  @override
  String get ui3FromContacts => 'Dos contatos';

  @override
  String get ui3FindFriendsFromContacts =>
      'Encontre amigos nos contatos do celular';

  @override
  String get ui3EnsOrDomain => 'ENS / Domínio';

  @override
  String get ui3LoadingContacts => 'Carregando contatos...';

  @override
  String get ui3ContactsPermissionRequired =>
      'Permissão de contatos necessária';

  @override
  String get ui3ContactsPermissionMessage =>
      'Para encontrar amigos nos seus contatos, permita o acesso aos contatos.';

  @override
  String get ui3AllowAccess => 'Permitir acesso';

  @override
  String get ui3NoContactMatches => 'Nenhuma correspondência encontrada';

  @override
  String get ui3NoContactMatchesMessage =>
      'Nenhum dos seus contatos usa este app ainda. Convide-os para participar!';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count contatos verificados';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return '$count correspondências encontradas nos seus contatos';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'Nos contatos: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Excluir esta foto?';

  @override
  String get ui3InviteLink => 'Link de convite';

  @override
  String get ui3ShareJoinLink => 'Compartilhe um link para entrar nesta sala';

  @override
  String get ui3ShareRoomReference =>
      'Compartilhe uma referência da sala com membros convidados';

  @override
  String get ui3ScanToJoinGroup =>
      'Escaneie para entrar diretamente neste grupo';

  @override
  String get ui3ScanToShareRoomReference =>
      'Escaneie para compartilhar a referência desta sala com membros convidados';

  @override
  String get ui3InviteLinkLoadFailed => 'Falha ao carregar o link de convite';

  @override
  String get ui3InviteLinkCopied => 'Link de convite copiado';

  @override
  String get ui3ChannelCategoryOptional => 'Categoria (opcional)';

  @override
  String get ui3ChannelCategoryHint => 'Avisos / Produto / Suporte';

  @override
  String get ui3DescriptionOptional => 'Descrição (opcional)';

  @override
  String get ui3WebhookEnable => 'Ativar automação por webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'Envia eventos de entrada de membros e boas-vindas para seu endpoint de integração.';

  @override
  String get ui3WebhookUrl => 'URL do webhook';

  @override
  String get ui3WebhookSecretOptional => 'Segredo de assinatura (opcional)';

  @override
  String get ui3WebhookSecretHint => 'Usado para X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined =>
      'Notificar quando um membro entrar';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'Notificar quando a boas-vindas for enviada';

  @override
  String get ui3WebhookTestSend => 'Enviar webhook de teste';

  @override
  String get ui3WebhookTestSending => 'Enviando webhook de teste...';

  @override
  String get ui3WebhookTestSent => 'Webhook de teste enviado com sucesso';

  @override
  String get ui3WebhookTestFailed => 'Falha ao enviar o webhook de teste';

  @override
  String get ui3WebhookUrlInvalid =>
      'A URL do webhook deve ser um endereço HTTPS público';

  @override
  String get ui3WebhookSelectEvent =>
      'Selecione pelo menos um evento de webhook';

  @override
  String get ui3SensitiveDataDetection => 'Detecção de dados sensíveis';

  @override
  String get ui3Email => 'E-mail';

  @override
  String get ui3CreditCard => 'Cartão de crédito';

  @override
  String get ui3DetectEmailDesc =>
      'Detectar endereços de e-mail em mensagens de texto';

  @override
  String get ui3DetectPhoneDesc =>
      'Detectar números de telefone e internacionais';

  @override
  String get ui3DetectCardDesc =>
      'Detectar prováveis números bancários e de cartão';

  @override
  String get ui3DetectWalletDesc =>
      'Detectar endereços de carteira no formato Ethereum';

  @override
  String get ui3GeneralTopic => 'Geral';

  @override
  String get a11yPreviousResult => 'Resultado anterior';

  @override
  String get a11yNextResult => 'Próximo resultado';

  @override
  String get ui3TryDifferentKeywords => 'Tente outras palavras-chave';

  @override
  String ui3FiltersActive(Object count) {
    return 'Filtros ativos: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Filtros de mensagens ativos: $count';
  }

  @override
  String get ui3LoadMore => 'Carregar mais';

  @override
  String get ui3MessageFilters => 'Filtros de mensagens';

  @override
  String get ui3SenderUserId => 'ID de usuário do remetente';

  @override
  String get ui3FilterType => 'Tipo';

  @override
  String get ui3FilterAny => 'Qualquer';

  @override
  String get ui3FilterImage => 'Imagem';

  @override
  String get ui3FilterTime => 'Período';

  @override
  String get ui3AnyTime => 'Qualquer data';

  @override
  String get ui3OnlyMyMessages => 'Somente minhas mensagens';

  @override
  String get ui3MediaOnly => 'Somente mídia';

  @override
  String get ui3Apply => 'Aplicar';

  @override
  String get ui3QrStyleClassic => 'Clássico';

  @override
  String get ui3QrStyleOcean => 'Oceano';

  @override
  String get ui3QrStyleBerry => 'Frutas vermelhas';

  @override
  String get a11yFlashlightOn => 'Ligar lanterna';

  @override
  String get a11yFlashlightOff => 'Desligar lanterna';

  @override
  String get ui3SocialGraph => 'Grafo social';

  @override
  String get ui3RecommendedConnections => 'Conexões recomendadas';

  @override
  String get ui3Portfolio => 'Portfólio';

  @override
  String get ui3Chains => 'Redes';

  @override
  String get ui3Tokens => 'Tokens digitais';

  @override
  String get ui3NoConnectionsFound => 'Nenhuma conexão encontrada';

  @override
  String get ui3ConnectionsHint =>
      'As conexões aparecem conforme você cria atividade on-chain';

  @override
  String get ui3SocialGraphLoadFailed => 'Falha ao carregar o grafo social';

  @override
  String get ui3Similarity => 'Similaridade';

  @override
  String get ui3Breakdown => 'Detalhamento';

  @override
  String get ui3TokenHoldings => 'Tokens em carteira';

  @override
  String get ui3NftCollections => 'Coleções de NFT';

  @override
  String get ui3ChainUsage => 'Uso de redes';

  @override
  String get ui3Transactions => 'Transações';

  @override
  String get ui3DaoMembership => 'Participação em DAOs';

  @override
  String get ui3NotWeighted => 'Sem peso';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (peso: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Atividade on-chain em comum';

  @override
  String get ui3SharedTokens => 'Tokens em comum';

  @override
  String get ui3SharedNftCollections => 'Coleções de NFT em comum';

  @override
  String get ui3SharedChains => 'Redes em comum';

  @override
  String get ui3NoSharedTokens => 'Nenhum token em comum encontrado';

  @override
  String get ui3NoSharedNftCollections =>
      'Nenhuma coleção de NFT em comum encontrada';

  @override
  String get ui3NoSharedChains => 'Nenhuma rede em comum encontrada';

  @override
  String get ui3SimilarityFailed => 'Não foi possível calcular a similaridade';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +$count outros';
  }

  @override
  String get a11yGovernance => 'Governança';

  @override
  String get ui3CommunityLink => 'Link da comunidade';

  @override
  String get ui3CommunityQrCode => 'QR code da comunidade';

  @override
  String get ui3CommunityQrSubtitle =>
      'Escaneie para entrar nesta comunidade e explorar os canais';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Não foi possível carregar o link da comunidade';

  @override
  String get ui3CommunityLinkCopied => 'Link da comunidade copiado';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name será removido desta comunidade.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name será removido e não poderá entrar novamente.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Entre para descobrir canais públicos';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Não foi possível entrar em $name: $error';
  }

  @override
  String get ui3CategoryTech => 'Tecnologia';

  @override
  String get ui3CategorySocial => 'Redes sociais';

  @override
  String get ui3NoPublicChannels => 'Nenhum canal público encontrado';

  @override
  String get ui3StoriesAndFun => 'Stories e diversão';

  @override
  String get ui3SearchMusicHint => 'Pesquise músicas, artistas ou amigos';

  @override
  String get ui3ForYou => 'Para você';

  @override
  String get ui3Liked => 'Curtidas';

  @override
  String get ui3NoLikedMusic => 'Nenhuma música curtida ainda';

  @override
  String get ui3NoMusicStories => 'Nenhum Story com música ainda';

  @override
  String get ui3LikedMusicHint =>
      'Toque no coração ao lado de uma música para salvá-la aqui.';

  @override
  String get ui3MusicStoriesHint =>
      'Músicas compartilhadas em Stories aparecerão aqui.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · compartilhado por $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Não foi possível reproduzir $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'Faixa anterior';

  @override
  String get a11yNextTrack => 'Próxima faixa';

  @override
  String get a11yPlay => 'Reproduzir';

  @override
  String get a11yPause => 'Pausar';

  @override
  String get ui3Refresh => 'Atualizar';

  @override
  String get ui3NearbyIntroTitle => 'Descubra publicações públicas por perto';

  @override
  String get ui3NearbyIntroBody =>
      'Sua localização é usada uma vez neste dispositivo para ordenar os Momentos públicos. Ela não é enviada, transmitida nem mostrada a outras pessoas.';

  @override
  String get ui3UseMyLocation => 'Usar minha localização';

  @override
  String get ui3NearbyUnavailable => 'Por perto não está disponível';

  @override
  String get ui3NoNearbyPosts => 'Nenhuma publicação por perto ainda';

  @override
  String get ui3NoNearbyPostsHint =>
      'Momentos públicos com localização aparecerão aqui.';

  @override
  String get ui3NearbyDistanceNote =>
      'Distância aproximada · apenas publicações públicas com localização';

  @override
  String get ui3PublicLocationPost => 'Publicação pública com localização';

  @override
  String get ui3LocationServicesOff =>
      'Os Serviços de Localização estão desativados';

  @override
  String get ui3LocationPermissionDenied =>
      'A permissão de localização foi negada';

  @override
  String get ui3EnableLocationInSettings =>
      'Ative a permissão de localização nas configurações do sistema';

  @override
  String get ui3CreateStory => 'Criar Story';

  @override
  String get ui3CreateStoryDesc => 'Publique um status de texto ou foto.';

  @override
  String get ui3StoryCamera => 'Câmera do Story';

  @override
  String get ui3StoryCameraDesc => 'Vá direto para filtros e edição de fotos.';

  @override
  String get ui3MomentsDesc => 'Abra o feed completo e os comentários.';

  @override
  String get ui3MomentCamera => 'Câmera de Momentos';

  @override
  String get ui3MomentCameraDesc =>
      'Crie uma publicação e escolha a mídia na hora.';

  @override
  String get ui3GamesDesc => 'Abra a central de jogos casuais integrada.';

  @override
  String get ui3AvatarStudio => 'Estúdio de avatar';

  @override
  String get ui3AvatarStudioDesc =>
      'Decorações, avatar NFT e estilo de identidade.';

  @override
  String get ui3SocialGraphDesc => 'Seguidos, fãs e conexões on-chain.';

  @override
  String get ui3SocialHubHeroTitle => 'Stories, momentos, jogos e avatares';

  @override
  String get ui3SocialHubHeroBody =>
      'Todos os recursos sociais em um só lugar, em vez de espalhados pelo chat, perfil e descobrir.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'O grafo social não está configurado nesta versão';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Conecte uma carteira para ver seu grafo social';

  @override
  String get ui3AvatarStudioSignIn => 'O estúdio de avatar exige login';

  @override
  String get a11yRemoveImage => 'Remover imagem';

  @override
  String get a11yBack => 'Voltar';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Confirmar transação';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Um Mini App está solicitando o envio de uma transação em seu nome.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Abrir $name?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Abrir';

  @override
  String get ui3StoryReplySendFailed =>
      'Não foi possível enviar a resposta ao Story';

  @override
  String get ui3RedPacketDemoNotice =>
      'Envelope vermelho de demonstração — apenas um registro no chat, nenhum ativo on-chain real é transferido.';

  @override
  String get ui3RedPacketCoverClassic => 'Vermelho clássico';

  @override
  String get ui3RedPacketCoverGolden => 'Dourado';

  @override
  String get ui3RedPacketCoverPurple => 'Roxo';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Azul oceano';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Verde natureza';

  @override
  String get ui3RedPacketCoverRosePink => 'Rosa';

  @override
  String get ui3RedPacketHistoryEmpty => 'Nenhum envelope vermelho ainda';

  @override
  String get ui3TransferMerchantQrWithAmount => 'QR de lojista (com valor)';

  @override
  String get ui3TransferMerchantQrTitle => 'QR de lojista';

  @override
  String get ui3TransferOpenAmountHint => 'Deixe em branco para valor livre';

  @override
  String get ui3FiatRampTitle => 'Comprar / vender cripto';

  @override
  String get ui3FiatRampBuy => 'Comprar';

  @override
  String get ui3FiatRampSell => 'Vender';

  @override
  String get ui3FiatRampNotConfigured =>
      'A rampa fiat de entrada/saída não está configurada';

  @override
  String get a11yPointsAddRule => 'Adicionar regra de recompensa';

  @override
  String get a11yGovernanceRemoveChoice => 'Remover opção';

  @override
  String get a11yGovernanceCreateProposal => 'Criar proposta';

  @override
  String get ui3MiniAppUpdateN42 => 'Atualizar N42';

  @override
  String get ui3MiniAppOfficial => 'Oficial';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count usuários';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Cor de fundo $index';
  }

  @override
  String get a11yStoryAdd => 'Adicionar story';

  @override
  String get ui3StoryPostFailed => 'Falha ao publicar o story';

  @override
  String get ui3StoryTapToSelectImage => 'Toque para selecionar uma imagem';

  @override
  String get ui3StoryChangeImage => 'Trocar';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Não foi possível ler a música selecionada: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Excluir este story?';

  @override
  String get ui3StoryDeleteFailed => 'Falha ao excluir o story';

  @override
  String get ui3MomentCreateTitle => 'Criar momento';

  @override
  String get ui3MomentContentHint => 'No que você está pensando?';

  @override
  String get ui3MomentAddPhotos => 'Adicionar fotos';

  @override
  String get ui3MomentAddLocation => 'Adicionar localização';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Mídia selecionada ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Limpar tudo';

  @override
  String get ui3MomentClearMediaConfirm =>
      'Remover todas as fotos/vídeos selecionados?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Todos os amigos podem ver';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Só você pode ver';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Escolha quem pode ver';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Ocultar de amigos específicos';

  @override
  String get ui3MomentVideos => 'Vídeos';

  @override
  String get ui3MomentNoVideos => 'Nenhum vídeo ainda';

  @override
  String get a11yCallMinimize => 'Minimizar';

  @override
  String get a11yCallGridView => 'Visualização em grade';

  @override
  String get a11yCallFocusView => 'Visualização em destaque';

  @override
  String get ui3CallTools => 'Ferramentas de chamada';

  @override
  String get ui3CallMeetingTools => 'Ferramentas de reunião';

  @override
  String get ui3CallToolsSubtitle =>
      'Ajuste a qualidade de áudio e vídeo sem sair da chamada.';

  @override
  String get ui3CallAudioEnhancement => 'Aprimoramento de áudio';

  @override
  String get ui3CallNoiseSuppression => 'Supressão de ruído';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Reduz o ruído do teclado e de fundo.';

  @override
  String get ui3CallEchoCancellation => 'Cancelamento de eco';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Impede que o som do alto-falante volte para o microfone.';

  @override
  String get ui3CallAutoGainControl => 'Controle automático de ganho';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Mantém o volume do microfone mais estável.';

  @override
  String get ui3CallVoiceIsolation => 'Isolamento de voz aprimorado';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Use um perfil de redução de ruído mais forte.';

  @override
  String get ui3CallVideoSection => 'Vídeo';

  @override
  String get ui3CallBackgroundBlur => 'Desfoque de fundo (beta)';

  @override
  String get ui3CallBlurDescReady =>
      'A preferência está ativa. O desfoque visual ainda depende da liberação do processador de vídeo.';

  @override
  String get ui3CallBlurDescSaved =>
      'A preferência de desfoque foi salva e será aplicada quando o processamento da câmera estiver disponível.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Ligue a câmera quando o processamento de fundo estiver disponível.';

  @override
  String get ui3CallRecordingSection => 'Gravação';

  @override
  String get ui3CallRecordingDesc =>
      'Requer saída no servidor para que as gravações possam ser salvas.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Falha ao atualizar as configurações da chamada: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Gravação iniciada';

  @override
  String get ui3VoiceRoomNotFound => 'Sala não encontrada';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Tem certeza de que deseja encerrar esta sala de voz?';

  @override
  String get a11yGameMoveUp => 'Mover para cima';

  @override
  String get a11yGameMoveDown => 'Mover para baixo';

  @override
  String get a11yGameMoveLeft => 'Mover para a esquerda';

  @override
  String get a11yGameMoveRight => 'Mover para a direita';

  @override
  String get a11yGameRotate => 'Girar';

  @override
  String get a11yGameDrop => 'Soltar';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count figurinha(s) adicionada(s)';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Falha ao adicionar: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Remover figurinha';

  @override
  String get ui3StickerRemoveConfirm => 'Remover esta figurinha do pacote?';

  @override
  String get ui3StickerRemoveFailed => 'Falha ao remover';

  @override
  String get ui3StickerRenamePack => 'Renomear pacote';

  @override
  String get ui3StickerPackName => 'Nome do pacote';

  @override
  String get ui3StickerRenameFailed => 'Falha ao renomear';

  @override
  String get ui3StickerDeletePack => 'Excluir pacote';

  @override
  String get ui3StickerThisPack => 'este pacote';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Excluir \"$name\" e todas as figurinhas? Essa ação não pode ser desfeita.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Falha ao excluir';

  @override
  String get ui3StickerPack => 'Pacote de figurinhas';

  @override
  String get ui3StickerAdding => 'Adicionando…';

  @override
  String get ui3StickerAddStickers => 'Adicionar figurinhas';

  @override
  String get ui3StickerPackNotFound => 'Pacote não encontrado';

  @override
  String get ui3StickerEmptyHint =>
      'Toque em \"Adicionar figurinhas\" para enviar imagens';

  @override
  String get ui3StickerNewPack => 'Novo pacote de figurinhas';

  @override
  String get ui3StickerCreate => 'Criar';

  @override
  String get ui3StickerCreateFailed => 'Falha ao criar o pacote';

  @override
  String ui3StickerInstalled(Object name) {
    return '\"$name\" instalado';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Remover pacote de figurinhas';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Remover \"$name\" das suas figurinhas?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '\"$name\" removido';
  }

  @override
  String get ui3StickerAiSticker => 'Figurinha de IA';

  @override
  String get ui3StickerStoreTab => 'Loja';

  @override
  String get ui3StickerMyStickersTab => 'Minhas figurinhas';

  @override
  String get ui3StickerNoneFound => 'Nenhuma figurinha encontrada';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'por $author';
  }

  @override
  String get ui3StickerManage => 'Gerenciar';

  @override
  String ui3StickerCount(Object count) {
    return '$count figurinhas';
  }

  @override
  String get ui3StickerNoneInstalled => 'Nenhuma figurinha instalada';

  @override
  String get ui3StickerGetFromStore => 'Obtenha figurinhas na loja';

  @override
  String get ui3StickerBrowseStore => 'Explorar loja';

  @override
  String get ui3StickerAddedToAi => 'Adicionada a \"Figurinhas de IA\"';

  @override
  String get ui3StickerAddOneFailed => 'Falha ao adicionar a figurinha';

  @override
  String get ui3StickerPromptLabel => 'Descreva sua figurinha';

  @override
  String get ui3StickerPromptHint =>
      'ex.: um gato laranja feliz de óculos escuros';

  @override
  String get ui3StickerGenerating => 'Gerando…';

  @override
  String get ui3StickerGenerate => 'Gerar';

  @override
  String get ui3StickerAddToStickers => 'Adicionar às figurinhas';

  @override
  String get ui3StickerGeneratingPreview => 'Gerando sua figurinha…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Descreva uma figurinha e toque em \"Gerar\"';
}
