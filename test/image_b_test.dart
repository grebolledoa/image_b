import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_b/image_b.dart';

void main() {
  const MethodChannel channel = MethodChannel('image_b');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Image_b.platformVersion, '42');
  });
}
