import 'package:flutter/material.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/app_init_utils.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("关于我们").build(context),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              MyImage(
                "logo_app.png",
                width: 132.w,
                height: 132.w,
                isAssetImage: true,
                margin: EdgeInsets.only(top: 128.w),
              ),
              MySuperWidget(
                text: "密语",
                fontSize: 40.sp,
                textColor: kAppColor("#111111"),
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.only(top: 26.w),
              ),
              MySuperWidget(
                text: "当前版本: V2.71",
                fontSize: 32.sp,
                textColor: kAppColor("#78787C"),
                padding: EdgeInsets.only(bottom: 126.w),
              ),

              MySuperWidget(
                height: 20.w,
                  bgColor: kAppColor("#F8F9FB")
              ),
              MyItemWidget(
                title: "隐私政策",
                onTap: () {},
              ),

              Expanded(child: Container(color: kAppColor("#F8F9FB")))
            ],
          ),
        ));
  }
}
