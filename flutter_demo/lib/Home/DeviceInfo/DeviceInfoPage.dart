import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';
import 'package:flutter_demo/Home/DeviceInfo/DeviceInfoModel.dart';

class DeviceInfoPage extends StatefulWidget {
  final Map arguments;
  const DeviceInfoPage({Key? key, required this.arguments}) : super(key: key);
  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  List widgets = [];
  List dataList = [];
  String typeStr = "";
  String statusStr = "";
  String sessionId = "";
  String networkingStateResultType = "";
  String networkModelCode = "";
  bool isShowServerInfo = true;
  bool isShowMacAddress = true;
  String macAddressStr = "";
  String serverInfoStr = "";
  final callBluetoothSDK = CallBluetoothSDK();
  List<String> titles = [];
  List<String> titleContents = [];
  List<bool> offstageTitle = [];
  List<bool> offstageValue = [];
  @override
  void initState() {
    super.initState();
    queryOCPPConfigParams();
  }

  Future<void> queryOCPPConfigParams() async {
    callBluetoothSDK.queryOCPPConfigParams();
    delayedGetDomain();
  }

  void delayedGetDomain() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getDomain();
      return Future.value("延时4秒执行");
    });
  }

  Future<String> getDomain() async {
    var ocppConfigParams = await callBluetoothSDK.getDomain();
    print("ocppConfigParams===$ocppConfigParams");
    serverInfoStr = ocppConfigParams;
    queryNetworkState();
    return ocppConfigParams;
  }

  Future<void> queryNetworkState() async {
    callBluetoothSDK.queryNetworkState();
    getNetworkingStateData();
  }

  Future<String> getNetworkingStateData() async {
    var networkingStateData = await callBluetoothSDK.getNetworkingStateData();
    print("networkingStateData====$networkingStateData");
    networkingStateResultType = networkingStateData.substring(0, 1);
    statusStr = networkingStateResultType == "0" ? "Connected" : "Disconnected";
    isShowServerInfo = networkingStateResultType == "0";
    networkModelCode = networkingStateData.substring(1);
    if (networkModelCode == "0") {
      typeStr = "Offline";
    } else if (networkModelCode == "1") {
      typeStr = "WiFi";
      isShowMacAddress = true;
    } else if (networkModelCode == "2") {
      typeStr = "LAN";
      isShowMacAddress = true;
    } else if (networkModelCode == "4") {
      typeStr = "4G";
    }
    queryDeviceConfigType();
    return networkingStateData;
  }

  Future<void> queryDeviceConfigType() async {
    callBluetoothSDK.queryDeviceConfigType();
    delayedGetDeviceConfigData();
  }

  void delayedGetDeviceConfigData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getDeviceConfigData();
      ;
      return Future.value("延时4秒执行");
    });
  }

  Future<String> getDeviceConfigData() async {
    var configData = await callBluetoothSDK.getDeviceConfigData();
    setState(() {
      macAddressStr = configData.substring(2);
    });
    var resultCode = configData.substring(0, 1);
    print("configData===$configData");
    if (networkModelCode == "0" ||
        networkModelCode == "4" ||
        resultCode == "2") {
      isShowMacAddress = false;
    } else {
      isShowMacAddress = true;
    }
    _getSessionId().then((value) {
      _getDevice(widget.arguments["deviceNumber"]);
    });
    return configData;
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
          String str = json.encode(value);
          var ocppServerModel = deviceInfoModelFromJson(str);
          if (isShowMacAddress && isShowServerInfo) {
            dataList = [
              "",
              ocppServerModel.data.list.first.deviceNumber,
              ocppServerModel.data.list.first.hardwareModel,
              // ocppServerModel.data.list.first.chargeType,
              "${ocppServerModel.data.list.first.elecPower / 1000}kw",
              "${ocppServerModel.data.list.first.ratedCurrent}A",
              ocppServerModel.data.list.first.powerType.toString(),
              ocppServerModel.data.list.first.outlet,
              ocppServerModel.data.list.first.netModule.toString(),
              ocppServerModel.data.list.first.certified.toString(),
              "",
              typeStr,
              statusStr,
              "",
              "",
              ""
            ];
            offstageValue = [
              true,
              true,
              true,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              true
            ];
            offstageTitle = [
              true,
              false,
              false,
              false,
              true,
              true,
              true,
              true,
              true,
              true,
              true,
              true,
              false,
              false,
              true,
            ];
            titles = [
              "",
              "Serial Number",
              "Product Type",
              "Performance",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "Server Info",
              "Mac Address",
              ""
            ];

            titleContents = [
              "",
              "TACW22-4-0320-T0023",
              "TACW22-T-R-0",
              "Max Power",
              "Max Current",
              "Phases",
              "Outlet",
              "Internet suppot",
              "Certification",
              "",
              "Type",
              "Status",
              serverInfoStr,
              macAddressStr,
              ""
            ];
          } else {
            if (isShowMacAddress) {
              dataList = [
                "",
                ocppServerModel.data.list.first.deviceNumber,
                ocppServerModel.data.list.first.hardwareModel,
                // ocppServerModel.data.list.first.chargeType,
                "${ocppServerModel.data.list.first.elecPower / 1000}kw",
                "${ocppServerModel.data.list.first.ratedCurrent}A",
                ocppServerModel.data.list.first.powerType.toString(),
                ocppServerModel.data.list.first.outlet,
                ocppServerModel.data.list.first.netModule.toString(),
                ocppServerModel.data.list.first.certified.toString(),
                "",
                typeStr,
                statusStr,
                "",
                "",
              ];
              offstageValue = [
                true,
                true,
                true,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
              ];
              offstageTitle = [
                true,
                false,
                false,
                false,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                false,
                false,
              ];
              titles = [
                "",
                "Serial Number",
                "Product Type",
                "Performance",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "Mac Address",
                ""
              ];

              titleContents = [
                "",
                "TACW22-4-0320-T0023",
                "TACW22-T-R-0",
                "Max Power",
                "Max Current",
                "Phases",
                "Outlet",
                "Internet suppot",
                "Certification",
                "",
                "Type",
                "Status",
                macAddressStr,
                ""
              ];
            } else {
              dataList = [
                "",
                ocppServerModel.data.list.first.deviceNumber,
                ocppServerModel.data.list.first.hardwareModel,
                // ocppServerModel.data.list.first.chargeType,
                "${ocppServerModel.data.list.first.elecPower / 1000}kw",
                "${ocppServerModel.data.list.first.ratedCurrent}A",
                ocppServerModel.data.list.first.powerType.toString(),
                ocppServerModel.data.list.first.outlet,
                ocppServerModel.data.list.first.netModule.toString(),
                ocppServerModel.data.list.first.certified.toString(),
                "",
                typeStr,
                statusStr,
                ""
              ];
              offstageValue = [
                true,
                true,
                true,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                true
              ];
              offstageTitle = [
                true,
                false,
                false,
                false,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
              ];
              titles = [
                "",
                "Serial Number",
                "Product Type",
                "Performance",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                ""
              ];

              titleContents = [
                "",
                "TACW22-4-0320-T0023",
                "TACW22-T-R-0",
                "Max Power",
                "Max Current",
                "Phases",
                "Outlet",
                "Internet suppot",
                "Certification",
                "",
                "Type",
                "Status",
                ""
              ];
            }
          }
          for (int i = 0; i < dataList.length; i++) {
            widgets.add(getRow(i));
          }
          // print(dataList);
        });
      } else {
        LoadingUtils.showToast(value['msg']);
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
    });
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Offstage(
            offstage: offstageTitle[i],
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                titles[i],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  titleContents[i],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const Expanded(
                child: Text(''), // 中间用Expanded控件
              ),
              Offstage(
                offstage: offstageValue[i],
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Text(
                    dataList[i],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            // width: 40,
            height: 1,
            decoration: BoxDecoration(color: Colors.grey[350]),
          ),
        ],
      ),
      onTap: () {
        // setState(() {
        //   widgets.add(getRow(widgets.length + 1));
        print('row $i');
        // });
      },
    );
  }

  Widget title(String title, bool offstage) {
    return Row(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
            child: Offstage(
              offstage: offstage,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
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
          'Device Info',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          if (position == 0 ||
              position == 9 ||
              position == widgets.length - 1) {
            if (position == 0) {
              return title("Basic Info", true);
            } else if (position == 9) {
              return title("Internect Connection", true);
            } else {
              return title("Device Log", false);
            }
          } else {
            return getRow(position);
          }
        },
      ),
    );
  }
}
