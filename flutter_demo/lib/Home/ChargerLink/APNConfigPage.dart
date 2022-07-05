import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Home/ChargerLink/APNParamsModel.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';

class APNConfigPage extends StatefulWidget {
  final Map arguments;
  const APNConfigPage({Key? key, required this.arguments}) : super(key: key);
  @override
  State<APNConfigPage> createState() => _APNConfigPageState();
}

class _APNConfigPageState extends State<APNConfigPage> {
  bool isSelected = false;
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";
  String imageName = switchOff;

  static const String turnOffMsg = "Turn on this option and configure APN.";
  static const String turnOnMsg =
      "Turn off this option and APN configuration\nwill be clear and auto adapted.";
  String msg = turnOffMsg;

  TextEditingController apnController = TextEditingController();
  FocusNode apnFocusNode = FocusNode();
  TextEditingController apnUserController = TextEditingController();
  FocusNode apnUserFocusNode = FocusNode();
  TextEditingController apnPasswordController = TextEditingController();
  FocusNode apnPasswordFocusNode = FocusNode();

  ScrollController scrollController = ScrollController();

  Color btnBackgroundColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;

  final callBluetoothSDK = CallBluetoothSDK();
  late APNParamsModel apnParamsModel;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    apnParamsModel = widget.arguments["apnParamsModel"];
    if (apnParamsModel.apnType == 1) {
      isSelected = true;
      imageName = switchOn;
      msg = turnOnMsg;
    } else {
      isSelected = false;
      imageName = switchOff;
      msg = turnOffMsg;
    }

    apnController.addListener(() {
      setState(() {
        if (apnController.text.isEmpty) {
          btnBackgroundColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgroundColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
  }

  Future<void> configAPNWithParams() async {
    apnParamsModel.apn = apnController.text;
    apnParamsModel.apnLen = apnController.text.length;
    apnParamsModel.userName = apnUserController.text;
    apnParamsModel.userNameLen = apnUserController.text.length;
    apnParamsModel.psw = apnPasswordController.text;
    apnParamsModel.pswLen = apnPasswordController.text.length;

    var s = apnParamsModelToJson(apnParamsModel);
    callBluetoothSDK.configAPNWithParams(s);
    delayedGetIsConfigAPNWithParamsSuccess();
    print('configAPNWithParams');
  }

  void delayedGetIsConfigAPNWithParamsSuccess() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      getIsConfigAPNWithParamsSuccess();
      return Future.value("延时1秒执行");
    });
  }

  Future<void> getIsConfigAPNWithParamsSuccess() async {
    callBluetoothSDK.isConfigAPNWithParamsSuccess().then((value) {
      print('Flutte 配置成功');
    });
  }

  _clickAction() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        imageName = switchOn;
        msg = turnOnMsg;
      } else {
        imageName = switchOff;
        msg = turnOffMsg;
      }
    });
  }

  Function()? _saveAction() {
    if (apnController.text.isNotEmpty) {
      return () {
        configAPNWithParams();
      };
    }
    return () {
      return null;
    };
  }

  Widget textWidget(double top, double left, String text, double fontSize,
      Color color, FontWeight fontWeight) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: 20),
      height: 30,
      width: 500,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  Widget lineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 1,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  Widget textButtonWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 16, right: 20),
      child: Row(
        children: [
          const Text(
            "APN Settings",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
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
    );
  }

  Widget editorWidget(String title, String hintText, double top,
      TextEditingController controller, FocusNode focusNode) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: top, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // textWidget(13, FontWeight.w500, title, 5, 10, Colors.grey.shade700),
          textWidget(10, 20, title, 15, Colors.black, FontWeight.bold),
          Container(
            height: 30,
            margin: const EdgeInsets.only(left: 20, top: 0, right: 0),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, top: 10, right: 10),
            height: 1,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget apnSettingsWidget(double top) {
    return Container(
      margin: EdgeInsets.only(left: 0, top: top, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(14, 20, "APN Settings", 16, Colors.black, FontWeight.bold),
          editorWidget("APN", "", 0, apnController, apnFocusNode),
          editorWidget("Username", "", 10, apnUserController, apnUserFocusNode),
          editorWidget(
              "Password", "", 10, apnPasswordController, apnPasswordFocusNode),
          configureWidget(180, 42, "Configure"),
        ],
      ),
    );
  }

  Widget configureWidget(double width, double height, String text) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 70, bottom: 60),
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(btnBackgroundColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: btnTextColor,
            ),
          ),
          onPressed: _saveAction(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Charger Link',
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
          Expanded(
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      textWidget(28, 20, "Cellular Data", 18, Colors.black,
                          FontWeight.bold),
                      textButtonWidget(),
                      textWidget(
                          20, 20, msg, 14, Colors.grey, FontWeight.normal),
                      Offstage(
                        offstage: !isSelected,
                        child: apnSettingsWidget(40),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
