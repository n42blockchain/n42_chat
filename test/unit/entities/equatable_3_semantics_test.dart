import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
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

    test('preserves custom state diagnostic string output', () {
      expect(
        const AuthState.initial().toString(),
        'AuthState(status: AuthStatus.initial, user: null)',
      );
    });
  });
}
