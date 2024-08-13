import 'package:flutter_test/flutter_test.dart';
import 'package:nativesample/nativesample.dart';
import 'package:nativesample/nativesample_platform_interface.dart';
import 'package:nativesample/nativesample_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativesamplePlatform
    with MockPlatformInterfaceMixin
    implements NativesamplePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativesamplePlatform initialPlatform = NativesamplePlatform.instance;

  test('$MethodChannelNativesample is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativesample>());
  });

  test('getPlatformVersion', () async {
    Nativesample nativesamplePlugin = Nativesample();
    MockNativesamplePlatform fakePlatform = MockNativesamplePlatform();
    NativesamplePlatform.instance = fakePlatform;

    expect(await nativesamplePlugin.getPlatformVersion(), '42');
  });
}
