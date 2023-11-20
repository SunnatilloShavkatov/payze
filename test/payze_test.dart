import 'package:flutter_test/flutter_test.dart';
import 'package:payze/payze.dart';
import 'package:payze/payze_platform_interface.dart';
import 'package:payze/payze_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPayzePlatform
    with MockPlatformInterfaceMixin
    implements PayzePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PayzePlatform initialPlatform = PayzePlatform.instance;

  test('$MethodChannelPayze is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPayze>());
  });

  test('getPlatformVersion', () async {
    Payze payzePlugin = Payze();
    MockPayzePlatform fakePlatform = MockPayzePlatform();
    PayzePlatform.instance = fakePlatform;

    expect(await payzePlugin.getPlatformVersion(), '42');
  });
}
