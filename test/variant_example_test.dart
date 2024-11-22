import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_tester/variant_example.dart';

void main() {
  final valueVariant = ValueVariant({1, 2, 3, 4});

  testWidgets(
    'Variant test',
    (tester) async {
      final currentValue = valueVariant.currentValue!;
      await tester.pumpWidget(MaterialApp(home: IsEven(currentValue)));

      if (currentValue % 2 == 0) {
        expect(find.text('Even'), findsOneWidget);
        expect(find.text('Odd'), findsNothing);
      } else {
        expect(find.text('Even'), findsNothing);
        expect(find.text('Odd'), findsOneWidget);
      }
    },
    variant: valueVariant,
  );
}
