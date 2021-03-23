// To parse this JSON data, do
//
//     final groupUserModel = groupUserModelFromJson(jsonString);

import 'dart:convert';

GroupUser2Model groupUserModelFromJson(String str) => GroupUser2Model.fromJson(json.decode(str));

String groupUserModelToJson(GroupUser2Model data) => json.encode(data.toJson());

class GroupUser2Model {
  GroupUser2Model({
    this.gid,
    this.userId,
    this.nickname,
    this.duration,
  });

  String gid;
  int userId;
  String nickname;
  int duration;

  factory GroupUser2Model.fromJson(Map<String, dynamic> json) => GroupUser2Model(
    gid: json["gid"],
    userId: json["user_id"],
    nickname: json["nickname"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "gid": gid,
    "user_id": userId,
    "nickname": nickname,
    "duration": duration,
  };
}
