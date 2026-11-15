import 'dart:async';

import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/chat_sync_phase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/common/sync_progress_overlay.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements Client {}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

Widget _buildOverlay() {
  return const MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    locale: Locale('en'),
    home: Scaffold(
      body: Stack(children: [Placeholder(), SyncProgressOverlay()]),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('SyncProgressOverlay', () {
    late _Manager manager;
    late _Client client;
    late StreamController<ChatSyncPhase> phases;

    setUp(() {
      manager = _Manager();
      client = _Client();
      phases = StreamController<ChatSyncPhase>.broadcast();
      when(() => manager.client).thenReturn(client);
      when(() => manager.onChatSyncPhase).thenAnswer((_) => phases.stream);
      when(() => client.prevBatch).thenReturn(null);
    });
    tearDown(() => phases.close());

    Future<void> mount(WidgetTester tester) => tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: Stack(
            children: [
              const Text('Underlying conversations'),
              SyncProgressOverlay(clientManager: manager),
            ],
          ),
        ),
      ),
    );

    testWidgets(
      'sync error offers retry and dismiss instead of endless spinner',
      (tester) async {
        await mount(tester);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        phases.add(ChatSyncPhase.error);
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Retry'), findsOneWidget);
        await tester.tap(find.text('Close'));
        await tester.pumpAndSettle();
        expect(find.text('Retry'), findsNothing);
      },
    );

    testWidgets('retry is single flight and successful sync hides overlay', (
      tester,
    ) async {
      final pending = Completer<void>();
      when(() => client.oneShotSync(timeout: Duration.zero))
          .thenAnswer((_) => pending.future);
      await mount(tester);
      phases.add(ChatSyncPhase.error);
      await tester.pump();
      await tester.tap(find.text('Retry'));
      await tester.pump();
      await tester.tap(find.text('Retry'));
      verify(() => client.oneShotSync(timeout: Duration.zero)).called(1);
      phases.add(ChatSyncPhase.finished);
      pending.complete();
      await tester.pumpAndSettle();
      expect(find.text('Retry'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('old overlay cannot retry after account client replacement', (
      tester,
    ) async {
      await mount(tester);
      phases.add(ChatSyncPhase.error);
      await tester.pump();
      when(() => manager.client).thenReturn(_Client());
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      verifyNever(() => client.oneShotSync(timeout: Duration.zero));
      expect(find.text('Retry'), findsNothing);
    });

    testWidgets('retry exception preserves recovery controls', (tester) async {
      when(() => client.oneShotSync(timeout: Duration.zero))
          .thenThrow(StateError('offline'));
      await mount(tester);
      phases.add(ChatSyncPhase.error);
      await tester.pump();
      await tester.tap(find.text('Retry'));
      await tester.pump();
      expect(find.text('Retry'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading overlay can close without waiting for network', (
      tester,
    ) async {
      await mount(tester);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      phases.add(ChatSyncPhase.error);
      await tester.pump();
      expect(find.text('Retry'), findsNothing);
      verifyNever(() => client.oneShotSync(timeout: Duration.zero));
    });

    testWidgets('pending retry completion after dispose is harmless', (
      tester,
    ) async {
      final pending = Completer<void>();
      when(() => client.oneShotSync(timeout: Duration.zero))
          .thenAnswer((_) => pending.future);
      await mount(tester);
      phases.add(ChatSyncPhase.error);
      await tester.pump();
      await tester.tap(find.text('Retry'));
      await tester.pumpWidget(const SizedBox.shrink());
      pending.completeError(StateError('offline'));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('token change on the same SDK client prevents retry', (
      tester,
    ) async {
      when(() => client.accessToken).thenReturn('original');
      await mount(tester);
      phases.add(ChatSyncPhase.error);
      await tester.pump();
      when(() => client.accessToken).thenReturn('replacement');
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      verifyNever(() => client.oneShotSync(timeout: Duration.zero));
      expect(find.text('Retry'), findsNothing);
    });

    testWidgets('Matrix 客户端未初始化时组件不可见（SizedBox.shrink）', (tester) async {
      // 测试环境中 MatrixClientManager.instance 的 onSyncStatus 为 null
      // _checkSyncState() 早返回，_visible = false
      await tester.pumpWidget(_buildOverlay());
      await tester.pump();

      // 覆盖层不显示，不含进度指示器也不含同步文本
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.textContaining('Sync'), findsNothing);
    });

    testWidgets('组件本身不抛出异常', (tester) async {
      // 只要组件能正常 build / dispose 即可
      await tester.pumpWidget(_buildOverlay());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('暗色主题下组件不抛出异常', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          theme: ThemeData.dark(),
          home: const Scaffold(
            body: Stack(children: [Placeholder(), SyncProgressOverlay()]),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // 暗色主题下也应安全渲染
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('dispose 时正确释放 AnimationController 无报错', (tester) async {
      await tester.pumpWidget(_buildOverlay());
      await tester.pumpAndSettle();

      // 从 widget tree 移除，触发 dispose
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
