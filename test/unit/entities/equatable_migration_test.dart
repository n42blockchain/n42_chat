import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_event.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_state.dart';

class _AlternateAuthState extends AuthState {
  const _AlternateAuthState() : super.initial();
}

class _AlternateUser extends UserEntity {
  const _AlternateUser() : super(userId: '@alice:hs', displayName: 'Alice');
}

void main() {
  test('entity subtypes remain distinct with matching values', () {
    const user = UserEntity(userId: '@alice:hs', displayName: 'Alice');
    expect(user.props, const _AlternateUser().props);
    expect(user, isNot(const _AlternateUser()));
    expect(user, const UserEntity(userId: '@alice:hs', displayName: 'Alice'));
  });
  test('empty auth event subtypes remain unequal', () {
    expect(const AuthCheckRequested(), isNot(const AuthLogoutRequested()));
    expect(const AuthCheckRequested(), const AuthCheckRequested());
    expect({
      const AuthCheckRequested(),
      const AuthLogoutRequested(),
    }, hasLength(2));
  });
  test('same subtype and values compare equal with matching hashes', () {
    final first = AuthLoginRequested(
      homeserver: 'hs',
      username: 'alice',
      password: 'secret',
    );
    final second = AuthLoginRequested(
      homeserver: 'hs',
      username: 'alice',
      password: 'secret',
    );
    expect(identical(first, second), isFalse);
    expect(first, second);
    expect(first.hashCode, second.hashCode);
    expect(
      first,
      isNot(
        const AuthLoginRequested(
          homeserver: 'hs',
          username: 'bob',
          password: 'secret',
        ),
      ),
    );
  });
  test('state subtype remains distinct even with identical props', () {
    expect(const AuthState.initial().props, const _AlternateAuthState().props);
    expect(const AuthState.initial(), isNot(const _AlternateAuthState()));
  });
}
