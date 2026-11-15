import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/widgets/auth/social_sign_in_row.dart';

void main() {
  Widget page(double width, double scale) => MaterialApp(
    home: Scaffold(
      body: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(scale)),
        child: Center(
          child: SizedBox(
            width: width,
            child: SocialSignInRow(
              google: CompactSocialSignInButton(
                label: 'Google',
                icon: const Icon(Icons.login),
                onPressed: () {},
              ),
              facebook: CompactSocialSignInButton(
                label: 'Facebook',
                icon: const Icon(Icons.login),
                onPressed: () {},
              ),
              apple: const ColoredBox(key: Key('apple'), color: Colors.black),
            ),
          ),
        ),
      ),
    ),
  );

  testWidgets('reference width keeps compact providers beside wide Apple', (
    tester,
  ) async {
    await tester.pumpWidget(page(328, 1));
    expect(tester.takeException(), isNull);
    expect(
      tester.getTopLeft(find.byKey(const Key('apple'))).dx,
      greaterThan(tester.getTopLeft(find.text('Facebook')).dx),
    );
    expect(
      tester.getSize(find.byKey(const Key('apple'))).width,
      greaterThan(140),
    );
  });
  testWidgets('large text moves Apple below without overflow', (tester) async {
    await tester.pumpWidget(page(280, 2));
    expect(tester.takeException(), isNull);
    expect(
      tester.getTopLeft(find.byKey(const Key('apple'))).dy,
      greaterThan(tester.getBottomLeft(find.text('Facebook')).dy),
    );
  });
  testWidgets('busy provider prevents taps and retains label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CompactSocialSignInButton(
            label: 'Google',
            icon: Icon(Icons.login),
            onPressed: null,
            loading: true,
          ),
        ),
      ),
    );
    expect(
      tester.widget<TextButton>(find.byType(TextButton)).onPressed,
      isNull,
    );
    expect(find.text('Google'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
