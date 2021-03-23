// To parse this JSON data, do
//
//     final groupUserModel = groupUserModelFromJson(jsonString);

import 'dart:convert';

GroupUserModel groupUserModelFromJson(String str) => GroupUserModel.fromJson(json.decode(str));

String groupUserModelToJson(GroupUserModel data) => json.encode(data.toJson());

class GroupUserModel {
  GroupUserModel({
    this.gId,
    this.level,
    this.sel,
    this.nickname,
    this.userAvatarFileName,
    this.userUid,
  });

  String gId;
  int level;
  bool sel;
  String nickname;
  String userAvatarFileName;
  String userUid;

  factory GroupUserModel.fromJson(Map<String, dynamic> json) => GroupUserModel(
    gId: json["g_id"],
    level: json["level"],
    sel: json["sel"],
    nickname: json["nickname"],
    userAvatarFileName: json["userAvatarFileName"],
    userUid: json["user_uid"],
  );

  Map<String, dynamic> toJson() => {
    "g_id": gId,
    "level": level,
    "sel": sel,
    "nickname": nickname,
    "userAvatarFileName": userAvatarFileName,
    "user_uid": userUid,
  };
}
