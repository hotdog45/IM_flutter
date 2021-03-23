import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: buddy_model
 * Author: lishunfeng
 * Date: 2/15/21 4:11 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final buddyModel = buddyModelFromJson(jsonString);

import 'dart:convert';

BuddyModel buddyModelFromJson(String str) => BuddyModel.fromJson(json.decode(str));

String buddyModelToJson(BuddyModel data) => json.encode(data.toJson());

class BuddyModel extends ISuspensionBean {
  BuddyModel({
    this.liveStatus,
    this.man,
    this.nickname,
    this.online,
    this.userAvatarFileName,
    this.userMail,
    this.userSex,
    this.userUid,
    this.whatsUp,
  });

  int liveStatus;
  bool man;
  String nickname;
  bool online;
  String userAvatarFileName;
  String userMail;
  String userSex;
  String userUid;
  String whatsUp;

  factory BuddyModel.fromJson(Map<String, dynamic> json) => BuddyModel(
    liveStatus: json["liveStatus"],
    man: json["man"],
    nickname: json["nickname"],
    online: json["online"],
    userAvatarFileName: json["userAvatarFileName"],
    userMail: json["user_mail"],
    userSex: json["user_sex"],
    userUid: json["user_uid"],
    whatsUp: json["whatsUp"],
  );

  Map<String, dynamic> toJson() => {
    "liveStatus": liveStatus,
    "man": man,
    "nickname": nickname,
    "online": online,
    "userAvatarFileName": userAvatarFileName,
    "user_mail": userMail,
    "user_sex": userSex,
    "user_uid": userUid,
    "whatsUp": whatsUp,
  };
  /// 用于通讯录排序
  String tagIndex;
  String screenNamePinyin;
  @override
  String getSuspensionTag() => tagIndex;

}
