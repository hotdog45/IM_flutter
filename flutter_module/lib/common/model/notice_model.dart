import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: notice_model
 * Author: lishunfeng
 * Date: 3/2/21 9:26 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) => NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  NoticeModel({
    this.id,
    this.title,
    this.body,
    this.ctime,
  });

  int id;
  String title;
  String body;
  DateTime ctime;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    ctime: DateTime.parse(json["ctime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "ctime": ctime.toIso8601String(),
  };
}
