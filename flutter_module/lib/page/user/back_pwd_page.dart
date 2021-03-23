
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'reset_pwd_page.dart';

class BackPwdPage extends StatefulWidget {
  final int setType; //1 修改密码  2忘记密码

  const BackPwdPage({Key key, this.setType = 1}) : super(key: key);

  @override
  _BackPwdPageState createState() => _BackPwdPageState();
}

class _BackPwdPageState extends State<BackPwdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("").build(context),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MySuperWidget(
                text: "找回密码",
                fontSize: 50.sp,
                textColor: kAppColor("#0D0E15"),
                fontWeight: FontWeight.bold,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 107.w, left: 75.w),
              ),
              MySuperWidget(
                text: "请选择找回密码的方式",
                fontSize: 32.sp,
                textColor: kAppColor("#B7B7BB"),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16.w, left: 75.w, right: 60.w),
              ),
              MySuperWidget(
                onTap: () {
                  Get.to(ResetPwdPage());
                },
                padding: EdgeInsets.only(left: 24.w,right: 24.w),
                child: Row(
                  children: [
                    Expanded(
                      child: MySuperWidget(
                        text: "根据登录邮箱找回密码",
                        textColor: kAppColor("#78787C"),
                        fontSize: 32.sp,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Image.asset(
                      Config.KEY_IMAGE_PATH + "icon_right_b.png",
                      width:  28.w,
                      height: 28.w,
                    ),
                  ],
                ),
                hasBorder: true,
                borderColor: kAppColor("#D6D6D6"),
                height: 88.w,
                radius: 8.w,
                margin: EdgeInsets.only(top: 128.w, left: 60.w, right: 60.w),
              ),
              MySuperWidget(
                onTap: () {
                  Get.to(ResetPwdPage(type: 2));
                },
                padding: EdgeInsets.only(left: 24.w,right: 24.w),
                child: Row(
                  children: [
                    Expanded(
                      child: MySuperWidget(
                        text: "根据手机找回密码",
                        textColor: kAppColor("#78787C"),
                        fontSize: 32.sp,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Image.asset(
                      Config.KEY_IMAGE_PATH + "icon_right_b.png",
                      width:  28.w,
                      height: 28.w,
                    ),
                  ],
                ),
                hasBorder: true,
                borderColor: kAppColor("#D6D6D6"),
                height: 88.w,
                radius: 8.w,
                margin: EdgeInsets.only(top: 36.w, left: 60.w, right: 60.w),
              ),
            ]));
  }
}
