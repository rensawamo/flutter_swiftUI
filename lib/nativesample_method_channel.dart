import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nativesample_platform_interface.dart';

/// An implementation of [NativesamplePlatform] that uses method channels.
class MethodChannelNativesample extends NativesamplePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nativesample');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
