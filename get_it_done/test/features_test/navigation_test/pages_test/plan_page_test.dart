import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/plan/plan.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Plan - Displays tasks correctly', (WidgetTester tester) async {
    final authStateProvider = AuthStateProviderMock();
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => authStateProvider,
        child: MaterialApp(
          home: Scaffold(
            body: Plan(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Task Name 1'), findsOneWidget);
    expect(find.text('Task Name 2'), findsOneWidget);
  });

  testWidgets('Plan - Edit Task', (WidgetTester tester) async {
    final authStateProvider = AuthStateProviderMock();
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => authStateProvider,
        child: MaterialApp(
          home: Scaffold(
            body: Plan(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit).first);
    await tester.pumpAndSettle();
    expect(find.text('Edit Task'), findsOneWidget);
  });

  testWidgets('Plan - Delete Task', (WidgetTester tester) async {
    final authStateProvider = AuthStateProviderMock();
    await tester.pumpWidget(
      Provider<AuthStateProvider>(
        create: (_) => authStateProvider,
        child: MaterialApp(
          home: Scaffold(
            body: Plan(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete_forever).first);
    await tester.pumpAndSettle();
    expect(authStateProvider.deleteTaskCalled, true);
  });
}

class AuthStateProviderMock extends AuthStateProvider {
  bool deleteTaskCalled = false;
  
  @override
  Future<void> deleteTask(String taskId) async {
    deleteTaskCalled = true;
  }
}
