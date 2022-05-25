import 'package:flutter/foundation.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';

// 实现 Flutter ApiGenerated 的接口
class FTLApiManager extends MyApi {
  @override
  Future<void> sessionInValid() async {
    if (kDebugMode) {
      print('Flutter====Call session invalid====');
    }
  }
}
