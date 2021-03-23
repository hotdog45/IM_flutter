// To parse this JSON data, do
//
//     final alarmMessageModel = alarmMessageModelFromJson(jsonString);

import 'dart:convert';

AlarmMessageModel alarmMessageModelFromJson(String str) => AlarmMessageModel.fromJson(json.decode(str));

String alarmMessageModelToJson(AlarmMessageModel data) => json.encode(data.toJson());

class AlarmMessageModel {
  AlarmMessageModel({
    this.alarmContent,
    this.alarmType,
    this.alwaysTop,
    this.dataId,
    this.date,
    this.extraString1,
    this.flagNum,
    this.title,
  });

  String alarmContent;
  int alarmType;
  bool alwaysTop;
  String dataId;
  int date;
  String extraString1;
  String flagNum;
  String title;

  factory AlarmMessageModel.fromJson(Map<String, dynamic> json) => AlarmMessageModel(
    alarmContent: json["alarmContent"],
    alarmType: json["alarmType"],
    alwaysTop: json["alwaysTop"],
    dataId: json["dataId"],
    date: json["date"],
    extraString1: json["extraString1"],
    flagNum: json["flagNum"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "alarmContent": alarmContent,
    "alarmType": alarmType,
    "alwaysTop": alwaysTop,
    "dataId": dataId,
    "date": date,
    "extraString1": extraString1,
    "flagNum": flagNum,
    "title": title,
  };
}
