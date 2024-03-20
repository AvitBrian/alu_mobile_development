import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it_done/main.dart';

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('MyApp builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MyApp), findsOneWidget);
  });
}
