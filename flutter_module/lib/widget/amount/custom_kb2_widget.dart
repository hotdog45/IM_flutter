import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/string_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: custom_kb_widget
 * Author: lishunfeng
 * Date: 2/11/21 12:01 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

///  自定义 键盘 按钮
class CustomKb2Widget extends StatefulWidget {
  ///  按钮显示的文本内容
  final String text;
  final int type; //1 充值 2,转账,3 提现


  CustomKb2Widget({Key key, this.text,this.type, this.callback}) : super(key: key);

  ///  按钮 点击事件的回调函数
  final callback;
  @override
  State<StatefulWidget> createState() {
    return CustomKb2WidgetState();
  }
}

class CustomKb2WidgetState extends State<CustomKb2Widget> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.callback('$backMethod');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text == "del") {
      return MySuperWidget(
        onTap: back,
        fontSize: 50.w,
        bgColor: kAppWhiteColor,
        textColor: kAppWhiteColor,
        child: MyImage(
          "icon_kb_del.png",
          isAssetImage: true,
          width: 60.w,
          height: 55.w,
          // fit: BoxFit.fill,
        ),
      );
    }
    if (widget.text == "ok") {
      if (widget.type == 1){
        return MySuperWidget(
          onTap: back,
          fontSize: 36.w,
          bgColor: kAppColor("#C1342D"),
          textColor: kAppWhiteColor,
          text: "充值",
        );
      }
      if (widget.type == 2){
        return MySuperWidget(
          onTap: back,
          fontSize: 36.w,
          bgColor: kAppColor("#C1342D"),
          textColor: kAppWhiteColor,
          text: "转账",
        );
      }
      return MySuperWidget(
        onTap: back,
        fontSize: 36.w,
        bgColor: kAppColor("#C1342D"),
        textColor: kAppWhiteColor,
        text: "提现",
      );
    }
    return MySuperWidget(
        onTap: back,
        fontSize: 50.w,
        textColor: kAppTextColor,
        bgColor: kAppWhiteColor,
        text: widget.text);
  }
}
