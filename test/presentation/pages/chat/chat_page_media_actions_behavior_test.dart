import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/services/red_packet_service.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/domain/entities/red_packet_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:n42_chat/src/presentation/pages/red_packet/send_red_packet_page.dart';
import 'package:n42_chat/src/presentation/widgets/chat/poll_create_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Chat extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class _FakeChatEvent extends Fake implements ChatEvent {}

class _ContactBloc extends Mock implements ContactBloc {}

class _ContactRepository extends Mock implements IContactRepository {}

class _WalletBridge extends Mock implements IWalletBridge {}

class _RedPacketService extends Mock implements IRedPacketService {}

class _MessageRepository extends Mock implements IMessageRepository {}

class _ImagePicker extends ImagePickerPlatform {
  List<XFile> media = const [];
  XFile? video;
  int videoRequests = 0;

  @override
  Future<List<XFile>> getMedia({required MediaOptions options}) async => media;

  @override
  Future<List<XFile>?> getMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async => media;

  @override
  Future<XFile?> getVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    videoRequests++;
    return video;
  }
}

void main() {
  late _Chat chat;
  late _ContactBloc contacts;
  late _ContactRepository contactRepository;
  late _ImagePicker imagePicker;
  late ImagePickerPlatform previousImagePicker;
  late List<ChatEvent> events;

  setUpAll(() {
    registerFallbackValue(_FakeChatEvent());
  });

  setUp(() async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
    contactRepository = _ContactRepository();
    getIt.registerSingleton<IContactRepository>(contactRepository);
    when(() => contactRepository.getContactById('@tip:server.test')).thenAnswer(
      (_) async => const ContactEntity(
        userId: '@tip:server.test',
        displayName: 'Tip recipient',
        walletAddress: '0x1111111111111111111111111111111111111111',
      ),
    );

    chat = _Chat();
    events = [];
    when(() => chat.state).thenReturn(const ChatState(canSendMessages: true));
    when(() => chat.stream).thenAnswer((_) => const Stream<ChatState>.empty());
    when(() => chat.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as ChatEvent);
    });

    contacts = _ContactBloc();
    when(() => contacts.state).thenReturn(const ContactState());
    when(
      () => contacts.stream,
    ).thenAnswer((_) => const Stream<ContactState>.empty());

    previousImagePicker = ImagePickerPlatform.instance;
    imagePicker = _ImagePicker();
    ImagePickerPlatform.instance = imagePicker;
  });

  tearDown(() async {
    ImagePickerPlatform.instance = previousImagePicker;
    await getIt.reset();
  });

  Future<S> openChat(
    WidgetTester tester, {
    bool encrypted = false,
    String? directUserId,
  }) async {
    tester.view.physicalSize = const Size(430, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: BlocProvider<ContactBloc>.value(
          value: contacts,
          child: BlocProvider<ChatBloc>.value(
            value: chat,
            child: ChatPage(
              conversation: ConversationEntity(
                id: '!media:server.test',
                name: 'Media test',
                isEncrypted: encrypted,
                directUserId: directUserId,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return S.of(tester.element(find.byType(ChatPage)))!;
  }

  Future<void> openAttachmentPanel(WidgetTester tester) async {
    await tester.tap(
      find.byKey(const ValueKey('chat_input_attachment_toggle')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  Future<void> mockFilePicker(
    WidgetTester tester, {
    required String path,
    required int size,
  }) async {
    const channel = MethodChannel('miguelruivo.flutter.plugins.filepicker');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (call) async => [
        {'name': 'document.txt', 'path': path, 'size': size},
      ],
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        null,
      ),
    );
  }

  Future<void> openPhotoOptions(WidgetTester tester, S l10n) async {
    await openAttachmentPanel(tester);
    await tester.tap(find.text(l10n.contactPhotos).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  testWidgets('selecting multiple photos sends each image through ChatBloc', (
    tester,
  ) async {
    imagePicker.media = [
      XFile.fromData(Uint8List.fromList([1, 2, 3]), name: 'first.jpg'),
      XFile.fromData(Uint8List.fromList([4, 5, 6]), name: 'second.png'),
    ];
    final l10n = await openChat(tester);

    await openPhotoOptions(tester, l10n);
    await tester.tap(find.text(l10n.contactPhotos).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    verify(() => chat.add(any(that: isA<SendImageMessage>()))).called(2);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'recording menu returns cleanly when the camera picker is canceled',
    (tester) async {
      final l10n = await openChat(tester);

      await openAttachmentPanel(tester);
      await tester.tap(find.text(l10n.commonTakePhoto));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.text(l10n.chatRecording));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(imagePicker.videoRequests, 1);
      verifyNever(() => chat.add(any(that: isA<SendVideoMessage>())));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('selected document is queued from its readable path', (
    tester,
  ) async {
    final directory = Directory.systemTemp.createTempSync('chat-file-picker');
    addTearDown(() => directory.deleteSync(recursive: true));
    final source = File('${directory.path}/document.txt')
      ..writeAsStringSync('note');
    await mockFilePicker(tester, path: source.path, size: 4);
    final l10n = await openChat(tester);

    await openAttachmentPanel(tester);
    await tester.tap(find.text(l10n.commonFileLabel).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final event = events.whereType<SendFileMessage>().single;
    verify(() => chat.add(any(that: isA<SendFileMessage>()))).called(1);
    expect(event.filename, 'document.txt');
    expect(event.filePath, source.path);
    expect(event.fileSize, 4);
    expect(tester.takeException(), isNull);
  });

  testWidgets('encrypted room rejects documents above its size limit', (
    tester,
  ) async {
    final directory = Directory.systemTemp.createTempSync(
      'chat-encrypted-file-picker',
    );
    addTearDown(() => directory.deleteSync(recursive: true));
    final source = File('${directory.path}/large.txt')..writeAsStringSync('x');
    await mockFilePicker(tester, path: source.path, size: 64 * 1024 * 1024 + 1);
    final l10n = await openChat(tester, encrypted: true);

    await openAttachmentPanel(tester);
    await tester.tap(find.text(l10n.commonFileLabel).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    verifyNever(() => chat.add(any(that: isA<SendFileMessage>())));
    expect(
      find.textContaining('secure file uploads up to 64MB'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty photo picker result leaves the composer unchanged', (
    tester,
  ) async {
    final l10n = await openChat(tester);

    await openPhotoOptions(tester, l10n);
    await tester.tap(find.text(l10n.contactPhotos).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    verifyNever(() => chat.add(any(that: isA<SendImageMessage>())));
    expect(tester.takeException(), isNull);
  });

  testWidgets('original gallery image is sent as an uncompressed file', (
    tester,
  ) async {
    imagePicker.media = [
      XFile.fromData(Uint8List.fromList([1, 2, 3, 4]), name: 'original.png'),
    ];
    final l10n = await openChat(tester);

    await openPhotoOptions(tester, l10n);
    await tester.tap(find.text('Original Images'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final event = events.whereType<SendFileMessage>().single;
    expect(event.filename, startsWith('image_'));
    expect(event.filename, endsWith('.jpg'));
    expect(event.filePath, isNull);
    expect(event.fileSize, 4);
    expect(event.fileBytes, [1, 2, 3, 4]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('video selected from the gallery reaches the video event', (
    tester,
  ) async {
    const videoThumbnailChannel = MethodChannel(
      'plugins.justsoft.xyz/video_thumbnail',
    );
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      videoThumbnailChannel,
      (_) async => null,
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        videoThumbnailChannel,
        null,
      ),
    );
    imagePicker.media = [
      XFile.fromData(
        Uint8List.fromList([7, 8, 9]),
        name: 'clip.mp4',
        path: '/tmp/clip.mp4',
      ),
    ];
    final l10n = await openChat(tester);

    await openPhotoOptions(tester, l10n);
    await tester.tap(find.text(l10n.contactPhotos).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.runAsync(() async {
      for (var attempt = 0; attempt < 100; attempt++) {
        if (events.whereType<SendVideoMessage>().isNotEmpty) return;
        await Future<void>.delayed(const Duration(milliseconds: 10));
      }
    });
    await tester.pump();

    final event = events.whereType<SendVideoMessage>().single;
    expect(event.filename, 'clip.mp4');
    expect(event.videoBytes, [7, 8, 9]);
    expect(event.mimeType, 'video/mp4');
    expect(tester.takeException(), isNull);
  });

  testWidgets('location options can be canceled without sending a message', (
    tester,
  ) async {
    final l10n = await openChat(tester);

    await openAttachmentPanel(tester);
    await tester.ensureVisible(find.text(l10n.commonLocationLabel));
    await tester.tap(find.text(l10n.commonLocationLabel).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text(l10n.chatSendLocation), findsOneWidget);
    expect(find.text(l10n.chatShareRealTimeLocation), findsOneWidget);
    await tester.tap(find.text(l10n.commonCancel).last);
    await tester.pumpAndSettle();

    verifyNever(() => chat.add(any(that: isA<SendLocationMessage>())));
    expect(tester.takeException(), isNull);
  });

  testWidgets('red packet stays open when wallet balance is insufficient', (
    tester,
  ) async {
    final l10n = await openChat(tester);
    final wallet = _WalletBridge();
    getIt.registerSingleton<IWalletBridge>(wallet);
    when(() => wallet.getBalance('CNY')).thenAnswer((_) async => '1');

    await openAttachmentPanel(tester);
    await tester.drag(find.byType(PageView), const Offset(-350, 0));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.ensureVisible(find.text(l10n.profileRedPacket));
    await tester.tap(find.text(l10n.profileRedPacket));
    await tester.pumpAndSettle();

    expect(find.byType(SendRedPacketPage), findsOneWidget);
    expect(find.text(l10n.commonSendRedPacket), findsOneWidget);
    final amountField = find
        .descendant(
          of: find.byType(SendRedPacketPage),
          matching: find.byType(TextField),
        )
        .first;
    await tester.enterText(amountField, '10');
    await tester.pump();
    expect(tester.widget<TextField>(amountField).controller?.text, '10');
    final submitButton = find.widgetWithText(
      ElevatedButton,
      l10n.commonPutMoneyInRedPacket,
    );
    expect(tester.widget<ElevatedButton>(submitButton).onPressed, isNotNull);
    await tester.tap(find.text(l10n.commonPutMoneyInRedPacket));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(SendRedPacketPage), findsOneWidget);
    verify(() => wallet.getBalance('CNY')).called(1);
    expect(find.text(l10n.redPacketInsufficientBalance), findsOneWidget);
    expect(events.whereType<SendCustomMessage>(), isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('successful red packet sends its metadata and visible receipt', (
    tester,
  ) async {
    final l10n = await openChat(tester);
    when(
      () => chat.state,
    ).thenReturn(const ChatState(roomId: '!media:server.test'));
    final wallet = _WalletBridge();
    final service = _RedPacketService();
    final messages = _MessageRepository();
    getIt.registerSingleton<IWalletBridge>(wallet);
    getIt.registerSingleton<IRedPacketService>(service);
    getIt.registerSingleton<IMessageRepository>(messages);
    when(() => wallet.getBalance('CNY')).thenAnswer((_) async => '100');
    when(
      () => messages.getCurrentUserId(),
    ).thenAnswer((_) async => '@sender:server.test');
    when(
      () => service.createRedPacket(
        roomId: '!media:server.test',
        totalAmount: 10,
        totalCount: 1,
        token: 'CNY',
        type: RedPacketType.normal,
        greeting: 'Good luck',
        senderId: '@sender:server.test',
        senderName: any(named: 'senderName'),
      ),
    ).thenAnswer(
      (_) async => RedPacketEntity(
        id: 'packet-1',
        roomId: '!media:server.test',
        senderId: '@sender:server.test',
        senderName: 'Media test',
        greeting: 'Good luck',
        type: RedPacketType.normal,
        totalAmount: 10,
        totalCount: 1,
        token: 'CNY',
        claims: const [],
        createdAt: DateTime.utc(2026),
        expiresAt: DateTime.utc(2026, 1, 2),
      ),
    );

    await openAttachmentPanel(tester);
    await tester.drag(find.byType(PageView), const Offset(-350, 0));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.ensureVisible(find.text(l10n.profileRedPacket));
    await tester.tap(find.text(l10n.profileRedPacket));
    await tester.pumpAndSettle();

    final formFields = find.descendant(
      of: find.byType(SendRedPacketPage),
      matching: find.byType(TextField),
    );
    await tester.enterText(formFields.at(0), '10');
    await tester.pump();
    await tester.enterText(formFields.at(1), 'Good luck');
    await tester.pump();
    await tester.tap(find.text(l10n.commonPutMoneyInRedPacket));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 500));

    verify(() => wallet.getBalance('CNY')).called(1);
    verify(() => messages.getCurrentUserId()).called(1);
    verify(
      () => service.createRedPacket(
        roomId: '!media:server.test',
        totalAmount: 10,
        totalCount: 1,
        token: 'CNY',
        type: RedPacketType.normal,
        greeting: 'Good luck',
        senderId: '@sender:server.test',
        senderName: any(named: 'senderName'),
      ),
    ).called(1);

    expect(find.byType(SendRedPacketPage), findsNothing);
    expect(find.text(l10n.chatRedPacketSent('10', 'CNY')), findsOneWidget);
    final event = events.whereType<SendCustomMessage>().single;
    expect(event.type, MessageType.redPacket);
    expect(event.content, 'Good luck');
    expect(event.metadata?.redPacketId, 'packet-1');
    expect(event.metadata?.amount, '10');
    expect(event.metadata?.token, 'CNY');
    expect(event.metadata?.transferStatus, 'pending');
    expect(tester.takeException(), isNull);
  });

  testWidgets('tip refuses a direct recipient without a wallet address', (
    tester,
  ) async {
    await openChat(tester, directUserId: '@peer:server.test');

    await openAttachmentPanel(tester);
    await tester.drag(find.byType(PageView), const Offset(-350, 0));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.ensureVisible(find.text('Tip'));
    await tester.tap(find.text('Tip'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Recipient has no wallet address'), findsOneWidget);
    verifyNever(() => chat.add(any(that: isA<SendCustomMessage>())));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'canceling a tip leaves its dialog controllers alive through exit',
    (tester) async {
      final l10n = await openChat(tester, directUserId: '@tip:server.test');

      await openAttachmentPanel(tester);
      await tester.drag(find.byType(PageView), const Offset(-350, 0));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.ensureVisible(find.text('Tip'));
      await tester.tap(find.text('Tip'));
      await tester.pumpAndSettle();
      expect(find.text('Send a tip'), findsOneWidget);

      await tester.tap(find.text(l10n.commonCancel));
      await tester.pumpAndSettle();

      expect(find.text('Send a tip'), findsNothing);
      expect(events.whereType<SendCustomMessage>(), isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  for (final invalidCase in {
    'empty': '',
    'zero': '0',
    'negative': '-1',
    'NaN': 'NaN',
    'Infinity': 'Infinity',
    'text': 'not-a-number',
  }.entries) {
    testWidgets(
      'rejects ${invalidCase.key} tip amount before wallet transfer',
      (tester) async {
        final l10n = await openChat(tester, directUserId: '@tip:server.test');
        final wallet = _WalletBridge();
        getIt.registerSingleton<IWalletBridge>(wallet);

        await openAttachmentPanel(tester);
        await tester.drag(find.byType(PageView), const Offset(-350, 0));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.ensureVisible(find.text('Tip'));
        await tester.tap(find.text('Tip'));
        await tester.pumpAndSettle();
        final amountField = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(amountField, invalidCase.value);
        await tester.tap(find.widgetWithText(TextButton, 'Tip'));
        await tester.pumpAndSettle();

        expect(find.text('Send a tip'), findsOneWidget);
        expect(find.text(l10n.transferEnterValidAmount), findsOneWidget);
        expect(events.whereType<SendCustomMessage>(), isEmpty);
        verifyNever(
          () => wallet.requestTransfer(
            toAddress: any(named: 'toAddress'),
            amount: any(named: 'amount'),
            token: any(named: 'token'),
            memo: any(named: 'memo'),
          ),
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('positive tip sends the entered amount and transaction hash', (
    tester,
  ) async {
    await openChat(tester, directUserId: '@tip:server.test');
    final wallet = _WalletBridge();
    getIt.registerSingleton<IWalletBridge>(wallet);
    when(
      () => wallet.requestTransfer(
        toAddress: '0x1111111111111111111111111111111111111111',
        amount: '1.25',
        token: 'USDC',
        memo: 'Lunch',
      ),
    ).thenAnswer((_) async => TransferResult.success('0xtip'));

    await openAttachmentPanel(tester);
    await tester.drag(find.byType(PageView), const Offset(-350, 0));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.ensureVisible(find.text('Tip'));
    await tester.tap(find.text('Tip'));
    await tester.pumpAndSettle();
    final fields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextField),
    );
    await tester.enterText(fields.at(0), '1.25');
    await tester.enterText(fields.at(1), 'USDC');
    await tester.enterText(fields.at(2), 'Lunch');
    await tester.tap(find.widgetWithText(TextButton, 'Tip'));
    await tester.pumpAndSettle();

    final event = events.whereType<SendCustomMessage>().single;
    expect(event.content, 'Lunch');
    expect(event.metadata?.amount, '1.25');
    expect(event.metadata?.token, 'USDC');
    expect(event.metadata?.txHash, '0xtip');
    verify(
      () => wallet.requestTransfer(
        toAddress: '0x1111111111111111111111111111111111111111',
        amount: '1.25',
        token: 'USDC',
        memo: 'Lunch',
      ),
    ).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('poll composer sends the validated poll through ChatBloc', (
    tester,
  ) async {
    final l10n = await openChat(tester);

    await openAttachmentPanel(tester);
    await tester.ensureVisible(find.text(l10n.commonPoll));
    await tester.tap(find.text(l10n.commonPoll));
    await tester.pumpAndSettle();

    final question = find.descendant(
      of: find.byType(PollCreateSheet),
      matching: find.byType(TextField),
    );
    await tester.enterText(question.at(0), '  Team lunch?  ');
    await tester.enterText(question.at(1), ' Noodles ');
    await tester.enterText(question.at(2), ' Tacos ');
    await tester.ensureVisible(find.text(l10n.chatSubmitPoll));
    await tester.tap(find.text(l10n.chatSubmitPoll));
    await tester.pumpAndSettle();

    final event = events.whereType<SendPollMessage>().single;
    expect(event.question, 'Team lunch?');
    expect(event.options, ['Noodles', 'Tacos']);
    expect(event.maxSelections, 1);
    expect(event.isAnonymous, isFalse);
    expect(find.byType(PollCreateSheet), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('choosing a recommended song sends a music card', (tester) async {
    final l10n = await openChat(tester);

    await openAttachmentPanel(tester);
    await tester.drag(find.byType(PageView), const Offset(-350, 0));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.ensureVisible(find.text(l10n.commonMusic));
    await tester.tap(find.text(l10n.commonMusic));
    await tester.pumpAndSettle();
    await tester.tap(find.text('晴天'));
    await tester.pumpAndSettle();

    final event = events.whereType<SendCustomMessage>().single;
    expect(event.type, MessageType.music);
    expect(event.content, '🎵 晴天 - 周杰伦');
    expect(event.metadata?.musicTitle, '晴天');
    expect(event.metadata?.musicArtist, '周杰伦');
    expect(tester.takeException(), isNull);
  });
}
