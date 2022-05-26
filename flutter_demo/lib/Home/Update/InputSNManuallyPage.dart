import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  RegExp englishRegExp = RegExp(r'(^[a-zA-Z]*$)');
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
    firstController.addListener(() {
      firstController.text.toUpperCase();
      print(firstController.text);
      if (firstController.text.length > 7) {}
    });
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
                  Container(
                    width: 70,
                    height: 30,
                    margin: const EdgeInsets.only(left: 5, top: 10, right: 0),
                    child: TextField(
                      controller: firstController,
                      focusNode: firstFocusNode,
                      autofocus: false,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "TACW22",
                        hintStyle: TextStyle(
                          color: Colors.grey[350],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(6) //限制长度
                      ],
                      onChanged: (value) {
                        ///禁止联想输入
                        if (firstController.text.length > 7) {
                          inputText = firstController.text.substring(0,6);
                          firstController.value = TextEditingValue(
                              text: inputText.toUpperCase(),
                              selection:  TextSelection.collapsed(
                                  offset: inputText.length));
                          return;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 5),
                    width: 20,
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 30,
                    margin: const EdgeInsets.only(left: 25, top: 10, right: 0),
                    child: TextField(
                      controller: secondController,
                      focusNode: secondFocusNode,
                      autofocus: false,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "40320",
                        hintStyle: TextStyle(
                          color: Colors.grey[350],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(5) //限制长度
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 5),
                    width: 20,
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 30,
                    margin: const EdgeInsets.only(left: 25, top: 10, right: 0),
                    child: TextField(
                      controller: thirdController,
                      focusNode: thirdFocusNode,
                      autofocus: false,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "T0023",
                        hintStyle: TextStyle(
                          color: Colors.grey[350],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(5) //限制长度
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 5),
              width: MediaQuery.of(context).size.width - 44,
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
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
    /// 判断当前输入框是否存在未完成的字符串
    if (newValue.isComposingRangeValid) return newValue;

    /// ①
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
