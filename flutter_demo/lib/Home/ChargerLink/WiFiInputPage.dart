import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:flutter_demo/Utils/routes.dart';

class WiFiInputPage extends StatefulWidget {
  final Map arguments;
  const WiFiInputPage({Key? key, required this.arguments}) : super(key: key);
  @override
  State<WiFiInputPage> createState() => _WiFiInputPageState();
}

class _WiFiInputPageState extends State<WiFiInputPage> {
  bool isSelected = true;
  static const String inputHide = "lib/images/3.0x/input_hid@3x.png";
  static const String inputShow = "lib/images/3.0x/input_show@3x.png";
  String imageName = inputHide;

  final callBluetoothSDK = CallBluetoothSDK();

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  Color btnBackgroundColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    controller.addListener(() {
      setState(() {
        if (controller.text.isEmpty) {
          btnBackgroundColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgroundColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
  }

  _clickAction() {
    isSelected = !isSelected;
    setState(() {
      if (isSelected) {
        imageName = inputShow;
      } else {
        imageName = inputHide;
      }
    });
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

  Widget textFieldButtonWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 16, right: 20),
      child: Row(
        children: [
          Expanded(
            // height: 30,
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
                hintText: "Enter Password",
                hintStyle: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 25,
            height: 15,
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

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 1,
      width: 500,
      decoration: BoxDecoration(
        color: color,
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

  Function()? _saveAction() {
    if (controller.text.isNotEmpty) {
      return () {
        // LoadingUtils.showToast("Config failed");
        Navigator.pushNamed(
          context,
          Routes.wifiSettingPage,
          arguments: {
            "ssid": widget.arguments["ssid"],
            "psw": controller.text,
            "deviceNumber": widget.arguments['deviceNumber'],
          },
        );
      };
    }
    return () {
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
          textWidget(20, 20, "Wi-Fi  Configuration", 18, Colors.black,
              FontWeight.bold),
          textWidget(
              10,
              20,
              "Please make sure the APP is connected with 2.4G Wi-Fi.",
              16,
              Colors.grey.shade600,
              FontWeight.normal),
          textWidget(20, 30, "SSID：${widget.arguments["ssid"]}", 16,
              Colors.black, FontWeight.normal),
          textFieldButtonWidget(),
          heightLineWidget(10, 0, 10, Colors.grey.shade300),
          configureWidget(180, 42, "Configure"),
        ],
      ),
    );
  }
}
