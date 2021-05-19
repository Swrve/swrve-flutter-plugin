import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swrve_plugin/swrve_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('swrve_plugin');

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
    expect(await SwrvePlugin.platformVersion, '42');
  });
}
