import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_tester/method_channel_example.dart';

void main() {
  test('MethodChannel example', () async {
    // Note, you don't need to call ensureInitialized in a widget test,
    // since the testWidgets method does that for you
    TestWidgetsFlutterBinding.ensureInitialized();

    const methodChannel = MethodChannel('my_method_channel');

    var didCheckNative = false;

    handler(methodCall) {
      if (methodCall.method == 'checkNative') {
        didCheckNative = true;
      }
      return;
    }

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, handler);

    await MethodChannelExample().checkNative();

    expect(didCheckNative, true);
  });
}
