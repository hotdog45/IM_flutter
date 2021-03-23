import 'dart:convert';

import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/getx/UserInfoController.dart';
import 'package:flutter_module/common/model/buddy_model.dart';
import 'package:flutter_module/common/model/group_data_model.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/model/user_info_model.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/common/unils/string_utils.dart';
import 'package:flutter_module/common/unils/text_utils.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'address.dart';
import 'api.dart';

final UserInfoModel userInfoModel =
    Get.put(UserController()).userInfoModel.value;
// String testUid = "400142";
// 修改密码
reqModifyPwd(String oldPwd, String pwd) async {
  var uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
  Map map = {"uid": uid, "old_psw": oldPwd, "psw": pwd};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 1,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1008,
      "actionId": 9,
    },
    hostType: 3,
  );
  if (data == "1") {
    MyToast.show("密码修改成功~");
  } else if (data == "2") {
    MyToast.show("原密码有误,请确认!");
  }
}

//  好友列表
reqBuddyList(uid) async {
  // var uid = await LocalStorage.get(AppConstant.USER_ID) ?? testUid;
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 2,
      "doInput": true,
      "device": 1,
      "newData": uid,
      "processorId": 1008,
      "actionId": 7
    },
    hostType: 3,
  );
  if (data != null && data.isNotEmpty) {
    List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
    List<BuddyModel> _list = List<BuddyModel>();
    jsonList.forEach((v) => _list.add(BuddyModel.fromJson(v)));
    return _list;
  }
  return [];
}

// 群成员
reqGroupUserList(String gid) async {
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 25,
      "doInput": true,
      "device": 1,
      "newData": gid,
      "processorId": 1016,
      "actionId": 9,
    },
    hostType: 3,
  );
  if (data != null && data.isNotEmpty) {
    List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
    List<GroupUserModel> _list = List<GroupUserModel>();
    jsonList.forEach((v) => _list.add(GroupUserModel.fromJson(v)));
    return _list;
  }
  return [];
}

// 群资料
reqGroupData(String gid) async {
  var uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
  Map map = {"my_user_id": uid, "gid": gid};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 25,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1016,
      "actionId": 8,
    },
    hostType: 3,
  );
  if (data == null || data.length < 10) {
    return;
  }
  var jsonData = jsonDecode(data);

  GroupDataModel model = GroupDataModel.fromJson(jsonData);
  return model;
}

// 群列表
reqGroupListData() async {
  var uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 25,
      "doInput": true,
      "device": 1,
      "newData": uid,
      "processorId": 1016,
      "actionId": 7,
    },
    hostType: 3,
  );
  if (data == null || data.length < 10) {
    return;
  }
  if (data != null && data.isNotEmpty) {
    List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
    List<GroupDataModel> _list = List<GroupDataModel>();
    jsonList.forEach((v) => _list.add(GroupDataModel.fromJson(v)));
    return _list;
  }
  return [];
}

// 修改昵称 & 性别
reqModifyName(String name, {String sex}) async {
  var sex2 = sex;
  if (sex != null && sex.isNotEmpty) {
    sex2 = Get.put(UserController()).man.value ? "1" : "0";
  }

  Map map = {"uid": userInfoModel.userId, "nickName": name, "sex": sex2};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 1,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1008,
      "actionId": 8,
    },
    hostType: 3,
  );
  if (data == "1") {
    MyToast.show("修改成功~");
    Get.put(UserController()).nickname.value = name;
    if (sex != null && sex.isNotEmpty) {
      Get.put(UserController()).man.value = sex == "1";
    }
    Get.back();
  } else {
    MyToast.show("修改失败~");
  }
}

//修改签名
reqModifyWhatsUp(String whatsUp) async {
  Map map = {
    "uid": userInfoModel.userId,
    "whats_up": whatsUp,
  };
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 1,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1008,
      "actionId": 22,
    },
    hostType: 3,
  );
  if (data == "1") {
    MyToast.show("修改成功~");
    Get.put(UserController()).whatsUp.value = whatsUp;
    Get.back();
  } else {
    MyToast.show("修改失败~");
  }
}

//修改说明
reqModifyDesc(String desc) async {
  Map map = {"uid": userInfoModel.userId, "user_desc": desc};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 1,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1008,
      "actionId": 24,
    },
    hostType: 3,
  );
  if (data == "1") {
    MyToast.show("修改成功~");
    Get.put(UserController()).userDesc.value = desc;
    Get.back();
  } else {
    MyToast.show("修改失败~");
  }
}

//修改群名称
reqModifyGroupName(String name,String gid) async {
  var uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
  var nickname = await LocalStorage.get(AppConstant.USER_NICKNAME) ?? "";

  Map map = {"modify_by_uid": uid, "modify_by_nickname":  nickname,
    "group_name":name ,"gid": gid};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 24,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1016,
      "actionId": 8,
    },
    hostType: 3,
  );
  if (data == "1") {
    MyToast.show("修改成功~");
    Get.back(result: true);
  } else {
    MyToast.show("修改失败~");
  }
}
//修改群昵称
reqModifyGroupNickname(String name,String gid) async {
  var uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";

  Map map = {"user_uid": uid, "nickname_ingroup": name,"gid": gid};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 24,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1016,
      "actionId": 9,
    },
    hostType: 3,
  );
  if (data == "1") {
    MyToast.show("修改成功~");
    Get.back(result: true);
  } else {
    MyToast.show("修改失败~");
  }
}

//用户相册
reqUserPhoto({String uid, String type = "0"}) async {
  String id = uid;
  if (TextUtils.isEmpty(uid)) {
    id = userInfoModel.userId.toString();
  }
  Map map = {"user_uid": id, "res_type": type};
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 10,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1008,
      "actionId": 9,
    },
    hostType: 3,
  );

  if (data != null && data.isNotEmpty) {
    List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;

    return jsonList;
  }
  return [];
}

//删除照片
reqDelImage(String resourceId, String fileName, {resType = "0"}) async {
  Map map = {
    "resType": resType,
    "resourceId": resourceId,
    "fileName": fileName
  };
  var jsonString = json.encode(map);
  String data = await httpManager.netFetch(
    "",
    {
      "jobDispatchId": 10,
      "doInput": true,
      "device": 1,
      "newData": jsonString,
      "processorId": 1008,
      "actionId": 7,
    },
    hostType: 3,
  );
  MyToast.show("删除成功~");
}
