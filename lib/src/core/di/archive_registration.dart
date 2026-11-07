import 'package:get_it/get_it.dart';

import '../../data/datasources/local/archive_database.dart';
import '../../data/datasources/matrix/matrix_client_manager.dart';
import '../services/archive_account_access.dart';
import '../services/archive_integrity_service.dart';
import '../services/archive_search_service.dart';
import '../services/legacy_archive_recovery_service.dart';
import '../services/message_archive_service.dart';

/// All live consumers resolve an account-owned archive; the unowned database
/// remains accessible only through the explicitly confirmed recovery flow.
void registerAccountArchiveServices(GetIt dependencies) {
  dependencies.registerLazySingleton<ArchiveAccountAccess>(
    () => ArchiveAccountAccess(
      clientManager: dependencies<MatrixClientManager>(),
    ),
    dispose: (_) => ArchiveDatabase.closeAccountInstances(),
  );
  dependencies.registerLazySingleton<MessageArchiveService>(
    () => MessageArchiveService.accountScoped(
      access: dependencies<ArchiveAccountAccess>(),
      clientManager: dependencies<MatrixClientManager>(),
    ),
  );
  dependencies.registerLazySingleton<ArchiveSearchService>(
    () => ArchiveSearchService.accountScoped(
      access: dependencies<ArchiveAccountAccess>(),
    ),
  );
  dependencies.registerLazySingleton<ArchiveIntegrityService>(
    () => ArchiveIntegrityService.accountScoped(
      access: dependencies<ArchiveAccountAccess>(),
    ),
  );
  dependencies.registerLazySingleton<LegacyArchiveRecoveryService>(
    () => LegacyArchiveRecoveryService(
      access: dependencies<ArchiveAccountAccess>(),
    ),
  );
}
