import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/transfer_entity.dart';
import 'package:n42_chat/src/domain/repositories/transfer_repository.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_event.dart';
import 'package:n42_chat/src/presentation/blocs/transfer/transfer_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:n42_chat/src/presentation/pages/transfer/transfer_page.dart';
import 'package:n42_chat/src/presentation/widgets/chat/transfer_message_widget.dart';
import 'package:n42_chat/src/presentation/widgets/common/n42_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Chat extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class _Transfer extends MockBloc<TransferEvent, TransferState>
    implements TransferBloc {}

class _Transfers extends Mock implements ITransferRepository {}

class _Event extends Fake implements TransferEvent {}

const _contract = '0xabcdef0123456789abcdef0123456789abcdef01';

void main() {
  setUpAll(() => registerFallbackValue(_Event()));

  testWidgets('tapping exact payment message fulfills with complete identity', (
    tester,
  ) async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
    final repository = _Transfers();
    when(
      () => repository.getTransfersByRoom('!room:test'),
    ).thenAnswer((_) async => <TransferEntity>[]);
    getIt.registerSingleton<ITransferRepository>(repository);
    final transfer = _Transfer();
    const transferState = TransferState(
      status: TransferBlocStatus.addressValidated,
      isWalletConnected: true,
      walletAddress: '0xsender',
      tokens: [
        TokenInfo(
          symbol: 'USDT',
          name: 'Tether',
          decimals: 6,
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: _contract,
          contractAddress: _contract,
          receiverAddress: '0xsender',
        ),
      ],
      validatedAddress: '0xreceiver',
      isAddressValid: true,
    );
    when(() => transfer.state).thenReturn(transferState);
    whenListen(
      transfer,
      Stream<TransferState>.value(transferState),
      initialState: transferState,
    );
    when(() => transfer.add(any())).thenReturn(null);
    getIt.registerFactory<TransferBloc>(() => transfer);
    final chat = _Chat();
    when(() => chat.state).thenReturn(
      ChatState(
        messages: [
          MessageEntity(
            id: 'request',
            roomId: '!room:test',
            senderId: '@bob:test',
            senderName: 'Bob',
            content: 'Lunch',
            type: MessageType.paymentRequest,
            timestamp: DateTime(2026, 1, 1),
            metadata: const MessageMetadata(
              paymentRequestId: 'req-exact',
              paymentReceiverAddress: '0xreceiver',
              amount: '1.250000',
              token: 'USDT',
              paymentChain: 'ETH',
              paymentNetwork: 'mainnet',
              paymentAssetType: 'token',
              paymentAssetId: _contract,
            ),
          ),
        ],
        canSendMessages: false,
      ),
    );
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    addTearDown(() async => getIt.reset());
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<ChatBloc>.value(
          value: chat,
          child: const ChatPage(
            conversation: ConversationEntity(id: '!room:test', name: 'Bob'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final requestCard = find.byType(PaymentRequestMessageWidget);
    await tester.ensureVisible(requestCard);
    await tester.tap(requestCard);
    await tester.pumpAndSettle();
    expect(find.byType(TransferPage), findsOneWidget);
    await tester.tap(find.byType(N42Button).last);
    await tester.pump();
    verify(
      () => transfer.add(
        const FulfillPaymentRequest(
          roomId: '!room:test',
          requestId: 'req-exact',
          receiverAddress: '0xreceiver',
          amount: '1.250000',
          token: 'USDT',
          chain: 'ETH',
          network: 'mainnet',
          assetType: 'token',
          assetId: _contract,
        ),
      ),
    ).called(1);
  });
}
