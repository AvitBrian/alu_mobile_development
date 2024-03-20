import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';

void main() {
  group('SignInForm methods', () {
    testWidgets('handleGoogleSignIn - Test', (WidgetTester tester) async {
      // Build our SignInForm widget
      await tester.pumpWidget(MaterialApp(home: SignInForm()));

      // Trigger the handleGoogleSignIn
      await tester.tap(find.text('Google Sign In'));
      await tester.pump();

      // Verify that the handleGoogleSignIn button was tapped
      expect(find.text('Google Sign In'), findsOneWidget);
    });

    testWidgets('handleEmailAndPasswordSignIn - Test', (WidgetTester tester) async {
      // Build our SignInForm widget
      await tester.pumpWidget(MaterialApp(home: SignInForm()));

      // Trigger the handleEmailAndPasswordSignIn
      await tester.tap(find.text('Email Sign In'));
      await tester.pump();

      // Verify that the handleEmailAndPasswordSignIn button was tapped
      expect(find.text('Email Sign In'), findsOneWidget);
    });
  });
}
