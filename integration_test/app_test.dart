import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recipes/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "First Page loads a list of recipes",
          (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());
        await tester.pumpAndSettle();
        expect(find.byKey(Key('recipe_0')), findsOneWidget);
        expect(find.text('Crock Pot Roast'), findsOneWidget);
      }
  );
}