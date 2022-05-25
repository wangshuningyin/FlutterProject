import 'package:flutter/material.dart';

class FirmwareInfoPage extends StatefulWidget {
  const FirmwareInfoPage({Key? key}) : super(key: key);
  @override
  State<FirmwareInfoPage> createState() => _FirmwareInfoPageState();
}

class _FirmwareInfoPageState extends State<FirmwareInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 1,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Firmware Info',
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
        body: Container(
          margin: const EdgeInsets.only(left: 20, top: 0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              textWidget(16, FontWeight.bold, 'Basic Info', 0, 0, Colors.black),
              textWidget(14, FontWeight.normal, "Package Code", 10, 30,
                  Colors.grey.shade600),
              textWidget(14, FontWeight.normal, "D831100101", 10, 20,
                  Colors.grey.shade900),
              heightLineWidget(0, 15, 0, Colors.grey.shade300),
              textWidget(14, FontWeight.normal, "Package Version", 10, 20,
                  Colors.grey.shade600),
              textWidget(14, FontWeight.normal, "D831100101", 10, 20,
                  Colors.grey.shade900),
              heightLineWidget(0, 15, 0, Colors.grey.shade300),
            ],
          ),
        ));
  }
}
