import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: old_base_model
 * Author: lishunfeng
 * Date: 2/15/21 1:28 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final oldBaseModel = oldBaseModelFromJson(jsonString);

import 'dart:convert';

OldBaseModel oldBaseModelFromJson(String str) => OldBaseModel.fromJson(json.decode(str));

String oldBaseModelToJson(OldBaseModel data) => json.encode(data.toJson());

class OldBaseModel {
  OldBaseModel({
    this.success,
    this.returnValue,
  });

  bool success;
  String returnValue;

  factory OldBaseModel.fromJson(Map<String, dynamic> json) => OldBaseModel(
    success: json["success"],
    returnValue: json["returnValue"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "returnValue": returnValue,
  };
}
