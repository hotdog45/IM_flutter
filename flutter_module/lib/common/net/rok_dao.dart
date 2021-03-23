import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/event/index.dart';
import 'package:flutter_module/common/getx/UserInfoController.dart';
import 'package:flutter_module/common/model/bank_model.dart';
import 'package:flutter_module/common/model/base/base_model.dart';
import 'package:flutter_module/common/model/bill_model.dart';
import 'package:flutter_module/common/model/group_user2_model.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/model/notice_model.dart';
import 'package:flutter_module/common/model/red_list_model.dart';
import 'package:flutter_module/common/model/user_info_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/unils/app_init_utils.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/common/unils/string_utils.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/common/main_page.dart';
import 'package:flutter_module/page/group/group_user_list_page.dart';
import 'package:flutter_module/page/user/login_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'address.dart';
import 'api.dart';

// 登录

reqAccountLogin(String identity, String pwd, {isAuto = false}) async {
  // var bytes = utf8.encode(pwd); // data being hashed
  // var digest = sha1.convert(bytes);
  var jsonData = await httpManager.netFetch(accountLogin, {
    "device_info": "device_info",
    "hash_password": pwd,
    "identity": identity,
    "os_type": 0,
  });
  if (jsonData == null) {
    if (!isAuto) BotToast.showText(text: "登录失败~");
    return null;
  } else {
    if (!isAuto) BotToast.showText(text: "登录成功~");
    // appInitUtils.saveUserData(jsonData);
    eventBus.fire(LoginEvent(jsonData));
    UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonData);
    final _user = Get.put(UserController());
    // _user.setUserInfo(userInfoModel);
    _user.userMail.value = userInfoModel.userMail;
    _user.nickname.value = userInfoModel.nickname;
    _user.userId.value = userInfoModel.userId;
    _user.userAvatarFileName.value = userInfoModel.userAvatarFileName;
    _user.whatsUp.value = userInfoModel.whatsUp;
    _user.userDesc.value = userInfoModel.userDesc;
    _user.man.value = userInfoModel.man;


    _user.userInfoModel.value = userInfoModel;

    HiFlutterBridge.getInstance().goToNative({
      "action": "imServerConnector",
      "jsonData": json.encode(jsonData),
      "uid": jsonData["user_id"].toString(),
      "pwd": pwd
    });
    if (!isAuto) Get.offAll(MainPage());
    return true;
  }
}

//  发送验证码

reqSecurityCode(String identity) async {
  await httpManager.netFetch(securityCode, {
    "identity": identity,
    "identity_type": StringUtils.isNumeric(identity) ? 1 : 0 //邮箱0 手机1
  });
  MyToast.show("验证码已发送");
}
//  注册账号

reqAccountNew(
    String identity, String nickname, String code, String pwd, int sex) async {
  var bytes = utf8.encode(pwd); // data being hashed
  var hashPwd = sha1.convert(bytes);
  var jsonData = await httpManager.netFetch(accountNew, {
    "hash_password": pwd,
    "identity": identity,
    "nickname": nickname,
    "security_code": code,
    "sex": sex,
    "identity_type": StringUtils.isNumeric(identity) ? 1 : 0 //邮箱0 手机1
  });
  if (jsonData == null) {
    return false;
  } else {
    MyToast.show("注册成功~" + jsonData.toString());
    Get.offAll(LoginPage(type: 1, pwd: pwd, uid: jsonData.toString()));
    return true;
  }
}

reqAccountPasswordSet(
    String identity, String code, String pwd, int type) async {
  var bytes = utf8.encode(pwd); // data being hashed
  var hashPwd = sha1.convert(bytes);
  var jsonData = await httpManager.netFetch(accountPasswordSet, {
    "hash_password": pwd,
    "identity": identity,
    "security_code": code,
    // "identity_type": StringUtils.isNumeric(identity) ? 1 : 0 //邮箱0 手机1
  });
  if (jsonData == null) {
    return false;
  } else {
    MyToast.show(type == 1 ? "重置成功~" : "密码修改成功~");
    Get.offAll(LoginPage(type: 2, pwd: pwd));
    return true;
  }
}

//设置支付密码
reqOperateSetTradePwd(String pwd) async {
  var bytes = utf8.encode(pwd); // data being hashed
  var hashPwd = sha1.convert(bytes);
  var jsonData = await httpManager
      .netFetch(operateSetTradePwd, {"tradePwd": pwd}, hostType: 2);
  if (jsonData == null) {
    return false;
  } else {
    MyToast.show("密码设置成功~");

    return true;
  }
}

// 发红包
reqTradingGiveRedPacket(amount, to, description, tradePwd,
    {type = 1, total = 1}) async {
  var jsonData = await httpManager.netFetch(
      tradingGiveRedPacket,
      {
        "amount": amount,
        "to": to,
        "type": type,
        "total": total,
        "params": {"description": description},
        "tradePwd": tradePwd
      },
      hostType: 2);

  return jsonData;
}

