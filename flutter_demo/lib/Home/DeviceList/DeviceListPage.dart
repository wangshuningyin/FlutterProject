import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({Key? key}) : super(key: key);
  // 必须重写 createState()，返回一个 State，它包含了视图和交互逻辑
  @override
  State<StatefulWidget> createState() => _DeviceListPage();
}

class _DeviceListPage extends State<DeviceListPage> {
  //定义一个变量，在页面销毁时需要用到，如果在定时器内部已经销毁了，可以不需要
  late Timer _timer;
  List<String?> deviceNameList = [];

  final callBluetoothSDK = CallBluetoothSDK();
  Future<List<String?>> callDeviceName() async {
    final deviceNames = await callBluetoothSDK.getDeviceNames();
    return deviceNames;
  }

  Future<void> getDeviceName(String item) async {
    callBluetoothSDK.getConnectDeviceName(item);
    Navigator.pop(context, item);
    print('Flutter1------连接的蓝牙设备名称$item');
  }

  myTimer() {
    // 定义一个函数，将定时器包裹起来
    _timer = Timer.periodic(const Duration(milliseconds: 800), (t) {
      callBluetoothSDK.scanForPeripherals();
      callDeviceName().then((value) => setState(() {
            deviceNameList = value;
          }));
    });
  }

  @override
  void initState() {
    deviceNameList.clear();
    super.initState();
    if (Platform.isIOS) {
      myTimer();
    }
  }

  // 在页面销毁时，需要销毁定时器
  // void dispose()，此方法造成返回home页崩溃（仅在安卓手机上存在）
  // 返回home也此页面销毁导致崩溃，需要解决
  @override
  void dispose() {
    if (_timer.isActive) {
      // 判断定时器是否是激活状态
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Device List',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //修改颜色
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // color: Colors.white,
      body: ListView.builder(
        itemCount: deviceNameList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = deviceNameList[index];
          return ListTile(
            title: Text(
              '$item',
            ),
            onTap: () {
              if (Platform.isIOS) {
                getDeviceName(item!);
              }
            },
          );
        },
      ),
    );
  }
}
