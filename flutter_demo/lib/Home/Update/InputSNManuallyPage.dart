import 'dart:io';
import 'package:flutter/material.dart';

class InputSNManuallyPage extends StatefulWidget {
  const InputSNManuallyPage({Key? key}) : super(key: key);
  @override
  State<InputSNManuallyPage> createState() => _InputSNManuallyPageState();
}

class _InputSNManuallyPageState extends State<InputSNManuallyPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {}
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
              margin: const EdgeInsets.only(top: 15),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
              child: Image.asset(
                "lib/images/3.0x/light_open@3x.png",
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'InputSNManuallyPage',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              alignment: Alignment.center,
            ),
          ],
        );
      }),
    );
  }
}
