import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/domain/entities/contact_entity.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/red_packet_entity.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/core/services/red_packet_service.dart';
import 'package:n42_chat/src/integration/wallet_bridge.dart';
import 'package:n42_chat/src/domain/repositories/message_repository.dart';
import 'package:n42_chat/src/presentation/widgets/chat/transfer_message_widget.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/domain/repositories/contact_repository.dart';
import 'package:n42_chat/src/domain/repositories/group_repository.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_event.dart';
import 'package:n42_chat/src/presentation/blocs/chat/chat_state.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_event.dart';
import 'package:n42_chat/src/presentation/blocs/contact/contact_state.dart';
import 'package:n42_chat/src/presentation/blocs/live_location/live_location_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/live_location/live_location_event.dart';
import 'package:n42_chat/src/presentation/blocs/live_location/live_location_state.dart';
import 'package:n42_chat/src/presentation/pages/chat/chat_page.dart';
import 'package:n42_chat/src/presentation/pages/chat/live_location_page.dart';
import 'package:n42_chat/src/presentation/pages/red_packet/red_packet_detail_page.dart';
import 'package:n42_chat/src/presentation/pages/red_packet/send_red_packet_page.dart';
import 'package:n42_chat/src/presentation/pages/transfer/transfer_page.dart';
import 'package:n42_chat/src/presentation/widgets/chat/chat_input_bar.dart';
import 'package:n42_chat/src/presentation/widgets/chat/chat_more_panel.dart';
import 'package:n42_chat/src/presentation/widgets/chat/expression_panel.dart';
import 'package:n42_chat/src/presentation/widgets/chat/poll_create_sheet.dart';
import 'package:n42_chat/src/presentation/widgets/chat/open_red_packet_dialog.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Chat extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class _ChatEvent extends Fake implements ChatEvent {}

class _Contacts extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

class _LiveLocation extends MockBloc<LiveLocationEvent, LiveLocationState>
    implements LiveLocationBloc {}

class _LiveLocationEvent extends Fake implements LiveLocationEvent {}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Auth extends Mock
    implements IAuthRepository, IAccountBoundDeletionLifecycle {}

class _Groups extends Mock implements IGroupRepository {}

class _ContactRepository extends Mock implements IContactRepository {}

class _Messages extends Mock implements IMessageRepository {}

class _RedPackets extends Mock implements IRedPacketService {}

class _WalletBridge extends Mock implements IWalletBridge {}

class _Account {
  _Account(this.contactRepository) {
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@me:hs.test');
    when(() => client.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => client.accessToken).thenReturn('token');
    when(() => client.deviceID).thenReturn(null);
    when(client.isLogged).thenReturn(true);
    when(() => auth.currentAccountGeneration).thenReturn(generation);
    when(() => auth.currentUser).thenReturn(null);
    when(() => groups.getGroupMembers(any())).thenAnswer((_) async => []);
    when(() => contactRepository.getContacts()).thenAnswer((_) async => []);
    getIt.registerSingleton<MatrixClientManager>(manager);
    getIt.registerSingleton<IAuthRepository>(auth);
    getIt.registerSingleton<IGroupRepository>(groups);
    getIt.registerSingleton<IContactRepository>(contactRepository);
  }

  final manager = _Manager();
  final client = _Client();
  final auth = _Auth();
  final groups = _Groups();
  final IContactRepository contactRepository;
  final generation = AuthSessionInvalidation(
    userId: '@me:hs.test',
    homeserver: Uri.parse('https://hs.test'),
    deviceId: null,
    isCurrent: () => true,
    matchesClient: (_) => true,
  );
}

class _ImagePicker extends ImagePickerPlatform {
  int mediaCalls = 0;
  int multiImageCalls = 0;
  int cameraImageCalls = 0;
  int videoCalls = 0;
  List<XFile> mediaFiles = [];
  List<XFile> images = [];
  XFile? video;
  Duration? requestedVideoDuration;

  @override
  Future<List<XFile>> getMedia({required MediaOptions options}) async {
    mediaCalls++;
    return mediaFiles;
  }

  @override
  Future<List<XFile>> getMultiImageWithOptions({
    MultiImagePickerOptions options = const MultiImagePickerOptions(),
  }) async {
    multiImageCalls++;
    return images;
  }

  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    expect(source, ImageSource.camera);
    cameraImageCalls++;
    return null;
  }

  @override
  Future<XFile?> getVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    expect(source, ImageSource.camera);
    videoCalls++;
    requestedVideoDuration = maxDuration;
    return video;
  }
}

class _MemoryImage extends XFile {
  _MemoryImage(Uint8List bytes, this.fileName) : super.fromData(bytes);

  final String fileName;

  @override
  String get name => fileName;
}

class _AppSupportPaths extends PathProviderPlatform {
  _AppSupportPaths(this.path);

  final String path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;
}

class _LocationSource extends GeolocatorPlatform {
  bool serviceEnabled = true;
  LocationPermission permission = LocationPermission.whileInUse;
  LocationPermission requestedPermission = LocationPermission.whileInUse;
  int serviceChecks = 0;
  int permissionChecks = 0;
  int permissionRequests = 0;

