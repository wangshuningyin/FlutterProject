import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';

class DeviceModePage extends StatefulWidget {
  const DeviceModePage({Key? key}) : super(key: key);
  @override
  State<DeviceModePage> createState() => _DeviceModePageState();
}

class _DeviceModePageState extends State<DeviceModePage> {
  bool isSelected = true;
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";
  final callBluetoothSDK = CallBluetoothSDK();
  String imageName = switchOff;
  String enableStr = "";
  bool isHide = false;

  Future<void> queryEnableConfig() async {
    callBluetoothSDK.queryEnableConfig();
    delayedGetEnable();
    print('Flutter------free vending使能查询成功');
  }

  Future<void> enableConfig(String enableConfigBinaryStr) async {
    callBluetoothSDK.enableConfig(enableConfigBinaryStr);
    delayedGetIsEnableSuccess();
    print('Flutter------free vending使能查询成功');
  }

  void delayedGetIsEnableSuccess() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      getIsEnableSuccess();
      return Future.value("延时4秒执行");
    });
  }

  void delayedGetEnable() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      getEnable();
      return Future.value("延时4秒执行");
    });
  }

  Future<void> getIsEnableSuccess() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.isEnableSuccess().then((value) {
      setState(() {
        if (value) {
          if (isSelected) {
            imageName = switchOn;
            LoadingUtils.dismiss();
          } else {
            imageName = switchOff;
            LoadingUtils.dismiss();
          }
          isHide = isSelected;
        }
      });
    });
  }

  Future<void> getEnable() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.getEnable().then((value) {
      setState(() {
        isHide = value;
        if (value) {
          imageName = switchOn;
        } else {
          imageName = switchOff;
        }
      });
      print('Flutter------$value');
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      queryEnableConfig();
    }
  }

  _clickAction() {
    setState(() {
      isSelected = !isSelected;
      enableStr = isSelected ? "1" : "0";
      LoadingUtils.show(showMsg: "Loading...");
      enableConfig(enableStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Device Mode',
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
            child: Row(
              children: [
                const Text(
                  "Free Vending",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                SizedBox(
                  width: 40,
                  height: 25,
                  // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: InkWell(
                    onTap: () {
                      _clickAction();
                    },
                    child: Image(
                      image: AssetImage(imageName),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !isHide,
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
              height: 30,
              width: 500,
              child: const Text(
                "Enable without authentication.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            height: 1,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: Border.all(
                width: 2,
                color: const Color(0xFFEEEEEE),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
