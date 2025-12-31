import 'package:get_it/get_it.dart';

import '../../data/datasources/local/secure_storage_datasource.dart';
import '../../data/datasources/matrix/matrix_auth_datasource.dart';
import '../../data/datasources/matrix/matrix_client_manager.dart';
import '../../data/datasources/matrix/matrix_room_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/conversation_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../n42_chat_config.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/conversation/conversation_bloc.dart';

/// 全局GetIt实例
final GetIt getIt = GetIt.instance;

/// 配置依赖注入
///
/// 在N42Chat.initialize()中调用
Future<void> configureDependencies(N42ChatConfig config) async {
  // 注册配置
  getIt.registerSingleton<N42ChatConfig>(config);

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

  // TODO: 注册MessageRepository
  // TODO: 注册ContactRepository
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

  // TODO: 注册其他BLoC
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

