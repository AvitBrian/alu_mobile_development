import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockAuthStateProvider extends Mock implements AuthStateProvider {}

void main() {
  group('SignInForm', () {
    late MockAuthStateProvider mockAuthProvider;

    setUp(() {
      mockAuthProvider = MockAuthStateProvider();
    });

    testWidgets('Renders UI widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => mockAuthProvider,
          child: MaterialApp(home: SignInForm()),
        ),
      );

      expect(find.text('GET IT DONE!'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Email and Password are required', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => mockAuthProvider,
          child: MaterialApp(home: SignInForm()),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Email and Password Required!'), findsOneWidget);
    });

    testWidgets('Google sign in button works', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => mockAuthProvider,
          child: MaterialApp(home: SignInForm()),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockAuthProvider.setAuthState(any)).called(1);
    });

    testWidgets('Email and Password sign in button works', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<AuthStateProvider>(
          create: (_) => mockAuthProvider,
          child: MaterialApp(home: SignInForm()),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password123');

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      verify(mockAuthProvider.signInWithEmailAndPassword(any, any)).called(1);
    });
  });
}
