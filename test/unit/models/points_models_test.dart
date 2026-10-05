import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/models/points/points_balance_model.dart';
import 'package:n42_chat/src/data/models/points/points_transaction_model.dart';
import 'package:n42_chat/src/domain/entities/points/points_transaction.dart';

void main() {
  group('PointsBalanceModel', () {
    test('reads API values, serializes them, and converts the active date', () {
      final model = PointsBalanceModel.fromJson({
        'userId': 'user-1',
        'roomId': '!room:example.org',
        'totalPoints': 240,
        'availablePoints': 180,
        'redeemedPoints': 60,
        'rank': 4,
        'streakDays': 8,
        'lastActiveDate': '2026-10-04T12:30:00.000Z',
      });

      expect(model.toJson(), {
        'userId': 'user-1',
        'roomId': '!room:example.org',
        'totalPoints': 240,
        'availablePoints': 180,
        'redeemedPoints': 60,
        'rank': 4,
        'streakDays': 8,
        'lastActiveDate': '2026-10-04T12:30:00.000Z',
      });
      final entity = model.toEntity();
      expect(entity.userId, 'user-1');
      expect(entity.roomId, '!room:example.org');
      expect(entity.totalPoints, 240);
      expect(entity.availablePoints, 180);
      expect(entity.redeemedPoints, 60);
      expect(entity.rank, 4);
      expect(entity.streakDays, 8);
      expect(entity.lastActiveDate, DateTime.utc(2026, 10, 4, 12, 30));
    });

    test('uses defaults for missing API fields and ignores invalid dates', () {
      final model = PointsBalanceModel.fromJson({
        'lastActiveDate': 'not-a-date',
      });

      expect(model.userId, isEmpty);
      expect(model.roomId, isEmpty);
      expect(model.totalPoints, 0);
      expect(model.availablePoints, 0);
      expect(model.redeemedPoints, 0);
      expect(model.rank, 0);
      expect(model.streakDays, 0);
      expect(model.toEntity().lastActiveDate, isNull);
    });
  });

  group('PointsTransactionModel', () {
    test('serializes a transaction and maps every API transaction type', () {
      const types = {
        'earned': PointsTransactionType.earned,
        'redeemed': PointsTransactionType.redeemed,
        'received': PointsTransactionType.received,
        'sent': PointsTransactionType.sent,
        'adjustment': PointsTransactionType.adjustment,
        'unknown': PointsTransactionType.earned,
      };

      for (final entry in types.entries) {
        final model = PointsTransactionModel.fromJson({
          'id': 'tx-${entry.key}',
          'userId': 'user-1',
          'roomId': '!room:example.org',
          'type': entry.key,
          'amount': 12,
          'description': 'Activity reward',
          'actionType': 'daily_check_in',
          'createdAt': '2026-10-04T12:30:00.000Z',
        });

        expect(model.toJson(), {
          'id': 'tx-${entry.key}',
          'userId': 'user-1',
          'roomId': '!room:example.org',
          'type': entry.key,
          'amount': 12,
          'description': 'Activity reward',
          'actionType': 'daily_check_in',
          'createdAt': '2026-10-04T12:30:00.000Z',
        });
        final entity = model.toEntity();
        expect(entity.type, entry.value);
        expect(entity.amount, 12);
        expect(entity.createdAt, DateTime.utc(2026, 10, 4, 12, 30));
      }
    });

    test('uses safe defaults and current time for malformed API values', () {
      final before = DateTime.now();
      final entity = PointsTransactionModel.fromJson({
        'type': 'unsupported',
        'createdAt': 'not-a-date',
      }).toEntity();

      expect(entity.id, isEmpty);
      expect(entity.userId, isEmpty);
      expect(entity.roomId, isEmpty);
      expect(entity.type, PointsTransactionType.earned);
      expect(entity.amount, 0);
      expect(entity.description, isEmpty);
      expect(entity.actionType, isNull);
      expect(entity.createdAt.isBefore(before), isFalse);
    });
  });
}
