import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Utils/routes.dart';
// import 'package:barcode_scan/barcode_scan.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Future<void> queryEnableConfig() async {
    final callBluetoothSDK = CallBluetoothSDK();
    callBluetoothSDK.scanQRCode();
  }

  @override
  void initState() {
    super.initState();
    print("执行顺序");
  }

  //扫描二维码
  // static Future<String?> getQrcodeState() async {
  //   try {
  //     const ScanOptions options = ScanOptions(
  //       strings: {
  //         'cancel': '取消',
  //         'flash_on': '开启闪光灯',
  //         'flash_off': '关闭闪光灯',
  //       },
  //     );
  //     final ScanResult result = await BarcodeScanner.scan(options: options);
  //     return result.rawContent;
  //   } catch (e) {}
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Update',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.qRViewExample);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'lib/images/3.0x/home_scan@3x.png',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 57,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Scan or manuallly input serial number to get a match update package',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
