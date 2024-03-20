import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/authentication.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';
import 'package:get_it_done/features/authentication/pages/signup_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Authentication page - SignInForm shown by default',
      (WidgetTester tester) async {
    // Build Authentication widget and trigger all the frame rendering.
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => AuthStateProvider(),
        child: Authentication(),
      ),
    );

    expect(find.byType(SignInForm), findsOneWidget);
    expect(find.byType(SignUpForm), findsNothing);
  });

  testWidgets('Authentication page - SignUpForm shown when not signed in',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => AuthStateProvider(),
        child: Authentication(),
      ),
    );

    final authStateProvider =
        tester.state<AuthStateProvider>(find.byType(AuthStateProvider));
    authStateProvider.toggleSigned();

    // Verify that SignUpForm is shown when not signed in.
    expect(find.byType(SignUpForm), findsOneWidget);
    expect(find.byType(SignInForm), findsNothing);
  });

  testWidgets('Authentication page - Toggling between sign-in and sign-up',
      (WidgetTester tester) async {
    // Build Authentication widget and trigger all the frame rendering.
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => AuthStateProvider(),
        child: Authentication(),
      ),
    );

    // Initial state should show SignInForm.
    expect(find.byType(SignInForm), findsOneWidget);
    expect(find.byType(SignUpForm), findsNothing);

    // Toggling to sign-up mode.
    await tester.tap(find.text('Sign up'));
    await tester.pump();

    // Now SignUpForm should be shown.
    expect(find.byType(SignUpForm), findsOneWidget);
    expect(find.byType(SignInForm), findsNothing);

    await tester.tap(find.text('Log in!'));
    await tester.pump();

    expect(find.byType(SignInForm), findsOneWidget);
    expect(find.byType(SignUpForm), findsNothing);
  });
}
