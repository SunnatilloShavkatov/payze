import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'payze_method_channel.dart';

abstract class PayzePlatform extends PlatformInterface {
  /// Constructs a PayzePlatform.
  PayzePlatform() : super(token: _token);

  static final Object _token = Object();

  static PayzePlatform _instance = MethodChannelPayze();

  /// The default instance of [PayzePlatform] to use.
  ///
  /// Defaults to [MethodChannelPayze].
  static PayzePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PayzePlatform] when
  /// they register themselves.
  static set instance(PayzePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
