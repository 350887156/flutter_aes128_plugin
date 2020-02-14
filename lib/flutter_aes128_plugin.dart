import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAes128Plugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_aes128_plugin');

  static Future<String> encrypt(String target,String key) async {
    final String result = await _channel.invokeMethod('encrypt',
        {
          'target':target,
          'key':key
        });
    return result;
  }
  static Future<String> decrypt(String target,String key) async {
    final String result = await _channel.invokeMethod('decrypt',
        {
          'target':target,
          'key':key
        });
    return result;
  }
}
