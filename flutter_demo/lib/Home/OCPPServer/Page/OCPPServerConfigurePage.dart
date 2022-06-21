import 'package:flutter/material.dart';

class OCPPServerConfigurePage extends StatefulWidget {
  const OCPPServerConfigurePage({Key? key}) : super(key: key);
  @override
  _OCPPServerConfigurePageState createState() =>
      _OCPPServerConfigurePageState();
}

class _OCPPServerConfigurePageState extends State<OCPPServerConfigurePage> {
  bool isSelected = true;
  static const String switchOff = "lib/images/3.0x/switch_off@3x.png";
  static const String switchOn = "lib/images/3.0x/switch_on@3x.png";
  String imageName = switchOn;

  TextEditingController editorController = TextEditingController();
  FocusNode editorFocusNode = FocusNode();
  bool isEditor = false;
  @override
  void initState() {
    // editorFocusNode.unfocus();
    // editorFocusNode.canRequestFocus = false;
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    String textStr = "TACW2240320T0023";
    editorController.text = textStr;

    editorController.value = TextEditingValue(
        text: textStr,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: textStr.length)));
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
    // editorController.addListener(() {
    //   setState(() {
    //     print("开始编辑");
    //   });
    // });
    // setState(() {
    //   if (Platform.isIOS) {
    //     print("objectToJson(UserInfo())");
    //   }
    // });
    super.initState();
  }

  _switchClickAction() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        imageName = switchOn;
      } else {
        imageName = switchOff;
      }
    });
  }

  Future<void> editorClickAction() async {
    setState(() {
      print("dianji");
      isEditor = true;
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

  Widget configureWidget() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 60),
        width: 300,
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
            "Configure",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            print("objectToJson(UserInfo())");
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
                              textWidget(15.0, FontWeight.w500,
                                  "TACW22-4-0320-T0023", 20, 30, Colors.black),
                              textWidget(15.0, FontWeight.w600, "Server Info",
                                  20, 30, Colors.black),
                              textWidget(
                                  15.0,
                                  FontWeight.normal,
                                  "https://new.evsync.com",
                                  20,
                                  30,
                                  Colors.black),
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
                              configureProcessWidget("Security Identify"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            configureWidget(),
          ],
        ),
      ),
    );
  }
}
