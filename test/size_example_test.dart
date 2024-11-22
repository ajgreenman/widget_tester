import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Size example', (tester) async {
    tester.view.physicalSize = const Size(600.0, 800.0);

    addTearDown(() {
      tester.view.resetPhysicalSize();
    });

    // rest of test
  });
}
