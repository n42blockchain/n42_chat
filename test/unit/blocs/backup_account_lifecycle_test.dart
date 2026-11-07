import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/chat_backup_service.dart';
import 'package:n42_chat/src/presentation/blocs/backup/backup_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/backup/backup_event.dart';

class _Service extends Mock implements ChatBackupService {}

BackupPreview preview(String id) => BackupPreview(
  backupId: id,
  createdAt: DateTime(2026),
  roomCount: 1,
  roomNames: [id],
  hasMedia: false,
  hasKeys: false,
  hasSettings: true,
);

void main() {
  test(
    'closed lifecycle stream clears an invalidated loaded preview',
    () async {
      final service = _Service();
      final changes = StreamController<bool>.broadcast();
      var current = true;
      when(() => service.previewBackup('old'))
          .thenAnswer((_) async => preview('old'));
      final bloc = BackupBloc(
        backupService: service,
        isAccountCurrent: () => current,
        accountChanges: changes.stream,
      );
      addTearDown(bloc.close);
      final loaded = bloc.stream.firstWhere((state) => state.preview != null);
      bloc.add(const PreviewBackup(filePath: 'old'));
      await loaded;
      final cleared = bloc.stream.firstWhere(
        (state) => state.preview == null && !state.isLoading,
      );
      current = false;
      await changes.close();
      await cleared;
      expect(bloc.state.error, isNull);
      expect(bloc.isAccountCurrent, isFalse);
    },
  );
  for (final kind in ['preview', 'estimate', 'create', 'restore']) {
    for (final fails in [false, true]) {
      test(
        'account invalidation clears and rejects late $kind outcome: error=$fails',
        () async {
          final service = _Service();
          final changes = StreamController<bool>.broadcast(sync: true);
          var current = true;
          final started = Completer<void>();
          final result = Completer<dynamic>();
          final bloc = BackupBloc(
            backupService: service,
            isAccountCurrent: () => current,
            accountChanges: changes.stream,
          );
          addTearDown(() async {
            await bloc.close();
            await changes.close();
          });
          Future<dynamic> wait() {
            started.complete();
            return result.future;
          }

          switch (kind) {
            case 'preview':
              when(() => service.previewBackup('old'))
                  .thenAnswer((_) async => await wait() as BackupPreview);
              bloc.add(const PreviewBackup(filePath: 'old'));
            case 'estimate':
              when(
                () => service.estimateBackupSize(
                  roomIds: null,
                  includeMedia: false,
                ),
              ).thenAnswer((_) async => await wait() as BackupSizeEstimate);
              bloc.add(const EstimateBackupSize());
            case 'create':
              when(
                () =>
                    service.createBackup(onProgress: any(named: 'onProgress')),
              ).thenAnswer((_) async => await wait() as BackupResult);
              bloc.add(const CreateBackup());
            case 'restore':
              when(
                () => service.restoreFromBackup(
                  backupFilePath: 'old',
                  onProgress: any(named: 'onProgress'),
                ),
              ).thenAnswer((_) async => await wait() as RestoreResult);
              bloc.add(const RestoreFromBackup(backupFilePath: 'old'));
          }
          await started.future;
          final cleared = bloc.stream.firstWhere(
            (state) =>
                !state.isLoading && !state.isCreating && !state.isRestoring,
          );
          current = false;
          changes.add(false);
          await cleared;
          clearInteractions(service);
          if (fails) {
            result.completeError(StateError('private-old-account-error'));
          } else {
            switch (kind) {
              case 'preview':
                result.complete(preview('private-old-room'));
              case 'estimate':
                result.complete(
                  const BackupSizeEstimate(
                    estimatedBytes: 999,
                    roomCount: 99,
                    includesMedia: false,
                  ),
                );
              case 'create':
                result.complete(
                  BackupResult(
                    backupId: 'private',
                    filePath: 'private',
                    fileSizeBytes: 1,
                    roomCount: 1,
                    messageCount: 1,
                    createdAt: DateTime(2026),
                  ),
                );
              case 'restore':
                result.complete(const RestoreResult(roomsRestored: 99));
            }
          }
          await Future<void>.delayed(Duration.zero);
          expect(bloc.state.backups, isEmpty);
          expect(bloc.state.preview, isNull);
          expect(bloc.state.sizeEstimate, isNull);
          expect(bloc.state.error, isNull);
          expect(bloc.state.successMessage, isNull);
          expect(bloc.tryBeginRestoreSelection(), isFalse);
          bloc.add(const LoadBackupList());
          bloc.add(const CreateBackup());
          bloc.add(const DeleteBackup('old'));
          bloc.add(const RestoreFromBackup(backupFilePath: 'old'));
          await Future<void>.delayed(Duration.zero);
          verifyZeroInteractions(service);
        },
      );
    }
  }

  for (final kind in ['preview', 'estimate']) {
    for (final fails in [false, true]) {
      test(
        'older $kind result cannot replace newer selection: error=$fails',
        () async {
          final service = _Service();
          final first = Completer<dynamic>();
          final second = Completer<dynamic>();
          final started = Completer<void>();
          var calls = 0;
          Future<dynamic> next() {
            if (++calls == 1) return first.future;
            started.complete();
            return second.future;
          }

          final bloc = BackupBloc(backupService: service);
          addTearDown(bloc.close);
          if (kind == 'preview') {
            when(() => service.previewBackup('file'))
                .thenAnswer((_) async => await next() as BackupPreview);
            bloc.add(const PreviewBackup(filePath: 'file'));
            bloc.add(const PreviewBackup(filePath: 'file'));
          } else {
            when(
              () => service.estimateBackupSize(
                roomIds: null,
                includeMedia: false,
              ),
            ).thenAnswer((_) async => await next() as BackupSizeEstimate);
            bloc.add(const EstimateBackupSize());
            bloc.add(const EstimateBackupSize());
          }
          await started.future;
          final updated = bloc.stream.firstWhere(
            (state) => kind == 'preview'
                ? state.preview != null
                : state.sizeEstimate != null,
          );
          second.complete(
            kind == 'preview'
                ? preview('new')
                : const BackupSizeEstimate(
                    estimatedBytes: 2,
                    roomCount: 2,
                    includesMedia: false,
                  ),
          );
          await updated;
          if (fails) {
            first.completeError(StateError('older-error'));
          } else {
            first.complete(
              kind == 'preview'
                  ? preview('old')
                  : const BackupSizeEstimate(
                      estimatedBytes: 1,
                      roomCount: 1,
                      includesMedia: false,
                    ),
            );
          }
          await Future<void>.delayed(Duration.zero);
          expect(
            kind == 'preview'
                ? bloc.state.preview!.backupId
                : bloc.state.sizeEstimate!.roomCount,
            kind == 'preview' ? 'new' : 2,
          );
          expect(bloc.state.error, isNull);
        },
      );
    }
  }

  test('closing Bloc cancels the account lifecycle listener', () async {
    final changes = StreamController<bool>.broadcast();
    final bloc = BackupBloc(
      backupService: _Service(),
      isAccountCurrent: () => true,
      accountChanges: changes.stream,
    );
    expect(changes.hasListener, isTrue);
    await bloc.close();
    expect(changes.hasListener, isFalse);
    await changes.close();
  });
}
