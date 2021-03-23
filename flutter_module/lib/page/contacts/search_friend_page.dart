import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'accurate_friend_page.dart';
import 'search_results_page.dart';

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

class SearchFriendPage extends StatefulWidget {
  final String title;

  const SearchFriendPage({Key key, this.title}) : super(key: key);
  @override
  _SearchFriendPageState createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  final TextEditingController descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: [
        MyImage(
          "bg_search_friend.png",
          isAssetImage: true,
        ),
        Positioned(
            child: MyImage("icon_left.png",
                isAssetImage: true,
                width: 20,
                height: 20,
                padding: EdgeInsets.only(right: 50, bottom: 50), onTap: () {
              Get.back();
            }),
            left: 30.w,
            top: 25.w + ScreenUtil().statusBarHeight),
        Positioned(
            child: MyImage("icon_search_b.png",
                isAssetImage: true,
                width: 20,
                height: 20,
                padding: EdgeInsets.only(left: 50, bottom: 50), onTap: () {
              Get.to(AccurateFriendPage());
            }),
            right: 30.w,
            top: 25.w + ScreenUtil().statusBarHeight),
        Container(
          padding: EdgeInsets.only(left: 60.w, top: 200.w),
          child: ListView(
            children: [
              MySuperWidget(
                text: "随机查找新朋友",
                fontSize: 48.w,
                fontWeight: FontWeight.bold,
                alignment: Alignment.centerLeft,
              ),
              MySuperWidget(
                text: "请选择是否在线",
                fontSize: 28.w,
                textColor: kAppColor("#78787C"),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 114.w, bottom: 20.w),
              ),
              Row(
                children: [
                  _btnWidget("全部", true),
                  _btnWidget("在线", false),
                  _btnWidget("离线", false),
                ],
              ),
              MySuperWidget(
                text: "请选择性别",
                fontSize: 28.w,
                textColor: kAppColor("#78787C"),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 114.w, bottom: 20.w),
              ),
              Row(
                children: [
                  _btnWidget("全部", true),
                  _btnWidget("男", false),
                  _btnWidget("女", false),
                ],
              ),
              MySuperWidget(
                text: "开始查找",
                onTap: () {
                  Get.to(SearchResultsPage());
                },
                fontSize: 32.sp,
                textColor: Colors.white,
                bgColor: kAppThemeColor,
                height: 88.w,
                radius: 8.w,
                margin: EdgeInsets.only(top: 130.w, right: 60.w),
              ),
            ],
          ),
        )
      ],
    )));
  }

  _btnWidget(text, sel) {
    return Stack(
      children: [
        MySuperWidget(
          width: 196.w,
          height: 88.w,
          text: text,
          fontSize: 32.w,
          textColor: sel ? kAppColor("#C1342D") : kAppColor("#78787C"),
          fontWeight: FontWeight.bold,
          hasBorder: true,
          borderColor: sel ? kAppColor("#FFDDDC") : kAppColor("#F0F0F0"),
          margin: EdgeInsets.only(right: 20.w),
          borderWidth: 1,
          radius: 3,
        ),
        sel
            ? Positioned(
                right: 20.w,
                bottom: 0,
                child: MyImage(
                  "icon_search_dui.png",
                  isAssetImage: true,
                  width: 52.w,
                  height: 37.w,
                ))
            : Container()
      ],
    );
  }
}
