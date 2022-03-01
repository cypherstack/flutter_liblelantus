
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterLiblelantus {
  static const MethodChannel _channel = MethodChannel('flutter_liblelantus');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
