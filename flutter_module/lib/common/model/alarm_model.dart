import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: alarm_model
 * Author: lishunfeng
 * Date: 2/19/21 1:43 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final alarmModel = alarmModelFromJson(jsonString);

import 'dart:convert';

AlarmModel alarmModelFromJson(String str) => AlarmModel.fromJson(json.decode(str));

String alarmModelToJson(AlarmModel data) => json.encode(data.toJson());

class AlarmModel {
  AlarmModel({
    this.dataId,
    this.alarmType,
    this.title,
    this.alarmContent,
    this.date,
    this.extraString1,
    this.alwaysTop,
    this.flagNum,
  });

  String dataId;
  int alarmType;
  String title;
  String alarmContent;
  String date;
  String extraString1;
  bool alwaysTop;
  String flagNum;

  factory AlarmModel.fromJson(Map<String, dynamic> json) => AlarmModel(
    dataId: json["dataId"],
    alarmType: json["alarmType"],
    title: json["title"],
    alarmContent: json["alarmContent"],
    date: json["date"],
    extraString1: json["extraString1"],
    alwaysTop: json["alwaysTop"],
    flagNum: json["flagNum"],
  );

  Map<String, dynamic> toJson() => {
    "dataId": dataId,
    "alarmType": alarmType,
    "title": title,
    "alarmContent": alarmContent,
    "date": date,
    "extraString1": extraString1,
    "alwaysTop": alwaysTop,
    "flagNum": flagNum,
  };
}
