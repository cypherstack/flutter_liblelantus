import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_liblelantus_platform_interface.dart';

/// An implementation of [FlutterLiblelantusPlatform] that uses method channels.
class MethodChannelFlutterLiblelantus extends FlutterLiblelantusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_liblelantus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
