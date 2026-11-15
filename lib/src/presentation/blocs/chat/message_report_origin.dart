import '../../../core/di/injection.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../data/services/account_action_capture.dart';
import '../../../domain/entities/account_action_origin.dart';
import '../../../domain/repositories/auth_repository.dart';

class MessageReportOrigin {
  final AccountActionOrigin _origin;
  MessageReportOrigin._(this._origin);
  Object get manager => _origin.owner;
  bool get isCurrent => _origin.isCurrent;
  static MessageReportOrigin? capture() {
    if (!getIt.isRegistered<MatrixClientManager>() ||
        !getIt.isRegistered<IAuthRepository>())
      return null;
    final origin = captureAccountAction(
      getIt<MatrixClientManager>(),
      getIt<IAuthRepository>(),
    );
    return origin == null ? null : MessageReportOrigin._(origin);
  }
}
