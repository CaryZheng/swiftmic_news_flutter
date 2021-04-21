import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_hello/my_hello.dart';

void main() {
  const MethodChannel channel = MethodChannel('my_hello');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MyHello.platformVersion, '42');
  });
}
