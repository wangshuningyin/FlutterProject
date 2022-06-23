import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';

class ChargerLinkPage extends StatefulWidget {
  const ChargerLinkPage({Key? key}) : super(key: key);
  @override
  State<ChargerLinkPage> createState() => _ChargerLinkPageState();
}

class _ChargerLinkPageState extends State<ChargerLinkPage> {
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";

  static const String wifiStr = "Wi-Fi";
  static const String fourGIStr = "4G";
  static const String lanStr = "LAN";
  static const String offlineIStr = "Offline";

  bool isWifiSelected = true;
  bool isFourGSelected = true;
  bool isLanSelected = true;
  bool isOfflineSelected = true;

  String wifiImageName = switchOn;
  String fourGImageName = switchOff;
  String lanImageName = switchOff;
  String offlineImageName = switchOff;

  bool wifiOffstage = true;
  bool fourGOffstage = true;

  Future<void> queryEnableConfig() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.queryEnableConfig();
    getEnable();
    print('Flutter2------free vending使能查询成功');
  }

  Future<void> getEnable() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.getFreeVendingEnable().then((value) {
      isWifiSelected = value;
      setState(() {
        if (isWifiSelected) {
          wifiImageName = switchOn;
          wifiOffstage = false;
        } else {
          wifiImageName = switchOff;
          wifiOffstage = true;
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

  _wifiClickAction() {
    setState(() {
      isWifiSelected = !isWifiSelected;
      if (isWifiSelected) {
        wifiImageName = switchOn;
        wifiOffstage = false;
      } else {
        wifiImageName = switchOff;
        wifiOffstage = true;
      }
    });
  }

  _fourGClickAction() {
    setState(() {
      isFourGSelected = !isFourGSelected;
      if (!isFourGSelected) {
        fourGImageName = switchOn;
        fourGOffstage = false;
      } else {
        fourGImageName = switchOff;
        fourGOffstage = true;
      }
    });
  }

  _lanClickAction() {
    setState(() {
      isLanSelected = !isLanSelected;
      if (!isLanSelected) {
        lanImageName = switchOn;
      } else {
        lanImageName = switchOff;
      }
    });
  }

  _offlineClickAction() {
    setState(() {
      isOfflineSelected = !isOfflineSelected;
      if (!isOfflineSelected) {
        offlineImageName = switchOn;
      } else {
        offlineImageName = switchOff;
      }
    });
  }

  Widget networkStatebuild(String networkStateTxt, String networkContentTxt,
      bool offstage, BuildContext context, String imageName) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
          decoration: const BoxDecoration(
              // color: Colors.blue,
              ),
          child: Row(
            children: [
              Text(
                networkStateTxt,
                style: const TextStyle(
                    fontSize: 16,
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
                    if (networkStateTxt == wifiStr) {
                      _wifiClickAction();
                    } else if (networkStateTxt == fourGIStr) {
                      _fourGClickAction();
                    } else if (networkStateTxt == lanStr) {
                      _lanClickAction();
                    } else if (networkStateTxt == offlineIStr) {
                      _offlineClickAction();
                    }
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
          offstage: offstage,
          child: Container(
            decoration: const BoxDecoration(
                // color: Colors.blue,
                ),
            margin: const EdgeInsets.only(left: 20, top: 5, right: 20),
            child: Row(
              children: [
                Text(
                  networkContentTxt,
                  style: const TextStyle(fontSize: 15, color: Colors.grey
                      // fontWeight: Fon tWeight.bold
                      ),
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
                      _wifiClickAction();
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
              ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          ' Charger Link',
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
            margin: const EdgeInsets.only(left: 20, top: 18, right: 20),
            height: 30,
            width: 500,
            decoration: const BoxDecoration(
                // color: Colors.blue,
                ),
            child: const Text(
              "Activation of Network",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            width: 500,
            decoration: const BoxDecoration(
                // color: Colors.blue,
                ),
            child: const Text(
              "Select the type of network you want to connect your charger to.",
              style: TextStyle(
                fontSize: 14, color: Colors.grey,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 30),
            width: 500,
            decoration: const BoxDecoration(
                // color: Colors.blue,
                ),
            child: const Text(
              "Enable LAN or switch LAN to 4G or Wi-Fi will initiate the charger to restart.",
              style: TextStyle(
                fontSize: 14, color: Colors.grey,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          networkStatebuild(
              wifiStr, "CHARGDOT 2.4G", wifiOffstage, context, wifiImageName),
          networkStatebuild(fourGIStr, "APN Settings", fourGOffstage, context,
              fourGImageName),
          networkStatebuild(lanStr, "", true, context, lanImageName),
          networkStatebuild(offlineIStr, "", true, context, offlineImageName),
        ],
      ),
    );
  }
}
