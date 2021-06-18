import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('wallpaper_manager_flutter');

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
    expect(await WallpaperManagerFlutter.platformVersion, '42');
  });
}
