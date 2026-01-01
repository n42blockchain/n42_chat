import 'package:get_it/get_it.dart';

import '../../data/datasources/local/secure_storage_datasource.dart';
import '../../data/datasources/matrix/matrix_auth_datasource.dart';
import '../../data/datasources/matrix/matrix_client_manager.dart';
import '../../data/datasources/matrix/matrix_contact_datasource.dart';
import '../../data/datasources/matrix/matrix_group_datasource.dart';
import '../../data/datasources/matrix/matrix_message_datasource.dart';
import '../../data/datasources/matrix/matrix_room_datasource.dart';
import '../../data/datasources/matrix/matrix_reaction_datasource.dart';
import '../../data/datasources/matrix/matrix_search_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../data/repositories/conversation_repository_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../data/repositories/message_repository_impl.dart';
import '../../data/repositories/message_action_repository_impl.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../domain/repositories/group_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/repositories/message_action_repository.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../integration/wallet_bridge.dart';
import '../../n42_chat_config.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/chat/chat_bloc.dart';
import '../../presentation/blocs/contact/contact_bloc.dart';
import '../../presentation/blocs/conversation/conversation_bloc.dart';
import '../../presentation/blocs/group/group_bloc.dart';
import '../../presentation/blocs/message_action/message_action_bloc.dart';
import '../../presentation/blocs/search/search_bloc.dart';
import '../../presentation/blocs/transfer/transfer_bloc.dart';

/// 全局GetIt实例
final GetIt getIt = GetIt.instance;

/// 配置依赖注入
///
/// 在N42Chat.initialize()中调用
Future<void> configureDependencies(N42ChatConfig config, {IWalletBridge? walletBridge}) async {
  // 注册配置
  getIt.registerSingleton<N42ChatConfig>(config);

  // 注册钱包桥接
  getIt.registerSingleton<IWalletBridge>(
    walletBridge ?? MockWalletBridge(),
  );

  // 注册服务
  await _registerServices();

  // 注册数据源
  await _registerDataSources();

  // 注册仓库
  _registerRepositories();

  // 注册用例
  _registerUseCases();

  // 注册BLoC
  _registerBlocs();
}

/// 注册服务
Future<void> _registerServices() async {
  // Matrix客户端管理器
  getIt.registerLazySingleton<MatrixClientManager>(
    () => MatrixClientManager.instance,
  );
}

/// 注册数据源
Future<void> _registerDataSources() async {
  // 安全存储
  getIt.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSource(),
  );

  // Matrix认证数据源
  getIt.registerLazySingleton<MatrixAuthDataSource>(
    () => MatrixAuthDataSource(
      clientManager: getIt<MatrixClientManager>(),
    ),
  );

  // Matrix房间数据源
  getIt.registerLazySingleton<MatrixRoomDataSource>(
    () => MatrixRoomDataSource(getIt<MatrixClientManager>()),
  );

  // Matrix消息数据源
  getIt.registerLazySingleton<MatrixMessageDataSource>(
    () => MatrixMessageDataSource(getIt<MatrixClientManager>()),
  );

  // Matrix联系人数据源
  getIt.registerLazySingleton<MatrixContactDataSource>(
    () => MatrixContactDataSource(getIt<MatrixClientManager>()),
  );

  // Matrix群聊数据源
  getIt.registerLazySingleton<MatrixGroupDataSource>(
    () => MatrixGroupDataSource(getIt<MatrixClientManager>()),
  );

  // Matrix搜索数据源
  getIt.registerLazySingleton<MatrixSearchDataSource>(
    () => MatrixSearchDataSource(getIt<MatrixClientManager>()),
  );

  // Matrix消息反应数据源
  getIt.registerLazySingleton<MatrixReactionDataSource>(
    () => MatrixReactionDataSource(getIt<MatrixClientManager>()),
  );
}

/// 注册仓库
void _registerRepositories() {
  // 认证仓库
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt<MatrixAuthDataSource>(),
      secureStorage: getIt<SecureStorageDataSource>(),
    ),
  );

  // 会话仓库
  getIt.registerLazySingleton<IConversationRepository>(
    () => ConversationRepositoryImpl(getIt<MatrixRoomDataSource>()),
  );

  // 消息仓库
  getIt.registerLazySingleton<IMessageRepository>(
    () => MessageRepositoryImpl(
      getIt<MatrixMessageDataSource>(),
      getIt<MatrixClientManager>(),
    ),
  );

  // 联系人仓库
  getIt.registerLazySingleton<IContactRepository>(
    () => ContactRepositoryImpl(
      getIt<MatrixContactDataSource>(),
      getIt<SecureStorageDataSource>(),
    ),
  );

  // 群聊仓库
  getIt.registerLazySingleton<IGroupRepository>(
    () => GroupRepositoryImpl(
      getIt<MatrixGroupDataSource>(),
      getIt<MatrixClientManager>(),
    ),
  );

  // 转账仓库
  getIt.registerLazySingleton<ITransferRepository>(
    () => TransferRepositoryImpl(
      getIt<IWalletBridge>(),
      getIt<MatrixMessageDataSource>(),
      getIt<MatrixClientManager>(),
    ),
  );

  // 搜索仓库
  getIt.registerLazySingleton<ISearchRepository>(
    () => SearchRepositoryImpl(
      getIt<MatrixSearchDataSource>(),
      getIt<MatrixClientManager>(),
    ),
  );

  // 消息操作仓库
  getIt.registerLazySingleton<IMessageActionRepository>(
    () => MessageActionRepositoryImpl(
      getIt<MatrixReactionDataSource>(),
      getIt<MatrixClientManager>(),
    ),
  );
}

/// 注册用例
void _registerUseCases() {
  // TODO: 注册各种UseCase
}

/// 注册BLoC
void _registerBlocs() {
  // 认证BLoC - 使用Factory模式，每次获取新实例
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<IAuthRepository>()),
  );

  // 会话列表BLoC
  getIt.registerFactory<ConversationBloc>(
    () => ConversationBloc(
      conversationRepository: getIt<IConversationRepository>(),
    ),
  );

  // 聊天BLoC
  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(
      messageRepository: getIt<IMessageRepository>(),
    ),
  );

  // 联系人BLoC
  getIt.registerFactory<ContactBloc>(
    () => ContactBloc(getIt<IContactRepository>()),
  );

  // 群聊BLoC
  getIt.registerFactory<GroupBloc>(
    () => GroupBloc(getIt<IGroupRepository>()),
  );

  // 转账BLoC
  getIt.registerFactory<TransferBloc>(
    () => TransferBloc(
      getIt<ITransferRepository>(),
      getIt<IWalletBridge>(),
    ),
  );

  // 搜索BLoC
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(getIt<ISearchRepository>()),
  );

  // 消息操作BLoC
  getIt.registerFactory<MessageActionBloc>(
    () => MessageActionBloc(getIt<IMessageActionRepository>()),
  );
}

/// 重置依赖（用于测试）
Future<void> resetDependencies() async {
  await getIt.reset();
}

/// 检查是否已注册
bool isRegistered<T extends Object>() => getIt.isRegistered<T>();

/// 扩展方法：简化获取依赖
extension GetItExtension on GetIt {
  /// 获取配置
  N42ChatConfig get config => get<N42ChatConfig>();
}

