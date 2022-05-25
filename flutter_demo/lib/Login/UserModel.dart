import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  int code;
  String msg;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    required this.userId,
    required this.sessionId,
    required this.accept,
    required this.change,
    required this.userInfo,
  });

  int userId;
  String sessionId;
  int accept;
  int change;
  UserInfo userInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        sessionId: json["sessionId"],
        accept: json["accept"],
        change: json["change"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "sessionId": sessionId,
        "accept": accept,
        "change": change,
        "userInfo": userInfo.toJson(),
      };
}

class UserInfo {
  UserInfo({
    this.id = 0,
    this.authen = '',
    this.name = '',
    this.face = 0,
    this.url = '',
    this.accept = 0,
    this.change = 0,
    this.forbidStatus = 0,
    this.createdAt = '',
    this.enterpriseId = 0,
  });

  int id;
  String authen;
  String name;
  int face;
  String url;
  int accept;
  int change;
  int forbidStatus;
  String createdAt;
  int enterpriseId;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        authen: json["authen"],
        name: json["name"],
        face: json["face"],
        url: json["url"],
        accept: json["accept"],
        change: json["change"],
        forbidStatus: json["forbidStatus"],
        createdAt: json["createdAt"],
        enterpriseId: json["enterpriseId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "authen": authen,
        "name": name,
        "face": face,
        "url": url,
        "accept": accept,
        "change": change,
        "forbidStatus": forbidStatus,
        "createdAt": createdAt,
        "enterpriseId": enterpriseId,
      };
}
