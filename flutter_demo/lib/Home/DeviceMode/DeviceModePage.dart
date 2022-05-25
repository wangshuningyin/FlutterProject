import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';

class DeviceModePage extends StatefulWidget {
  const DeviceModePage({Key? key}) : super(key: key);
  @override
  State<DeviceModePage> createState() => _DeviceModePageState();
}

class _DeviceModePageState extends State<DeviceModePage> {
  bool isSelected = true;
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";

  String imageName = switchOn;
  Future<void> queryEnableConfig() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.queryEnableConfig();
    getEnable();
    print('Flutter2------free vending使能查询成功');
  }

  Future<void> getEnable() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.getEnable().then((value) {
      isSelected = value;
      setState(() {
        if (isSelected) {
          imageName = switchOn;
        } else {
          imageName = switchOff;
        }
      });
      print('Flutter2------$value');
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
      if (isSelected) {
        imageName = switchOn;
      } else {
        imageName = switchOff;
      }
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
            offstage: !isSelected,
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
