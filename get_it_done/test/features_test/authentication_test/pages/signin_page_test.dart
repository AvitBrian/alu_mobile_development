import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

class AuthStateProviderMock extends AuthStateProvider {
}

void main() {
  group('SignInForm methods', () {
    testWidgets('handleGoogleSignIn - Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => AuthStateProviderMock(),
          child: MaterialApp(home: SignInForm()),
        ),
      );

      // Trigger the handleGoogleSignIn
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the handleGoogleSignIn button was tapped
      expect(find.text('Google Sign In'), findsOneWidget);
    });

    testWidgets('handleEmailAndPasswordSignIn - Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => AuthStateProviderMock(),
          child: MaterialApp(home: SignInForm()),
        ),
      );

      // Trigger the handleEmailAndPasswordSignIn
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Verify that the handleEmailAndPasswordSignIn button was tapped
      expect(find.text('Email Sign In'), findsOneWidget);
    });
  });
}
