import 'package:flutter/services.dart';

class MethodChannelExample {
  static const methodChannel = MethodChannel('my_method_channel');

  Future<void> checkNative() async {
    await methodChannel.invokeMethod('checkNative');
  }
}
