// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  BillModel({
    this.endRow,
    this.firstPage,
    this.hasNextPage,
    this.hasPreviousPage,
    this.isFirstPage,
    this.isLastPage,
    this.lastPage,
    this.navigateFirstPage,
    this.navigateLastPage,
    this.navigatePages,
    this.navigatepageNums,
    this.nextPage,
    this.pageNum,
    this.pageSize,
    this.pages,
    this.prePage,
    this.size,
    this.startRow,
    this.total,
    this.list,
  });

  int endRow;
  int firstPage;
  bool hasNextPage;
  bool hasPreviousPage;
  bool isFirstPage;
  bool isLastPage;
  int lastPage;
  int navigateFirstPage;
  int navigateLastPage;
  int navigatePages;
  dynamic navigatepageNums;
  int nextPage;
  int pageNum;
  int pageSize;
  int pages;
  int prePage;
  int size;
  int startRow;
  int total;
  List<ListElement> list;

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
    endRow: json["end_row"],
    firstPage: json["first_page"],
    hasNextPage: json["has_next_page"],
    hasPreviousPage: json["has_previous_page"],
    isFirstPage: json["is_first_page"],
    isLastPage: json["is_last_page"],
    lastPage: json["last_page"],
    navigateFirstPage: json["navigate_first_page"],
    navigateLastPage: json["navigate_last_page"],
    navigatePages: json["navigate_pages"],
    navigatepageNums: json["navigatepage_nums"],
    nextPage: json["next_page"],
    pageNum: json["page_num"],
    pageSize: json["page_size"],
    pages: json["pages"],
    prePage: json["pre_page"],
    size: json["size"],
    startRow: json["start_row"],
    total: json["total"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "end_row": endRow,
    "first_page": firstPage,
    "has_next_page": hasNextPage,
    "has_previous_page": hasPreviousPage,
    "is_first_page": isFirstPage,
    "is_last_page": isLastPage,
    "last_page": lastPage,
    "navigate_first_page": navigateFirstPage,
    "navigate_last_page": navigateLastPage,
    "navigate_pages": navigatePages,
    "navigatepage_nums": navigatepageNums,
    "next_page": nextPage,
    "page_num": pageNum,
    "page_size": pageSize,
    "pages": pages,
    "pre_page": prePage,
    "size": size,
    "start_row": startRow,
    "total": total,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.amount,
    this.title,
    this.from,
    this.fromIsAccId,
    this.fromNickname,
    this.fromAvatar,
    this.inOutFlag,
    this.serviceFee,
    this.to,
    this.toIsAccId,
    this.toNickname,
    this.toAvatar,
    this.tradeId,
    this.subTradeTypeCode,
    this.subTradeTypeDesc,
    this.tradeTime,
  });

  String amount;
  String title;
  String from;
  bool fromIsAccId;
  String fromNickname;
  String fromAvatar;
  int inOutFlag;
  String serviceFee;
  String to;
  bool toIsAccId;
  String toNickname;
  String toAvatar;
  double tradeId;
  String subTradeTypeCode;
  String subTradeTypeDesc;
  String tradeTime;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    amount: json["amount"],
    title: json["title"],
    from: json["from"],
    fromIsAccId: json["from_is_acc_id"],
    fromNickname: json["from_nickname"],
    fromAvatar: json["from_avatar"],
    inOutFlag: json["in_out_flag"],
    serviceFee: json["service_fee"],
    to: json["to"],
    toIsAccId: json["to_is_acc_id"],
    toNickname: json["to_nickname"],
    toAvatar: json["to_avatar"],
    tradeId: json["trade_id"].toDouble(),
    subTradeTypeCode: json["sub_trade_type_code"],
    subTradeTypeDesc: json["sub_trade_type_desc"],
    tradeTime: json["trade_time"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "title": title,
    "from": from,
    "from_is_acc_id": fromIsAccId,
    "from_nickname": fromNickname,
    "from_avatar": fromAvatar,
    "in_out_flag": inOutFlag,
    "service_fee": serviceFee,
    "to": to,
    "to_is_acc_id": toIsAccId,
    "to_nickname": toNickname,
    "to_avatar": toAvatar,
    "trade_id": tradeId,
    "sub_trade_type_code": subTradeTypeCode,
    "sub_trade_type_desc": subTradeTypeDesc,
    "trade_time": tradeTime,
  };
}
