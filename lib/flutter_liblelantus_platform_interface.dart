import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_liblelantus_method_channel.dart';

abstract class FlutterLiblelantusPlatform extends PlatformInterface {
  /// Constructs a FlutterLiblelantusPlatform.
  FlutterLiblelantusPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLiblelantusPlatform _instance = MethodChannelFlutterLiblelantus();

  /// The default instance of [FlutterLiblelantusPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLiblelantus].
  static FlutterLiblelantusPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLiblelantusPlatform] when
  /// they register themselves.
  static set instance(FlutterLiblelantusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
