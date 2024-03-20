import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signup_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('SignUpForm methods', () {
    testWidgets('checkUserExists - Test', (WidgetTester tester) async {
      final mockFirestore = MockFirestore();
      final authStateProvider = AuthStateProviderMock();
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => authStateProvider,
          child: MaterialApp(
            home: Scaffold(
              body: SignUpForm(),
            ),
          ),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Email');
      await tester.enterText(emailField, 'test@example.com');
      // Trigger the checkUserExists method
      await tester.runAsync(() async {
        final userExists = await authStateProvider.checkUserExists('test@example.com');
        // Verify that the checkUserExists method returns the correct result
        expect(userExists, false);
      });
    });

    testWidgets('handleSignUp - Test', (WidgetTester tester) async {
      final mockFirestore = MockFirestore();

      final authStateProvider = AuthStateProviderMock();
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => authStateProvider,
          child: MaterialApp(
            home: Scaffold(
              body: SignUpForm(),
            ),
          ),
        ),
      );

      final usernameField = find.widgetWithText(TextField, 'Username');
      final emailField = find.widgetWithText(TextField, 'Email');
      final passwordField = find.widgetWithText(TextField, 'Password');
      await tester.enterText(usernameField, 'testuser');
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password');

      // Trigger handleSignUp 
      await tester.tap(find.text('Sign Up'));
      await tester.pump();


      expect(authStateProvider.handleSignUpCalled, true);
    });
  });
}

class MockFirestore extends Mock implements FirebaseFirestore {}

class AuthStateProviderMock extends AuthStateProvider {
  bool handleSignUpCalled = false;

  @override
  Future<bool> checkUserExists(String email) async {
    return false;
  }

  @override
  Future<void> handleSignUp(String email, String password, String username) async {
    handleSignUpCalled = true;
  }
}
