// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:flutter_demo/Utils/DatabaseHelper.dart';

class OCPPServerPage extends StatefulWidget {
  final Map arguments;
  const OCPPServerPage({Key? key, required this.arguments}) : super(key: key);
  @override
  _OCPPServerPageState createState() => _OCPPServerPageState();
}

class _OCPPServerPageState extends State<OCPPServerPage> {
  bool isCancleIconSelected = false;
  static const String delecteIcon = "lib/images/3.0x/ocpp_delecte_icon@3x.png";
  static const String cancleIcon = "lib/images/3.0x/ocpp_cancel_icon@3x.png";

  int currentIndex = 0;
  var selectedCurrentModel;

  String imageName = delecteIcon;
  String buttonText = "Next";
  Color btnBackgorondColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;
  List widgets = [];
  List deleteDataList = [];

  List ocppServerModelList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      getOCPPServerModels().then((value) => {
            for (int i = 1; i < ocppServerModelList.length; i++)
              {widgets.add(getRow(i))}
          });
    });
  }

  Future<void> getOCPPServerModels() async {
    var db = DatabaseHelper();
    var model = await db.queryOCPPServerModel();
    setState(() {
      ocppServerModelList.addAll(model);
    });
  }

  Future<void> deleteOCPPServerModels() async {
    var db = DatabaseHelper();
    var id;
    for (var item in deleteDataList) {
      id = await db.deleteOCPPServerModel(item);
    }
    if (id == 1) {
      LoadingUtils.showToast("Delete Success");
    }
    ocppServerModelList.clear();
    getData();
  }

  stringToBool(String msg) {
    if (msg == "true") {
      return true;
    } else {
      return false;
    }
  }

  ///列表Widget
  Widget getRow(int i) {
    return GestureDetector(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 5),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 65),
                    child: Text(
                      ocppServerModelList[i].location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      ocppServerModelList[i].domain,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: Text(""),
              ),
              Offstage(
                offstage: !stringToBool(ocppServerModelList[i].isSelected),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
            // width: 40,
            height: 1,
            decoration: BoxDecoration(color: Colors.grey[350]),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          if (isCancleIconSelected) {
            currentIndex = i;
            print(
                'Delete $i $isCancleIconSelected, ${stringToBool(ocppServerModelList[i].isSelected)}');
            setState(() {
              if (!stringToBool(ocppServerModelList[i].isSelected)) {
                print('选中');
                ocppServerModelList[i].isSelected = "true";
                btnBackgorondColor = Colors.red;
                btnTextColor = Colors.white;
                deleteDataList.add(ocppServerModelList[i]);
              } else {
                print('没选中');
                deleteDataList.remove(ocppServerModelList[i]);
                ocppServerModelList[i].isSelected = "false";
                for (var item in ocppServerModelList) {
                  if (item.isSelected == "true") {
                    btnBackgorondColor = Colors.red;
                    btnTextColor = Colors.white;
                    break;
                  } else {
                    btnBackgorondColor = Colors.grey.shade300;
                    btnTextColor = Colors.black;
                  }
                }
              }
            });
          } else {
            setState(() {
              btnBackgorondColor = Colors.red;
              btnTextColor = Colors.white;
              print("Next $i $isCancleIconSelected");
              currentIndex = i;
              selectedCurrentModel = ocppServerModelList[currentIndex];
              for (int i = 0; i < ocppServerModelList.length; i++) {
                if (i != currentIndex) {
                  setState(() {
                    ocppServerModelList[i].isSelected = "false";
                  });
                } else {
                  setState(() {
                    ocppServerModelList[i].isSelected = "true";
                  });
                }
              }
            });
          }
        });
      },
    );
  }

  Widget title() {
    return Row(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 20, top: 20, right: 0, bottom: 20),
          child: const Text(
            "Locally Cached Server",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Expanded(
          child: Text(''), // 中间用Expanded控件
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: InkWell(
            child: const Icon(Icons.add, color: Colors.red, size: 28),
            onTap: () {
              Navigator.pushNamed(context, Routes.ocppServerDownLoadPage)
                  .then((value) {
                ocppServerModelList.clear();
                getData();
                _deleteBtnState();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget footerWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 0, bottom: 40),
      width: 260,
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
          buttonText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: btnTextColor,
          ),
        ),
        onPressed: _clickAction,
      ),
    );
  }

  _clickAction() {
    if (isCancleIconSelected) {
      _deleteAction();
    } else {
      _nextAction();
    }
  }

  Function()? _nextAction() {
    if (selectedCurrentModel != null) {
      _seletedData();
    }
    return () {
      return null;
    };
  }

  _seletedData() {
    Navigator.pushNamed(
      context,
      Routes.ocppServerConfigurePage,
      arguments: {
        "deviceNumber": widget.arguments["deviceNumber"],
      },
    );
  }

  Function()? _deleteAction() {
    if (deleteDataList.isNotEmpty) {
      _deletedData();
    }
    return () {
      return null;
    };
  }

  _deletedData() {
    deleteOCPPServerModels();
  }

  _deleteBtnState() {
    selectedCurrentModel = null;
    imageName = delecteIcon;
    btnBackgorondColor = Colors.grey.shade300;
    btnTextColor = Colors.black;
    buttonText = "Next";
    for (var item in ocppServerModelList) {
      item.isSelected = "false";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'OCPP Server',
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
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              imageName,
              fit: BoxFit.scaleDown,
              width: 20,
              height: 20,
            ),
            onPressed: () {
              setState(() {
                isCancleIconSelected = !isCancleIconSelected;
                if (isCancleIconSelected) {
                  imageName = cancleIcon;
                  buttonText = "Delete";
                  btnBackgorondColor = Colors.grey.shade300;
                  btnTextColor = Colors.black;
                  for (var item in ocppServerModelList) {
                    item.isSelected = "false";
                  }
                } else {
                  selectedCurrentModel = null;
                  imageName = delecteIcon;
                  btnBackgorondColor = Colors.grey.shade300;
                  btnTextColor = Colors.black;
                  buttonText = "Next";
                  for (var item in ocppServerModelList) {
                    item.isSelected = "false";
                  }
                }
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: ocppServerModelList.length + 1,
              itemBuilder: (BuildContext context, int position) {
                if (position == 0) {
                  return title();
                } else {
                  return getRow(position - 1);
                }
              },
            ),
          ),
          footerWidget(),
        ],
      ),
    );
  }
}
