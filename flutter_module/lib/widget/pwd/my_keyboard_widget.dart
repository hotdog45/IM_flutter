import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_kb_widget.dart';
import '../amount/key_event.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_keyboard_widget
 * Author: lishunfeng
 * Date: 2/11/21 12:03 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

/// 自定义密码 键盘

var _list = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "del"];

class MyKeyboard extends StatelessWidget {
  final callback;

  const MyKeyboard({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
        height: 440.w,
        color: kAppColor("#F8F9FB"),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: _list.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 250.w/109.w,
          ),
          itemBuilder: (context, index) {
            return CustomKbWidget(
                text: _list[index],
                callback: (val) {
                  callback(KeyEvent(_list[index]));
                });
          },
        ),
      );
  }
}
