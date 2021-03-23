import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/page/contacts/search_friend_page.dart';
import 'package:flutter_module/page/group/group_data_page.dart';
import 'package:flutter_module/page/group/group_members_page.dart';
import 'package:flutter_module/page/group/notice_list_page.dart';
import 'package:flutter_module/page/red_envelope/red_envelope_page.dart';
import 'package:flutter_module/page/transfer/transfer_page.dart';
import 'package:flutter_module/page/chat/chat_messages_page.dart';
import 'package:flutter_module/page/user/login_page.dart';
import 'package:flutter_module/page/group/publish_notice_page.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/dialog/add_friend_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: message_page
 * Author: lishunfeng
 * Date: 2/4/21 9:08 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  var color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("发现", hasBackBtn: false).build(context),
      body: Center(
          child: Column(
        children: [
          MySuperWidget(
            text: "测试00",
            onTap: () {
              Get.to(GroupDataPage());

            },
            fontSize: 32.sp,
            textColor: Colors.white,
            bgColor: color,
            height: 88.w,
            radius: 12.w,
            margin: EdgeInsets.only(top: 80.w, left: 60.w, right: 60.w),
          ),
          MySuperWidget(
            text: "测试00",
            onTap: () {

            },
            fontSize: 32.sp,
            textColor: Colors.white,
            bgColor: color,
            height: 88.w,
            radius: 12.w,
            margin: EdgeInsets.only(top: 80.w, left: 60.w, right: 60.w),
          ),
          MySuperWidget(
            text: "测试00",
            onTap: () {

              // AddFriendDialog.show(context);
            },
            fontSize: 32.sp,
            textColor: Colors.white,
            bgColor: color,
            height: 88.w,
            radius: 12.w,
            margin: EdgeInsets.only(top: 80.w, left: 60.w, right: 60.w),
          ),
          MySuperWidget(
            text: "测试00",
            onTap: () {

            },
            fontSize: 32.sp,
            textColor: Colors.white,
            bgColor: kAppThemeColor,
            height: 88.w,
            radius: 12.w,
            margin: EdgeInsets.only(top: 80.w, left: 60.w, right: 60.w),
          ),
        ],
      )),
    );
  }
}
