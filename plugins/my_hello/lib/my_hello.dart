import 'dart:async';

import 'package:flutter/services.dart';

class MyHello {
  static const MethodChannel _channel = const MethodChannel('my_hello');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
