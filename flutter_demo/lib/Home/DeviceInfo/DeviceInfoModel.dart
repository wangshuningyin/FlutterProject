// To parse this JSON data, do
//
//     final deviceInfoModel = deviceInfoModelFromJson(jsonString);

import 'dart:convert';

DeviceInfoModel deviceInfoModelFromJson(String str) =>
    DeviceInfoModel.fromJson(json.decode(str));

String deviceInfoModelToJson(DeviceInfoModel data) =>
    json.encode(data.toJson());

class DeviceInfoModel {
  DeviceInfoModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  int code;
  String msg;
  Data data;

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      DeviceInfoModel(
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.list,
  });

  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.id,
    required this.deviceNumber,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.chargeType,
    required this.status,
    required this.aliasNumber,
    required this.netType,
    required this.stationId,
    required this.elecPower,
    required this.ratedCurrent,
    required this.softVersion,
    required this.model,
    required this.netModule,
    required this.pinCode,
    required this.powerType,
    required this.hardwareModel,
    required this.certified,
    required this.partNumber,
    required this.hardwareVersion,
    required this.outlet,
  });

  int id;
  String deviceNumber;
  String address;
  String longitude;
  String latitude;
  int chargeType;
  int status;
  String aliasNumber;
  int netType;
  int stationId;
  int elecPower;
  int ratedCurrent;
  String softVersion;
  String model;
  List<String> netModule;
  String pinCode;
  int powerType;
  String hardwareModel;
  List<dynamic> certified;
  String partNumber;
  String hardwareVersion;
  String outlet;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        deviceNumber: json["deviceNumber"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        chargeType: json["chargeType"],
        status: json["status"],
        aliasNumber: json["aliasNumber"],
        netType: json["netType"],
        stationId: json["stationId"],
        elecPower: json["elecPower"],
        ratedCurrent: json["ratedCurrent"],
        softVersion: json["softVersion"],
        model: json["model"],
        netModule: List<String>.from(json["netModule"].map((x) => x)),
        pinCode: json["pinCode"],
        powerType: json["powerType"],
        hardwareModel: json["hardwareModel"],
        certified: List<dynamic>.from(json["certified"].map((x) => x)),
        partNumber: json["partNumber"],
        hardwareVersion: json["hardwareVersion"],
        outlet: json["outlet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deviceNumber": deviceNumber,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "chargeType": chargeType,
        "status": status,
        "aliasNumber": aliasNumber,
        "netType": netType,
        "stationId": stationId,
        "elecPower": elecPower,
        "ratedCurrent": ratedCurrent,
        "softVersion": softVersion,
        "model": model,
        "netModule": List<dynamic>.from(netModule.map((x) => x)),
        "pinCode": pinCode,
        "powerType": powerType,
        "hardwareModel": hardwareModel,
        "certified": List<dynamic>.from(certified.map((x) => x)),
        "partNumber": partNumber,
        "hardwareVersion": hardwareVersion,
        "outlet": outlet,
      };
}
