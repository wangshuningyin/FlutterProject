import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Home/YRunStateModel.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Home/DeviceList/DeviceListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String version = '';
  bool isSelectedDevice = false;
  Color connectColor = Colors.black;
  String manualConnection = '';
  String connectionStr = '';
  String bleImageStr = 'lib/images/3.0x/home_ble_select@3x.png';
  String wifiImageStr = 'lib/images/3.0x/home_wifi_select@3x.png';
  String lanImageStr = 'lib/images/3.0x/home_lan_select@3x.png';
  String fourGImageStr = 'lib/images/3.0x/home_4g_select@3x.png';
  String connectImageStr = 'lib/images/3.0x/home_disconnect@3x.png';
  bool isConnectPeripheralSuccess = false;
  String connectState = "Connect Charger";
  String deviceNumber = "";
  final callBluetoothSDK = CallBluetoothSDK();
  bool isSelected = false;
  String sessionId = '';
  List<YRunStateModel> systemInfoList = [];
  String packageVersion = '';
  String packageCode = '';

  Future<void> callstartConnectPeripheral(String item) async {
    callBluetoothSDK.startConnectPeripheral();
    delayedConnectPeripheral(item);
    print('Flutter2------开始连接蓝牙设备');
  }

  void delayedConnectPeripheral(String item) {
    Future.delayed(const Duration(milliseconds: 4000), () {
      callIsConnectPeripheralSuccess(item);
      return Future.value("延时4秒执行");
    });
  }

  Future<bool?> callIsConnectPeripheralSuccess(String item) async {
    final res = await callBluetoothSDK.isConnectPeripheralSuccess();
    print('Flutter蓝牙设备连接成功$res');
    isConnectPeripheralSuccess = res;

    if (!res) {
      connectionStr = "Connection Lost";
      manualConnection = 'Reconnect';
      LoadingUtils.showToast("Bluetooth connection failure");
    } else {
      callQueryDeviceSystemInfo();
      setState(() {
        _connectState(res);
      });
    }
    return res;
  }

  Future<void> callStartBluetooth() async {
    callBluetoothSDK.startBluetooth();
  }

  Future<void> callStopConnectPeripheral(
      String item, bool isGoToNextPage) async {
    callBluetoothSDK.stopConnectPeripheral();
    delayedStopConnectPeripheral(item, isGoToNextPage);
    print('Flutter2------开始连接蓝牙设备');
  }

  void delayedStopConnectPeripheral(String item, bool isGoToNextPage) {
    callIsDisConnectPeripheralSuccess(item, isGoToNextPage);
  }

  Future<bool?> callIsDisConnectPeripheralSuccess(
      String item, bool isGoToNextPage) async {
    final res = await callBluetoothSDK.isDisConnectPeripheralSuccess();
    if (isGoToNextPage) {
      // isConnectPeripheralSuccess = false;
      isSelected = false;
      _navigateAndDisplaySelection(context);
    }
    return res;
  }

  Future<bool?> callIsConnectPeripheral() async {
    final res = await callBluetoothSDK.isConnectedPeripheral();
    return res;
  }

  Future<void> callQueryDeviceSystemInfo() async {
    callBluetoothSDK.queryDeviceSystemInfo();
    callGetSystemInfoList();
  }

  Future<List<String?>> callGetSystemInfoList() async {
    final systemInfoLists = await callBluetoothSDK.getSystemInfoList();
    for (var jsonStr in systemInfoLists) {
      var yRunStateModel = yRunStateModelFromJson(jsonStr!);
      print(yRunStateModel.content);
      systemInfoList.add(yRunStateModel);
    }
    for (var i = 0; i < systemInfoList.length; i++) {
      packageCode = systemInfoList[4].content;
      packageVersion = systemInfoList[5].content;
    }
    print("$systemInfoList + $packageCode + $packageVersion");
    return systemInfoLists;
  }

  _clickAction() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        print('Flutter2------开始断开蓝牙设备');
        connectionStr = "Connection Lost";
        manualConnection = 'Reconnect';
        callStopConnectPeripheral(deviceNumber, false);
        _connectState(!isSelected);
      } else {
        print('Flutter2------开始连接蓝牙设备');
        callstartConnectPeripheral(deviceNumber);
        connectionStr = "Connecting...";
        manualConnection = 'Reconnect';
        // _connectState(!isSelected);
      }
    });
  }

  _connectState(bool isConnect) {
    if (isConnect) {
      connectColor = Colors.green;
      connectionStr = "Connected";
      manualConnection = 'Disconnect';
      bleImageStr = 'lib/images/3.0x/home_ble_select@3x.png';
      wifiImageStr = 'lib/images/3.0x/home_wifi_select@3x.png';
      lanImageStr = 'lib/images/3.0x/home_lan_select@3x.png';
      fourGImageStr = 'lib/images/3.0x/home_4g_select@3x.png';
      connectImageStr = 'lib/images/3.0x/home_disconnect@3x.png';
    } else {
      connectColor = Colors.black;
      bleImageStr = 'lib/images/3.0x/home_ble@3x.png';
      wifiImageStr = 'lib/images/3.0x/home_wifi@3x.png';
      lanImageStr = 'lib/images/3.0x/home_lan@3x.png';
      fourGImageStr = 'lib/images/3.0x/home_4g@3x.png';
      connectImageStr = 'lib/images/3.0x/home_reconnect@3x.png';
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      if (Platform.isIOS) {
        callStartBluetooth();
      }
    });
  }

  Future<void> _getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var sessionIdStr = prefs.getString('sessionId') ?? "";
      sessionId = sessionIdStr;
    });
  }

  _deviceSync(String sessionID) {
    Map<String, dynamic> parameter = {
      "deviceNumber": deviceNumber,
      "softVersion": packageVersion
    };
    NetWorkApiRequest.updateDevice(sessionID, parameter).then((value) async {
      if (value != null && value['code'] == 0) {
        LoadingUtils.showToast("Sync Success");
      } else {
        LoadingUtils.showToast(value['msg']);
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
    });
  }

  List<Widget> _getListData(int startCount, int count) {
    List<Widget> list = [];
    List<String> imageList = [
      'lib/images/3.0x/device_sync@3x.png',
      'lib/images/3.0x/home_firmware_info@3x.png',
      'lib/images/3.0x/home_device_info@3x.png',
      'lib/images/3.0x/home_device_update@3x.png',
      'lib/images/3.0x/home_charger_link@3x.png',
      'lib/images/3.0x/home_ocpp_server@3x.png',
      'lib/images/3.0x/home_general_parameters@3x.png',
      'lib/images/3.0x/home_card@3x.png',
      'lib/images/3.0x/home_device_model@3x.png',
      'lib/images/3.0x/home_load_balance@3x.png'
    ];
    List<String> titleList = [
      'Device Sync',
      'Firmware Info',
      'Device Info',
      'Update',
      'Charger Link',
      'OCPP Server',
      'Settings',
      'Card',
      'Device Mode',
      'Load Balance'
    ];
    for (var i = startCount; i < count - startCount; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            if (Platform.isIOS) {
              callIsConnectPeripheral().then((value) => {
                    if (value == false)
                      {
                        LoadingUtils.showToast(
                            "Bluetooth Disconnected. Please connect charger.")
                      }
                    else
                      {
                        if (i == 0)
                          {
                            _getSessionId().then((value) {
                              _deviceSync(sessionId);
                            })
                          }
                        else if (i == 1)
                          {
                            Navigator.pushNamed(
                                context, Routes.firmwareInfoPage)
                          }
                        else if (i == 2)
                          {
                            Navigator.pushNamed(
                              context,
                              Routes.deviceInfoPage,
                              arguments: {
                                "deviceNumber": deviceNumber,
                              },
                            )
                          }
                        else if (i == 3)
                          {Navigator.pushNamed(context, Routes.updatePage)}
                        else if (i == 4)
                          {Navigator.pushNamed(context, Routes.chargerLinkPage)}
                        else if (i == 5)
                          {
                            Navigator.pushNamed(
                              context,
                              Routes.ocppServerPage,
                              arguments: {
                                "deviceNumber": deviceNumber,
                              },
                            )
                          }
                        else if (i == 6)
                          {
                            Navigator.pushNamed(
                                context, Routes.setGeneralParameterPage)
                          }
                        else if (i == 7)
                          {
                            Navigator.pushNamed(
                                context, Routes.cardConfigurePage)
                          }
                        else if (i == 8)
                          {Navigator.pushNamed(context, Routes.deviceMode)}
                        else if (i == 9)
                          {Navigator.pushNamed(context, Routes.modbusModePage)}
                        else
                          {LoadingUtils.showToast("正在开发。。。。。。")}
                      }
                  });
            } else {
              if (i == 0) {
                _getSessionId().then((value) {
                  _deviceSync(sessionId);
                });
              } else if (i == 1) {
                Navigator.pushNamed(context, Routes.firmwareInfoPage);
              } else if (i == 2) {
                Navigator.pushNamed(context, Routes.deviceInfoPage);
              } else if (i == 3) {
                Navigator.pushNamed(context, Routes.updatePage);
              } else if (i == 4) {
                Navigator.pushNamed(context, Routes.chargerLinkPage);
              } else if (i == 5) {
                Navigator.pushNamed(context, Routes.ocppServerPage);
              } else if (i == 6) {
                Navigator.pushNamed(context, Routes.setGeneralParameterPage);
              } else if (i == 7) {
                Navigator.pushNamed(context, Routes.cardConfigurePage);
              } else if (i == 8) {
                Navigator.pushNamed(context, Routes.deviceMode);
              } else if (i == 9) {
                Navigator.pushNamed(context, Routes.modbusModePage);
              } else {
                LoadingUtils.showToast("正在开发。。。。。。");
              }
            }
          },
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  imageList[i],
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  titleList[i],
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  Widget renderTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          width: 40,
          height: 5,
          decoration: const BoxDecoration(color: Colors.red),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget headerbuild(String title, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      height: 220,
      decoration: BoxDecoration(
        // color: Colors.blue,
        border: Border.all(
          width: 2,
          color: const Color(0xFFEEEEEE),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // MainAxisAlignment.spaceBetween,
        // VerticalDirection verticalDirection = VerticalDirection.d
        verticalDirection: VerticalDirection.up,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              //  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 60),
                  child: Material(
                    // color: Colors.green,
                    //INK可以实现装饰容器
                    child: Ink(
                      //用ink圆角矩形
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        //背景
                        // color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        //设置四周边框
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFEEEEEE),
                        ),
                      ),
                      child: InkWell(
                        //圆角设置,给水波纹也设置同样的圆角
                        //如果这里不设置就会出现矩形的水波纹效果
                        highlightColor: Colors.transparent,
                        radius: 0.0,
                        borderRadius: BorderRadius.circular(25.0),
                        //设置点击事件回调
                        // onTap: () => callScanForPeripherals(),
                        onTap: () {
                          // isConnectPeripheralSuccess = false;
                          callStopConnectPeripheral(deviceNumber, true);
                        },
                        child: Container(
                          //设置 child 居中
                          alignment: const Alignment(0, 0),
                          height: 40,
                          width: 180,
                          child: Text(
                            connectState,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              // height: 100,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              child: Image.asset(
                "lib/images/3.0x/home_device@3x.png",
                // fit: BoxFit.cover,
                width: 120,
                height: 180,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget connectbuild(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      height: 220,
      // width:,
      decoration: BoxDecoration(
        // color: Colors.blue,
        border: Border.all(
          width: 2,
          color: const Color(0xFFEEEEEE),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 0, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          const Text("Switch Charge"),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Image.asset(
                              'lib/images/3.0x/home_switch@3x.png',
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                            ),
                            onPressed: () {
                              callStopConnectPeripheral(deviceNumber, true);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        connectionStr,
                        style: TextStyle(
                            fontSize: 16,
                            color: connectColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            bleImageStr,
                            fit: BoxFit.cover,
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            wifiImageStr,
                            fit: BoxFit.cover,
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            lanImageStr,
                            fit: BoxFit.cover,
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            fourGImageStr,
                            fit: BoxFit.cover,
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: <Widget>[
                          Text(manualConnection),
                          const SizedBox(width: 10),
                          // const Icon(Icons.bolt_outlined, size: 20),
                          IconButton(
                            icon: Image.asset(
                              connectImageStr,
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                            ),
                            onPressed: () {
                              _clickAction();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      "lib/images/3.0x/home_device@3x.png",
                      // fit: BoxFit.cover,
                      width: 100,
                      height: 160,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(deviceNumber),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 44),
                      renderTitle("Charger Paring"),
                      // 视觉上隐藏小部件  _offstage 为真即隐藏
                      Offstage(
                        offstage: isSelectedDevice,
                        child: headerbuild("title", context),
                      ),
                      Offstage(
                        offstage: !isSelectedDevice,
                        child: connectbuild(context),
                      ),
                      renderTitle("Self Detect"),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 30.0, //水平子 Widget 之间间距
                        mainAxisSpacing: 10.0, //垂直子 Widget 之间间距
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        crossAxisCount: 3, //一行的 Widget 数量
                        childAspectRatio: 1.1, //宽度和高度的比例
                        children: _getListData(0, 3),
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      renderTitle("Configuration"),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 30.0, //水平子 Widget 之间间距
                        mainAxisSpacing: 10.0, //垂直子 Widget 之间间距
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        crossAxisCount: 3, //一行的 Widget 数量
                        childAspectRatio: 1.1, //宽度和高度的比例
                        children: _getListData(3, 13),
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeviceListPage()),
    );
    setState(() {
      if (result == null) {
        connectState = "Connect Charger";
        deviceNumber = "";
        isSelectedDevice = false;
      } else {
        callstartConnectPeripheral(result);
        deviceNumber = result.toString();
        isSelectedDevice = true;
        connectionStr = "Connecting...";
        manualConnection = 'Reconnect';
        _connectState(false);
      }
    });
  }
}
