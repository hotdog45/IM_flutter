import 'package:flutter/material.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/app_init_utils.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'about_page.dart';
import 'head_portrait_page.dart';
import 'login_page.dart';
import 'setting_gender_page.dart';
import 'setting_name_page.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: user_info_page
 * Author: lishunfeng
 * Date: 3/10/21 9:15 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("设置").build(context),
        body: Container(
          child: Column(
            children: [
              MyItemWidget(
                title: "新消息通知",
                isSwitch: true,
                onChanged: () {

                },
              ),
              MyItemWidget(
                title: "声音",
                isSwitch: true,
                onChanged: () {

                },
              ),
              MyItemWidget(
                title: "震动",
                isSwitch: true,
                onChanged: () {

                },
              ),
              MySuperWidget(
                height: 20.w,
              ),
              MyItemWidget(
                title: "关于我们",
                onTap: () {
                  Get.to(AboutPage());
                },
              ),
              MyItemWidget(
                title: "检查更新",
                subTitle: "当前版本: V2.71",
                onTap: () {},
              ),
              MyItemWidget(
                title: "清理缓存",
                subTitle: "28.89MB",
                onTap: () {


                },
              ),
              MyExpanded(),
              MySuperWidget(
                text: "退出登录",
                onTap: () {
                  // appInitUtils.clearUserData();
                  HiFlutterBridge.getInstance().goToNative({"action": "loginOut"});
                  Get.offAll(LoginPage());
                },
                fontSize: 32.sp,
                textColor: kAppColor("#C0342D"),
                bgColor: Colors.white,
                height: 88.w,
                radius: 12.w,
                width: 690.w,
                margin: EdgeInsets.only(bottom: 150.w, left: 15, right: 15),
              ),
            ],
          ),
        ));
  }
}
