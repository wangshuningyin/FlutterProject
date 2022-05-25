// ignore_for_file: constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';

enum ModbusModeType {
  ModbusModeTypeSlave, // 从机
  ModbusModeTypeHost, // 主机
  ModbusModeTypeOff // 禁用
}
enum LoadBalanceSourceType {
  LoadBalanceSourceTypeSinglePrimary, // 单主
  LoadBalanceSourceTypeMultiplePrimary, // 多主
  LoadBalanceSourceTypeMultipleSecondary, // 多从
}

class ModbusModePage extends StatefulWidget {
  const ModbusModePage({Key? key}) : super(key: key);
  @override
  State<ModbusModePage> createState() => _ModbusModePageState();
}

class _ModbusModePageState extends State<ModbusModePage> {
  bool isSelected = true;
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";
  static const String modbusFNor = "lib/images/3.0x/modbus_f_nor@3x.png";
  static const String modbusF = "lib/images/3.0x/modbus_f@3x.png";

  static const String modbusSNor = "lib/images/3.0x/modbus_s_nor@3x.png";
  static const String modbusS = "lib/images/3.0x/modbus_s@3x.png";

  static const String modbusTNor = "lib/images/3.0x/modbus_t_nor@3x.png";
  static const String modbusT = "lib/images/3.0x/modbus_t@3x.png";

  String switchImageName = switchOff;
  String modbusFImageName = modbusF;
  String modbusSImageName = modbusS;
  String modbusTImageName = modbusT;

  String modbusModeTitle = "Single Charge";
  String modbusModeSubTitle = "";
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
  }

  _switchClickAction() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        switchImageName = switchOff;
        modbusFImageName = modbusF;
        modbusSImageName = modbusS;
        modbusTImageName = modbusT;
      } else {
        switchImageName = switchOn;
        modbusFImageName = modbusFNor;
        modbusSImageName = modbusSNor;
        modbusTImageName = modbusTNor;
      }
    });
  }

  Function()? tapAction(LoadBalanceSourceType type) {
    if (isSelected) {
      return null;
    }
    return () {
      if (type == LoadBalanceSourceType.LoadBalanceSourceTypeSinglePrimary) {
        modbusModeTitle = "Single Charge";
        modbusModeSubTitle = "Charge as primary";
      } else if (type ==
          LoadBalanceSourceType.LoadBalanceSourceTypeMultiplePrimary) {
        modbusModeTitle = "Multiple Charges";
        modbusModeSubTitle = "Charge as primary";
      } else if (type ==
          LoadBalanceSourceType.LoadBalanceSourceTypeMultipleSecondary) {
        modbusModeTitle = "Multiple Charges";
        modbusModeSubTitle = "Charge as secondary";
      }
      Navigator.pushNamed(
        context,
        Routes.modbusChargerPage,
        arguments: {
          "type": type,
          "modbusModeTitle": modbusModeTitle,
          "modbusModeSubTitle": modbusModeSubTitle,
        },
      );
    };
  }

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 5,
      width: 20,
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

  Widget switchModbusWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 10),
      child: Row(
        children: [
          const Text(
            "Modbus",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
                _switchClickAction();
              },
              child: Image(
                image: AssetImage(switchImageName),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget(String imageName, LoadBalanceSourceType type) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 10),
      // width: 40,
      height: 160,
      child: InkWell(
        onTap: tapAction(type),
        child: Image(
          image: AssetImage(imageName),
          // fit: BoxFit.fill,
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
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                heightLineWidget(
                    20, 10, MediaQuery.of(context).size.width - 54, Colors.red),
                textWidget(18, FontWeight.bold, 'Load Balancing', 20, 20,
                    Colors.black),
                textWidget(
                    14,
                    FontWeight.w500,
                    "Please enable Modbus and select one of the following options.",
                    20,
                    20,
                    Colors.black),
                switchModbusWidget(),
                imageWidget(modbusFImageName,
                    LoadBalanceSourceType.LoadBalanceSourceTypeSinglePrimary),
                imageWidget(modbusSImageName,
                    LoadBalanceSourceType.LoadBalanceSourceTypeMultiplePrimary),
                imageWidget(
                    modbusTImageName,
                    LoadBalanceSourceType
                        .LoadBalanceSourceTypeMultipleSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
