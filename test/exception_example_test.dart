import 'package:flutter_test/flutter_test.dart';
import 'package:widget_tester/exception_example.dart';

void main() {
  test('verify assert throws when url is empty', () {
    expect(() => ExceptionExample(url: ''), throwsAssertionError);
  });
}
