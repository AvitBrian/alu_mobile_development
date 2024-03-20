import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('SignInForm methods', () {
    testWidgets('handleGoogleSignIn - Test', (WidgetTester tester) async {
      final authStateProvider = AuthStateProviderMock();
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => authStateProvider,
          child: MaterialApp(
            home: Scaffold(
              body: SignInForm(),
            ),
          ),
        ),
      );

      // Trigger the handleGoogleSignIn
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the handleGoogleSignIn method is called
      expect(authStateProvider.handleGoogleSignInCalled, true);
    });

    testWidgets('handleEmailAndPasswordSignIn - Test', (WidgetTester tester) async {
      final authStateProvider = AuthStateProviderMock();
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => authStateProvider,
          child: MaterialApp(
            home: Scaffold(
              body: SignInForm(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MaterialButton));
      await tester.pump();

      expect(authStateProvider.handleEmailAndPasswordSignInCalled, true);
    });
  });
}

class AuthStateProviderMock extends AuthStateProvider {
  bool handleGoogleSignInCalled = false;
  bool handleEmailAndPasswordSignInCalled = false;

  @override
  Future<void> handleGoogleSignIn() async {
    handleGoogleSignInCalled = true;
  }

  @override
  Future<void> handleEmailAndPasswordSignIn() async {
    handleEmailAndPasswordSignInCalled = true;
  }
}
