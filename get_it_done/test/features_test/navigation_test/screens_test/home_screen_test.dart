import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/navigation/pages/home_screen.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('HomeScreen - Displays title correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => AuthStateProviderMock(),
        child: MaterialApp(
          home: HomeScreen(title: 'Test Title'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Test Title'), findsOneWidget);
  });

  testWidgets('HomeScreen - Navigate to Tasks Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => AuthStateProviderMock(),
        child: MaterialApp(
          home: HomeScreen(title: 'Test Title'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.check_circle_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(TasksPage), findsOneWidget);
  });

  testWidgets('HomeScreen - Navigate to Plan Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => AuthStateProviderMock(),
        child: MaterialApp(
          home: HomeScreen(title: 'Test Title'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.lightbulb_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(Plan), findsOneWidget);
  });

  testWidgets('HomeScreen - Add Task', (WidgetTester tester) async {
    final authStateProvider = AuthStateProviderMock();
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => authStateProvider,
        child: MaterialApp(
          home: HomeScreen(title: 'Test Title'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
  });
}

class AuthStateProviderMock extends AuthStateProvider {}
