import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: base_model
 * Author: lishunfeng
 * Date: 2/9/21 10:26 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final baseModel = baseModelFromJson(jsonString);

import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  BaseModel({
    this.code,
    this.message,
    this.body,
  });

  int code;
  String message;
  dynamic body;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
    code: json["code"],
    message: json["message"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "body": body,
  };
}
