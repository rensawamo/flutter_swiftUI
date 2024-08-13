import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nativesample_method_channel.dart';

abstract class NativesamplePlatform extends PlatformInterface {
  /// Constructs a NativesamplePlatform.
  NativesamplePlatform() : super(token: _token);

  static final Object _token = Object();

  static NativesamplePlatform _instance = MethodChannelNativesample();

  /// The default instance of [NativesamplePlatform] to use.
  ///
  /// Defaults to [MethodChannelNativesample].
  static NativesamplePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativesamplePlatform] when
  /// they register themselves.
  static set instance(NativesamplePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
