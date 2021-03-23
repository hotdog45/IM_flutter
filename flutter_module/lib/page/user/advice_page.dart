import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class AdvicePage extends StatefulWidget {
  final String title;

  const AdvicePage({Key key, this.title}) : super(key: key);
  @override
  _AdvicePageState createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar(widget.title ?? "测试").build(context),
      body: Center(child:MySuperWidget(
        text: widget.title ?? ""+"  疯狂搭建中...",
        onTap: (){

        },
        fontSize:32.sp,
        textColor: Colors.white,
        bgColor: kAppThemeColor,
        height: 88.w,
        radius: 12.w,
        margin: EdgeInsets.only(top: 80.w, left: 60.w, right: 60.w),
      ),),
    );
  }
}
