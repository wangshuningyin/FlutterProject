// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';

class PackageEditPage extends StatefulWidget {
  final Map type;
  const PackageEditPage({Key? key, required this.type}) : super(key: key);
  @override
  State<PackageEditPage> createState() => _PackageEditPageState();
}

class _PackageEditPageState extends State<PackageEditPage> {
  List widgets = [];
  List<String> titleContents = [
    "",
    "TACW22-4-0320-T0023",
    "TACW22-T-R-0",
    "Max Power",
    "Max Current",
    "Phases",
    "Outlet",
    "Internet suppot",
    "Certification",
  ];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < titleContents.length; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          title(titleContents[i], 34, 20, 30, Colors.black, 13, Icons.done),
          heightLineWidget(20, 0, 10, Colors.grey),
        ],
      ),
      onTap: () {
        setState(() {
          print('row $i');
        });
      },
    );
  }

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 0.5,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  Widget textWidget(double fontSize, FontWeight fontWeight, String text,
      double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
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

  Widget listWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
            14,
            FontWeight.w600,
            "Please do not plug in before and during the update process.",
            20,
            20,
            10,
            Colors.red),
        textWidget(
            16, FontWeight.bold, "Serial Number", 20, 20, 10, Colors.black),
        textWidget(15, FontWeight.normal, "TACW22-4-0320-T0023", 30, 20, 10,
            Colors.black),
        title("Downloaded Packages", 20, 20, 30, Colors.black, 16, Icons.add),
      ],
    );
  }

  Widget emptyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
            14,
            FontWeight.w600,
            "Tap '+' to download packages and update your charger's firmware.",
            30,
            80,
            20,
            Colors.black),
      ],
    );
  }

  Widget title(String title, double left, double top, double right, Color color,
      double fontSize, IconData icon) {
    return Row(
      children: [
        Container(
          margin:
              EdgeInsets.only(left: left, top: top, right: right, bottom: 20),
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(
          child: Text(''), // 中间用Expanded控件
        ),
        SizedBox(
          width: 40,
          height: 25,
          child: InkWell(
            child: Icon(
              icon,
              color: Colors.red,
              size: 24,
            ),
            onTap: () {
              print("点击了");
            },
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
        itemCount: widget.type["type"] == "type" ? 2 : widgets.length,
        itemBuilder: (BuildContext context, int position) {
          if (position == 0) {
            return listWidget();
          } else {
            if (widget.type["type"] == 'type') {
              return emptyWidget();
            } else {
              return getRow(position);
            }
          }
        },
      ),
    );
  }
}
