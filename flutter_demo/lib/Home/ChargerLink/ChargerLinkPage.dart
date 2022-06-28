import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Home/DeviceInfo/DeviceInfoModel.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChargerLinkPage extends StatefulWidget {
  final Map arguments;
  const ChargerLinkPage({Key? key, required this.arguments}) : super(key: key);
  @override
  State<ChargerLinkPage> createState() => _ChargerLinkPageState();
}

class _ChargerLinkPageState extends State<ChargerLinkPage> {
  final callBluetoothSDK = CallBluetoothSDK();

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
  bool wifiState = false;
  bool fourGOffstage = true;
  bool lanOffstage = true;
  bool offlineOffstage = true;

  String networkingStateResultType = "";
  String networkModelCode = "";

  String sessionId = '';
  String apnParamsData = '';
  String ssid = '';
  Future<void> queryConfigSSIDParams() async {
    callBluetoothSDK.queryConfigSSIDParams();
    delayedGetSSIDParamsData();
    print('Flutter查询成功ConfigSSIDParams功能');
  }

  void delayedGetSSIDParamsData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getSSIDParamsData();
      return Future.value("延时4秒执行");
    });
  }

  Future<void> getSSIDParamsData() async {
    callBluetoothSDK.getSSIDParamsData().then((value) => {
          setState(() {
            ssid = value;
          }),
          print('Flutter数据SSIDParamsData =$value 功能')
        });
  }

  Future<void> queryConfigAPNParams() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.queryConfigAPNParams();
    delayedGetAPNParamsData();
    print('Flutter--查询成功ConfigAPNParams功能');
  }

  void delayedGetAPNParamsData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getAPNParamsData();
      return Future.value("延时4秒执行");
    });
  }

  Future<void> getAPNParamsData() async {
    callBluetoothSDK.getAPNParamsData().then((value) => {
          setState(() {
            apnParamsData = value;
          }),
          print('Flutter数据APNParamsData =$value 功能')
        });
  }

  Future<void> ceAuthenticationWithParams(String authenticationParams) async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.ceAuthenticationWithParams(authenticationParams);
    delayedGetCEAuthenticationWithParamsSuccess(authenticationParams);
    print('Flutter--ceAuthenticationWithParams功能配置');
  }

  void delayedGetCEAuthenticationWithParamsSuccess(
      String authenticationParams) {
    Future.delayed(const Duration(milliseconds: 800), () {
      getCEAuthenticationWithParamsSuccess(authenticationParams);
      return Future.value("延时8秒执行");
    });
  }

  Future<void> getCEAuthenticationWithParamsSuccess(
      String authenticationParams) async {
    callBluetoothSDK.isCEAuthenticationWithParamsSuccess().then((value) => {
          setState(() {
            if (value) {
              if (authenticationParams == wifiStr) {
                wifiImageName = switchOn;
                fourGImageName = switchOff;
                lanImageName = switchOff;
                offlineImageName = switchOff;
                isOfflineSelected = false;
                isFourGSelected = false;
                isLanSelected = false;
                wifiState = false;
              }
              if (authenticationParams == fourGIStr) {
                fourGImageName = switchOn;
                wifiImageName = switchOff;
                lanImageName = switchOff;
                offlineImageName = switchOff;
                isOfflineSelected = false;
                isWifiSelected = false;
                isLanSelected = false;
                wifiState = true;
              }
              if (authenticationParams == lanStr) {
                lanImageName = switchOn;
                wifiImageName = switchOff;
                fourGImageName = switchOff;
                offlineImageName = switchOff;
                isOfflineSelected = false;
                isWifiSelected = false;
                isFourGSelected = false;
                wifiState = true;
              }
              if (authenticationParams == offlineIStr) {
                offlineImageName = switchOn;
                lanImageName = switchOff;
                wifiImageName = switchOff;
                fourGImageName = switchOff;
                isLanSelected = false;
                isWifiSelected = false;
                isFourGSelected = false;
                wifiState = true;
              }
              LoadingUtils.showToast("Set Success");
              callStopConnectPeripheral();
            } else {
              LoadingUtils.showToast("Set Failed");
            }
          }),
          print('Flutter数据APNParamsData =$value 功能')
        });
  }

  Future<void> callStopConnectPeripheral() async {
    callBluetoothSDK.stopConnectPeripheral();
    delayedStopConnectPeripheral();
    print('Flutter2------开始连接蓝牙设备');
  }

  void delayedStopConnectPeripheral() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      callIsDisConnectPeripheralSuccess();
      return Future.value("延时10秒执行");
    });
  }

  Future<void> callIsDisConnectPeripheralSuccess() async {
    callBluetoothSDK.isDisConnectPeripheralSuccess().then((value) => {
          LoadingUtils.showToast(
              "Bluetooth Disconnected.\nPlease connect charger."),
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pop(context, value);
            return Future.value("延时10秒执行");
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _getSessionId().then((value) {
        _getDevice(widget.arguments['deviceNumber']);
      });
      queryNetworkState();
      queryConfigSSIDParams();
      queryConfigAPNParams();
    }
  }

  Future<void> queryNetworkState() async {
    callBluetoothSDK.queryNetworkState();
    getNetworkingStateData();
  }

  Future<String> getNetworkingStateData() async {
    var networkingStateData = await callBluetoothSDK.getNetworkingStateData();
    print("networkingStateData====$networkingStateData");
    networkingStateResultType = networkingStateData.substring(0, 1);
    networkModelCode = networkingStateData.substring(1);
    if (networkModelCode == "0") {
      setState(() {
        // Offline
        isOfflineSelected = true;
        offlineImageName = switchOn;

        isFourGSelected = false;
        fourGImageName = switchOff;

        isLanSelected = false;
        lanImageName = switchOff;

        isWifiSelected = false;
        wifiImageName = switchOff;
      });
    } else if (networkModelCode == "1") {
      setState(() {
        // WiFi
        isWifiSelected = true;
        wifiImageName = switchOn;
        wifiState = false;

        isOfflineSelected = false;
        offlineImageName = switchOff;

        isFourGSelected = false;
        fourGImageName = switchOff;

        isLanSelected = false;
        lanImageName = switchOff;
      });
    } else if (networkModelCode == "2") {
      setState(() {
        // LAN
        isLanSelected = true;
        lanImageName = switchOn;

        isOfflineSelected = false;
        offlineImageName = switchOff;

        isFourGSelected = false;
        fourGImageName = switchOff;

        isWifiSelected = false;
        wifiImageName = switchOff;
      });
    } else if (networkModelCode == "4") {
      setState(() {
        // 4G
        isFourGSelected = true;
        fourGImageName = switchOn;

        isOfflineSelected = false;
        offlineImageName = switchOff;

        isLanSelected = false;
        lanImageName = switchOff;

        isWifiSelected = false;
        wifiImageName = switchOff;
      });
    }
    return networkingStateData;
  }

  _wifiClickAction() {
    ceAuthenticationWithParams(wifiStr);
  }

  _fourGClickAction() {
    ceAuthenticationWithParams(fourGIStr);
  }

  _lanClickAction() {
    ceAuthenticationWithParams(lanStr);
  }

  _offlineClickAction() {
    ceAuthenticationWithParams(offlineIStr);
  }

  Future<void> _getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var sessionIdStr = prefs.getString('sessionId') ?? "";
      sessionId = sessionIdStr;
    });
  }

  _getDevice(String code) {
    print("====$sessionId ====$code");
    Map<String, String> parameter = {"deviceNumber": code};

    NetWorkApiRequest.getDevice(sessionId, parameter).then((value) async {
      if (value != null && value['code'] == 0) {
        setState(() {
          List data = [];
          String str = json.encode(value);
          var ocppServerModel = deviceInfoModelFromJson(str);
          var netModule = ocppServerModel.data.list.first.netModule;

          if (netModule.contains("WIFI")) {
            data.add("Wi-Fi");
            setState(() {
              wifiOffstage = false;
              if (networkModelCode == "1") {
                wifiState = false;
              } else {
                wifiState = true;
              }
            });
          }
          if (netModule.contains("4G")) {
            data.add("4G");
            setState(() {
              fourGOffstage = false;
            });
          }
          if (netModule.contains("LAN")) {
            data.add("LAN");
            setState(() {
              lanOffstage = false;
            });
          }
          if (data.length > 1) {
            data.add('Offline');
            setState(() {
              offlineOffstage = false;
            });
          }
          print(str);
        });
      } else {
        LoadingUtils.showToast(value['msg']);
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
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
                      if (networkStateTxt == wifiStr) {
                        print("设置网络");
                      } else if (networkStateTxt == fourGIStr) {
                        print("设置4g");
                      }
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
          Offstage(
            offstage: wifiOffstage,
            child: networkStatebuild(
                wifiStr, ssid, wifiState, context, wifiImageName),
          ),
          Offstage(
            offstage: fourGOffstage,
            child: networkStatebuild(
                fourGIStr, "APN Settings", false, context, fourGImageName),
          ),
          Offstage(
            offstage: lanOffstage,
            child: networkStatebuild(lanStr, "", true, context, lanImageName),
          ),
          Offstage(
            offstage: offlineOffstage,
            child: networkStatebuild(
                offlineIStr, "", true, context, offlineImageName),
          ),
        ],
      ),
    );
  }
}
