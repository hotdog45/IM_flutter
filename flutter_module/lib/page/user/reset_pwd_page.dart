import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_pwd_page.dart';

class ResetPwdPage extends StatefulWidget {
  final int type; // 1邮箱 2手机 3银行卡
  final int setType; //1 修改密码  2忘记密码
  const ResetPwdPage({Key key, this.setType = 1, this.type = 1}) : super(key: key);

  @override
  _ResetPwdPageState createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {
  final TextEditingController numController = new TextEditingController();
  final TextEditingController codeController = new TextEditingController();

// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  var title = "";
  var subTitle = "";
  var numHint = "请输入邮箱或手机号";

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      title = "使用邮箱找回密码";
      subTitle = "请输入您的注册邮箱，以便找回密码";
    } else if (widget.type == 2) {
      title = "使用手机号找回密码";
    } else {
      title = "验证银行预留手机号";
      subTitle = "请输入银行预留手机号";
    }
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
                            text: title,
                            fontSize: 50.sp,
                            textColor: kAppColor("#0D0E15"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 107.w, left: 75.w),
                          ),
                          MySuperWidget(
                            text: subTitle,
                            fontSize: 32.sp,
                            textColor: kAppColor("#B7B7BB"),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: 16.w, left: 75.w, right: 60.w),
                          ),
                          _loginView(),
                          MySuperWidget(
                            onTap: () {
                              if (numController.text.length < 6) {
                                MyToast.show(numHint);

                                return;
                              }
                              if (codeController.text.length < 6) {
                                MyToast.show("请输入验证码~");

                                return;
                              }
                              Get.to(SettingPwdPage(type: widget.setType,num: numController.text,code: codeController.text,));
                            },
                            text: "下一步",
                            fontSize: 32.sp,
                            textColor: Colors.white,
                            bgColor: kAppThemeColor,
                            height: 88.w,
                            radius: 8.w,
                            margin: EdgeInsets.only(
                                top: 82.w, left: 60.w, right: 60.w),
                          ),
                        ]),
                  ),
                ))),
      ),
    );
  }

  Widget _loginView() {
    return Container(
        padding: EdgeInsets.only(left: 60.w, right: 60.w, top: 128.w),
        child: Column(children: <Widget>[
          MySuperWidget(
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            child: TextField(
              controller: numController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 25.w),
                hintText: numHint, //（18758586900）
                hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                border: InputBorder.none,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(18),
              ],
              onChanged: (v) {},
              style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
              textAlign: TextAlign.left,
            ),
          ),
          MySuperWidget(
            margin: EdgeInsets.only(top: 30.w),
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
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                MySuperWidget(
                  text: _getPhoneCode,
                  onTap: () {
                    if (numController.text.length < 6) {
                      MyToast.show(numHint);
                      return;
                    }
                    MyToast.show("验证码已发送");

                  },
                  textColor: kAppColor("#00A43C"),
                  padding: EdgeInsets.all(24.w),
                )
              ],
            ),
          ),
        ]));
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

  Timer _countdownTimer;
  int _countdownNum = 59;
  String _getPhoneCode = "发送";

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
}
