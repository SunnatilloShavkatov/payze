
import 'payze_platform_interface.dart';

class Payze {
  Future<String?> getPlatformVersion() {
    return PayzePlatform.instance.getPlatformVersion();
  }
}
