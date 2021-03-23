
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

import 'setting_gender_page.dart';

class SettingPwdPage extends StatefulWidget {
  final int type; //1重置
  final String name;
  final String num;
  final String code;

  const SettingPwdPage({Key key, this.type, this.name, this.num, this.code})
      : super(key: key);

  @override
  _SettingPwdPageState createState() => _SettingPwdPageState();
}

class _SettingPwdPageState extends State<SettingPwdPage> {
  final TextEditingController pwdController = new TextEditingController();
  final TextEditingController pwd2Controller = new TextEditingController();

// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            appBar: YPAppBar("", actions:widget.type == 1? null: [
              MySuperWidget(
                text: "登录",
                fontSize: 28.sp,
                textColor: kAppColor("#363638"),
                padding: EdgeInsets.only(right: 30.w),
              ),
            ]).build(context),
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
                            text: widget.type == 1 ? "重置密码" : "设置密码",
                            fontSize: 50.sp,
                            textColor: kAppColor("#0D0E15"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 107.w, left: 75.w),
                          ),
                          MySuperWidget(
                            text: "为了您的信息安全，请尽量设置复杂度较高的密码",
                            fontSize: 32.sp,
                            textColor: kAppColor("#B7B7BB"),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: 16.w, left: 75.w, right: 60.w),
                          ),
                          _loginView(),
                          MySuperWidget(
                            text: widget.type == 1 ? "完成" : "下一步",
                            onTap: nextOrDone,
                            fontSize: 32.sp,
                            textColor: Colors.white,
                            bgColor: kAppThemeColor,
                            height: 88.w,
                            radius: 8.w,
                            margin: EdgeInsets.only(
                                top: 200.w, left: 60.w, right: 60.w),
                          ),
                        ]),
                  ),
                ))),
      ),
    );
  }

  Widget _loginView() {
    return Container(
        padding: EdgeInsets.only(left: 60.w, right: 60.w, top: 45.w),
        child: Column(children: <Widget>[
          MySuperWidget(
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            child: TextField(
              controller: pwdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 25.w),
                hintText: '请输入密码，不少于6位', //（18758586900）
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
            bgColor: kAppColor("#F1F1F1"),
            radius: 4,
            margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
            child: TextField(
              controller: pwd2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 25.w),
                hintText: '请确认您的密码', //（18758586900）
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
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void nextOrDone() {

    if (pwdController.text.length < 6) {
      MyToast.show("密码不能少于6位");
      return;
    }
    if (pwdController.text != pwd2Controller.text) {
      MyToast.show("两次密码不一致");

      return;
    }
    if (widget.type == 1) {

      reqAccountPasswordSet(widget.num,widget.code,pwdController.text,widget.type);
      // Get.offAll(LoginPage(type: 2,pwd: pwdController.text));
    } else {
      Get.to(SettingGenderPage(
          name: widget.name,
          code: widget.code,
          num: widget.num,
          pwd: pwdController.text));
    }
  }
}
