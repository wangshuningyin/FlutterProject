import 'DioManagerUtils.dart';

class NetWorkApiRequest {
  ///登录
  static userLogin(Map paras) async {
    return await DioManager("")
        .post('/api/v3/user/user/login', data: paras, parameters: {});
  }

  ///退出登录
  static userLoginOut(String srt) async {
    return await DioManager(srt)
        .post('api/v3/user/user/logout', parameters: {});
  }

  ///获取 ocpp server 配置列表
  static getServerDomain(String str, Map<String, dynamic> parameter) async {
    return await DioManager(str).post('api/v3/server/domain/get',
        data: parameter, parameters: parameter);
  }

  ///文件下载
  static downloadBleFileWithURL(String fileURl, String fileName) async {
    return await DioManager('').downloadFile(fileURl, fileName);
  }

  ///更新设备信息
  static updateDevice(String str, Map<String, dynamic> parameter) async {
    return await DioManager(str).post('api/v3/device/device/update',
        data: parameter, parameters: parameter);
  }

  ///获取设备信息
  static getDevice(String str, Map<String, dynamic> parameter) async {
    return await DioManager(str).post('api/v3/device/device/info',
        data: parameter, parameters: parameter);
  }
}
