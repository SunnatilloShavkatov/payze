import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'payze_platform_interface.dart';

/// An implementation of [PayzePlatform] that uses method channels.
class MethodChannelPayze extends PayzePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('payze');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
