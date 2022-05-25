import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:crypto/crypto.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:file_utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_demo/Utils/LoadingUtils.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class DioManager {
  ///根地址

  static const base_Url = "https://testabb.installer.api.chargedot.com:28971/";
  static const kAppName = 'NEBULARAPP';
  static const kKey = 'XAH6ZTkxODIJKzTzZdfp8XPlOTc90MV4';
  static var cookieJar = CookieJar();
  late Dio _dio;
  late DioManager _instance;
  late BaseOptions _baseOptions;

  DioManager getInstance() {
    _instance;
    return _instance;
  }

  DioManager(String str) {
    var timeInterval = DateTime.now().microsecondsSinceEpoch / 1000000;
    var password = md5.convert(utf8.encode('$kAppName$timeInterval$kKey'));
    var base64AuthCredentials =
        convert.base64Encode(utf8.encode('$kAppName:$password'));
    var basicStr = 'Basic $base64AuthCredentials';
    _baseOptions = BaseOptions(
        baseUrl: base_Url,
        connectTimeout: 5000 * 2,
        receiveTimeout: 5000 * 2,
        headers: {
          'r': '$timeInterval',
          'LANGUAGE': '1',
          'appType': 'abb',
          'Authorization': basicStr,
          'SESSIONID': str,
        });

    _dio = Dio(_baseOptions)
      ..interceptors.add(CookieManager(cookieJar)); //添加cookieJar  拦截器也可以在这里添加
  }

  /// get请求
  get(url, {data, options, withLoading = true}) async {
    if (withLoading) {
      LoadingUtils.show(showMsg: "加载中...");
    }

    print('getRequest:==>path:${url}   params:${data}');
    Response response = Response(requestOptions: options);
    try {
      response = await _dio.get(url, queryParameters: data, options: options);
      print('getResponse==>:${response.data}');
      if (withLoading) {
        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      print('getError:==>errorType:${e.type}   errorMsg:${e.message}');
      if (withLoading) {
        LoadingUtils.dismiss();
      }
    }

    ///response.data  请求成功是一个map最终需要将map进行转换 , 请求失败直接返回null
    ///map:转换 ,将List中的每一个条目执行 map方法参数接收的这个方法,这个方法返回T类型，
    ///map方法最终会返回一个  Iterable<T>
    return response.data;
  }

  /// Post请求
  post(url,
      {required Map<String, dynamic> parameters,
      dynamic data,
      options,
      withLoading = true}) async {
    Options(headers: {'Content-Type': 'application/json'});
    if (withLoading) {
      LoadingUtils.show(showMsg: "加载中...");
    }
    print('postRequest:==>path:${url}   params:${data}');
    // Response response = Response(requestOptions: options);
    try {
      final response = await _dio.post(url,
          queryParameters: parameters,
          data: data,
          options: options ?? Options());
      print('postResponse==>:${response.data}');
      if (withLoading) {
        LoadingUtils.dismiss();
      }

      /// response.data  请求成功是一个map最终需要将map进行转换 , 请求失败直接返回null
      /// map:转换 ,将List中的每一个条目执行 map方法参数接收的这个方法,这个方法返回T类型，
      /// map方法最终会返回一个  Iterable<T>
      return response.data;
    } on DioError catch (e) {
      print('postError:==>errorType:${e.type}   errorMsg:${e.message}');
      if (withLoading) {
        LoadingUtils.dismiss();
      }
      return e;
    }
  }

  downloadFile(String fileURl, String fileName) async {
    Dio dio = Dio();
    String dirloc = "";
    String saveFilePath = "";
    String path = "";
    double progress = 0;
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getTemporaryDirectory()).path;
    }
    try {
      //2、创建文件
      FileUtils.mkdir([dirloc]);
      //3、使用 dio 下载文件
      final response = await dio.download(fileURl, dirloc + fileName + ".mp3",
          onReceiveProgress: (receivedBytes, totalBytes) {
        //4、连接资源成功开始下载后更新状态
        progress = (receivedBytes / totalBytes);
        saveFilePath = dirloc + fileName + ".mp3";
      });
      return response.data;
    } on DioError catch (e) {
      return e;
    }
  }
}
