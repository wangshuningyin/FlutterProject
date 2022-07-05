import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Utils/routes.dart';

class WiFiSettingPage extends StatefulWidget {
  final Map arguments;
  const WiFiSettingPage({Key? key, required this.arguments}) : super(key: key);
  @override
  State<WiFiSettingPage> createState() => _WiFiSettingPageState();
}

class _WiFiSettingPageState extends State<WiFiSettingPage>
    with TickerProviderStateMixin {
  bool isHide = true;
  static const String loadingImage =
      "lib/images/3.0x/ocpp_identify_bg_loading@3x.png";
  final callBluetoothSDK = CallBluetoothSDK();

  late Timer _timer;
  late AnimationController animatioController;
  late Animation<double> animation;

  Future<void> configWIFIWithSSID() async {
    callBluetoothSDK.configWIFIWithSSID(
        widget.arguments["ssid"], widget.arguments["psw"]);
    delayedGetIsConfigAPNWithParamsSuccess();
    print('Flutter------free vending使能查询成功');
  }

  void delayedGetIsConfigAPNWithParamsSuccess() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      getIsConfigWIFIWithSSIDSuccess();
      return Future.value("延时1秒执行");
    });
  }

  Future<void> getIsConfigWIFIWithSSIDSuccess() async {
    callBluetoothSDK.isConfigWIFIWithSSIDSuccess().then((value) {
      animatioController.stop();
      setState(() {
        isHide = value;
      });
      if (!value) {
        showConfigFailedDialog();
      }
      print('Flutte 配置成功');
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}

    animatioController = AnimationController(
      duration: const Duration(seconds: 300),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 1,
      end: 300,
    ).animate(animatioController);
    animatioController.forward();
    myTimer();
  }

  @override
  void dispose() {
    super.dispose();
    animatioController.dispose();
    if (_timer.isActive) {
      // 判断定时器是否是激活状态
      _timer.cancel();
    }
  }

  myTimer() {
    // 定义一个函数，将定时器包裹起来
    var counter = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      counter--;
      if (counter == 6) {
        configWIFIWithSSID();
      }
    });
  }

  // 弹出对话框
  Future<void> showConfigFailedDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: const Text(
              "Set Failed!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: Text("取消"),
            //   onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            // ),
            Center(
              child: TextButton(
                child: const Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  //关闭对话框并返回true
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, Routes.chargerLinkPage,
                      arguments: widget.arguments);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget textWidget(double top, double left, String text, double fontSize,
      Color color, FontWeight fontWeight) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: 20),
      height: 30,
      width: 500,
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

  Widget animationWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 80, right: 20),
      child: Column(
        // width: 80,
        // height: 80,
        children: [
          Stack(
            children: [
              Positioned(
                child: Center(
                  child: RotationTransition(
                    //设置动画的旋转中心
                    alignment: Alignment.center,
                    //动画控制器
                    turns: animation,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(loadingImage),
                          fit: BoxFit.cover,
                        ),
                        // color: Color(0xFFFF542C),
                        // borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
            child: const Text(
              "This may need a few minutes",
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 7, 113, 235),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget configurationDoneWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 80, right: 20),
          width: 144,
          height: 166,
          child: const Image(
            image: AssetImage(
                "lib/images/3.0x/wifi_config_complete_success@3x.png"),
            fit: BoxFit.cover,
          ),
          // color: Color(0xFFFF542C),
          // borderRadius: BorderRadius.circular(1000)
        ),
        Offstage(
          offstage: !isHide,
          child: Container(
            margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
            child: const Text(
              "This may need a few minutes",
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 7, 113, 235),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Offstage(
          offstage: !isHide,
          child: configureWidget(180, 42, "OK"),
        ),
      ],
    );
  }

  Widget configureWidget(double width, double height, String text) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 70, bottom: 60),
        width: width,
        height: height,
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
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
          'Device Mode',
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
          textWidget(20, 20, "Wi-Fi  Configuration", 18, Colors.black,
              FontWeight.bold),
          Offstage(
            offstage: !isHide,
            child: animationWidget(),
          ),
          Offstage(
            offstage: isHide,
            child: configurationDoneWidget(),
          ),
        ],
      ),
    );
  }
}
