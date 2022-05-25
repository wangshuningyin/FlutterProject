import 'dart:io';
import 'package:flutter/material.dart';
import '../../Utils/routes.dart';

class ModbusTcpPage extends StatefulWidget {
  const ModbusTcpPage({Key? key}) : super(key: key);
  @override
  State<ModbusTcpPage> createState() => _ModbusTcpPageState();
}

class _ModbusTcpPageState extends State<ModbusTcpPage> {
  List<String> valueList = [];

  TextEditingController ipAddressController = TextEditingController();
  FocusNode ipAddressFocusNode = FocusNode();
  TextEditingController maskAddressController = TextEditingController();
  FocusNode maskFocusNode = FocusNode();
  TextEditingController gatewayAddressController = TextEditingController();
  FocusNode gatewayFocusNode = FocusNode();
  TextEditingController serverPortController = TextEditingController();
  FocusNode serverPortFocusNode = FocusNode();

  Color btnBackgorondColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    ipAddressController.addListener(() {
      setState(() {
        if (ipAddressController.text.isEmpty ||
            maskAddressController.text.isEmpty ||
            gatewayAddressController.text.isEmpty ||
            serverPortController.text.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
    maskAddressController.addListener(() {
      setState(() {
        if (ipAddressController.text.isEmpty ||
            maskAddressController.text.isEmpty ||
            gatewayAddressController.text.isEmpty ||
            serverPortController.text.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
    gatewayAddressController.addListener(() {
      setState(() {
        if (ipAddressController.text.isEmpty ||
            maskAddressController.text.isEmpty ||
            gatewayAddressController.text.isEmpty ||
            serverPortController.text.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
    serverPortController.addListener(() {
      setState(() {
        if (ipAddressController.text.isEmpty ||
            maskAddressController.text.isEmpty ||
            gatewayAddressController.text.isEmpty ||
            serverPortController.text.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
  }

  Function()? _saveAction() {
    if (ipAddressController.text.isEmpty ||
        maskAddressController.text.isEmpty ||
        gatewayAddressController.text.isEmpty ||
        serverPortController.text.isEmpty) {
      return () {
        return null;
      };
    }
    return () {
      Navigator.pushNamed(context, Routes.homePage);
    };
  }

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 3,
      width: 32,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  Widget textWidget(double fontSize, FontWeight fontWeight, String text,
      double left, double top, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: 10),
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

  Widget richtTextWidget(double left, double top) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: 10),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 13,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
          text: "Please disable ",
          children: <TextSpan>[
            TextSpan(
              text: 'LAN ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'in Charger Link before configure ',
              style: TextStyle(
                fontSize: 13,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Modbus TCP/IP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ', otherwise a failure will arise.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        style: TextStyle(height: 1.5),
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Row(
        children: [
          const Expanded(
            child: Text(""),
          ),
          InkWell(
            onTap: () {
              print('点击了');
            },
            child: const Text(
              "Go disabled LAN",
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.underline,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
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
          textWidget(13, FontWeight.w500, title, 5, 10, Colors.grey.shade700),
          Container(
            height: 30,
            margin: const EdgeInsets.only(left: 5, top: 0, right: 0),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
            margin: const EdgeInsets.only(left: 5, top: 0, right: 10),
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

  Widget saveWidget() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 40),
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
          color: Colors.black,
          borderRadius: BorderRadius.circular((20.0)),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(btnBackgorondColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
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
      appBar: AppBar(
        title: const Text(
          '',
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
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    [
                      heightLineWidget(20, 10,
                          MediaQuery.of(context).size.width - 50, Colors.red),
                      textWidget(19, FontWeight.bold, 'Modbus TCP/IP', 20, 12,
                          Colors.black),
                      richtTextWidget(20, 20),
                      buttonWidget(),
                      editorWidget("IP Address", "Please input parameter", 0,
                          ipAddressController, ipAddressFocusNode),
                      editorWidget("Mask address", "Please input parameter", 0,
                          maskAddressController, maskFocusNode),
                      editorWidget("Gateway Address", "Please input parameter",
                          0, gatewayAddressController, gatewayFocusNode),
                      editorWidget("Server Port", "Please input parameter", 0,
                          serverPortController, serverPortFocusNode),
                    ],
                  ),
                ),
              ],
            ),
          ),
          saveWidget(),
        ],
      ),
    );
  }
}
