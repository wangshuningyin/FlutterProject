import 'package:flutter/material.dart';
import 'package:flutter_demo/CrossPlatformApi/api_flutter.dart';
import 'package:flutter_demo/CrossPlatformApi/api_generated.dart';
import 'package:flutter_demo/Home/Card/CardConfigurePage.dart';
import 'package:flutter_demo/Home/ChargerLink/APNConfigPage.dart';
import 'package:flutter_demo/Home/ChargerLink/WiFiInputPage.dart';
import 'package:flutter_demo/Home/ChargerLink/WiFiSettingPage.dart';
import 'package:flutter_demo/Home/DeviceMode/DeviceModePage.dart';
import 'package:flutter_demo/Home/FirmwareInfo/FirmwareInfoPage.dart';
import 'package:flutter_demo/Home/OCPPServer/Page/OCPPServerConfigurePage.dart';
import 'package:flutter_demo/Home/Settings/SetGeneralParameterPage.dart';
import 'package:flutter_demo/Home/Update/InputSNManuallyPage.dart';
import 'package:flutter_demo/Home/Update/PackageEditPage.dart';
import 'package:flutter_demo/Home/Update/QrCodeScanner.dart';
import 'package:flutter_demo/Home/Update/UpdatePage.dart';
import 'package:flutter_demo/Main/IndexPage.dart';
import 'package:flutter_demo/Me/PersonalCenterPage.dart';
import 'package:flutter_demo/Utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_demo/Home/ChargerLink/ChargerLinkPage.dart';
import 'package:flutter_demo/Home/DeviceInfo/DeviceInfoPage.dart';
import 'package:flutter_demo/Home/DeviceList/DeviceListPage.dart';
import 'package:flutter_demo/Home/LoadBalance/ModbusModePage.dart';
import 'package:flutter_demo/Home/LoadBalance/ModbusChargerPage.dart';
import 'package:flutter_demo/Home/LoadBalance/ModbusRtuPage.dart';
import 'package:flutter_demo/Home/LoadBalance/ModbusTcpPage.dart';
import 'package:flutter_demo/Home/LoadBalance/SmartMeterSelectionPage.dart';
import 'package:flutter_demo/Home/OCPPServer/Page/OCPPServerDownLoadPage.dart';
import 'package:flutter_demo/Home/OCPPServer/Page/OCPPServerPage.dart';
import 'package:flutter_demo/Login/UserLoginPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getString('sessionId') ?? "";
    return sessionId.isNotEmpty;
  }

  bool hasLogin = await isLogin();
  return runApp(
    MyApp(
      hasLogin: hasLogin,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.hasLogin}) : super(key: key);
  final bool hasLogin;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var routes = {
    Routes.userLoginPage: (BuildContext context) => const UserLoginPage(),
    Routes.deviceListPage: (BuildContext context) => const DeviceListPage(),
    Routes.homePage: (BuildContext context) => const Indexpage(),
    Routes.personCenterPage: (BuildContext context) =>
        const PersonalCenterPage(),
    Routes.deviceMode: (BuildContext context) => const DeviceModePage(),
    Routes.chargerLinkPage: (BuildContext context, {arguments}) =>
        ChargerLinkPage(arguments: arguments),
    Routes.deviceInfoPage: (BuildContext context, {arguments}) =>
        DeviceInfoPage(arguments: arguments),
    Routes.ocppServerPage: (BuildContext context, {arguments}) =>
        OCPPServerPage(arguments: arguments),
    Routes.ocppServerDownLoadPage: (BuildContext context) =>
        const OCPPServerDownLoadPage(),
    Routes.ocppServerConfigurePage: (BuildContext context, {arguments}) =>
        OCPPServerConfigurePage(arguments: arguments),
    Routes.modbusModePage: (BuildContext context) => const ModbusModePage(),
    Routes.modbusChargerPage: (BuildContext context, {arguments}) =>
        ModbusChargerPage(arguments: arguments),
    Routes.smartMeterSelection: (BuildContext context, {arguments}) =>
        SmartMeterSelectionPage(arguments: arguments),
    Routes.modbusRtuPage: (BuildContext context, {arguments}) =>
        ModbusRtuPage(arguments: arguments),
    Routes.modbusTcpPage: (BuildContext context) => const ModbusTcpPage(),
    Routes.firmwareInfoPage: (BuildContext context) => const FirmwareInfoPage(),
    Routes.cardConfigurePage: (BuildContext context) =>
        const CardConfigurePage(),
    Routes.setGeneralParameterPage: (BuildContext context) =>
        const SetGeneralParameterPage(),
    Routes.updatePage: (BuildContext context) => const UpdatePage(),
    Routes.qRViewExample: (BuildContext context) => const QrCodeScanner(),
    Routes.inputSNManuallyPage: (BuildContext context) =>
        const InputSNManuallyPage(),
    Routes.packageEditPage: (BuildContext context, {arguments}) =>
        PackageEditPage(arguments: arguments),
    Routes.apnConfigPage: (BuildContext context, {arguments}) =>
        APNConfigPage(arguments: arguments),
    Routes.wifiInputPage: (BuildContext context, {arguments}) =>
        WiFiInputPage(arguments: arguments),
    Routes.wifiSettingPage: (BuildContext context, {arguments}) =>
        WiFiSettingPage(arguments: arguments),
  };
  @override
  void initState() {
    super.initState();
    // ?????? method channel
    MyApi.setup(FTLApiManager());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: widget.hasLogin ? Routes.homePage : Routes.userLoginPage,
      onGenerateRoute: (RouteSettings settings) {
        final String? name = settings.name;
        final Function? pageContentBuilder = routes[name] as Function;
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            return MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context, arguments: settings.arguments),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => pageContentBuilder(context),
            );
          }
        }
      },
    );
  }
}
