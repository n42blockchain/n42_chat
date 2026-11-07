import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/chat_backup_service.dart';
import 'backup_event.dart';
import 'backup_state.dart';
import '../../../core/utils/debug_log.dart';

/// 备份 BLoC
class BackupBloc extends Bloc<BackupEvent, BackupState> {
  final ChatBackupService _backupService;
  bool _restoreSelectionPending = false;
  bool _restoreDispatchPending = false;
  bool _deletionPending = false;
  int _listRequest = 0;

  bool get isBackupOperationBusy =>
      _restoreSelectionPending || _restoreDispatchPending || _deletionPending ||
      state.isCreating || state.isRestoring;

  bool tryBeginRestoreSelection() {
    if (isBackupOperationBusy || isClosed) return false;
    _restoreSelectionPending = true;
    return true;
  }

  void endRestoreSelection() => _restoreSelectionPending = false;

  void restoreFromSelection(RestoreFromBackup event) {
    if (isClosed || !_restoreSelectionPending) return;
    _restoreSelectionPending = false;
    _restoreDispatchPending = true;
    add(event);
  }



  BackupBloc({required ChatBackupService backupService})
      : _backupService = backupService,
        super(BackupState.initial()) {
    on<LoadBackupList>(_onLoadBackupList);
    on<CreateBackup>(_onCreateBackup);
    on<DeleteBackup>(_onDeleteBackup);
    on<PreviewBackup>(_onPreviewBackup);
    on<RestoreFromBackup>(_onRestoreFromBackup);
    on<EstimateBackupSize>(_onEstimateBackupSize);
  }

  Future<void> _onLoadBackupList(
    LoadBackupList event,
    Emitter<BackupState> emit,
  ) async {
    final request = ++_listRequest;
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final backups = await _backupService.listBackups();
      if (request != _listRequest) return;
      emit(state.copyWith(
        backups: backups,
        isLoading: false,
      ));
    } catch (e) {
      if (request != _listRequest) return;
      if (e is BackupSessionChanged) {
        emit(BackupState(isLoading: false,
          isCreating: state.isCreating, isRestoring: state.isRestoring));
        return;
      }
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load backups: $e',
      ));
    }
  }

  Future<void> _onCreateBackup(
    CreateBackup event,
    Emitter<BackupState> emit,
  ) async {
    if (isBackupOperationBusy) return;
    emit(state.copyWith(isCreating: true, progress: 0, clearError: true));
    try {
      final result = await _backupService.createBackup(
        roomIds: event.roomIds,
        includeMedia: event.includeMedia,
        includeKeys: event.includeKeys,
        password: event.password,
        onProgress: (progress) {
          // BLoC 不能在回调中 emit，进度通过日志跟踪
          debugLog('Backup progress: ${(progress * 100).toInt()}%');
        },
      );
      emit(state.copyWith(
        isCreating: false,
        progress: 1.0,
        successMessage: _composeMessage(
          'Backup created: ${result.roomCount} rooms, ${result.messageCount} messages',
          result.warnings,
        ),
      ));
      // 刷新列表
      add(const LoadBackupList());
    } catch (e) {
      emit(state.copyWith(
        isCreating: false,
        error: 'Backup failed: $e',
      ));
    }
  }

  Future<void> _onDeleteBackup(
    DeleteBackup event,
    Emitter<BackupState> emit,
  ) async {
    if (isBackupOperationBusy || event.isCurrent?.call() == false) return;
    _deletionPending = true;
    try {
      await _backupService.deleteBackup(event.backupId, isCurrent: event.isCurrent);
      if (event.isCurrent?.call() == false) return;
      add(const LoadBackupList());
    } catch (e) {
      if (event.isCurrent?.call() == false) return;
      emit(state.copyWith(error: 'Failed to delete backup: $e'));
    } finally {
      _deletionPending = false;
    }
  }

  Future<void> _onPreviewBackup(
    PreviewBackup event,
    Emitter<BackupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearPreview: true));
    try {
      final preview = await _backupService.previewBackup(
        event.filePath,
        password: event.password,
      );
      emit(state.copyWith(
        preview: preview,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to preview backup: $e',
      ));
    }
  }

  Future<void> _onRestoreFromBackup(
    RestoreFromBackup event,
    Emitter<BackupState> emit,
  ) async {
    _restoreDispatchPending = false;
    if (_restoreSelectionPending || _deletionPending || state.isCreating || state.isRestoring) return;
    if (event.isCurrent?.call() == false) return;
    emit(state.copyWith(isRestoring: true, progress: 0, clearError: true));
    try {
      final result = await _backupService.restoreFromBackup(
        backupFilePath: event.backupFilePath,
        password: event.password,
        roomIds: event.roomIds,
        restoreSettings: event.restoreSettings,
        restoreKeys: event.restoreKeys,
        restoreMessages: event.restoreMessages,
        isCurrent: event.isCurrent,
        onProgress: (progress) {
          debugLog('Restore progress: ${(progress * 100).toInt()}%');
        },
      );

      if (event.isCurrent?.call() == false) {
        emit(state.copyWith(isRestoring: false));
        return;
      }
      if (result.hasErrors) {
        emit(state.copyWith(
          isRestoring: false,
          error: 'Restore completed with errors: ${result.errors.join(', ')}',
        ));
      } else {
        emit(state.copyWith(
          isRestoring: false,
          successMessage: _composeMessage(
            event.restoreMessages || result.roomsRestored > 0
                ? 'Restored ${result.settingsRestored} settings from ${result.roomsRestored} rooms'
                : 'Restored ${result.settingsRestored} settings. Messages will sync from server after login.',
            result.warnings,
          ),
        ));
      }
    } catch (e) {
      if (event.isCurrent?.call() == false) {
        emit(state.copyWith(isRestoring: false));
        return;
      }
      emit(state.copyWith(
        isRestoring: false,
        error: 'Restore failed: $e',
      ));
    }
  }

  Future<void> _onEstimateBackupSize(
    EstimateBackupSize event,
    Emitter<BackupState> emit,
  ) async {
    try {
      final estimate = await _backupService.estimateBackupSize(
        roomIds: event.roomIds,
        includeMedia: event.includeMedia,
      );
      emit(state.copyWith(sizeEstimate: estimate));
    } catch (e) {
      debugLog('BackupBloc: Failed to estimate size: $e');
    }
  }

  String _composeMessage(String base, List<String> warnings) {
    if (warnings.isEmpty) return base;
    return '$base ${warnings.join(' ')}';
  }
}
