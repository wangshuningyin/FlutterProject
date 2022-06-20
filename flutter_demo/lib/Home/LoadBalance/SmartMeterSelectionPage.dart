// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Utils/DataPickerTool.dart';

class SmartMeterSelectionPage extends StatefulWidget {
  final Map arguments;
  const SmartMeterSelectionPage({Key? key, required this.arguments})
      : super(key: key);
  @override
  State<SmartMeterSelectionPage> createState() =>
      _SmartMeterSelectionPageState();
}

class _SmartMeterSelectionPageState extends State<SmartMeterSelectionPage> {
  var mFList = ['ABB', 'Schneider Electric', 'Siemens'];
  var pNList = ['A, B and EV series'];
  var map = {
    "ABB": ["A, B and EV series"],
    "Schneider Electric": ["iEM3000 and PM5300 series"],
    "Siemens": ["PAC3100"]
  };
  String selectedManufactureStr = '';
  String selectedModelStr = '';
  Color btnBackgorondColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    print(widget.arguments);
  }

  Function()? _saveAction() {
    if (selectedManufactureStr == '' || selectedModelStr == '') {
      return () {
        return null;
      };
    }
    return () {
      Navigator.pushNamed(
        context,
        Routes.modbusRtuPage,
        arguments: widget.arguments,
      );
    };
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

  Widget selectedWidget(String title, double top) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: top, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(17, FontWeight.w500, title, 0, 20, Colors.black),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 26, right: 10),
            child: Row(
              children: [
                Expanded(
                  // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    title == 'Select the manufacture:'
                        ? selectedManufactureStr
                        : selectedModelStr,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 25,
                  // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: InkWell(
                    onTap: () {
                      if (title == 'Select the manufacture:') {
                        DataPickerTool.show(context,
                            list: mFList,
                            onSelectedItemChanged: (v) {}, confirmClick: (v) {
                          setState(() {
                            selectedManufactureStr = mFList[v];
                            pNList = map[mFList[v]]!;
                            selectedModelStr = "";
                            btnBackgorondColor = Colors.grey.shade300;
                            btnTextColor = Colors.black;
                          });
                        });
                      } else {
                        DataPickerTool.show(context,
                            list: pNList,
                            onSelectedItemChanged: (v) {}, confirmClick: (v) {
                          setState(() {
                            selectedModelStr = pNList[v];
                            btnBackgorondColor = Colors.red;
                            btnTextColor = Colors.white;
                          });
                        });
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, top: 20, right: 0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightLineWidget(
              20, 20, MediaQuery.of(context).size.width - 100, Colors.red),
          textWidget(
              22, FontWeight.bold, 'Single Charger', 20, 16, Colors.black),
          textWidget(18, FontWeight.w400, "Charger as Primary", 20, 22,
              Colors.grey.shade900),
          textWidget(18, FontWeight.bold, "Smart Meter Selection", 20, 24,
              Colors.grey.shade900),
          selectedWidget("Select the manufacture:", 0),
          selectedWidget("Select the model:", 18),
          Expanded(child: Container()),
          saveWidget(),
        ],
      ),
    );
  }
}
