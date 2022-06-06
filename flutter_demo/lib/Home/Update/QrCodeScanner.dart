import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_demo/NetWorkApi/NetWorkApiRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isSelected = false;
  static const String lightOpen = "lib/images/3.0x/light_open@3x.png";
  static const String lightColse = "lib/images/3.0x/light_close@3x.png";
  String imageName = lightColse;
  String sessionId = '';
  Future<void> _getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var sessionIdStr = prefs.getString('sessionId') ?? "";
      sessionId = sessionIdStr;
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  _getDevice(String code) {
    print("====$sessionId ====$code");
    Map<String, String> parameter = {"deviceNumber": code};

    NetWorkApiRequest.getDevice(sessionId, parameter).then((value) async {
      if (value != null && value['code'] == 0) {
        setState(() {
          String str = json.encode(value);
          print(str);
          Navigator.pushNamed(
            context,
            Routes.packageEditPage,
            arguments: {
              "type": 'type',
            },
          );
          // var ocppServerModel = ocppServerListModelFromJson(str);
          // for (var item in ocppServerModel.data.list) {
          //   item.isSelected = true;
          //   dataList.add(item);
          // }
          // for (int i = 0; i < ocppServerModel.data.list.length; i++) {
          //   widgets.add(getRow(i));
          // }
        });
      } else {
        LoadingUtils.showToast(value['msg']);
        controller!.resumeCamera();
      }
    }).catchError((e) {
      //失败
      LoadingUtils.showToast(e.toString());
      controller!.resumeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                leading: const BackButton(),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Container(
                margin: const EdgeInsets.only(top: 180),
                height: 40,
                child: const Text(
                  'Please put the barcode within frame to scan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: InkWell(
                  onTap: () async {
                    await controller?.toggleFlash();
                    setState(() {
                      isSelected = !isSelected;
                      if (isSelected) {
                        imageName = lightOpen;
                      } else {
                        imageName = lightColse;
                      }
                    });
                  },
                  child: FutureBuilder(
                    // future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Image.asset(
                        imageName,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170),
                height: 40,
                child: const Text(
                  'Scan Problem?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, Routes.inputSNManuallyPage);
                    });
                  },
                  child: const Text(
                    'Input SN manually',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      // decorationColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        // borderColor: Colors.red,
        borderRadius: 0,
        borderLength: 0,
        borderWidth: 0,
        cutOutWidth: MediaQuery.of(context).size.width - 60,
        cutOutHeight: 80,
        cutOutBottomOffset: 200,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code != null) {
          _getSessionId().then((value) {
            controller.pauseCamera();
            _getDevice(scanData.code!);
            print('扫描成功');
          });
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
