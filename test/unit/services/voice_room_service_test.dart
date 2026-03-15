import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/voice_room_entity.dart';
import 'package:n42_chat/src/domain/repositories/voice_room_repository.dart';
import 'package:n42_chat/src/services/voip/voice_room_service.dart';

class MockVoiceRoomRepository extends Mock implements IVoiceRoomRepository {}

void main() {
  late MockVoiceRoomRepository mockRepository;
  late VoiceRoomService service;

  setUp(() {
    mockRepository = MockVoiceRoomRepository();
    service = VoiceRoomService(
      repository: mockRepository,
      currentUserIdProvider: () => '@me:server',
    );
  });

  tearDown(() {
    service.dispose();
  });

  VoiceRoomEntity buildRoom({
    VoiceRoomRole myRole = VoiceRoomRole.listener,
    bool isMuted = true,
  }) {
    return VoiceRoomEntity(
      roomId: '!voice:server',
      name: 'Voice Room',
      creatorId: '@host:server',
      participants: [
        VoiceRoomParticipant(
          userId: '@me:server',
          displayName: 'Me',
          role: myRole,
          isMuted: isMuted,
        ),
      ],
    );
  }

  test('joinRoom syncs my role and mute state from repository room state', () async {
    when(() => mockRepository.joinVoiceRoom('!voice:server'))
        .thenAnswer((_) async => true);
    when(() => mockRepository.getVoiceRoom('!voice:server'))
        .thenAnswer((_) async => buildRoom(myRole: VoiceRoomRole.host, isMuted: false));

    final joined = await service.joinRoom('!voice:server');

    expect(joined, isTrue);
    expect(service.isConnected, isTrue);
    expect(service.myRole, VoiceRoomRole.host);
    expect(service.isMuted, isFalse);
  });

  test('syncFromRoom promotes creator to host when participant list is stale', () {
    const room = VoiceRoomEntity(
      roomId: '!voice:server',
      name: 'Voice Room',
      creatorId: '@me:server',
    );

    service.syncFromRoom(room);

    expect(service.myRole, VoiceRoomRole.host);
    expect(service.isMuted, isFalse);
  });

  test('toggleMute keeps previous state when repository rejects the change', () async {
    when(() => mockRepository.joinVoiceRoom('!voice:server'))
        .thenAnswer((_) async => true);
    when(() => mockRepository.getVoiceRoom('!voice:server'))
        .thenAnswer((_) async => buildRoom(myRole: VoiceRoomRole.speaker, isMuted: false));
    when(() => mockRepository.toggleMute('!voice:server', true))
        .thenAnswer((_) async => false);

    await service.joinRoom('!voice:server');

    await expectLater(service.toggleMute(), throwsStateError);
    expect(service.isMuted, isFalse);
  });
}
