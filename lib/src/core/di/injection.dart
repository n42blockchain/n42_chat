import 'package:get_it/get_it.dart';

import '../../n42_chat_config.dart';

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
  // TODO: 注册LoggerService
  // TODO: 注册StorageService
  // TODO: 注册EncryptionService
  // TODO: 注册NotificationService
}

/// 注册数据源
Future<void> _registerDataSources() async {
  // TODO: 注册MatrixClientManager
  // TODO: 注册LocalDatabase
  // TODO: 注册SecureStorage
}

/// 注册仓库
void _registerRepositories() {
  // TODO: 注册AuthRepository
  // TODO: 注册ConversationRepository
  // TODO: 注册MessageRepository
  // TODO: 注册ContactRepository
}

/// 注册用例
void _registerUseCases() {
  // TODO: 注册各种UseCase
}

/// 注册BLoC
void _registerBlocs() {
  // TODO: 注册各种BLoC
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

