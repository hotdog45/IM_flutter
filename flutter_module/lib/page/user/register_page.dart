import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_pwd_page.dart';

class RegisterPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController numController = new TextEditingController();
  final TextEditingController codeController = new TextEditingController();
  String _challenge = "";
  String _getPhoneCode = "发送";
  bool _isClickCode = false;
  bool _isClickLogin = false;
  bool selXy = false;

// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // getMobile();
  }

  getMobile() async {
    // String mobile = await LocalStorage.get(AppConstant.USER_MOBILE);
    // userController.value = TextEditingValue(text: "18758586900");
    // pwController.value = TextEditingValue(text: "123456");

    _setBtnState();
  }

  void _setBtnState() {
    _isClickCode =
        nameController.text.length > 2 && numController.text.length > 5;
    _isClickLogin = numController.text.length > 5 &&
        nameController.text.length > 2 &&
        codeController.text.length > 2;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            appBar: YPAppBar("").build(context),
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
                            text: "用户注册",
                            fontSize: 50.sp,
                            textColor: kAppColor("#0D0E15"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 107.w, left: 75.w),
                          ),
                          MySuperWidget(
                            text: "请使用邮箱或者手机号注册",
                            fontSize: 32.sp,
                            textColor: kAppColor("#B7B7BB"),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 16.w, left: 75.w),
                          ),
                          _loginView(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // icon_xy_no
                              MySuperWidget(
                                onTap: () {
                                  setState(() {
                                    selXy = !selXy;
                                  });
                                },
                                padding: EdgeInsets.only(
                                    left: 75.w, right: 16.w, top: 82.w),
                                child: Image.asset(
                                  Config.KEY_IMAGE_PATH +
                                      (selXy
                                          ? "icon_xy_sel.png"
                                          : "icon_xy_no.png"),
                                  width: 35.w,
                                  height: 35.w,
                                ),
                              ),
                              MySuperWidget(
                                text: "已阅读并同意《用户协议》和《隐私政策》",
                                fontSize: 28.sp,
                                textColor: kAppColor("#363638"),
                                radius: 12.w,
                                onTap: () {
                                  MyToast.show("点击了用户协议");
                                },
                              ),
                            ],
                          ),
                          MySuperWidget(
                            text: "下一步",
                            onTap: () {
                              if (nameController.text.length < 2) {
                                MyToast.show("请输入昵称");

                                return;
                              }
                              if (numController.text.length < 6) {
                                MyToast.show("请输入手机号或者邮箱");

                                return;
                              }
                              if (codeController.text.length < 6) {
                                MyToast.show("请输入验证码");
                                return;
                              }
                              if (!selXy) {
                                MyToast.show("请同意协议");

                                return;
                              }
                              Get.to(SettingPwdPage(
                                type: 2,
                                name: nameController.text,
                                code: codeController.text,
                                num: numController.text,
                              ));
                            },
                            fontSize: 32.sp,
                            textColor: Colors.white,
                            bgColor: kAppThemeColor,
                            height: 88.w,
                            radius: 12.w,
                            margin: EdgeInsets.only(
                                top: 34.w, left: 60.w, right: 60.w),
                          ),
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
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 25.w),
                hintText: '请输入昵称', //（18758586900）
                hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                border: InputBorder.none,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(18),
              ],
              onChanged: (v) {
                _setBtnState();
              },
              style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
              textAlign: TextAlign.left,
            ),
          ),
          MySuperWidget(
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
            child: TextField(
              controller: numController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 25.w),
                hintText: '请输入邮箱/手机号', //（18758586900）
                hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                border: InputBorder.none,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(18),
              ],
              onChanged: (v) {
                _setBtnState();
              },
              style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
              textAlign: TextAlign.left,
            ),
          ),
          MySuperWidget(
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25.w),
                      hintText: '请输入验证码', //（18758586900）
                      hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                    onChanged: (v) {
                      _setBtnState();
                    },
                    style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                MySuperWidget(
                  text: _getPhoneCode,
                  onTap: sendMsg,
                  textColor: kAppColor("#00A43C"),
                  padding: EdgeInsets.all(24.w),
                )
              ],
            ),
          ),
        ]));
  }

  Timer _countdownTimer;
  int _countdownNum = 59;

  void reGetCountdown() {
    if (_countdownTimer != null) {
      return;
    }
    // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
    _getPhoneCode = '重新获取(${_countdownNum}s)';
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownNum > 0) {
          _countdownNum = _countdownNum - 1;
          _getPhoneCode = '重新获取(${_countdownNum}s)';
        } else {
          _getPhoneCode = '发送';
          _countdownNum = 59;
          _countdownTimer.cancel();
          _countdownTimer = null;
        }
      });
    });
  }


  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  void sendMsg() {
    if (_countdownNum < 59) {
      return;
    }
    if (numController.text.length < 6) {
      MyToast.show("请输入手机号或者邮箱");

      return;
    }
    reqSecurityCode(numController.text);
    reGetCountdown();
  }


}
