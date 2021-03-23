import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/style/style.dart';
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

import 'pay_pwd2_page.dart';
import 'real_name_auth_page.dart';

class PayPwd1Page extends StatefulWidget {
  @override
  _PayPwd1PageState createState() => _PayPwd1PageState();
}

class _PayPwd1PageState extends State<PayPwd1Page> {


  var pwdData = "";

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
                          EdgeInsets.only(top: 16.w, left: 75.w, bottom: 168.w),
                    ),

                    ///密码框
                    Container(
                        width: 600.w,
                        height: 90.w,
                        child: CustomJPasswordField(pwdData)),
                    MySuperWidget(
                      onTap: (){

                        Get.to(RealNameAuthPage(type: 2));
                      },
                        text: "忘记密码？",
                        fontSize: 32.sp,
                        textColor: kAppColor("#363638"),
                        margin: EdgeInsets.only(top: 66.w)),


                    MyExpanded(),
                    MyKeyboard(callback: _onKeyDown)
                  ]),
            )),
      ),
    );
  }

  void _onKeyDown(KeyEvent data) {
    if (data.key == "") return;
    if (data.isDelete()) {
      if (pwdData.length > 0) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
      }
    } else {
      if (pwdData.length < 6) {
        pwdData += data.key;
      }
    }
    setState(() {});
    if (pwdData.length == 6){
      Get.off(PayPwd2Page());
    }
  }
}
