import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'custom_password_field.dart';
import '../amount/key_event.dart';
import 'my_keyboard_widget.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: pwd_keyboard_widget
 * Author: lishunfeng
 * Date: 2/11/21 12:24 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

/// 支付密码弹窗  +  自定义键盘

class PwdKeyboardDialog extends StatefulWidget {
  final pwdChange;
  final bool isShowPwdErr;

  const PwdKeyboardDialog({Key key, this.pwdChange, this.isShowPwdErr = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PwdKeyboardDialogState();
}

class PwdKeyboardDialogState extends State<PwdKeyboardDialog> {
  /// 用户输入的密码
  String pwdData = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext c) {
    return MySuperWidget(
      height: 1.sh,
      bgColor: Colors.transparent,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Center(
            child: MySuperWidget(
              height: 460.w,
              width: 600.w,
              radius: 20.w,
              margin: EdgeInsets.only(top: 200.w),
              bgColor: Colors.white,
              child: Stack(
                children: [
                  Column(
                    children: [
                      MySuperWidget(
                        text: "请输入支付密码",
                        fontSize: 32.sp,
                        padding: EdgeInsets.only(top: 25.w, bottom: 20.w),
                        textColor: kAppColor("#0D0E15"),
                      ),
                      MySuperWidget(
                        text: "金额",
                        fontSize: 32.sp,
                        textColor: kAppColor("#B7B7BB"),
                      ),
                      MySuperWidget(
                        text: "¥ 888.88",
                        fontSize: 80.sp,
                        fontWeight: FontWeight.bold,
                        padding: EdgeInsets.only(top: 5.w),
                        textColor: kAppColor("#0D0E15"),
                      ),
                      widget.isShowPwdErr
                          ? MySuperWidget(
                              text: "支付密码不正确",
                              fontSize: 32.sp,
                              padding: EdgeInsets.only(bottom: 20.w),
                              textColor: kAppColor("#C1342D"))
                          : Container(height: 50.w),

                      ///密码框
                      Container(
                          width: 540.w,
                          height: 90.w,
                          child: CustomJPasswordField(pwdData)),
                      MySuperWidget(
                        text: "忘记密码？",
                        fontSize: 32.sp,
                        padding: EdgeInsets.only(top: 20.w),
                        textColor: kAppColor("#00A43C"),
                      )
                    ],
                  ),
                  Positioned(
                    right: 6.w,
                    child: MySuperWidget(
                      onTap: () {
                        Get.back();
                      },
                      padding: EdgeInsets.all(28.w),
                      child: Image.asset(
                        Config.KEY_IMAGE_PATH + "icon_kb_close.png",
                        width: 30.w,
                        height: 30.w,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
          MyKeyboard(callback: _onKeyDown)
        ],
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

    widget.pwdChange(pwdData);
    setState(() {});
  }
}
