// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class SetGeneralParameterPage extends StatefulWidget {
  const SetGeneralParameterPage({Key? key}) : super(key: key);
  @override
  _SetGeneralParameterPageState createState() =>
      _SetGeneralParameterPageState();
}

class _SetGeneralParameterPageState extends State<SetGeneralParameterPage> {
  List list = [
    "Charge Point Employ Info",
    "User Settable Max Current",
    "Electrical Grid Network Type"
  ];
  @override
  void initState() {
    super.initState();
  }

  ///列表Widget
  Widget getRow(int i) {
    return GestureDetector(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 16),
                  child: Text(
                    list[i],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(""),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, top: 12, right: 10, bottom: 2),
              // width: 40,
              height: 1,
              decoration: BoxDecoration(color: Colors.grey[350]),
            ),
          ],
        ),
        onTap: () {
          print('点击了第$i行');
        });
  }

  Widget title() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 15, right: 0, bottom: 20),
      child: const Text(
        "Charge Point Settings",
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w700,
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
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white, //修改颜色
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: list.length + 1,
              itemBuilder: (BuildContext context, int position) {
                if (position == 0) {
                  return title();
                } else {
                  return getRow(position - 1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
