import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Home/LoadBalance/ModbusModePage.dart';

class ModbusChargerPage extends StatefulWidget {
  final Map type;

  const ModbusChargerPage({Key? key, required this.type}) : super(key: key);
  @override
  State<ModbusChargerPage> createState() => _ModbusChargerPageState();
}

class _ModbusChargerPageState extends State<ModbusChargerPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    print(widget.type);
  }

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 4,
      width: 30,
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

  Widget modbusWidget(String text, int id, double left, double top,
      BoxDecoration decoration, LoadBalanceSourceType type) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: 20),
      width: MediaQuery.of(context).size.width - 40,
      height: 100,
      decoration: decoration,
      child: InkWell(
        onTap: () {
          if (type ==
              LoadBalanceSourceType.LoadBalanceSourceTypeMultipleSecondary) {
            if (id == 1) {
              Navigator.pushNamed(
                context,
                Routes.modbusRtuPage,
                arguments: {
                  "type": type,
                },
              );
            } else {
              Navigator.pushNamed(context, Routes.modbusTcpPage);
            }
          } else {
            if (id == 1) {
              Navigator.pushNamed(
                context,
                Routes.smartMeterSelection,
                arguments: {
                  "type": type,
                },
              );
            } else {
              print('点击了第$id个图片');
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 25, right: 20),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightLineWidget(
              20, 20, MediaQuery.of(context).size.width - 100, Colors.red),
          textWidget(20, FontWeight.bold, widget.type["modbusModeTitle"], 20,
              20, Colors.black),
          textWidget(18, FontWeight.w400, widget.type["modbusModeSubTitle"], 20,
              24, Colors.grey.shade900),
          textWidget(
              17,
              FontWeight.w400,
              "Please select one of the following Modbus methods:",
              20,
              40,
              Colors.grey.shade900),
          modbusWidget(
            "Modbus \nRTU(RS485)",
            1,
            20,
            70,
            BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3, 5),
                  blurRadius: 5.0,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular((5.0)),
            ),
            widget.type['type'],
          ),
          modbusWidget(
            "Modbus \nTCP/IP",
            2,
            20,
            30,
            BoxDecoration(
              color: widget.type['type'] ==
                      LoadBalanceSourceType
                          .LoadBalanceSourceTypeMultipleSecondary
                  ? Colors.white
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular((5.0)),
              boxShadow: widget.type['type'] ==
                      LoadBalanceSourceType
                          .LoadBalanceSourceTypeMultipleSecondary
                  ? [
                      const BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 5),
                        blurRadius: 5.0,
                      )
                    ]
                  : null,
            ),
            widget.type['type'],
          ),
        ],
      ),
    );
  }
}
