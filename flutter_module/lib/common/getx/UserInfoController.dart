import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/user_info_model.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: UserInfoController
 * Author: lishunfeng
 * Date: 3/23/21 12:59 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

/// 用户数据控制器 {code: 0, message: , body: {token_id: account_9aca504f-bf4c-49ec-bec7-fd35674cf183,
/// user_id: 400149, userAvatarFileName: 400149_4894cbdf-2fc2-4e52-bf24-a66777306bd8.jpg, nickname: 往哪走,
/// user_mail: 15829566852, whatsUp: , latest_login_ip: 127.0.0.1, acc_id: 7368881529466880,
/// latest_login_time: 2021-03-23T13:11:13.823738113+08:00, liveStatus: 1, online: true,
/// man: true, maxFriend: 5000, register_time: 2021-02-19T22:11:28+08:00, user_type: 0,
/// user_sex: 1, token: account_9aca504f-bf4c-49ec-bec7-fd35674cf183, userDesc: }
class UserController extends GetxController {


  var tokenId = "".obs;
  var userId = 0.obs;
  var userAvatarFileName = "".obs;
  var nickname = "".obs;
  var userMail = "".obs;
  var whatsUp = "".obs;
  var latestLoginIp = "".obs;
  var accId = 0.obs;
  var latestLoginTime   = DateTime.now().obs;
  var liveStatus= 0.obs;
  var online= true.obs;
  var man= true.obs;
  var maxFriend= 5000.obs;
  var registerTime  = DateTime.now().obs;
  var userType= 1.obs;
  var userSex= 0.obs;
  var token  = "".obs;
  var userDesc  = "".obs;

  var  userInfoModel = UserInfoModel().obs;

  // void setUserInfo(UserInfoModel userInfo) {
  //   token.value = userInfo.token;
  //   userId.value = userInfo.userId;
  //   tokenId.value = userInfo.tokenId;
  //   userAvatarFileName.value = userInfo.userAvatarFileName;
  //   nickname.value = userInfo.nickname;
  //   userMail.value = userInfo.userMail;
  //   whatsUp.value = userInfo.whatsUp;
  //   accId.value = userInfo.accId;
  //   latestLoginTime.value = userInfo.latestLoginTime;
  //   liveStatus.value = userInfo.liveStatus;
  //   online.value = userInfo.online;
  //   man.value = userInfo.man;
  //   userDesc.value = userInfo.userDesc;
  //   userType.value = userInfo.userType;
  //   userSex.value = userInfo.userSex;
  //
  //
  //   update();
  // }


  @override
  void onInit() {
    super.onInit();
    print('SimpleController--onInit');
  }

  @override
  void onReady() {
    super.onReady();
    print('SimpleController--onReady');
  }

  @override
  void onClose() {
    super.onClose();
    print('SimpleController--onClose');
  }
}