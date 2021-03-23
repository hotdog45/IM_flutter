import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/page/other/my_qr_page.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

class AccurateFriendPage extends StatefulWidget {
  @override
  _AccurateFriendPageState createState() => _AccurateFriendPageState();
}

class _AccurateFriendPageState extends State<AccurateFriendPage> {
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
                bgColor: kAppColor("#F8F9FB"),
                radius: 4,
                alignment: Alignment.centerLeft,
                height: 90.w,
                hasBorder: true,
                borderColor: kAppColor("#F0F0F0"),
                borderWidth: 1,
                margin: EdgeInsets.only(right: 60.w, bottom: 20.w, top: 100.w),
                child: TextField(
                  controller: descController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25.w),
                    hintText: "输入对方账号/手机号/邮箱",
                    hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {},
                  style: TextStyle(fontSize: 30.sp, color: kAppTextColor),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
              ),
              MySuperWidget(
                  bgColor: kAppColor("#F8F9FB"),
                  radius: 4,
                  alignment: Alignment.centerLeft,
                  hasBorder: true,
                  borderColor: kAppColor("#F0F0F0"),
                  borderWidth: 1,
                  margin: EdgeInsets.only(right: 60.w, top: 30.w),
                  child: Column(
                    children: [
                      _itemWidget("扫一扫", "扫描二维码名片", "icon_saoma.png",onTap: ()=>Get.off(QrCodePage())),
                      _itemWidget("邀请好友", "分享邀请更多好友", "icon_share.png"),
                    ],
                  )),
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
                margin: EdgeInsets.only(top: 60.w, right: 60.w),
              ),
            ],
          ),
        )
      ],
    )));
  }

  _itemWidget(title, subTitle, icon, {onTap}) {
    return MySuperWidget(
      onTap: () => onTap,
      child: Column(
        children: [
          MySuperWidget(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            height: 150.w,
            child: Row(
              children: [
                MyImage(
                  icon,
                  width: 106.w,
                  height: 106.w,
                  margin: EdgeInsets.only(right: 30.w),
                  isAssetImage: true,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MySuperWidget(
                        alignment: Alignment.centerLeft,
                        text: title ?? "",
                        fontSize: 34.sp,
                        textColor: kAppColor("#0D0E15"),
                      ),
                      MySuperWidget(
                        alignment: Alignment.centerLeft,
                        maxLines: 1,
                        text: subTitle ?? "",
                        fontSize: 28.sp,
                        margin: EdgeInsets.only(top: 5),
                        textColor: kAppColor("#B7B7BB"),
                      ),
                    ],
                  ),
                ),
                MyImage(
                  "icon_right_b.png",
                  width: 24.w,
                  height: 24.w,
                  isAssetImage: true,
                ),
              ],
            ),
          ),
          MySuperWidget(
            margin: EdgeInsets.only(left: 104.w, right: 30.w),
            bgColor: kAppColor("#F0F0F0"),
            height: 0.5,
          )
        ],
      ),
    );
  }
}
