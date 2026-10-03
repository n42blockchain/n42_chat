import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/scheduled_message_draft.dart';
import 'package:n42_chat/src/domain/entities/governance/vote_entity.dart';
import 'package:n42_chat/src/domain/protocols/protocol_event.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';

class _Value extends Equatable {
  final Object? value;

  const _Value(this.value);

  @override
  List<Object?> get props => [value];
}

class _OtherValue extends Equatable {
  final Object? value;

  const _OtherValue(this.value);

  @override
  List<Object?> get props => [value];
}

void main() {
  group('Equatable 3 semantics', () {
    test('keeps top-level runtime types distinct', () {
      expect(const _Value(1), isNot(const _OtherValue(1)));
    });

    test('compares nested numeric values in lists and maps consistently', () {
      const integerValue = _Value([
        1,
        {
          'nested': [2],
        },
      ]);
      const doubleValue = _Value([
        1.0,
        {
          'nested': [2.0],
        },
      ]);

      expect(integerValue, doubleValue);
      expect(integerValue.hashCode, doubleValue.hashCode);
    });

    test('applies nested numeric equality to weakly typed domain fields', () {
      final timestamp = DateTime.utc(2026, 1, 2);
      final intProtocolEvent = ProtocolEvent(
        type: ProtocolEventType.message,
        eventId: 'event-1',
        timestamp: timestamp,
        data: const {
          'sequence': 1,
          'values': [2],
        },
      );
      final doubleProtocolEvent = ProtocolEvent(
        type: ProtocolEventType.message,
        eventId: 'event-1',
        timestamp: timestamp,
        data: const {
          'sequence': 1.0,
          'values': [2.0],
        },
      );
      final intDraft = ScheduledMessageDraft(
        messageId: 'draft-1',
        text: 'scheduled',
        type: MessageType.text,
        scheduledAt: timestamp,
        createdAt: timestamp,
        payload: const {
          'metadata': {'value': 1},
        },
      );
      final doubleDraft = ScheduledMessageDraft(
        messageId: 'draft-1',
        text: 'scheduled',
        type: MessageType.text,
        scheduledAt: timestamp,
        createdAt: timestamp,
        payload: const {
          'metadata': {'value': 1.0},
        },
      );
      final intVote = VoteEntity(
        id: 'vote-1',
        voter: 'voter',
        proposalId: 'proposal-1',
        choice: 1,
        created: timestamp,
      );
      final doubleVote = VoteEntity(
        id: 'vote-1',
        voter: 'voter',
        proposalId: 'proposal-1',
        choice: 1.0,
        created: timestamp,
      );

      expect(intProtocolEvent, doubleProtocolEvent);
      expect(intProtocolEvent.hashCode, doubleProtocolEvent.hashCode);
      expect(intDraft, doubleDraft);
      expect(intDraft.hashCode, doubleDraft.hashCode);
      expect(intVote, doubleVote);
      expect(intVote.hashCode, doubleVote.hashCode);
    });

    test('preserves custom state diagnostic string output', () {
      expect(
        const AuthState.initial().toString(),
        'AuthState(status: AuthStatus.initial, user: null)',
      );
    });
  });
}
