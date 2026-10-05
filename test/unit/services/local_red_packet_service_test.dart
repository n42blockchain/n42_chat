import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/datasources/local/local_red_packet_service.dart';
import 'package:n42_chat/src/domain/entities/red_packet_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LargestRandom implements Random {
  @override
  bool nextBool() => true;

  @override
  double nextDouble() => 0.999;

  @override
  int nextInt(int max) => max - 1;
}

void main() {
  late LocalRedPacketService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    service = LocalRedPacketService();
  });

  test('normal packet claims distribute every cent of the total', () async {
    final packet = await service.createRedPacket(
      roomId: '!room:hs.test',
      totalAmount: 1,
      totalCount: 3,
      token: 'CNY',
      type: RedPacketType.normal,
      greeting: 'Good luck',
      senderId: '@sender:hs.test',
      senderName: 'Sender',
    );

    final claims = <RedPacketClaim>[];
    for (final (userId, userName) in [
      ('@one:hs.test', 'One'),
      ('@two:hs.test', 'Two'),
      ('@three:hs.test', 'Three'),
    ]) {
      final claim = await service.claimRedPacket(
        redPacketId: packet.id,
        userId: userId,
        userName: userName,
      );
      expect(claim, isNotNull);
      claims.add(claim!);
    }

    expect(claims.map((claim) => claim.amount), [0.33, 0.33, 0.34]);
    expect(claims.fold<double>(0, (total, claim) => total + claim.amount), 1.0);
    final completed = await service.getRedPacketStatus(packet.id);
    expect(completed?.remainingAmount, 0);
    expect(completed?.isCompleted, isTrue);
  });

  test('claims reject unknown packets and duplicate users', () async {
    expect(
      await service.claimRedPacket(
        redPacketId: 'missing',
        userId: '@one:hs.test',
        userName: 'One',
      ),
      isNull,
    );
    final packet = await service.createRedPacket(
      roomId: '!room:hs.test',
      totalAmount: 2,
      totalCount: 2,
      token: 'CNY',
      type: RedPacketType.normal,
      greeting: 'Good luck',
      senderId: '@sender:hs.test',
      senderName: 'Sender',
    );

    final firstClaim = await service.claimRedPacket(
      redPacketId: packet.id,
      userId: '@one:hs.test',
      userName: 'One',
    );
    final duplicateClaim = await service.claimRedPacket(
      redPacketId: packet.id,
      userId: '@one:hs.test',
      userName: 'One',
    );

    expect(firstClaim, isNotNull);
    expect(duplicateClaim, isNull);
    expect(
      (await service.getRedPacketHistory(
        roomId: '!room:hs.test',
        userId: '@one:hs.test',
      )).map((item) => item.id),
      [packet.id],
    );
    expect(
      await service.getRedPacketHistory(roomId: '!other:hs.test'),
      isEmpty,
    );
  });

  test('lucky claims reserve one cent for each remaining user', () async {
    service = LocalRedPacketService(random: _LargestRandom());
    final packet = await service.createRedPacket(
      roomId: '!room:hs.test',
      totalAmount: 1,
      totalCount: 3,
      token: 'CNY',
      type: RedPacketType.lucky,
      greeting: 'Good luck',
      senderId: '@sender:hs.test',
      senderName: 'Sender',
    );

    final claims = <RedPacketClaim>[];
    for (final userId in ['@one:hs.test', '@two:hs.test', '@three:hs.test']) {
      final claim = await service.claimRedPacket(
        redPacketId: packet.id,
        userId: userId,
        userName: userId,
      );
      expect(claim, isNotNull);
      claims.add(claim!);
    }

    expect(claims.map((claim) => claim.amount), [0.66, 0.33, 0.01]);
    expect(claims.fold<double>(0, (total, claim) => total + claim.amount), 1.0);
  });
}
