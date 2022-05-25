import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:flutter_demo/Login/UserModel.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';

class PersonalCenterPage extends StatefulWidget {
  const PersonalCenterPage({Key? key}) : super(key: key);
  @override
  _PersonalCenterPageState createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  UserInfo userInfo = UserInfo();
  String sessionId = '';
  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var userStr = prefs.getString('userInfo') ?? "";
      var userModel = userModelFromJson(userStr);
      userInfo = userModel.data.userInfo;
      sessionId = userModel.data.sessionId;
    });
  }

  _loginOutData(BuildContext context) {
    NetWorkApiRequest.userLoginOut(sessionId).then((value) async {
      if (value != null && value['code'] == 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('sessionId', "");
        print("当前值: " + prefs.setString('sessionId', "").toString());
        Navigator.popAndPushNamed(context, Routes.userLoginPage);
      } else {
        LoadingUtils.showToast(value['msg']);
      }
    }).catchError((e) {
      LoadingUtils.showToast(e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  userInfo.name,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(userInfo.authen),
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.account_balance,
                    color: Colors.red,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  title: Container(
                    transform: Matrix4.translationValues(-20, 0.0, 0.0),
                    child: const Text("My Account"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 1),
                  color: Colors.grey,
                  height: 0.5,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  title: Container(
                    transform: Matrix4.translationValues(-20, 0.0, 0.0),
                    child: const Text("setting"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 1),
                  color: Colors.grey,
                  height: 0.5,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.disabled_by_default,
                    color: Colors.red,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  title: Container(
                    transform: Matrix4.translationValues(-20, 0.0, 0.0),
                    child: const Text("App Version"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 1),
                  color: Colors.grey,
                  height: 0.5,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  title: Container(
                    transform: Matrix4.translationValues(-20, 0.0, 0.0),
                    child: const Text("Log Out"),
                  ),
                  onTap: () {
                    _loginOutData(context);
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 1),
                  color: Colors.grey,
                  height: 0.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
