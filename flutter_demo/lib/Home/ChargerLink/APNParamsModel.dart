// To parse this JSON data, do
//
//     final apnParamsModel = apnParamsModelFromJson(jsonString);

import 'dart:convert';

APNParamsModel apnParamsModelFromJson(String str) =>
    APNParamsModel.fromJson(json.decode(str));

String apnParamsModelToJson(APNParamsModel data) => json.encode(data.toJson());

class APNParamsModel {
  APNParamsModel({
    required this.apn,
    required this.apnLen,
    required this.psw,
    required this.pswLen,
    required this.userName,
    required this.userNameLen,
    required this.apnType,
    required this.imei,
    required this.imsi,
    required this.csq,
  });

  int apnLen;
  int pswLen;
  dynamic userName;
  int apnType;
  int userNameLen;
  dynamic psw;
  String imei;
  String imsi;
  int csq;
  dynamic apn;

  factory APNParamsModel.fromJson(Map<String, dynamic> json) => APNParamsModel(
        apnLen: json["apnLen"],
        pswLen: json["pswLen"],
        userName: json["userName"],
        apnType: json["apnType"],
        userNameLen: json["userNameLen"],
        psw: json["psw"],
        imei: json["imei"],
        imsi: json["imsi"],
        csq: json["csq"],
        apn: json["apn"],
      );

  Map<String, dynamic> toJson() => {
        "apnLen": apnLen,
        "pswLen": pswLen,
        "userName": userName,
        "apnType": apnType,
        "userNameLen": userNameLen,
        "psw": psw,
        "imei": imei,
        "imsi": imsi,
        "csq": csq,
        "apn": apn,
      };
}
