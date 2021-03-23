import 'dart:io';

import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/page/common/main_page.dart';
import 'package:flutter_module/page/common/welcome_page.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'local_storage.dart';



final AppInitUtils appInitUtils = AppInitUtils();

class AppInitUtils {

   BuildContext appContext;

   Future saveUserData(jsonData) async {
     // LocalStorage.save(AppConstant.USER_TOKEN, jsonData["token"]);
     // LocalStorage.save(AppConstant.USER_ID, jsonData["user_id"]);
     // LocalStorage.save(AppConstant.USER_NICKNAME, jsonData["nickname"]);
     // LocalStorage.save(AppConstant.USER_SEX, jsonData["user_sex"]);
     // LocalStorage.save(AppConstant.USER_AVATAR_PATH, jsonData["userAvatarFileName"]);
   }
//移除用户数据
  Future clearUserData() async {
    // LocalStorage.save(AppConstant.USER_TOKEN, "");
    // LocalStorage.save(AppConstant.USER_ID, "");
    // LocalStorage.save(AppConstant.USER_NICKNAME, "");
    // LocalStorage.save(AppConstant.USER_SEX, "");
    // LocalStorage.save(AppConstant.USER_AVATAR_PATH, "");
  }

  initFluwx() async {
    // await registerWxApi(
    //     appId: "wxb68309ed6b51fa56",
    //     doOnAndroid: true,
    //     doOnIOS: true,
    //     universalLink: "https://www.baidu.com");
  }

  //友盟统计
  Future<void> initUmeng() async {
//    var result = await UmengAnalyticsPlugin.init(
//      androidKey: '5f04300b167edd29040000ac',
//      iosKey: '5f0430250cafb223330000a3',
//    );
//
//    print('Umeng initialized:' + result.toString());
  }

  initEasyLoading() async {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..userInteractions = false;
    EasyLoading.dismiss();
  }

  initAndroidSystemUI() async {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  appRoutes() {
    return {
      // WelcomePage.sName: (context) => WelcomePage(),
      MainPage.sName: (context) => MainPage(),

    };
  }

  ThemeData initThemeData() {
    return ThemeData(
        brightness: Brightness.light,
//        primaryColor: kAppThemeColor,
        primaryColor: Colors.greenAccent,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black)));
  }
}