  @override
  Future<bool> isLocationServiceEnabled() async {
    serviceChecks++;
    return serviceEnabled;
  }

  @override
  Future<LocationPermission> checkPermission() async {
    permissionChecks++;
    return permission;
  }

  @override
  Future<LocationPermission> requestPermission() async {
    permissionRequests++;
    return requestedPermission;
  }
}

const _roomId = '!media-actions:hs.test';
const _pollEventId = r'$page-poll-event';

MessageEntity _paymentRequest({
  String id = 'request',
  String? requestId = 'request-id',
  String? receiver = '0xreceiver',
  String? amount = '1.0',
  String? token = 'USDT',
  String? status,
  DateTime? expiresAt,
  bool isFromMe = false,
}) => MessageEntity(
  id: id,
  roomId: _roomId,
  senderId: '@friend:hs.test',
  senderName: 'Friend',
  content: 'Lunch',
  type: MessageType.paymentRequest,
  timestamp: DateTime(2026, 1, 1),
  isFromMe: isFromMe,
  metadata: MessageMetadata(
    paymentRequestId: requestId,
    paymentReceiverAddress: receiver,
    amount: amount,
    token: token,
    transferStatus: status,
    paymentRequestExpiresAt: expiresAt,
  ),
);

MessageEntity _pollMessage({
  List<String> selectedOptionIds = const ['red', 'blue'],
  List<String> currentVotes = const [],
  int maxSelections = 1,
  bool isFromMe = false,
}) {
  return MessageEntity(
    id: _pollEventId,
    roomId: _roomId,
    senderId: '@me:hs.test',
    senderName: 'Me',
    content: 'Choose a color',
    type: MessageType.poll,
    timestamp: DateTime(2026, 1, 1),
    isFromMe: isFromMe,
    metadata: MessageMetadata(
      pollQuestion: 'Choose a color',
      pollOptions: const ['Red', 'Blue'],
      pollOptionIds: selectedOptionIds,
      myVotes: currentVotes,
      maxSelections: maxSelections,
      totalVoters: 1,
    ),
  );
}

