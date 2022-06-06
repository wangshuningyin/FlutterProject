import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputSNManuallyPage extends StatefulWidget {
  const InputSNManuallyPage({Key? key}) : super(key: key);
  @override
  State<InputSNManuallyPage> createState() => _InputSNManuallyPageState();
}

class _InputSNManuallyPageState extends State<InputSNManuallyPage> {
  TextEditingController firstController = TextEditingController();
  FocusNode firstFocusNode = FocusNode();
  TextEditingController secondController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  TextEditingController thirdController = TextEditingController();
  FocusNode thirdFocusNode = FocusNode();
  String inputText = '';
  String fristInputText = '';
  String secondInputText = '';
  String thridInputText = '';
  String selectedManufactureStr = '';
  String selectedModelStr = '';
  Color btnBackgorondColor = Colors.grey.shade300;
  Color btnTextColor = Colors.black;
  String sessionId = '';
  Future<void> _getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var sessionIdStr = prefs.getString('sessionId') ?? "";
      sessionId = sessionIdStr;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    firstController.addListener(() {
      setState(() {
        fristInputText = firstController.text;
        if (fristInputText.isEmpty ||
            secondInputText.isEmpty ||
            thridInputText.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
    secondController.addListener(() {
      setState(() {
        secondInputText = secondController.text;
        if (fristInputText.isEmpty ||
            secondInputText.isEmpty ||
            thridInputText.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
    thirdController.addListener(() {
      thridInputText = thirdController.text;
      setState(() {
        thridInputText = thirdController.text;
        if (fristInputText.isEmpty ||
            secondInputText.isEmpty ||
            thridInputText.isEmpty) {
          btnBackgorondColor = Colors.grey.shade300;
          btnTextColor = Colors.black;
        } else {
          btnBackgorondColor = Colors.red;
          btnTextColor = Colors.white;
        }
      });
    });
  }

  Function()? _saveAction() {
    print(thirdController.text);
    if (fristInputText.isEmpty ||
        secondInputText.isEmpty ||
        thridInputText.isEmpty) {
      return () {
        return null;
      };
    }
    return () {
      _getSessionId().then((value) {
        _getDevice('$fristInputText$secondInputText$thridInputText');
      });
    };
  }

  _getDevice(String code) {
    print("====$sessionId ====$code");
    Map<String, String> parameter = {"deviceNumber": code};

    NetWorkApiRequest.getDevice(sessionId, parameter).then((value) async {
      if (value != null && value['code'] == 0) {
        setState(() {
          String str = json.encode(value);
          print(str);
          // var ocppServerModel = ocppServerListModelFromJson(str);
          // for (var item in ocppServerModel.data.list) {
          //   item.isSelected = true;
          //   dataList.add(item);
          // }
          // for (int i = 0; i < ocppServerModel.data.list.length; i++) {
          //   widgets.add(getRow(i));
          // }
          Navigator.pushNamed(
            context,
            Routes.packageEditPage,
            arguments: {
              "type": 'type',
            },
          );
        });
      } else {
        LoadingUtils.showToast(value['msg']);
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
    });
  }

  Widget textEditingWidget(
    String hintText,
    double left,
    double top,
    TextEditingController controller,
    FocusNode focusNode,
    int limitLength,
    double textLength,
    FocusNode requestFocus,
  ) {
    return Container(
      width: 70,
      height: 30,
      margin: EdgeInsets.only(left: left, top: top, right: 0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: false,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[350],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputFormatters: <TextInputFormatter>[
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(limitLength) //限制长度
        ],
        onChanged: (value) {
          if (controller.text.length > textLength) {
            inputText = controller.text.substring(0, limitLength);
            controller.value = TextEditingValue(
              text: inputText.toUpperCase(),
              selection: TextSelection.collapsed(offset: inputText.length),
            );
            return;
          }
          if (controller.text.length >= limitLength) {
            focusNode.unfocus();
            FocusScope.of(context).requestFocus(requestFocus);
          }
        },
      ),
    );
  }

  Widget lineWidget(
      double left, double top, Color color, double width, double height) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget saveWidget() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60, bottom: 40),
        width: 140,
        height: 40,
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
            "OK",
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
      resizeToAvoidBottomInset: false,
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
      body: Builder(builder: (context) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
              child: Image.asset(
                "lib/images/3.0x/abb_input@3x.png",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width - 100,
                height: 200,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              width: MediaQuery.of(context).size.width - 44,
              child: const Text(
                'Enter SN(Serial Number) ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, top: 5),
              child: Row(
                children: [
                  textEditingWidget("TACW22", 5, 10, firstController,
                      firstFocusNode, 6, 7, secondFocusNode),
                  lineWidget(16, 5, Colors.black, 20, 1.5),
                  textEditingWidget("40320", 32, 10, secondController,
                      secondFocusNode, 5, 6, thirdFocusNode),
                  lineWidget(6, 5, Colors.black, 20, 1.5),
                  textEditingWidget("T0023", 26, 10, thirdController,
                      thirdFocusNode, 5, 6, thirdFocusNode),
                ],
              ),
            ),
            lineWidget(20, 5, Colors.grey,
                MediaQuery.of(context).size.width - 44, 0.5),
            saveWidget(),
          ],
        );
      }),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.isComposingRangeValid) return newValue;
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
