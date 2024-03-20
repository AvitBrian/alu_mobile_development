import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';

void main() {
  testWidgets('Sign in form UI test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SignInForm(),
    ));

    // expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });

}
