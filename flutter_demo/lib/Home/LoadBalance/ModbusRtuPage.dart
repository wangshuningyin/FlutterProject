import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Utils/DataPickerTool.dart';
import 'package:flutter_demo/Home/LoadBalance/ModbusModePage.dart';

class ModbusRtuPage extends StatefulWidget {
  final Map type;
  const ModbusRtuPage({Key? key, required this.type}) : super(key: key);
  @override
  State<ModbusRtuPage> createState() => _ModbusRtuPageState();
}

class _ModbusRtuPageState extends State<ModbusRtuPage> {
  var singlePrimaryList = [
    "",
    "",
    "",
    'Charger Modbus Address',
    'Baud Rate',
    'Parity',
    'Stop Bits',
    'Data Bits',
    "",
    "Electrical Capacity(A)",
    "Load Threshold(A)",
    "power Decrease Baseline(%)",
  ];

  var multiplePrimaryList = [
    "",
    "",
    "",
    'Charger Modbus Address',
    'Baud Rate',
    'Parity',
    'Stop Bits',
    'Data Bits',
  ];

  var contentList = [
    "",
    "",
    "",
    "1",
    "9600",
    "None",
    "1",
    "8",
    "",
    "--",
    "80%",
    "70%",
  ];
  List<String> valueList = [];

  TextEditingController addressController = TextEditingController();
  FocusNode addressFocusNode = FocusNode();
  TextEditingController capacityController = TextEditingController();
  FocusNode capacityFocusNode = FocusNode();

  Color btnBackgorondColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    print(widget.type);
    addressController.text = '1';
    capacityController.text = '--';
    capacityController.addListener(() {
      setState(() {
        if (capacityController.text.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
          contentList[9] = capacityController.text;
        }
      });
    });
  }

  List<Widget> _getListData(List list) {
    List<Widget> widgetList = [];
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        widgetList.add(heightLineWidget(
            20, 10, MediaQuery.of(context).size.width - 50, Colors.red));
      } else if (i == 1) {
        widgetList.add(textWidget(
            19, FontWeight.bold, 'Modbus RTU(RS485)', 20, 12, Colors.black));
      } else if (i == 2) {
        widgetList.add(textWidget(15, FontWeight.w600, "Communication Settings",
            20, 14, Colors.grey.shade900));
      } else if (i == 8) {
        widgetList.add(textWidget(15, FontWeight.w600,
            "Load Management Settings", 20, 14, Colors.grey.shade900));
      } else if (i == 3) {
        widgetList
            .add(editorWidget(list[i], 0, addressController, addressFocusNode));
      } else if (i == 9) {
        widgetList.add(
            editorWidget(list[i], 0, capacityController, capacityFocusNode));
      } else {
        widgetList.add(selectedWidget(list[i], 0, i));
      }
    }
    return widgetList;
  }

  Function()? _saveAction() {
    if (contentList[9] == '--') {
      return () {
        return null;
      };
    }
    return () {
      Navigator.pushNamed(context, Routes.modbusTcpPage);
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

  Widget selectedWidget(String title, double top, i) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: top, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(13, FontWeight.w500, title, 5, 10, Colors.grey),
          Container(
            margin: const EdgeInsets.only(left: 5, top: 2, right: 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    contentList[i],
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 25,
                  // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: InkWell(
                    onTap: () {
                      if (i == 4) {
                        valueList = [
                          "1200",
                          "2400",
                          "4800",
                          "9600",
                          "19200",
                          "38400",
                          "57600",
                          "115200"
                        ];
                      } else if (i == 5) {
                        valueList = ["None", "Odd", "Even"];
                      } else if (i == 6) {
                        valueList = ["1", "2"];
                      } else if (i == 7) {
                        valueList = ["8"];
                      } else {
                        valueList = [
                          "20%",
                          "30%",
                          "40%",
                          "50%",
                          "60%",
                          "70%",
                          "80%",
                          "90%"
                        ];
                      }
                      DataPickerTool.show(context,
                          list: valueList,
                          onSelectedItemChanged: (v) {}, confirmClick: (v) {
                        setState(() {
                          contentList[i] = valueList[v];
                          print(i);
                        });
                      });
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

  Widget editorWidget(String title, double top,
      TextEditingController controller, FocusNode focusNode) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: top, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(13, FontWeight.w500, title, 5, 10, Colors.grey),
          Container(
            margin: const EdgeInsets.only(left: 5, top: 2, right: 0),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                // contentPadding:
                // EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                isDense: true,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
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
                    _getListData(widget.type['type'] ==
                            LoadBalanceSourceType
                                .LoadBalanceSourceTypeSinglePrimary
                        ? singlePrimaryList
                        : multiplePrimaryList),
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
