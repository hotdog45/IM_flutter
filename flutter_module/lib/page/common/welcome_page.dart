import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/net/rok_dao.dart';

import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../user/login_page.dart';
import 'main_page.dart';

class WelcomePage extends StatefulWidget {


  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // Future.delayed(const Duration(seconds: 1), () {
    //   autoLogin();
    // });
    autoLogin();
  }

  // initParams() async {
  //   String token = await LocalStorage.get(AppConstant.USER_TOKEN) ?? "";
  //   if (token.isNotEmpty) {
  //     Get.off(MainPage());
  //   } else {
  //     Get.off(LoginPage());
  //   }
  // }
  autoLogin() async {
    String uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
    String autoLogin = await LocalStorage.get("AutoLogin") ?? "0";
    String pwd = await LocalStorage.get("pwd") ?? "";
    if (uid.isNotEmpty && autoLogin == "1") {
      reqAccountLogin(uid, pwd, isAuto: true);
    }else{
      Get.off(LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Center(
          child: Image.asset(
            "static/images/bg_qidongye.png",
            scale: 0.5,
            fit: BoxFit.fill,
            height: 1.sh,
          ),
        ),
      ],padding: EdgeInsets.all(0),),
    );
  }
}
