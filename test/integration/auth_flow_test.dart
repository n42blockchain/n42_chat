import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';
import 'package:n42_chat/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:n42_chat/src/presentation/pages/auth/login_page.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    
    // 设置默认行为
    when(() => mockAuthRepository.loginStateStream)
        .thenAnswer((_) => const Stream.empty());
    when(() => mockAuthRepository.isLoggedIn).thenReturn(false);
    when(() => mockAuthRepository.currentUser).thenReturn(null);
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(authRepository: mockAuthRepository),
        child: child,
      ),
    );
  }

  group('Authentication Flow Integration Tests', () {
    testWidgets('should show login form fields', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LoginPage()));

      // 验证登录表单元素存在
      expect(find.byType(TextFormField), findsNWidgets(3)); // homeserver, username, password
      // 找到按钮类型的登录
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
