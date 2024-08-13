
import 'nativesample_platform_interface.dart';

class Nativesample {
  Future<String?> getPlatformVersion() {
    return NativesamplePlatform.instance.getPlatformVersion();
  }
}
