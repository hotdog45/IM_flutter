import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/string_utils.dart';
import 'package:flutter_module/config/config.dart';
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
class CustomKbWidget extends StatefulWidget {
  ///  按钮显示的文本内容
  final String text;

  CustomKbWidget({Key key, this.text, this.callback}) : super(key: key);

  ///  按钮 点击事件的回调函数
  final callback;
  @override
  State<StatefulWidget> createState() {
    return ButtonState();
  }
}

class ButtonState extends State<CustomKbWidget> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.callback('$backMethod');
  }

  @override
  Widget build(BuildContext context) {
    return MySuperWidget(
        onTap: back,
        height: 108.w,
        width: 1.sw / 3,
        fontSize: 50.w,
        textColor: kAppColor("#0D0E15"),
        borderColor: kAppColor("#DFDFDF"),
        bgColor: StringUtils.isNumeric(widget.text)
            ? Colors.white
            : kAppColor("#F8F9FB"),
        hasBorder: StringUtils.isNumeric(widget.text),
        child: widget.text == "del"
            ? Image.asset(
                Config.KEY_IMAGE_PATH + "icon_kb_del.png",
                width: 44.w,
                height: 44.w,
              )
            : Container(),
        text: widget.text == "del" ? "" : widget.text);
  }
}
