import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: group_data_model
 * Author: lishunfeng
 * Date: 3/7/21 11:57 AM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// To parse this JSON data, do
//
//     final groupDataModel = groupDataModelFromJson(jsonString);

import 'dart:convert';

GroupDataModel groupDataModelFromJson(String str) => GroupDataModel.fromJson(json.decode(str));

String groupDataModelToJson(GroupDataModel data) => json.encode(data.toJson());

class GroupDataModel {
  GroupDataModel({
    this.createTime,
    this.createUserName,
    this.gId,
    this.gIsBan,
    this.gMemberCount,
    this.gName,
    this.gNotice,
    this.gNoticeUpdatenick,
    this.gNoticeUpdatetime,
    this.gNoticeUpdateuid,
    this.gOwnerName,
    this.gOwnerUserUid,
    this.gStatus,
    this.imIsInGroup,
    this.maxMemberCount,
    this.nicknameIngroup,
    this.worldChat,
  });



  String createTime;
  String createUserName;
  String gId;
  int gIsBan;
  String gMemberCount;
  String gName;
  String gNotice;
  String gNoticeUpdatenick;
  String gNoticeUpdatetime;
  String gNoticeUpdateuid;
  String gOwnerName;
  String gOwnerUserUid;
  String gStatus;
  String imIsInGroup;
  String maxMemberCount;
  String nicknameIngroup;
  bool worldChat;

  factory GroupDataModel.fromJson(Map<String, dynamic> json) => GroupDataModel(
    createTime: json["create_time"],
    createUserName: json["create_user_name"],
    gId: json["g_id"],
    gIsBan: json["g_is_ban"],
    gMemberCount: json["g_member_count"],
    gName: json["g_name"],
    gNotice: json["g_notice"],
    gNoticeUpdatenick: json["g_notice_updatenick"],
    gNoticeUpdatetime: json["g_notice_updatetime"],
    gNoticeUpdateuid: json["g_notice_updateuid"],
    gOwnerName: json["g_owner_name"],
    gOwnerUserUid: json["g_owner_user_uid"],
    gStatus: json["g_status"],
    imIsInGroup: json["imIsInGroup"],
    maxMemberCount: json["max_member_count"],
    nicknameIngroup: json["nickname_ingroup"],
    worldChat: json["worldChat"],
  );

  Map<String, dynamic> toJson() => {
    "create_time": createTime,
    "create_user_name": createUserName,
    "g_id": gId,
    "g_is_ban": gIsBan,
    "g_member_count": gMemberCount,
    "g_name": gName,
    "g_notice": gNotice,
    "g_notice_updatenick": gNoticeUpdatenick,
    "g_notice_updatetime": gNoticeUpdatetime,
    "g_notice_updateuid": gNoticeUpdateuid,
    "g_owner_name": gOwnerName,
    "g_owner_user_uid": gOwnerUserUid,
    "g_status": gStatus,
    "imIsInGroup": imIsInGroup,
    "max_member_count": maxMemberCount,
    "nickname_ingroup": nicknameIngroup,
    "worldChat": worldChat,
  };
}
