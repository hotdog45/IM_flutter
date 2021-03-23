
import 'package:dio_log/dio_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'back_pwd_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  final int type; //1 注册  2重置密码
  final String uid;
  final String pwd;

  const LoginPage({Key key, this.type, this.uid, this.pwd}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  @override
  void initState() {
    super.initState();
    showDebugBtn(context);

    autoLogin();
    // HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
    //   if (Navigator.canPop(context)){
    //     Navigator.pop(context);
    //   }
    //
    // });
  }

  autoLogin() async {
    if (widget.type == 1){
      reqAccountLogin(widget.uid, widget.pwd);
      return;
    }
    String uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
    if (widget.type == 2){
      reqAccountLogin(uid, widget.pwd);
      return;
    }
    String autoLogin = await LocalStorage.get("AutoLogin") ?? "0";
    String pwd = await LocalStorage.get("pwd") ?? "";
    userController.value = TextEditingValue(text: uid);
    pwController.value = TextEditingValue(text: pwd);
    if (uid.isNotEmpty && autoLogin == "1") {
      reqAccountLogin(uid, pwd, isAuto: true);
    }

  }

  getMobile() async {
    userController.value = TextEditingValue(text: "400143");
    pwController.value = TextEditingValue(text: "123456");
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            body: GestureDetector(
                onTap: () {
                  // 点击空白页面关闭键盘
                  FocusScope.of(context).requestFocus(blankNode);
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: 1.sh,
                    width: 1.sw,
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MySuperWidget(
                            text: "用户登录",
                            fontSize: 50.sp,
                            textColor: kAppColor("#0D0E15"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 257.w, left: 75.w),
                          ),
                          MySuperWidget(
                            text: "User login",
                            fontSize: 50.sp,
                            textColor: kAppColor("#E4E4E9"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 16.w, left: 75.w),
                          ),
                          _loginView(),
                          MySuperWidget(
                            text: "登录",
                            onTap: _login,
                            fontSize: 32.sp,
                            textColor: Colors.white,
                            bgColor: kAppThemeColor,
                            height: 88.w,
                            radius: 12.w,
                            margin: EdgeInsets.only(
                                top: 80.w, left: 60.w, right: 60.w),
                          ),
                          MySuperWidget(
                            text: "注册",
                            onTap: () {
                              Get.to(RegisterPage());
                            },
                            fontSize: 32.sp,
                            textColor: kAppColor("#C0342D"),
                            bgColor: Colors.white,
                            height: 88.w,
                            borderColor: kAppThemeColor,
                            hasBorder: true,
                            radius: 12.w,
                            margin: EdgeInsets.only(
                                top: 30.w, left: 60.w, right: 60.w),
                          ),
                          _goCheckBtn(),
                        ]),
                  ),
                ))),
      ),
    );
  }

  Widget _loginView() {
    return Container(
        padding: EdgeInsets.only(left: 60.w, right: 60.w, top: 90.w),
        child: Column(children: <Widget>[
          MySuperWidget(
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 20.w),
                  child: Image.asset(
                    Config.KEY_IMAGE_PATH + "icon_user_phone.png",
                    width: 38.w,
                    height: 38.w,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintText: '邮箱/手机号',
                      hintStyle: TextStyle(color: Color(0xffc3c3c3)), //修改颜色
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 34.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                MySuperWidget(
                  onTap: () {
                    userController.text = "";
                  },
                  padding: EdgeInsets.all(15.0),
                  child: Image.asset(
                    Config.KEY_IMAGE_PATH + "icon_clean.png",
                    width: 30.w,
                    height: 30.w,
                  ),
                ),
              ],
            ),
          ),
          MySuperWidget(
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            margin: EdgeInsets.only(top: 30.w),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 20.w),
                  child: Image.asset(
                    Config.KEY_IMAGE_PATH + "icon_user_pwd.png",
                    width: 38.w,
                    height: 38.w,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: pwController,
                    decoration: InputDecoration(
                      hintText: '密码',
                      hintStyle: TextStyle(color: Color(0xffc3c3c3)), //修改颜色
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 34.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  Widget _goCheckBtn() {
    return Container(
      margin: EdgeInsets.only(top: 50.w, left: 60.w, right: 60.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          MySuperWidget(
            onTap: () {
              Get.to(BackPwdPage(setType: 2));
            },
            text: "忘记密码？",
            textColor: kAppColor("#363638"),
            fontSize: 32.sp,
          ),
          Expanded(child: Container()),
          MySuperWidget(
            onTap: () {
              Get.to(RegisterPage());
            },
            text: "注册",
            textColor: kAppColor("#363638"),
            fontSize: 32.sp,
          ),
        ],
      ),
    );
  }

  void _login() {
    if (userController.text.length < 6) {
      MyToast.show("请输入手机号或者邮箱");

      return;
    }
    if (pwController.text.length < 6) {
      MyToast.show("请输入密码");
      return;
    }
    FocusScope.of(context).requestFocus(blankNode);
    reqAccountLogin(userController.text, pwController.text);
  }
}
