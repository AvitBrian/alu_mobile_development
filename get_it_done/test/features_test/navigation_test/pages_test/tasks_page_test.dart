import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/tasks/tasks_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('TasksPage - Displays tasks correctly', (WidgetTester tester) async {
    final authStateProvider = AuthStateProviderMock();
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => authStateProvider,
        child: MaterialApp(
          home: Scaffold(
            body: TasksPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Task Name 1'), findsOneWidget);
    expect(find.text('Task Name 2'), findsOneWidget);
  });

  testWidgets('TasksPage - Complete Task', (WidgetTester tester) async {
    final authStateProvider = AuthStateProviderMock();
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => authStateProvider,
        child: MaterialApp(
          home: Scaffold(
            body: TasksPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.check).first);
    await tester.pumpAndSettle();
  });
}

class AuthStateProviderMock extends AuthStateProvider {}

