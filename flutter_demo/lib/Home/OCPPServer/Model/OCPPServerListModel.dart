import 'dart:convert';

OcppServerListModel ocppServerListModelFromJson(String str) =>
    OcppServerListModel.fromJson(json.decode(str));

String ocppServerListModelToJson(OcppServerListModel data) =>
    json.encode(data.toJson());

class OcppServerListModel {
  OcppServerListModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  int code;
  String msg;
  Data data;

  factory OcppServerListModel.fromJson(Map<String, dynamic> json) =>
      OcppServerListModel(
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
    required this.name,
    required this.domain,
    required this.port,
    required this.type,
    required this.version,
    required this.tls,
    required this.execute,
    required this.certId,
    required this.passphrase,
    required this.passSupprot,
    required this.aliasNumber,
    required this.location,
    required this.applyVersion,
    required this.code,
    required this.url,
    required this.isSelected,
  });

  int id;
  String name;
  String domain;
  int port;
  String type;
  String version;
  int tls;
  int execute;
  int certId;
  String passphrase;
  int passSupprot;
  String aliasNumber;
  String location;
  String applyVersion;
  String code;
  String url;
  bool isSelected;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        domain: json["domain"],
        port: json["port"],
        type: json["type"],
        version: json["version"],
        tls: json["tls"],
        execute: json["execute"],
        certId: json["certId"],
        passphrase: json["passphrase"],
        passSupprot: json["passSupprot"],
        aliasNumber: json["aliasNumber"],
        location: json["location"],
        applyVersion: json["applyVersion"],
        code: json["code"],
        url: json["url"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "domain": domain,
        "port": port,
        "type": type,
        "version": version,
        "tls": tls,
        "execute": execute,
        "certId": certId,
        "passphrase": passphrase,
        "passSupprot": passSupprot,
        "aliasNumber": aliasNumber,
        "location": location,
        "applyVersion": applyVersion,
        "code": code,
        "url": url,
      };
}
