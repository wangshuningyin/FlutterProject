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
      body: const Text(
        'InputSNManuallyPage',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
