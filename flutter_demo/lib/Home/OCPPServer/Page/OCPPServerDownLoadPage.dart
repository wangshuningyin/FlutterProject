// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:flutter_demo/Utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';
import 'package:flutter_demo/Home/OCPPServer/Model/OCPPServerModel.dart';
import 'package:flutter_demo/Home/OCPPServer/Model/OCPPServerListModel.dart';

class OCPPServerDownLoadPage extends StatefulWidget {
  const OCPPServerDownLoadPage({Key? key}) : super(key: key);
  @override
  _OCPPServerDownLoadPage createState() => _OCPPServerDownLoadPage();
}

class _OCPPServerDownLoadPage extends State<OCPPServerDownLoadPage> {
  List widgets = [];
  List dataList = [];
  List ocppServerModelList = [];
  bool isSelected = true;
  String sessionId = '';
  int currentIndex = 0;
  var currentPage;
  Future<void> _getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var sessionIdStr = prefs.getString('sessionId') ?? "";
      sessionId = sessionIdStr;
    });
  }

  ///获取ServerDomain数据
  _getServerDomainData() {
    Map<String, dynamic> parameter = {"deviceNumber": "TACW2244719T2347"};
    NetWorkApiRequest.getServerDomain(sessionId, parameter).then((value) async {
      if (value != null && value['code'] == 0) {
        setState(() {
          String str = json.encode(value);
          var ocppServerModel = ocppServerListModelFromJson(str);
          for (var item in ocppServerModel.data.list) {
            item.isSelected = true;
            dataList.add(item);
          }
          for (int i = 0; i < ocppServerModel.data.list.length; i++) {
            widgets.add(getRow(i));
          }
        });
      } else {
        LoadingUtils.showToast(value['msg']);
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _getSessionId().then((value) {
      _getServerDomainData();
    });
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
                      dataList[i].location,
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
                      dataList[i].domain,
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
                offstage: dataList[i].isSelected,
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
          currentIndex = i;
          currentPage = dataList[currentIndex];
          for (int i = 0; i < dataList.length; i++) {
            if (i != currentIndex) {
              dataList[i].isSelected = true;
            } else {
              dataList[i].isSelected = false;
            }
          }
        });
      },
    );
  }

  ///列表头部
  Widget headerWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 0, bottom: 20),
      child: const Text(
        "Download Server Info",
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  ///列表底部下载按钮
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
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        ),
        child: const Text(
          "Download",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          if (currentPage.tls == 1) {
            _downloadFile();
          } else {
            LoadingUtils.showToast("Download Success!");
            _insertData(currentIndex);
          }
        },
      ),
    );
  }

  ///下载文件数据
  _downloadFile() async {
    NetWorkApiRequest.downloadBleFileWithURL(currentPage.url, "").then((value) {
      //成功(value
      if (value.statusCode == 200) {
        LoadingUtils.showToast("Download Success!");
        _insertData(currentIndex);
      } else {
        LoadingUtils.showToast(value.msg);
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
    });
  }

  void _insertData(index) async {
    var db = DatabaseHelper();
    OCPPServerModel todo = OCPPServerModel(
        dataList[index].id.toString(),
        dataList[index].name,
        dataList[index].domain,
        dataList[index].port.toString(),
        dataList[index].type,
        dataList[index].version,
        dataList[index].tls.toString(),
        dataList[index].execute.toString(),
        dataList[index].certId.toString(),
        dataList[index].passphrase,
        dataList[index].passSupprot.toString(),
        dataList[index].aliasNumber,
        dataList[index].location,
        dataList[index].applyVersion,
        dataList[index].code,
        dataList[index].url,
        dataList[index].isSelected.toString());
    await db.saveOCPPServerModel(todo);
    Navigator.pop(context, true);
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
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length + 1,
              itemBuilder: (BuildContext context, int position) {
                if (position == 0) {
                  return headerWidget();
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
