import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';

class CardConfigurePage extends StatefulWidget {
  const CardConfigurePage({Key? key}) : super(key: key);
  @override
  State<CardConfigurePage> createState() => _CardConfigurePageState();
}

class _CardConfigurePageState extends State<CardConfigurePage> {
  bool isSelected = true;
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";

  String imageName = switchOn;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
  }

  _clickAction() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        imageName = switchOn;
      } else {
        imageName = switchOff;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Card Config',
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
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: const Text(
              "Card Permissions",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, right: 20),
            child: Row(
              children: [
                const Text(
                  "Enable external cards",
                  style: TextStyle(
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
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, top: 12, right: 20),
            child: const Text(
              "Turn on this option and default card will be denied by this charger.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
