import 'package:flutter/material.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({Key? key}) : super(key: key);
  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  List widgets = [];
  List<String> titles = [
    "",
    "Serial Number",
    "Product Type",
    "Performance",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];

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
    "",
    "Type",
    "Status",
    ""
  ];

  List<String> titleValues = [
    "",
    "TACW22-4-0320-T0023",
    "TACW22-T-R-0",
    "22kW",
    "32A",
    "3",
    "type-2 socket with shutter",
    "4G Wi-Fi LAN",
    "MID PTB",
    "",
    "Lan",
    "Not Connected",
    ""
  ];

  List<bool> offstageTitle = [
    true,
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> offstageValue = [
    true,
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true,
    false,
    false,
    true
  ];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < titles.length; i++) {
      widgets.add(getRow(i));
    }
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Offstage(
            offstage: offstageTitle[i],
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                titles[i],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  titleContents[i],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const Expanded(
                child: Text(''), // 中间用Expanded控件
              ),
              Offstage(
                offstage: offstageValue[i],
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Text(
                    titleValues[i],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            // width: 40,
            height: 1,
            decoration: BoxDecoration(color: Colors.grey[350]),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length + 1));
          print('row $i');
        });
      },
    );
  }

  Widget title(String title, bool offstage) {
    return Row(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(
          child: Text(''), // 中间用Expanded控件
        ),
        SizedBox(
          width: 40,
          height: 25,
          // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: InkWell(
            child: Offstage(
              offstage: offstage,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ),
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
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          if (position == 0 || position == 9 || position == 12) {
            if (position == 0) {
              return title("Basic Info", true);
            } else if (position == 9) {
              return title("Internect Connection", true);
            } else {
              return title("Device Log", false);
            }
          } else {
            return getRow(position);
          }
        },
      ),
    );
  }
}
