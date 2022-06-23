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
  bool isConnectedPeripheral();
  @async
  void queryEnableConfig();
  @async
  bool getFreeVendingEnable();
  @async
  bool getConfigServerEnable();
  @async
  void enableConfig(String enableConfigBinaryStr);
  @async
  bool isEnableSuccess();
  @async
  void scanQRCode();
  @async
  void queryDeviceSystemInfo();
  @async
  List<String?> getSystemInfoList();
  @async
  void queryNetworkState();
  @async
  void queryDeviceConfigType();
  @async
  void queryOCPPConfigParams();
  @async
  String getNetworkingStateData();
  @async
  String getDeviceConfigData();
  @async
  String getDomain();
  @async
  String getDomainSuffix();
}

// 原生调用 Flutter 方法1
@FlutterApi()
abstract class MyApi {
  @async
  void sessionInValid();
}
