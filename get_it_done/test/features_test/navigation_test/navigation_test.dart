import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/navigation/screens/home_screen.dart';
import 'package:get_it_done/features/navigation/widgets/navigation.dart';

void main() {
  testWidgets('Navigation Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Navigation()));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
