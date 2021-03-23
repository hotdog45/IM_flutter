import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'complaints_desc_page.dart';
import 'head_portrait_page.dart';
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

class ComplaintsPage extends StatefulWidget {
  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("投诉").build(context),
        body: Container(
          child: Column(
            children: [
              MySuperWidget(
                text: "请选择一项违规内容：",
                textColor: kAppColor("#78787C"),
                alignment: Alignment.centerLeft,
                fontSize: 28.w,
                height: 90.w,
                margin: EdgeInsets.only(left: 30.w),
              ),
              MyItemWidget(
                title: "发布垃圾广告内容",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              ),
              MyItemWidget(
                title: "账号可能被盗",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              ),MyItemWidget(
                title: "发布违法有害信息",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              ),MyItemWidget(
                title: "存在赌博行为",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              ),MyItemWidget(
                title: "存在欺骗行为",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              ),MyItemWidget(
                title: "辱骂骚扰",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              ),MyItemWidget(
                title: "其他",
                onTap: () {
                  Get.to(ComplaintsDescPage());
                },
              )
            ],
          ),
        ));
  }
}
