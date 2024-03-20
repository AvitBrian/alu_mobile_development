
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'signin_page_test.mocks.dart';

@GenerateMocks([AuthStateProvider])
void main() {
  group('SignInForm Widget Tests', () {
    late MockAuthStateProvider mockAuthStateProvider;

    setUp(() {
      mockAuthStateProvider = MockAuthStateProvider();
    });

    testWidgets('Email and Password Fields are present', (WidgetTester tester) async {
      // Build the SignInForm widget with the mock AuthStateProvider
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => mockAuthStateProvider,
          child: const MaterialApp(home: SignInForm()),
        ),
      );

      final emailField = find.byKey(const Key('email_field'));
      final passwordField = find.byKey(const Key('password_field'));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
    });

    testWidgets('Sign in button is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => mockAuthStateProvider,
          child: const MaterialApp(home: SignInForm()),
        ),
      );

      final signInButton = find.byKey(const Key('sign_in_button'));

      expect(signInButton, findsOneWidget);
    });
  });
}
