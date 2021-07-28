import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amap_flutter_navi/amap_flutter_navi.dart';

void main() {
  const MethodChannel channel = MethodChannel('amap_flutter_navi');

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
    expect(await AmapFlutterNavi.platformVersion, '42');
  });
}
