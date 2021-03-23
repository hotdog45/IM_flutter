import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/user/reset_pwd_page.dart';
import 'package:flutter_module/widget/amount/key_event.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/pwd/custom_password_field.dart';
import 'package:flutter_module/widget/pwd/my_keyboard_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'real_name_auth_page.dart';

class PayPwd2Page extends StatefulWidget {
  final int type; //1重置 2设置

  const PayPwd2Page({Key key, this.type}) : super(key: key);
  @override
  _PayPwd2PageState createState() => _PayPwd2PageState();
}

class _PayPwd2PageState extends State<PayPwd2Page> {
  final TextEditingController pwd1Controller = new TextEditingController();
  final TextEditingController pwd2Controller = new TextEditingController();

  var title = "修改密码";
  var subTitle = "请输入6位新密码，用于支付验证";
  var btnTitle = "输入密码";
  @override
  void initState() {
    super.initState();
    if (widget.type == 2) {
      title = "设置支付密码";
      subTitle = "为了您的账户安全，请设置6位密码";
      btnTitle = "重新设置密码";
    }
  }

// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            appBar: YPAppBar("").build(context),
            body: Container(
              height: 1.sh,
              width: 1.sw,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MySuperWidget(
                      text: "修改支付密码",
                      fontSize: 50.sp,
                      textColor: kAppColor("#0D0E15"),
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 107.w, left: 75.w),
                    ),
                    MySuperWidget(
                      text: "请输入原始支付密码，以验证身份",
                      fontSize: 32.sp,
                      textColor: kAppColor("#B7B7BB"),
                      alignment: Alignment.centerLeft,
                      margin:
                          EdgeInsets.only(top: 16.w, left: 75.w),
                    ),
                    _inputView(),
                    MySuperWidget(
                      onTap: () {
                        if (pwd1Controller.text.length < 6) {
                          MyToast.show( "密码不能少于6位");
                          return;
                        }
                        if (pwd1Controller.text != pwd2Controller.text) {
                          MyToast.show("两次密码不一致");
                          return;
                        }
                        MyToast.show( "设置成功~");
                        Get.back();
                      },
                      text: "确定",
                      fontSize: 32.sp,
                      textColor: Colors.white,
                      bgColor: kAppThemeColor,
                      height: 88.w,
                      radius: 8.w,
                      margin:
                          EdgeInsets.only(top: 120.w, left: 60.w, right: 60.w),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _inputView() {
    return Container(
        padding: EdgeInsets.only(left: 60.w, right: 60.w, top: 90.w),
        child: Column(children: <Widget>[
          MySuperWidget(
            bgColor: kAppWhiteColor,
            radius: 4,
            height: 88.w,
            hasBorder: true,
            borderColor: kAppColor("#D6D6D6"),
            child: Row(
              children: [
                MySuperWidget(
                  text: "输入密码",
                  fontSize: 32.sp,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  textColor: kAppTextColor,
                ),
                Expanded(
                  child: TextField(
                    controller: pwd1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25.w),
                      hintText: '请输入', //（18758586900）
                      hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                    ],
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          MySuperWidget(
            bgColor: kAppWhiteColor,
            radius: 4,
            height: 88.w,
            hasBorder: true,
            borderColor: kAppColor("#D6D6D6"),
            margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
            child: Row(
              children: [
                MySuperWidget(
                  text: "确认密码",
                  fontSize: 32.sp,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  textColor: kAppTextColor,
                ),
                Expanded(
                  child: TextField(
                    controller: pwd2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25.w),
                      hintText: '请输入', //（18758586900）
                      hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                    ],
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