// 转账
Future reqTradingTransfer(amount, transInAccId, memo, tradePwd) async {
  var jsonData = await httpManager.netFetch(
      tradingTransfer,
      {
        "amount": amount,
        "memo": memo,
        "tradePwd": tradePwd,
        "transInAccId": transInAccId
      },
      hostType: 2);

  return jsonData;
}

// 查询 账户余额
reqAccountQueryAccount() async {
  var jsonData =
      await httpManager.netFetch(accountQueryAccount, {}, hostType: 2);

  return jsonData;
}

// // 查询 账单
// reqTradeQueryBill({pageNum = 1, pageSize =Config.PAGE_SIZE}) async {
//   var jsonData = await httpManager.netFetch(
//       tradeQueryBill, {"pageNum": pageNum, "pageSize": pageSize},
//       hostType: 2);
//   if (jsonData == null) {
//     MyToast.show("查询 账单 失败~");
//
//     return false;
//   } else {
//     MyToast.show("查询 账单 成功~");
//     return true;
//   }
// }

// 查询 accid
reqAccountAccId(uid, {uidArr}) async {
  var jsonData = await httpManager.netFetch(accountAccId, {
    "uids": uidArr == null ? [uid] : uidArr
  });
  if (jsonData == null) {
    return null;
  }
  return jsonData["Items"];
}

//account/red/pay 抢红包
reqAccountRedPay(redId,{type = 1}) async {
  var jsonData = await httpManager.netFetch(
      accountRedPay, {"red_id": int.parse(redId ?? "0"), "type": type},
      useBaseModel: false);
  BaseModel baseModel = jsonData;
  if (baseModel == null) {
    HiFlutterBridge.getInstance()
        .goToNative({"action": "MyToast", "msg": "系统异常"});
  }
  if (baseModel.code != 0 || type==0) {
    return jsonData;
  }
  HiFlutterBridge.getInstance().dismiss();
  HiFlutterBridge.getInstance().goToNative(
      {"action": "pushPage", "page": "EnvelopeDetailPage?redId=" + redId});
  return jsonData;
}

// accountRedGet 领红包记录
reqAccountAccGet(redId) async {
  var jsonData = await httpManager.netFetch(accountRedGet, {"red_id": redId});
  if (jsonData == null) {
    return null;
  }

  RedListModel redListModel = RedListModel.fromJson(jsonData);
  return redListModel;
}

// app/notice appNotice
// accountRedGet 领红包记录
reqAppNotice() async {
  var jsonData = await httpManager.netFetch(appNotice, {});
  if (jsonData == null) {
    return [];
  }
  List<NoticeModel> list = [];
  jsonData.forEach((v) => list.add(NoticeModel.fromJson(v)));
  return list;
}

// accountBill
reqAccountBill({pageNum = 1, pageSize = Config.PAGE_SIZE}) async {
  var jsonData = await httpManager
      .netFetch(accountBill, {"pageNum": pageNum, "pageSize": pageSize});
  if (jsonData == null) {
    return null;
  }

  BillModel billModel = BillModel.fromJson(jsonData);
  return billModel;
}

/// bindInfoQueryBindCardList

reqBindInfoQueryBindCardList() async {
  var jsonData =
      await httpManager.netFetch(bindInfoQueryBindCardList, {}, hostType: 2);
  if (jsonData == null) {
    return [];
  }
  List<BankModel> list = [];
  jsonData.forEach((v) => list.add(BankModel.fromJson(v)));
  return list;
}

//禁言整个群
reqGroupBan(gid, isBan) async {
  var jsonData =
      await httpManager.netFetch(groupBan, {"gid": gid, "is_ban": isBan});
  if (jsonData == null) {
    MyToast.show("整群禁言失败!");
    return null;
  }
  if (isBan) {
    MyToast.show("整群禁言成功!");
  } else {
    MyToast.show("解除禁言成功!");
  }
}

//禁言群用户
reqGroupBanUser(gid, time, uid) async {
  var jsonData = await httpManager
      .netFetch(groupBanUser, {"gid": gid, "user_id": uid, "ban_time": time});
  if (jsonData == null) {
    MyToast.show("禁言失败!");
    return null;
  }
  MyToast.show("禁言成功!");
}

// 禁言用户列表
reqGroupBanUserList(gid) async {
  var jsonData = await httpManager.netFetch(groupBanUserList, {"gid": gid});
  if (jsonData == null) {
    return [];
  }
  List<GroupUser2Model> list = [];
  jsonData.forEach((v) => list.add(GroupUser2Model.fromJson(v)));
  return list;
}

// 设置管理员
reqGroupLevelSet(gid, level, uid) async {
  var jsonData = await httpManager
      .netFetch(groupLevelSet, {"gid": gid, "user_id": uid, "level": level});
  if (jsonData == null) {
    MyToast.show("设置失败!");
    return null;
  }
  if (level == 20) {
    MyToast.show("管理员设置成功!");
  } else {
    MyToast.show("管理员移除成功!");
  }
}