void main() {
  late _ImagePicker imagePicker;
  late ImagePickerPlatform originalImagePicker;
  late _LocationSource locationSource;
  late GeolocatorPlatform originalLocationSource;
  late PathProviderPlatform originalPathProvider;
  late Directory appSupportDirectory;
  late _ContactRepository contactRepository;

  setUpAll(() {
    registerFallbackValue(_ChatEvent());
    registerFallbackValue(_LiveLocationEvent());
  });

  setUp(() async {
    originalImagePicker = ImagePickerPlatform.instance;
    imagePicker = _ImagePicker();
    ImagePickerPlatform.instance = imagePicker;
    originalLocationSource = GeolocatorPlatform.instance;
    locationSource = _LocationSource();
    GeolocatorPlatform.instance = locationSource;
    originalPathProvider = PathProviderPlatform.instance;
    appSupportDirectory = await Directory.systemTemp.createTemp(
      'n42-chat-media-actions-',
    );
    PathProviderPlatform.instance = _AppSupportPaths(appSupportDirectory.path);
    contactRepository = _ContactRepository();
  });

  tearDown(() async {
    ImagePickerPlatform.instance = originalImagePicker;
    GeolocatorPlatform.instance = originalLocationSource;
    PathProviderPlatform.instance = originalPathProvider;
    if (await appSupportDirectory.exists()) {
      await appSupportDirectory.delete(recursive: true);
    }
  });

  Future<_Chat> pumpChat(
    WidgetTester tester, {
    bool canSendMessages = true,
    List<MessageEntity> messages = const [],
    void Function(_Auth auth)? configureAuth,
  }) async {
    SharedPreferences.setMockInitialValues({});
    getIt.registerSingleton<PreferencesDataSource>(PreferencesDataSource());
    final account = _Account(contactRepository);
    configureAuth?.call(account.auth);

    final chat = _Chat();
    when(() => chat.state).thenReturn(
      ChatState(
        roomId: _roomId,
        messages: messages,
        canSendMessages: canSendMessages,
      ),
    );
    final contacts = _Contacts();
    whenListen(
      contacts,
      const Stream<ContactState>.empty(),
      initialState: const ContactState(),
    );

    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ChatBloc>.value(value: chat),
            BlocProvider<ContactBloc>.value(value: contacts),
          ],
          child: const ChatPage(
            conversation: ConversationEntity(id: _roomId, name: 'Media'),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 400));
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      await getIt.reset();
      await tester.binding.setSurfaceSize(null);
    });
    return chat;
  }

  Future<void> openAttachmentPanel(WidgetTester tester) async {
    await tester.tap(
      find.byKey(const ValueKey('chat_input_attachment_toggle')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  Future<void> openLiveLocationPermissionPrompt(WidgetTester tester) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Location').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.text('Share Real-time Location'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
  }

  testWidgets('photo picker cancel does not invoke the platform picker', (
    tester,
  ) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Photos').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Original Images'), findsOneWidget);

    await tester.tap(find.text('Cancel').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(imagePicker.mediaCalls, 0);
    expect(imagePicker.multiImageCalls, 0);
  });

  testWidgets('empty original image selection returns without sending', (
    tester,
  ) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Photos').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.text('Original Images'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(imagePicker.multiImageCalls, 1);
    expect(imagePicker.mediaCalls, 0);
  });

  testWidgets('selected gallery images dispatch separate image messages', (
    tester,
  ) async {
    imagePicker.mediaFiles = [
      XFile.fromData(Uint8List.fromList([1, 2]), path: '/picked/first.jpg'),
      XFile.fromData(Uint8List.fromList([3, 4, 5]), path: '/picked/second.png'),
    ];
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Photos').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.text('Photos').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();

    final images = sentEvents.whereType<SendImageMessage>().toList();
    expect(imagePicker.mediaCalls, 1);
    expect(images.map((event) => event.filename), ['first.jpg', 'second.png']);
    expect(images.map((event) => event.imageBytes.length), [2, 3]);
  });

  testWidgets('original image selection sends file messages with metadata', (
    tester,
  ) async {
    imagePicker.images = [
      _MemoryImage(Uint8List.fromList([1, 2, 3, 4]), 'original.png'),
    ];
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Photos').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.text('Original Images'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();

    final files = sentEvents.whereType<SendFileMessage>().toList();
    expect(imagePicker.multiImageCalls, 1);
    expect(files, hasLength(1));
    expect(files.single.filename, 'original.png');
    expect(files.single.fileSize, 4);
    expect(files.single.fileBytes, Uint8List.fromList([1, 2, 3, 4]));
  });

  testWidgets('video note records a short circular video message', (
    tester,
  ) async {
    imagePicker.video = XFile.fromData(
      Uint8List.fromList([4, 5, 6]),
      path: '/picked/video-note.mp4',
      name: 'camera-recording.mp4',
      mimeType: 'video/mp4',
    );
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await openAttachmentPanel(tester);
    tester
        .widget<ChatMorePanel>(find.byType(ChatMorePanel))
        .onVideoNotePressed!();
    for (var attempt = 0; attempt < 20; attempt++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();
      if (sentEvents.whereType<SendVideoMessage>().isNotEmpty) break;
    }

    expect(imagePicker.videoCalls, 1);
    expect(imagePicker.requestedVideoDuration, const Duration(seconds: 15));
    final message = sentEvents.whereType<SendVideoMessage>().single;
    expect(message.filename, startsWith('n42note_'));
    expect(message.filename, endsWith('.mp4'));
    expect(message.mimeType, 'video/mp4');
    expect(message.videoBytes, Uint8List.fromList([4, 5, 6]));
  });

  testWidgets('scheduled original image persists a safe readable attachment', (
    tester,
  ) async {
    imagePicker.images = [
      _MemoryImage(
        Uint8List.fromList([7, 8, 9, 10]),
        'Vacation: Original Photo.png',
      ),
    ];
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await openAttachmentPanel(tester);
    await tester.longPress(find.text('Photos').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('In 1 hour'), findsOneWidget);
    await tester.tap(find.text('In 1 hour'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Original Images'), findsOneWidget);
    await tester.tap(find.text('Original Images'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    for (var attempt = 0; attempt < 30; attempt++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();
      if (sentEvents.isNotEmpty) {
        break;
      }
    }
    await tester.pumpAndSettle();

    expect(imagePicker.multiImageCalls, 1);
    expect(sentEvents, isNotEmpty);
    final scheduled = sentEvents.whereType<SendScheduledMessage>().single;
    final localPath = scheduled.payload!['localPath'] as String;
    final persistedFile = File(localPath);
    expect(scheduled.type, MessageType.file);
    expect(scheduled.text, 'Vacation: Original Photo.png');
    expect(scheduled.payload, containsPair('filename', scheduled.text));
    expect(scheduled.payload, containsPair('mimeType', 'image/png'));
    expect(scheduled.payload, containsPair('fileSize', 4));
    expect(scheduled.scheduledAt.isAfter(DateTime.now()), isTrue);
    expect(
      localPath,
      startsWith('${appSupportDirectory.path}/scheduled_attachments/'),
    );
    expect(localPath, isNot(contains('..')));
    expect(localPath, isNot(contains(':')));
    expect(persistedFile.readAsBytesSync(), [7, 8, 9, 10]);
    expect(persistedFile.lengthSync(), 4);
    expect(
      find.text('Scheduled original image: ${scheduled.text}'),
      findsOneWidget,
    );
    expect(imagePicker.multiImageCalls, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('camera menu cancel does not open the camera picker', (
    tester,
  ) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Take Photo').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Take Photo'), findsOneWidget);
    expect(find.text('Recording'), findsOneWidget);

    await tester.tap(find.text('Cancel').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(imagePicker.cameraImageCalls, 0);
    expect(imagePicker.mediaCalls, 0);
  });

  testWidgets('location menu cancel does not open a location picker', (
    tester,
  ) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    await tester.tap(find.text('Location').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Send Location'), findsOneWidget);
    expect(find.text('Share Real-time Location'), findsOneWidget);

    await tester.tap(find.text('Cancel').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Send Location'), findsNothing);
    expect(find.text('Share Real-time Location'), findsNothing);
    expect(imagePicker.cameraImageCalls, 0);
  });

  testWidgets(
    'live location explains how to enable a disabled location service',
    (tester) async {
      locationSource.serviceEnabled = false;
      await openLiveLocationPermissionPrompt(tester);

      expect(find.text('Location service is not enabled'), findsOneWidget);
      expect(locationSource.serviceChecks, 1);
      expect(locationSource.permissionChecks, 0);

      await tester.tap(find.text('Cancel').last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('Location service is not enabled'), findsNothing);
    },
  );

  testWidgets('live location reports permanently denied location permission', (
    tester,
  ) async {
    locationSource.permission = LocationPermission.deniedForever;
    await openLiveLocationPermissionPrompt(tester);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('permanently'), findsOneWidget);
    expect(locationSource.serviceChecks, 1);
    expect(locationSource.permissionChecks, 1);
    expect(locationSource.permissionRequests, 0);
  });

  testWidgets('authorized live location can be canceled at confirmation', (
    tester,
  ) async {
    await openLiveLocationPermissionPrompt(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Start Sharing'), findsOneWidget);
    await tester.tap(find.text('Cancel').last);
    await tester.pump();

    expect(find.byType(LiveLocationPage), findsNothing);
    expect(locationSource.serviceChecks, 1);
    expect(locationSource.permissionChecks, 1);
    expect(locationSource.permissionRequests, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('confirming live location observes the current room', (
    tester,
  ) async {
    await pumpChat(tester);
    final events = <LiveLocationEvent>[];
    final liveLocation = _LiveLocation();
    whenListen(
      liveLocation,
      const Stream<LiveLocationState>.empty(),
      initialState: const LiveLocationState(),
    );
    when(() => liveLocation.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as LiveLocationEvent);
    });
    getIt.registerFactory<LiveLocationBloc>(() => liveLocation);

    await openAttachmentPanel(tester);
    await tester.tap(find.text('Location').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.text('Share Real-time Location'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.text('Start Sharing'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.byType(LiveLocationPage), findsOneWidget);
    expect(events.whereType<ObserveLiveLocationRoom>().single.roomId, _roomId);
    expect(locationSource.serviceChecks, 1);
    expect(locationSource.permissionChecks, 1);
    expect(locationSource.permissionRequests, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('read-only channels show an announcement instead of a composer', (
    tester,
  ) async {
    await pumpChat(tester, canSendMessages: false);

    expect(find.text('Only admins can post in this channel'), findsOneWidget);
    expect(find.byType(ChatInputBar), findsNothing);
  });

  testWidgets('self-destruct timer picker renders without obscured ink', (
    tester,
  ) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    tester
        .widget<ChatMorePanel>(find.byType(ChatMorePanel))
        .onSelfDestructTimerPressed!();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Self-destruct Timer'), findsOneWidget);
    expect(find.text('10 秒'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('view-once mode can be cancelled before sending', (tester) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);
    tester
        .widget<ChatMorePanel>(find.byType(ChatMorePanel))
        .onViewOncePressed!();
    await tester.pump();

    expect(find.text('View Once'), findsOneWidget);
    final indicatorRow = find.ancestor(
      of: find.text('View Once'),
      matching: find.byType(Row),
    );
    await tester.tap(
      find.descendant(
        of: indicatorRow.first,
        matching: find.byIcon(Icons.close),
      ),
    );
    await tester.pump();

    expect(find.text('View Once'), findsNothing);
  });

  testWidgets(
    'composer sends non-empty text and ignores whitespace-only text',
    (tester) async {
      final chat = await pumpChat(tester);
      final sentEvents = <ChatEvent>[];
      when(() => chat.add(any())).thenAnswer((invocation) {
        sentEvents.add(invocation.positionalArguments.single as ChatEvent);
      });
      final input = find.byType(TextField).last;

      await tester.enterText(input, '   ');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      expect(sentEvents.whereType<SendTextMessage>(), isEmpty);

      await tester.enterText(input, 'hello from the composer');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      final messages = sentEvents.whereType<SendTextMessage>().toList();
      expect(messages, hasLength(1));
      expect(messages.single.text, 'hello from the composer');
    },
  );

  testWidgets('emoji and attachment panels are mutually exclusive', (
    tester,
  ) async {
    await pumpChat(tester);

    await tester.tap(find.byIcon(Icons.emoji_emotions_outlined));
    await tester.pump();
    expect(find.byType(ExpressionPanel), findsOneWidget);
    expect(find.byType(ChatMorePanel), findsNothing);

    await tester.tap(
      find.byKey(const ValueKey('chat_input_attachment_toggle')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(ExpressionPanel), findsNothing);
    expect(find.byType(ChatMorePanel), findsOneWidget);
  });

  testWidgets('code composer sends fenced code and ignores empty input', (
    tester,
  ) async {
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    Future<void> openCodeComposer() async {
      await openAttachmentPanel(tester);
      tester.widget<ChatMorePanel>(find.byType(ChatMorePanel)).onCodePressed!();
      await tester.pump();
      final fields = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextField),
      );
      expect(fields, findsNWidgets(2));
    }

    await openCodeComposer();
    await tester.tap(find.text('Send').last);
    await tester.pump();
    expect(sentEvents.whereType<SendCustomMessage>(), isEmpty);

    await openCodeComposer();
    final fields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextField),
    );
    await tester.enterText(fields.at(0), 'dart');
    await tester.enterText(fields.at(1), 'void main() {}');
    await tester.tap(find.text('Send').last);
    await tester.pump();

    final messages = sentEvents.whereType<SendCustomMessage>().toList();
    expect(messages, hasLength(1));
    expect(messages.single.content, '```dart\nvoid main() {}\n```');
    expect(messages.single.type, MessageType.codeBlock);
  });

  testWidgets('poll composer sends a trimmed poll to the chat bloc', (
    tester,
  ) async {
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await openAttachmentPanel(tester);
    tester.widget<ChatMorePanel>(find.byType(ChatMorePanel)).onPollPressed!();
    await tester.pumpAndSettle();

    final pollFields = find.descendant(
      of: find.byType(PollCreateSheet),
      matching: find.byType(TextField),
    );
    expect(pollFields, findsNWidgets(3));
    await tester.enterText(pollFields.at(0), '  Best color?  ');
    await tester.enterText(pollFields.at(1), '  Blue  ');
    await tester.enterText(pollFields.at(2), ' Green ');
    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    final polls = sentEvents.whereType<SendPollMessage>().toList();
    expect(polls, hasLength(1));
    expect(polls.single.question, 'Best color?');
    expect(polls.single.options, ['Blue', 'Green']);
    expect(polls.single.maxSelections, 1);
  });

  testWidgets('shop action lists commerce apps and assistant choices', (
    tester,
  ) async {
    await pumpChat(tester);
    await openAttachmentPanel(tester);

    tester.widget<ChatMorePanel>(find.byType(ChatMorePanel)).onShopPressed!();
    await tester.pumpAndSettle();

    expect(find.text('AI Assistant'), findsOneWidget);
    expect(find.text('Gift NFT'), findsOneWidget);
    expect(find.text('N42 Shop'), findsOneWidget);
    expect(find.text('Creator Pass'), findsOneWidget);
    expect(find.byIcon(Icons.storefront_outlined), findsOneWidget);
    expect(find.byIcon(Icons.workspace_premium_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('payment request missing identity shows unavailable feedback', (
    tester,
  ) async {
    await pumpChat(
      tester,
      canSendMessages: false,
      messages: [_paymentRequest(requestId: '')],
    );

    await tester.tap(find.byType(PaymentRequestMessageWidget));
    await tester.pumpAndSettle();

    expect(find.text('Payment request is unavailable'), findsOneWidget);
    expect(find.byType(TransferPage), findsNothing);
  });

  testWidgets('paid payment request reports that payment is already sent', (
    tester,
  ) async {
    await pumpChat(
      tester,
      canSendMessages: false,
      messages: [_paymentRequest(status: 'paid')],
    );

    await tester.tap(find.byType(PaymentRequestMessageWidget));
    await tester.pumpAndSettle();

    expect(find.text('Payment already sent'), findsOneWidget);
    expect(find.byType(TransferPage), findsNothing);
  });

  testWidgets('expired payment request reports expiry without navigation', (
    tester,
  ) async {
    await pumpChat(
      tester,
      canSendMessages: false,
      messages: [
        _paymentRequest(
          expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
        ),
      ],
    );

    await tester.tap(find.byType(PaymentRequestMessageWidget));
    await tester.pumpAndSettle();

    expect(find.text('Expired'), findsWidgets);
    expect(find.byType(TransferPage), findsNothing);
  });

  testWidgets('own payment request waits for the recipient', (tester) async {
    await pumpChat(
      tester,
      canSendMessages: false,
      messages: [_paymentRequest(isFromMe: true)],
    );

    await tester.tap(find.byType(PaymentRequestMessageWidget));
    await tester.pumpAndSettle();

    expect(find.text('Waiting to receive'), findsWidgets);
    expect(find.byType(TransferPage), findsNothing);
  });

  testWidgets(
    'first view starts self-destruct only for incoming pending text',
    (tester) async {
      final chat = await pumpChat(
        tester,
        canSendMessages: false,
        messages: [
          MessageEntity(
            id: 'incoming-pending',
            roomId: _roomId,
            senderId: '@friend:hs.test',
            senderName: 'Friend',
            content: 'Incoming pending',
            type: MessageType.text,
            timestamp: DateTime(2026, 1, 1),
            selfDestructAfter: 30,
          ),
          MessageEntity(
            id: 'outgoing-pending',
            roomId: _roomId,
            senderId: '@me:hs.test',
            senderName: 'Me',
            content: 'Outgoing pending',
            type: MessageType.text,
            timestamp: DateTime(2026, 1, 1),
            isFromMe: true,
            selfDestructAfter: 30,
          ),
          MessageEntity(
            id: 'incoming-started',
            roomId: _roomId,
            senderId: '@friend:hs.test',
            senderName: 'Friend',
            content: 'Incoming started',
            type: MessageType.text,
            timestamp: DateTime(2026, 1, 1),
            selfDestructAfter: 30,
            destroyedAt: DateTime.now().add(const Duration(seconds: 30)),
          ),
        ],
      );
      final events = <ChatEvent>[];
      when(() => chat.add(any())).thenAnswer((invocation) {
        events.add(invocation.positionalArguments.single as ChatEvent);
      });

      await tester.tap(find.text('Incoming pending'));
      await tester.pump();
      await tester.tap(find.text('Outgoing pending'));
      await tester.pump();
      await tester.tap(find.text('Incoming started'));
      await tester.pump();

      expect(
        events.whereType<StartMessageDestruction>().map((e) => e.messageId),
        ['incoming-pending'],
      );
    },
  );

  testWidgets('double tapping an incoming avatar sends a poke to its owner', (
    tester,
  ) async {
    final chat = await pumpChat(
      tester,
      canSendMessages: false,
      messages: [
        MessageEntity(
          id: 'poke-target',
          roomId: _roomId,
          senderId: '@friend:hs.test',
          senderName: 'Friend',
          content: 'Hello',
          type: MessageType.text,
          timestamp: DateTime(2026, 1, 1),
        ),
      ],
    );
    final events = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as ChatEvent);
    });

    final avatar = find.byWidgetPredicate(
      (widget) => widget is GestureDetector && widget.onDoubleTap != null,
    );
    expect(avatar, findsOneWidget);
    await tester.tap(avatar);
    await tester.pump(const Duration(milliseconds: 80));
    await tester.tap(avatar);
    await tester.pump();

    final pokes = events.whereType<SendPokeMessage>().toList();
    expect(pokes, hasLength(1));
    expect(pokes.single.pokerName, 'Me');
    expect(pokes.single.targetUserId, '@friend:hs.test');
    expect(pokes.single.targetName, 'Friend');
    expect(pokes.single.pokerPokeText, isNull);
    expect(find.byType(SnackBar), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('poke uses current profile name and configured suffix', (
    tester,
  ) async {
    final chat = await pumpChat(
      tester,
      canSendMessages: false,
      messages: [
        MessageEntity(
          id: 'poke-target-profile',
          roomId: _roomId,
          senderId: '@friend:hs.test',
          senderName: 'Friend',
          content: 'Hello',
          type: MessageType.text,
          timestamp: DateTime(2026, 1, 1),
        ),
      ],
      configureAuth: (auth) {
        when(() => auth.currentUser).thenReturn(
          const UserEntity(userId: '@me:hs.test', displayName: 'Alice'),
        );
        when(
          () => auth.getUserProfileData(),
        ).thenAnswer((_) async => {'pokeText': '的头'});
      },
    );
    final events = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as ChatEvent);
    });

    final avatar = find.byWidgetPredicate(
      (widget) => widget is GestureDetector && widget.onDoubleTap != null,
    );
    await tester.tap(avatar);
    await tester.pump(const Duration(milliseconds: 80));
    await tester.tap(avatar);
    await tester.pump();

    final poke = events.whereType<SendPokeMessage>().single;
    expect(poke.pokerName, 'Alice');
    expect(poke.targetUserId, '@friend:hs.test');
    expect(poke.pokerPokeText, '的头');
    expect(find.textContaining('Friend'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('red packet states route to open dialog or claimed details', (
    tester,
  ) async {
    MessageEntity packet(String id, String status, String greeting) =>
        MessageEntity(
          id: id,
          roomId: _roomId,
          senderId: '@friend:hs.test',
          senderName: 'Friend',
          content: greeting,
          type: MessageType.redPacket,
          timestamp: DateTime(2026, 1, 1),
          metadata: MessageMetadata(
            amount: '2.50',
            token: 'CNY',
            transferStatus: status,
          ),
        );

    await pumpChat(
      tester,
      canSendMessages: false,
      messages: [
        packet('packet-pending', 'pending', 'Pending greeting'),
        packet('packet-empty', 'empty', 'Empty greeting'),
        packet('packet-expired', 'expired', 'Expired greeting'),
        packet('packet-opened', 'opened', 'Claimed greeting'),
      ],
    );

    Future<void> openStatusDialog(
      String greeting,
      String expectedStatus,
    ) async {
      await tester.ensureVisible(find.text(greeting).first);
      await tester.tap(find.text(greeting).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.byType(OpenRedPacketDialog), findsOneWidget);
      expect(find.text(expectedStatus), findsOneWidget);
      expect(find.text(greeting), findsWidgets);
      await tester.tap(find.byIcon(Icons.close).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
    }

    await openStatusDialog('Pending greeting', 'Open');
    await openStatusDialog('Empty greeting', 'All claimed');
    await openStatusDialog('Expired greeting', 'Expired');

    await tester.ensureVisible(find.text('Claimed greeting').first);
    await tester.tap(find.text('Claimed greeting').first);
    await tester.pumpAndSettle();
    expect(find.byType(RedPacketDetailPage), findsOneWidget);
    expect(find.text('Friend sent a red packet'), findsOneWidget);
    expect(find.text('Claimed greeting'), findsOneWidget);
  });

  testWidgets('claiming a pending red packet opens the claim details', (
    tester,
  ) async {
    final chat = await pumpChat(
      tester,
      canSendMessages: false,
      messages: [
        MessageEntity(
          id: 'claimable-packet',
          roomId: _roomId,
          senderId: '@friend:hs.test',
          senderName: 'Friend',
          content: 'Good luck',
          type: MessageType.redPacket,
          timestamp: DateTime(2026, 1, 1),
          metadata: MessageMetadata(
            redPacketId: 'red-packet-id',
            amount: '5.00',
            token: 'CNY',
            transferStatus: 'pending',
          ),
        ),
      ],
    );
    final messages = _Messages();
    when(
      () => messages.getCurrentUserId(),
    ).thenAnswer((_) async => '@me:hs.test');
    final redPackets = _RedPackets();
    when(
      () => redPackets.claimRedPacket(
        redPacketId: any(named: 'redPacketId'),
        userId: any(named: 'userId'),
        userName: any(named: 'userName'),
        avatarUrl: any(named: 'avatarUrl'),
      ),
    ).thenAnswer(
      (_) async => RedPacketClaim(
        userId: '@me:hs.test',
        userName: 'Media',
        amount: 2.5,
        claimedAt: DateTime(2026, 1, 2),
      ),
    );
    getIt.registerSingleton<IMessageRepository>(messages);
    getIt.registerSingleton<IRedPacketService>(redPackets);
    when(() => chat.add(any())).thenReturn(null);

    await tester.tap(find.text('Good luck'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.byType(GestureDetector).last);
    await tester.pump();
    await tester.pumpAndSettle();

    verify(
      () => redPackets.claimRedPacket(
        redPacketId: 'red-packet-id',
        userId: '@me:hs.test',
        userName: 'Media',
        avatarUrl: null,
      ),
    ).called(1);
    expect(find.byType(OpenRedPacketDialog), findsNothing);
    expect(find.byType(RedPacketDetailPage), findsOneWidget);
    final detail = tester.widget<RedPacketDetailPage>(
      find.byType(RedPacketDetailPage),
    );
    expect(detail.isClaimed, isTrue);
    expect(detail.claimedAmount, '2.50');
    expect(detail.token, 'CNY');
  });

  testWidgets('sending a demo red packet creates and posts the packet', (
    tester,
  ) async {
    final chat = await pumpChat(tester);
    final events = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      events.add(invocation.positionalArguments.single as ChatEvent);
    });
    final messages = _Messages();
    when(
      () => messages.getCurrentUserId(),
    ).thenAnswer((_) async => '@me:hs.test');
    final redPackets = _RedPackets();
    when(() => redPackets.isDemo).thenReturn(true);
    when(
      () => redPackets.createRedPacket(
        roomId: _roomId,
        totalAmount: 12.34,
        totalCount: 1,
        token: 'CNY',
        type: RedPacketType.normal,
        greeting: 'Good luck',
        senderId: '@me:hs.test',
        senderName: 'Media',
        senderAvatar: null,
      ),
    ).thenAnswer(
      (_) async => RedPacketEntity(
        id: 'new-packet',
        roomId: _roomId,
        senderId: '@me:hs.test',
        senderName: 'Media',
        greeting: 'Good luck',
        type: RedPacketType.normal,
        totalAmount: 12.34,
        totalCount: 1,
        token: 'CNY',
        claims: const [],
        createdAt: DateTime(2026, 1, 1),
        expiresAt: DateTime(2026, 1, 2),
      ),
    );
    getIt.registerSingleton<IMessageRepository>(messages);
    getIt.registerSingleton<IRedPacketService>(redPackets);
    getIt.registerSingleton<IWalletBridge>(_WalletBridge());

    await openAttachmentPanel(tester);
    tester
        .widget<ChatMorePanel>(find.byType(ChatMorePanel))
        .onRedPacketPressed!
        .call();
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '12.34');
    await tester.enterText(find.byType(TextField).at(1), 'Good luck');
    await tester.pump();
    tester
        .widget<ElevatedButton>(find.byType(ElevatedButton))
        .onPressed!
        .call();
    await tester.pumpAndSettle();

    final sent = events.whereType<SendCustomMessage>().single;
    expect(sent.type, MessageType.redPacket);
    expect(sent.content, 'Good luck');
    expect(sent.metadata?.redPacketId, 'new-packet');
    verify(
      () => redPackets.createRedPacket(
        roomId: _roomId,
        totalAmount: 12.34,
        totalCount: 1,
        token: 'CNY',
        type: RedPacketType.normal,
        greeting: 'Good luck',
        senderId: '@me:hs.test',
        senderName: 'Media',
        senderAvatar: null,
      ),
    ).called(1);
    expect(find.byType(SendRedPacketPage), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cancelling the poll composer sends no poll event', (
    tester,
  ) async {
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await openAttachmentPanel(tester);
    tester.widget<ChatMorePanel>(find.byType(ChatMorePanel)).onPollPressed!();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(sentEvents.whereType<SendPollMessage>(), isEmpty);
    expect(find.byType(PollCreateSheet), findsNothing);
  });

  testWidgets('cancelling contact-card selection sends no event', (
    tester,
  ) async {
    final chat = await pumpChat(tester);
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await openAttachmentPanel(tester);
    tester
        .widget<ChatMorePanel>(find.byType(ChatMorePanel))
        .onContactCardPressed!();
    await tester.pumpAndSettle();
    expect(find.text('Select Contact'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close).last);
    await tester.pumpAndSettle();

    expect(sentEvents.whereType<SendContactCardMessage>(), isEmpty);
  });

  testWidgets('selecting a contact dispatches its contact card', (
    tester,
  ) async {
    final chat = await pumpChat(tester);
    when(() => contactRepository.getContacts()).thenAnswer(
      (_) async => const [
        ContactEntity(userId: '@friend:hs.test', displayName: 'Friend'),
      ],
    );
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await openAttachmentPanel(tester);
    tester
        .widget<ChatMorePanel>(find.byType(ChatMorePanel))
        .onContactCardPressed!();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Friend'));
    await tester.pumpAndSettle();

    final cards = sentEvents.whereType<SendContactCardMessage>().toList();
    expect(cards, hasLength(1));
    expect(cards.single.userId, '@friend:hs.test');
    expect(cards.single.displayName, 'Friend');
    expect(cards.single.avatarUrl, isNull);
  });

  testWidgets(
    'single-choice vote replaces the previous answer and locks duplicates',
    (tester) async {
      final chat = await pumpChat(
        tester,
        messages: [
          _pollMessage(currentVotes: const ['red']),
        ],
      );
      final sentEvents = <ChatEvent>[];
      when(() => chat.add(any())).thenAnswer((invocation) {
        sentEvents.add(invocation.positionalArguments.single as ChatEvent);
      });

      await tester.tap(find.text('Blue'));
      await tester.pump();
      await tester.tap(find.text('Red'));
      await tester.pump();

      var votes = sentEvents.whereType<VoteOnPoll>().toList();
      expect(votes, hasLength(1));
      expect(votes.single.pollEventId, _pollEventId);
      expect(votes.single.selectedOptionIds, ['blue']);

      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.text('Red'));
      await tester.pump();
      votes = sentEvents.whereType<VoteOnPoll>().toList();
      expect(votes, hasLength(2));
      expect(votes.last.selectedOptionIds, isEmpty);
      await tester.pump(const Duration(seconds: 2));
    },
  );

  testWidgets('multiple-choice voting adds and removes selected answers', (
    tester,
  ) async {
    final chat = await pumpChat(
      tester,
      messages: [
        _pollMessage(currentVotes: const ['red'], maxSelections: 2),
      ],
    );
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await tester.tap(find.text('Blue'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text('Red'));
    await tester.pump();

    final votes = sentEvents.whereType<VoteOnPoll>().toList();
    expect(votes, hasLength(2));
    expect(votes.first.selectedOptionIds, ['red', 'blue']);
    expect(votes.last.selectedOptionIds, isEmpty);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('ending a poll can be cancelled without dispatching', (
    tester,
  ) async {
    final chat = await pumpChat(
      tester,
      messages: [_pollMessage(isFromMe: true)],
    );
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await tester.ensureVisible(find.text('End Poll'));
    await tester.tap(find.text('End Poll'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        S.of(tester.element(find.byType(ChatPage)))!.chatEndPollConfirmMessage,
      ),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(sentEvents.whereType<EndPoll>(), isEmpty);
  });

  testWidgets('confirming poll end dispatches the poll event ID', (
    tester,
  ) async {
    final chat = await pumpChat(
      tester,
      messages: [_pollMessage(isFromMe: true)],
    );
    final sentEvents = <ChatEvent>[];
    when(() => chat.add(any())).thenAnswer((invocation) {
      sentEvents.add(invocation.positionalArguments.single as ChatEvent);
    });

    await tester.ensureVisible(find.text('End Poll'));
    await tester.tap(find.text('End Poll'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Confirm'));
    await tester.pumpAndSettle();

    final endedPolls = sentEvents.whereType<EndPoll>().toList();
    expect(endedPolls, hasLength(1));
    expect(endedPolls.single.pollEventId, _pollEventId);
    expect(find.text('Poll ended'), findsOneWidget);
  });
}
