import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_module/common/constant/app_constant.dart';

import 'local_storage.dart';
import 'dart:convert' as convert;

//保存用户的登陆信息
class SaveLoginUser {
//   static void saveUser(UserModel userModel) {
//     String carString = json.encode(userModel).toString();
//
//     LocalStorage.save(AppConstant.USER_LOGIN, carString);
//
//     LocalStorage.save(AppConstant.USER_NAME, userModel.userName);
//     LocalStorage.save(AppConstant.USER_ID, userModel.userId.toString());
//     LocalStorage.save(AppConstant.USER_AVATAR_PATH, userModel.avatarPath);
//
//     String josnNameString = convert.jsonEncode(userModel.menuList);
//
//     LocalStorage.save(AppConstant.USER_MENU_LIST, josnNameString);
//   }

  //清空登陆的数据
  static void clearUser() async {
    LocalStorage.save(AppConstant.USER_NAME, "");
    LocalStorage.save(AppConstant.USER_ID, "");
    LocalStorage.save(AppConstant.USER_AVATAR_PATH, "");
    await LocalStorage.remove(AppConstant.USER_COOKIE);
  }

//获取极光推送的id
  static Future<String> getJpushRegId() async {
    var value = await LocalStorage.get(AppConstant.J_PUSH_REG_ID) ?? "";

    return value;
  }

  //获取登陆成功之后   保存的用户头像路径
  static Future<String> getAvatarPath() async {
    var value = await LocalStorage.get(AppConstant.USER_AVATAR_PATH) ?? "";

    return value;
  }

  //获取登陆成功之后   保存的用户姓名
  static Future<String> getUserName() async {
    var value = await LocalStorage.get(AppConstant.USER_NAME) ?? "";

    return value;
  }

//获取登陆成功之后   保存的用户id
  static Future<String> getUserID() async {
    var value = await LocalStorage.get(AppConstant.USER_ID) ?? "";

    return value;
  }



}
