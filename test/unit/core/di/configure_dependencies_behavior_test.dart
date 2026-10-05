import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/services/ai_service.dart';
import 'package:n42_chat/src/core/services/fiat_ramp_service.dart';
import 'package:n42_chat/src/core/services/gif_service.dart';
import 'package:n42_chat/src/core/services/giphy_service.dart';
import 'package:n42_chat/src/core/services/points_tracking_service.dart';
import 'package:n42_chat/src/core/services/social_graph_service.dart';
import 'package:n42_chat/src/core/services/tenor_service.dart';
import 'package:n42_chat/src/data/datasources/governance/snapshot_graphql_datasource.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:n42_chat/src/data/datasources/local/media_metadata_database.dart';
import 'package:n42_chat/src/data/datasources/push_protocol/push_protocol_datasource.dart';
import 'package:n42_chat/src/data/protocols/protocol_registry.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/integration/api_hub_bridge.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/n42_chat_config.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ClientManager extends Mock implements MatrixClientManager {}

class _TestPaths extends PathProviderPlatform {
  _TestPaths(this.path);

  final String path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;

  @override
  Future<String?> getTemporaryPath() async => path;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory dataDirectory;
  late PathProviderPlatform originalPaths;

  setUp(() async {
    originalPaths = PathProviderPlatform.instance;
    dataDirectory = await Directory.systemTemp.createTemp(
      'n42-chat-di-behavior-',
    );
    PathProviderPlatform.instance = _TestPaths(dataDirectory.path);
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  tearDown(() async {
    if (getIt.isRegistered<ArchiveDatabase>()) {
      await getIt<ArchiveDatabase>().close();
    }
    if (getIt.isRegistered<MediaMetadataDatabase>()) {
      await getIt<MediaMetadataDatabase>().close();
    }
    await resetDependencies();
    PathProviderPlatform.instance = originalPaths;
    if (await dataDirectory.exists()) {
      await dataDirectory.delete(recursive: true);
    }
  });

  test(
    'config wires core and opt-in Chat services to their consumers',
    () async {
      const config = N42ChatConfig(
        enableEncryption: false,
        enablePushNotifications: false,
        googleTranslateApiKey: 'fixture-translate-key',
        aiApiKey: 'fixture-ai-key',
        giphyApiKey: 'fixture-giphy-key',
        tenorApiKey: 'fixture-tenor-key',
        fiatRampApiKey: 'fixture-fiat-key',
        enableProtocolAbstraction: true,
        enableGovernance: true,
        enableSocialGraph: true,
        enablePoints: true,
        pointsApiBaseUrl: 'https://points.example.test',
        pushProtocol: PushProtocolConfig(
          apiBaseUrl: 'https://push.example.test',
        ),
      );

      final clientManager = _ClientManager();
      when(() => clientManager.isInitialized).thenReturn(true);
      when(() => clientManager.client).thenReturn(null);
      when(() => clientManager.dispose()).thenAnswer((_) async {});

      await configureDependencies(config, clientManagerOverride: clientManager);

      expect(getIt<N42ChatConfig>(), same(config));
      expect(getIt<IWalletBridge>(), isA<NoOpWalletBridge>());
      expect(getIt<IApiHubBridge>(), isA<MockApiHubBridge>());
      expect(getIt.isRegistered<IMessageRepository>(), isTrue);
      expect(getIt.isRegistered<ChatBloc>(), isTrue);
      expect(getIt.isRegistered<GiphyService>(), isTrue);
      expect(getIt.isRegistered<TenorService>(), isTrue);
      expect(getIt.isRegistered<GifService>(), isTrue);
      expect(getIt.isRegistered<FiatRampService>(), isTrue);
      expect(getIt.isRegistered<SnapshotGraphQLDatasource>(), isTrue);
      expect(getIt.isRegistered<ProtocolRegistry>(), isTrue);
      expect(getIt.isRegistered<SocialGraphService>(), isTrue);
      expect(getIt.isRegistered<PointsTrackingService>(), isTrue);
      expect(getIt.isRegistered<PushProtocolDatasource>(), isTrue);
      expect(getIt.isRegistered<AiService>(), isTrue);
    },
  );
}
