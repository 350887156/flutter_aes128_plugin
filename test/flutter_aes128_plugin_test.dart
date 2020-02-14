import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aes128_plugin/flutter_aes128_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_aes128_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('encrypt', () async {
    expect(await FlutterAes128Plugin.encrypt('我是123', '1234567890123456'), '42');
  });
}
