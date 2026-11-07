import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/chat_backup_service.dart';
import 'package:n42_chat/src/presentation/blocs/backup/backup_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/backup/backup_event.dart';

class _Service extends Mock implements ChatBackupService {}

void main() {
  late _Service service;
  late BackupBloc bloc;
  setUp(() {
    service = _Service();
    when(() => service.listBackups()).thenAnswer((_) async => []);
    bloc = BackupBloc(backupService: service);
  });
  tearDown(() => bloc.close());

  test(
    'selection excludes duplicate selection and unrelated mutations',
    () async {
      expect(bloc.tryBeginRestoreSelection(), isTrue);
      expect(bloc.tryBeginRestoreSelection(), isFalse);
      bloc.add(const CreateBackup());
      bloc.add(const DeleteBackup('file'));
      bloc.add(const RestoreFromBackup(backupFilePath: 'file'));
      await Future<void>.delayed(Duration.zero);
      verifyZeroInteractions(service);
      expect(bloc.isBackupOperationBusy, isTrue);
      bloc.endRestoreSelection();
      expect(bloc.tryBeginRestoreSelection(), isTrue);
      bloc.endRestoreSelection();
    },
  );

  test(
    'selection handoff excludes queued and running duplicate restores',
    () async {
      final started = Completer<void>();
      final finished = Completer<RestoreResult>();
      when(
        () => service.restoreFromBackup(
          backupFilePath: 'file',
          onProgress: any(named: 'onProgress'),
        ),
      ).thenAnswer((_) {
        started.complete();
        return finished.future;
      });
      expect(bloc.tryBeginRestoreSelection(), isTrue);
      bloc.restoreFromSelection(
        const RestoreFromBackup(backupFilePath: 'file'),
      );
      expect(bloc.tryBeginRestoreSelection(), isFalse);
      await started.future;
      bloc.add(const RestoreFromBackup(backupFilePath: 'file'));
      bloc.add(const CreateBackup());
      bloc.add(const DeleteBackup('file'));
      await Future<void>.delayed(Duration.zero);
      verify(
        () => service.restoreFromBackup(
          backupFilePath: 'file',
          onProgress: any(named: 'onProgress'),
        ),
      ).called(1);
      verifyNoMoreInteractions(service);
      final idle = bloc.stream.firstWhere((state) => !state.isRestoring);
      finished.complete(const RestoreResult());
      await idle;
      expect(bloc.isBackupOperationBusy, isFalse);
      expect(bloc.tryBeginRestoreSelection(), isTrue);
      bloc.endRestoreSelection();
    },
  );

  test('pending deletion excludes selection create and restore', () async {
    final started = Completer<void>();
    final finished = Completer<void>();
    when(() => service.deleteBackup('file')).thenAnswer((_) {
      started.complete();
      return finished.future;
    });
    bloc.add(const DeleteBackup('file'));
    await started.future;
    expect(bloc.tryBeginRestoreSelection(), isFalse);
    bloc.add(const CreateBackup());
    bloc.add(const RestoreFromBackup(backupFilePath: 'file'));
    bloc.add(const DeleteBackup('file'));
    await Future<void>.delayed(Duration.zero);
    verify(() => service.deleteBackup('file')).called(1);
    verifyNoMoreInteractions(service);
    finished.complete();
    await Future<void>.delayed(Duration.zero);
    expect(bloc.tryBeginRestoreSelection(), isTrue);
    bloc.endRestoreSelection();
  });

  test(
    'expired confirmation releases queued handoff without a write',
    () async {
      expect(bloc.tryBeginRestoreSelection(), isTrue);
      bloc.restoreFromSelection(
        RestoreFromBackup(backupFilePath: 'file', isCurrent: () => false),
      );
      await Future<void>.delayed(Duration.zero);
      verifyZeroInteractions(service);
      expect(bloc.tryBeginRestoreSelection(), isTrue);
      bloc.endRestoreSelection();
    },
  );
}
