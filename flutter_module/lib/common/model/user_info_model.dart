import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: user_info_model
 * Author: lishunfeng
 * Date: 3/23/21 1:21 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  UserInfoModel({
    this.tokenId,
    this.userId,
    this.userAvatarFileName,
    this.nickname,
    this.userMail,
    this.whatsUp,
    this.latestLoginIp,
    this.accId,
    this.latestLoginTime,
    this.liveStatus,
    this.online,
    this.man,
    this.maxFriend,
    this.registerTime,
    this.userType,
    this.userSex,
    this.token,
    this.userDesc,
  });

  String tokenId;
  int userId;
  String userAvatarFileName;
  String nickname;
  String userMail;
  String whatsUp;
  String latestLoginIp;
  int accId;
  DateTime latestLoginTime;
  int liveStatus;
  bool online;
  bool man;
  int maxFriend;
  DateTime registerTime;
  int userType;
  int userSex;
  String token;
  String userDesc;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    tokenId: json["token_id"],
    userId: json["user_id"],
    userAvatarFileName: json["userAvatarFileName"],
    nickname: json["nickname"],
    userMail: json["user_mail"],
    whatsUp: json["whatsUp"],
    latestLoginIp: json["latest_login_ip"],
    accId: json["acc_id"],
    latestLoginTime: DateTime.parse(json["latest_login_time"]),
    liveStatus: json["liveStatus"],
    online: json["online"],
    man: json["man"],
    maxFriend: json["maxFriend"],
    registerTime: DateTime.parse(json["register_time"]),
    userType: json["user_type"],
    userSex: json["user_sex"],
    token: json["token"],
    userDesc: json["userDesc"],
  );

  Map<String, dynamic> toJson() => {
    "token_id": tokenId,
    "user_id": userId,
    "userAvatarFileName": userAvatarFileName,
    "nickname": nickname,
    "user_mail": userMail,
    "whatsUp": whatsUp,
    "latest_login_ip": latestLoginIp,
    "acc_id": accId,
    "latest_login_time": latestLoginTime.toIso8601String(),
    "liveStatus": liveStatus,
    "online": online,
    "man": man,
    "maxFriend": maxFriend,
    "register_time": registerTime.toIso8601String(),
    "user_type": userType,
    "user_sex": userSex,
    "token": token,
    "userDesc": userDesc,
  };
}
