// To parse this JSON data, do
//
//     final yRunStateModel = yRunStateModelFromJson(jsonString);

import 'dart:convert';

YRunStateModel yRunStateModelFromJson(String str) =>
    YRunStateModel.fromJson(json.decode(str));

String yRunStateModelToJson(YRunStateModel data) => json.encode(data.toJson());

class YRunStateModel {
  YRunStateModel({
    required this.title,
    required this.content,
    required this.detailType,
  });

  String title;
  String content;
  int detailType;

  factory YRunStateModel.fromJson(Map<String, dynamic> json) => YRunStateModel(
        title: json["title"],
        content: json["content"],
        detailType: json["detailType"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "detailType": detailType,
      };
}
