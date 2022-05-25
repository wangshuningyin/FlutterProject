import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Login/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);
  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  //声明emailcontroller
  TextEditingController emailController = TextEditingController();
  //声明pswcontroller
  TextEditingController pswController = TextEditingController();
  //email焦点监听
  FocusNode emailFocusNode = FocusNode();
  //psw焦点监听
  FocusNode pswFocusNode = FocusNode();
  //校验email格式是否正确
  bool isEmailEnabled = true;
  //校验psw格式是否正确
  bool isPswEnabled = true;
  //是否登录成功
  bool isLoginSuccess = false;
  Color? btnBackgroundColor = Colors.grey[300];

  Color btnTitleColor = Colors.black;
  String titleStr =
      'Password contains 8 characters at least and must include 1 uppercase letter.';

  _loginData() {
    Map paras = {
      "authen": emailController.text,
      'pwd': md5.convert(utf8.encode(pswController.text)).toString()
    };
    NetWorkApiRequest.userLogin(paras).then((value) async {
      if (value != null && value['code'] == 0) {
        String sessionId = value["data"]["sessionId"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('sessionId', sessionId);
        //成功解析数据
        String str = json.encode(value);
        var userModel = userModelFromJson(str);
        prefs.setString("userInfo", json.encode(userModel)); //存Sring
        //导航到新路由
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homePage, (route) => false);
      } else {
        setState(() {
          isPswEnabled = false;
          titleStr = value['msg'];
          isLoginSuccess = true;
        });
      }
    }).catchError((e) {
      //失败
      setState(() {
        isPswEnabled = false;
        isLoginSuccess = true;
        titleStr = e.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus == true) {
        setState(() {
          isEmailEnabled = true;
        });
      } else {
        setState(() {
          isEmailEnabled = isEmail(emailController.text);
          if (emailController.text.isEmpty) {
            isEmailEnabled = true;
          }
          buttonColorSate();
        });
      }
    });
    emailController.addListener(() {
      setState(() {
        if (isEmail(emailController.text)) {
          isEmailEnabled = true;
        }
        buttonColorSate();
      });
    });
    /** 
      KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          setState(() {
            isEnabled = isEmail(emailController.text);
            if (emailController.text.isEmpty) {
              isEnabled = true;
            }
          });
        } else {
          print("键盘消失");
          setState(() {
            isEnabled = isEmail(emailController.text);
            if (emailController.text.isEmpty) {
              isEnabled = true;
            }
          });
        }
      },
    );
    */
    pswFocusNode.addListener(() {
      if (pswFocusNode.hasFocus == true) {
        setState(() {
          isPswEnabled = true;
          isLoginSuccess = isPswEnabled;
        });
      } else {
        setState(() {
          isPswEnabled = isPsw(pswController.text);
          isLoginSuccess = isPswEnabled;
          if (pswController.text.isEmpty) {
            isPswEnabled = true;
            isLoginSuccess = isPswEnabled;
          }
          buttonColorSate();
        });
      }
    });
    pswController.addListener(() {
      setState(() {
        if (isPsw(pswController.text)) {
          isPswEnabled = true;
          isLoginSuccess = isPswEnabled;
        }
        buttonColorSate();
      });
    });
  }

  void buttonColorSate() {
    if (isPsw(pswController.text) && isEmail(emailController.text)) {
      btnBackgroundColor = Colors.red;
      btnTitleColor = Colors.white;
    } else {
      btnBackgroundColor = Colors.grey[300];
      btnTitleColor = Colors.black;
    }
  }

  Function()? _pressButton() {
    if (!isEmailEnabled || !isLoginSuccess) {
      return null;
    }
    return () {
      _loginData();
    };
  }

  static bool isEmail(String input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (input.isEmpty) return false;
    return RegExp(regexEmail).hasMatch(input);
  }

  static bool isPsw(String input) {
    String regexEmail = ".*[A-Z]+.*";
    if (input.isEmpty || input.length < 8) return false;
    return RegExp(regexEmail).hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Image.asset(
                    "lib/images/3.0x/nebual_logo@3x.png",
                    fit: BoxFit.scaleDown,
                    width: 173,
                    height: 38,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "lib/images/3.0x/language_earth@3x.png",
                        fit: BoxFit.scaleDown,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'English',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.black54,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
            height: 3,
            width: 32,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 18),
            child: const Text(
              'Log in',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: TextField(
              controller: emailController,
              focusNode: emailFocusNode,
              autofocus: false,
              decoration: const InputDecoration(
                hintText: "E-mail address",
              ),
            ),
          ),
          Offstage(
            offstage: isEmailEnabled,
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 8, right: 20),
              child: const Text(
                'Invalid email address.',
                style: TextStyle(fontSize: 10, color: Colors.red),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: TextField(
              controller: pswController,
              focusNode: pswFocusNode,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
              obscureText: true,
            ),
          ),
          Offstage(
            offstage: isPswEnabled,
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 8, right: 20),
              child: Text(
                titleStr,
                style: const TextStyle(fontSize: 10, color: Colors.red),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 210),
            child: TextButton(
              child: const Text(
                "Forgot password？",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: 280,
              height: 38,
              child: ElevatedButton(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 13,
                    color: btnTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(btnBackgroundColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35))),
                ),
                onPressed: _pressButton(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
