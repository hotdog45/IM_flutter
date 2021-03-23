// To parse this JSON data, do
//
//     final redListModel = redListModelFromJson(jsonString);

import 'dart:convert';

RedListModel redListModelFromJson(String str) => RedListModel.fromJson(json.decode(str));

String redListModelToJson(RedListModel data) => json.encode(data.toJson());

class RedListModel {
  RedListModel({
    this.amount,
    this.notice,
    this.redId,
    this.total,
    this.isFinish,
    this.items,
    this.formUserId,
    this.fromNickname,
    this.fromAvatar,
    this.type,
  });

  String amount;
  String notice;
  double redId;
  int total;
  bool isFinish;
  List<Item> items;
  int formUserId;
  String fromNickname;
  String fromAvatar;
  int type;

  factory RedListModel.fromJson(Map<String, dynamic> json) => RedListModel(
    amount: json["amount"] == null ? null : json["amount"],
    notice: json["notice"] == null ? null : json["notice"],
    redId: json["red_id"] == null ? null : json["red_id"].toDouble(),
    total: json["total"] == null ? null : json["total"],
    isFinish: json["is_finish"] == null ? null : json["is_finish"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    formUserId: json["form_user_id"] == null ? null : json["form_user_id"],
    fromNickname: json["from_nickname"] == null ? null : json["from_nickname"],
    fromAvatar: json["from_avatar"] == null ? null : json["from_avatar"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount == null ? null : amount,
    "notice": notice == null ? null : notice,
    "red_id": redId == null ? null : redId,
    "total": total == null ? null : total,
    "is_finish": isFinish == null ? null : isFinish,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    "form_user_id": formUserId == null ? null : formUserId,
    "from_nickname": fromNickname == null ? null : fromNickname,
    "from_avatar": fromAvatar == null ? null : fromAvatar,
    "type": type == null ? null : type,
  };
}



class Item {
  Item({
    this.amount,
    this.userId,
    this.nickname,
    this.avatar,
    this.utime,
  });

  String amount;
  int userId;
  String nickname;
  String avatar;
  DateTime utime;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    amount: json["amount"] == null ? null : json["amount"],
    userId: json["user_id"] == null ? null : json["user_id"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    utime: json["utime"] == null ? null : DateTime.parse(json["utime"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount == null ? null : amount,
    "user_id": userId == null ? null : userId,
    "nickname": nickname == null ? null : nickname,
    "avatar": avatar == null ? null : avatar,
    "utime": utime == null ? null : utime.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
