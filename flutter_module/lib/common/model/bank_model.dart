// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    this.bankName,
    this.cardNo,
    this.cardBindId,
    this.bankCode,
    this.cardType,
  });

  String bankName;
  String cardNo;
  String cardBindId;
  dynamic bankCode;
  String cardType;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    bankName: json["bank_name"],
    cardNo: json["card_no"],
    cardBindId: json["card_bind_id"],
    bankCode: json["bank_code"],
    cardType: json["card_type"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "card_no": cardNo,
    "card_bind_id": cardBindId,
    "bank_code": bankCode,
    "card_type": cardType,
  };
}
