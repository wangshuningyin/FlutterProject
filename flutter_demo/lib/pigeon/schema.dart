import 'package:pigeon/pigeon.dart';

// Flutter 调用原生方法
@HostApi()
abstract class Api {
  @async
  String getPlatformVersion();
}

@HostApi()
abstract class CallBluetoothSDK {
  @async
  List<String?> getDeviceNames();
  // @async
  // List<Map?> getCBPeripherals();

  @async
  void startBluetooth();
  @async
  void scanForPeripherals();
  @async
  void startConnectPeripheral();
  @async
  bool isConnectPeripheralSuccess();
  @async
  void getConnectDeviceName(String name);
  @async
  void stopConnectPeripheral();
  @async
  bool isDisConnectPeripheralSuccess();
  @async
  void queryEnableConfig();
  @async
  bool getEnable();
  @async
  void enableConfig();
  @async
  void scanQRCode();
}

// 原生调用 Flutter 方法1
@FlutterApi()
abstract class MyApi {
  @async
  void sessionInValid();
}
