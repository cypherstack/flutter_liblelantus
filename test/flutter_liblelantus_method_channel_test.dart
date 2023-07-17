import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lelantus/flutter_liblelantus_method_channel.dart';

void main() {
  MethodChannelFlutterLiblelantus platform = MethodChannelFlutterLiblelantus();
  const MethodChannel channel = MethodChannel('flutter_liblelantus');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
