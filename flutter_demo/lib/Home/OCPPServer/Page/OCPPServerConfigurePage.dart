import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Home/OCPPServer/Model/OCPPServerModel.dart';

class OCPPServerConfigurePage extends StatefulWidget {
  final Map arguments;
  const OCPPServerConfigurePage({Key? key, required this.arguments})
      : super(key: key);
  @override
  _OCPPServerConfigurePageState createState() =>
      _OCPPServerConfigurePageState();
}

class _OCPPServerConfigurePageState extends State<OCPPServerConfigurePage>
    with TickerProviderStateMixin {
  final callBluetoothSDK = CallBluetoothSDK();

  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";
  String imageName = switchOff;

  static const String identifyBgCompelete =
      "lib/images/3.0x/ocpp_identify_bg_compelete@3x.png";
  static const String identifyBgError =
      "lib/images/3.0x/ocpp_identify_bg_error@3x.png";
  static const String identifyBgLoading =
      "lib/images/3.0x/ocpp_identify_bg_loading@3x.png";
  static const String identifyBgNor =
      "lib/images/3.0x/ocpp_identify_bg_nor@3x.png";
  static const String identifySmallCompelete =
      "lib/images/3.0x/ocpp_identify_small_compelete@3x.png";
  static const String identifySmallError =
      "lib/images/3.0x/ocpp_identify_small_error@3x.png";
  static const String identifySmallSuccess =
      "lib/images/3.0x/ocpp_identify_small_success@3x.png";
  static const String processSmallCompelete =
      "lib/images/3.0x/ocpp_process_small_compelete@3x.png";
  static const String processSmallNor =
      "lib/images/3.0x/ocpp_process_small_nor@3x.png";
  static const String uploadSmallCompelete =
      "lib/images/3.0x/ocpp_upload_small_compelete@3x.png";
  static const String uploadSmallNor =
      "lib/images/3.0x/ocpp_upload_small_nor@3x.png";

  late AnimationController identifyAnimationController;
  late AnimationController uploadAnimationController;
  late AnimationController processController;
  late Animation<double> identifyAnimation;
  late Animation<double> uploadAnimation;
  late Animation<double> processAnimation;

  String identifyBigImageName = identifyBgLoading;
  String identifySmallImageName = identifySmallCompelete;
  String uploadBigImageName = identifyBgNor;
  String uploadSmallImageName = uploadSmallNor;
  String processBigImageName = identifyBgNor;
  String processSmallImageName = processSmallNor;

  Color identifyColor = Colors.black;
  Color uploadColor = Colors.black;
  Color processColor = Colors.black;

  ScrollController scrollController = ScrollController();

  TextEditingController editorController = TextEditingController();
  FocusNode editorFocusNode = FocusNode();

  bool isSelected = false;
  bool isEditor = false;
  bool isShowProcess = true;
  bool isHideConfigBtn = false;
  String domainStr = "";
  bool isRequestOCPPConfigParamsSuccess = false;
  late OCPPServerModel ocppServerModel;
  // String domainSuffixStr = "";

  @override
  void initState() {
    setState(() {
      ocppServerModel = widget.arguments["selectedCurrentModel"];
      domainStr = ocppServerModel.location;
    });
    queryEnableConfig();
    queryOCPPConfigParams();
    editorController.value = TextEditingValue(
      text: editorController.text,
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: editorController.text.length,
        ),
      ),
    );
    editorFocusNode.addListener(() {
      if (editorFocusNode.hasFocus == true) {
        setState(() {
          print("获取焦点");
        });
      } else {
        setState(() {
          print("失去焦点");
          setState(() {
            isEditor = false;
          });
        });
      }
    });

    identifyAnimationController = AnimationController(
        duration: const Duration(seconds: 300), vsync: this);

    identifyAnimation = Tween<double>(
      begin: 1,
      end: 300,
    ).animate(identifyAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成后反转
          identifyAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 反转回初始状态时继续播放，实现无限循环
          identifyAnimationController.forward();
        }
      });

    uploadAnimationController = AnimationController(
        duration: const Duration(seconds: 300), vsync: this);

    uploadAnimation = Tween<double>(
      begin: 1,
      end: 300,
    ).animate(uploadAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成后反转
          uploadAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 反转回初始状态时继续播放，实现无限循环
          uploadAnimationController.forward();
        }
      });

    processController = AnimationController(
        duration: const Duration(seconds: 300), vsync: this);

    processAnimation = Tween<double>(
      begin: 1,
      end: 300,
    ).animate(processController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成后反转
          processController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 反转回初始状态时继续播放，实现无限循环
          processController.forward();
        }
      });
    super.initState();
  }

  _switchClickAction() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        isHideConfigBtn = true;
        imageName = switchOn;
      } else {
        imageName = switchOff;
        isHideConfigBtn = false;
      }
    });
  }

  Future<void> editorClickAction() async {
    setState(() {
      print("点击了编辑按钮");
      isEditor = true;
    });
  }

  @override
  void dispose() {
    identifyAnimationController.dispose();
    uploadAnimationController.dispose();
    processController.dispose();
    super.dispose();
  }

  Future<void> queryEnableConfig() async {
    callBluetoothSDK.queryEnableConfig();
    delayedGetEnable();
    print('Flutter------free vending使能查询成功');
  }

  void delayedGetEnable() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getConfigServerEnable();
      return Future.value("延时4秒执行");
    });
  }

  Future<void> getConfigServerEnable() async {
    callBluetoothSDK.getConfigServerEnable().then((value) {
      setState(() {
        isSelected = value;
        isHideConfigBtn = value;
        if (value) {
          imageName = switchOn;
        } else {
          imageName = switchOff;
        }
      });
      print('Flutter------$value');
    });
  }

  Future<void> queryOCPPConfigParams() async {
    callBluetoothSDK.queryOCPPConfigParams();
    delayedGetDomainSuffix();
  }

  void delayedGetDomainSuffix() {
    Future.delayed(const Duration(milliseconds: 800), () {
      // callBluetoothSDK.getDomain().then((value) => {
      //       setState(() {
      //         domainStr = value;
      //       })
      //     });
      callBluetoothSDK.getDomainSuffix().then((value) => {
            setState(() {
              editorController.text = value;
            })
          });
      return Future.value("延时4秒执行");
    });
  }

  Future<void> requestOCPPConfigParams() async {
    callBluetoothSDK.requestOCPPConfigParams(
        "${widget.arguments["jsonStr"]}#${editorController.text}");
    delayedGetRequestOCPPConfigParamsSuccess();
  }

  void delayedGetRequestOCPPConfigParamsSuccess() {
    Future.delayed(const Duration(milliseconds: 800), () {
      callBluetoothSDK.isRequestOCPPConfigParamsSuccess().then((value) => {
            setState(() {
              isRequestOCPPConfigParamsSuccess = value;
            })
          });
      return Future.value("延时4秒执行");
    });
  }

  void configureAction() {
    requestOCPPConfigParams();
    setState(() {
      isShowProcess = false;
      isHideConfigBtn = false;
      scrollController.jumpTo(200);
    });
    myTimer();
  }

  myTimer() {
    // 定义一个函数，将定时器包裹起来
    var counter = 9;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      identifyAnimationController.forward();
      counter--;
      if (counter == 6) {
        print('Cancel timer');
        identifyAnimationController.stop();
        uploadAnimationController.forward();
        setState(() {
          identifyColor = const Color.fromARGB(229, 61, 33, 243);
          identifyBigImageName = identifyBgCompelete;
          identifySmallImageName = identifySmallSuccess;
          uploadBigImageName = identifyBgLoading;
          uploadSmallImageName = uploadSmallCompelete;
        });
      } else if (counter == 3) {
        uploadAnimationController.stop();
        processController.forward();
        setState(() {
          uploadColor = const Color.fromARGB(229, 61, 33, 243);
          uploadBigImageName = identifyBgCompelete;
          uploadSmallImageName = identifySmallSuccess;
          processBigImageName = identifyBgLoading;
          processSmallImageName = processSmallCompelete;
        });
        // timer.cancel();
      } else if (counter == 0) {
        if (isRequestOCPPConfigParamsSuccess) {
          setState(() {
            processColor = const Color.fromARGB(229, 61, 33, 243);
            processBigImageName = identifyBgCompelete;
            processSmallImageName = identifySmallSuccess;
          });
        } else {
          setState(() {
            processColor = Colors.red;
            processBigImageName = identifyBgError;
            processSmallImageName = identifySmallError;
          });
        }

        timer.cancel();
      }
    });
  }

  void okAction() {
    setState(() {
      isShowProcess = true;
      isHideConfigBtn = true;
      scrollController.jumpTo(0);
    });
  }

  Widget imageTitleWidget(String imageName, String title, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image(
            image: AssetImage(imageName),
            width: width,
            height: 48,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8, top: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget imageWidget() {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Row(
        children: [
          imageTitleWidget("lib/images/3.0x/original@3x.png", "Original", 38),
          imageTitleWidget("lib/images/3.0x/originalPass@3x.png", "", 60),
          imageTitleWidget("lib/images/3.0x/charger@3x.png", "Charger", 38),
          imageTitleWidget("lib/images/3.0x/chargerPass@3x.png", "", 60),
          imageTitleWidget("lib/images/3.0x/external@3x.png", "External", 38),
        ],
      ),
    ));
  }

  Widget externalWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        children: [
          const Text(
            "Enable external access",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const Expanded(
            child: Text(''), // 中间用Expanded控件
          ),
          SizedBox(
            width: 40,
            height: 25,
            // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: InkWell(
              onTap: () {
                _switchClickAction();
              },
              child: Image(
                image: AssetImage(imageName),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
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

  Widget heightLineWidget(double left, double top, double right, Color color) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right),
      height: 1,
      width: 500,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  // Renaming of OCPP Server
  Widget renamingWidget() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30, top: 14),
          child: const Text(
            "Renaming of OCPP Server",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5),
          child: const Image(
            image: AssetImage("lib/images/3.0x/tip@3x.png"),
            width: 12,
            height: 12,
          ),
        ),
      ],
    );
  }

  Widget renamingInputWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: editorController,
              focusNode: editorFocusNode,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              enableInteractiveSelection: isEditor,
              decoration: const InputDecoration(
                hintText: "E-mail address",
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                isDense: true,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: InkWell(
              onTap: () {
                editorClickAction().then((value) {
                  print("点击了");
                  FocusScope.of(context).requestFocus(editorFocusNode);
                });
              },
              child: const Image(
                image: AssetImage("lib/images/3.0x/editor@3x.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget configureProcessWidget(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
      child: Row(
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: Image(
              image: AssetImage("lib/images/3.0x/editor@3x.png"),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageTextWidget(String text, String bgImgStr, String smallImgStr,
      Animation<double> animation, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Stack(
              children: [
                Positioned(
                  child: Center(
                    child: RotationTransition(
                      //设置动画的旋转中心
                      alignment: Alignment.center,
                      //动画控制器
                      turns: animation,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(bgImgStr),
                            fit: BoxFit.cover,
                          ),
                          // color: Color(0xFFFF542C),
                          // borderRadius: BorderRadius.circular(1000)
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: IconButton(
                      icon: Image.asset(
                        smallImgStr,
                        fit: BoxFit.scaleDown,
                        width: 20,
                        height: 20,
                      ),
                      onPressed: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 0, right: 40),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget processWidget() {
    return Column(
      children: [
        imageTextWidget("Serial Number", identifyBigImageName,
            identifySmallImageName, identifyAnimation, identifyColor),
        imageTextWidget("Certificate Upload", uploadBigImageName,
            uploadSmallImageName, uploadAnimation, uploadColor),
        imageTextWidget("Configure Process", processBigImageName,
            processSmallImageName, processAnimation, processColor),
        configureWidget(150, 40, "OK", okAction),
      ],
    );
  }

  Widget configureWidget(
      double width, double height, String text, void Function() action) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 60),
        width: width,
        height: height,
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
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          onPressed: action,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        imageWidget(),
                        textWidget(
                            12.0,
                            FontWeight.w500,
                            "Enable this function to allow external organizations to access the EVSE.r",
                            10,
                            36,
                            Colors.black),
                        externalWidget(),
                        Offstage(
                          offstage: !isSelected,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget(15.0, FontWeight.w600, "Serial Number",
                                  20, 20, Colors.black),
                              textWidget(
                                  15.0,
                                  FontWeight.w500,
                                  widget.arguments["deviceNumber"],
                                  20,
                                  30,
                                  Colors.black),
                              textWidget(15.0, FontWeight.w600, "Server Info",
                                  20, 30, Colors.black),
                              textWidget(15.0, FontWeight.normal, domainStr, 20,
                                  30, Colors.black),
                              heightLineWidget(
                                  20, 14, 20, Colors.grey.shade400),
                              renamingWidget(),
                              textWidget(14.0, FontWeight.w500, "Alias", 30, 13,
                                  Colors.black),
                              renamingInputWidget(),
                              heightLineWidget(20, 0, 20, Colors.grey.shade400),
                              textWidget(
                                13.0,
                                FontWeight.w500,
                                "Supports letters and numbers , special characters:\$-_.+!*’(), Maximum 64 characters.",
                                30,
                                10,
                                Colors.grey.shade400,
                              ),
                              Offstage(
                                offstage: isShowProcess,
                                child: processWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !isHideConfigBtn,
              child: configureWidget(300, 40, "Configure", configureAction),
            )
          ],
        ),
      ),
    );
  }
}
