import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/main.dart';

void main() {
  testWidgets('MyApp builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MyApp), findsOneWidget);
  });
}
