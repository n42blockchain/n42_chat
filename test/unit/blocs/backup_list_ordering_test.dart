import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/chat_backup_service.dart';
import 'package:n42_chat/src/presentation/blocs/backup/backup_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/backup/backup_event.dart';

class _Service extends Mock implements ChatBackupService {}

BackupInfo info(String id) => BackupInfo(
  backupId: id,
  filePath: '/fixture/$id',
  fileSizeBytes: 1,
  createdAt: DateTime(2026),
  roomCount: 1,
  includesMedia: false,
  includesKeys: false,
);

void main() {
  test(
    'session invalidation clears previously loaded private backup data',
    () async {
      final service = _Service();
      var calls = 0;
      when(() => service.listBackups()).thenAnswer((_) async {
        if (++calls == 1) return [info('old-account')];
        throw BackupSessionChanged();
      });
      final bloc = BackupBloc(backupService: service);
      addTearDown(bloc.close);
      final loaded = bloc.stream.firstWhere((state) => !state.isLoading);
      bloc.add(const LoadBackupList());
      await loaded;
      expect(bloc.state.backups, isNotEmpty);
      final cleared = bloc.stream.firstWhere(
        (state) => !state.isLoading && state.backups.isEmpty,
      );
      bloc.add(const LoadBackupList());
      await cleared;
      expect(bloc.state.error, isNull);
      expect(bloc.state.preview, isNull);
      expect(bloc.state.sizeEstimate, isNull);
      expect(bloc.state.successMessage, isNull);
    },
  );

  test(
    'earlier completion cannot finish the latest loading indicator',
    () async {
      final service = _Service();
      final old = Completer<List<BackupInfo>>();
      final current = Completer<List<BackupInfo>>();
      final bothStarted = Completer<void>();
      var calls = 0;
      when(() => service.listBackups()).thenAnswer((_) {
        if (++calls == 1) return old.future;
        bothStarted.complete();
        return current.future;
      });
      final bloc = BackupBloc(backupService: service);
      addTearDown(bloc.close);
      bloc.add(const LoadBackupList());
      bloc.add(const LoadBackupList());
      await bothStarted.future;
      old.complete([info('old')]);
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state.isLoading, isTrue);
      expect(bloc.state.backups, isEmpty);
      final loaded = bloc.stream.firstWhere((state) => !state.isLoading);
      current.complete([info('new')]);
      await loaded;
      expect(bloc.state.backups.single.backupId, 'new');
    },
  );

  for (final outcome in ['success', 'error', 'session']) {
    test(
      'older list completion cannot replace newer result: outcome=$outcome',
      () async {
        final service = _Service();
        final first = Completer<List<BackupInfo>>();
        final second = Completer<List<BackupInfo>>();
        final startedFirst = Completer<void>();
        final startedSecond = Completer<void>();
        var calls = 0;
        when(() => service.listBackups()).thenAnswer((_) {
          if (++calls == 1) {
            startedFirst.complete();
            return first.future;
          }
          startedSecond.complete();
          return second.future;
        });
        final bloc = BackupBloc(backupService: service);
        addTearDown(bloc.close);
        bloc.add(const LoadBackupList());
        await startedFirst.future;
        bloc.add(const LoadBackupList());
        await startedSecond.future;
        final loaded = bloc.stream.firstWhere((state) => !state.isLoading);
        second.complete([info('new')]);
        await loaded;
        if (outcome == 'session') {
          first.completeError(BackupSessionChanged());
        } else if (outcome == 'error') {
          first.completeError(StateError('old-request-error'));
        } else {
          first.complete([info('old')]);
        }
        await Future<void>.delayed(Duration.zero);
        expect(bloc.state.backups.map((backup) => backup.backupId), ['new']);
        expect(bloc.state.error, isNull);
        expect(bloc.state.isLoading, isFalse);
      },
    );
  }
}
