import 'package:flutter/material.dart';

import '../../common/style/style.dart';
import 'my_super_widget.dart';

/// Copyright (C), 2015-2020, 谊品生鲜
/// FileName: line_widget
/// Author: lishunfeng
/// Date: 2020/7/30 10:27 PM
/// Description:
/// History:
/// <author> <time> <version> <desc>
/// 作者姓名 修改时间 版本号 描述

class LineWidget extends StatelessWidget {
  final Color color;
  final double height;
  final double left;
  final double right;
  final double top;
  final double bottom;

  const LineWidget({Key key, this.color = const Color(0xFFEAEAEC), this.height = 0.5, this.left = 0, this.right = 0, this.top = 0, this.bottom = 0}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MySuperWidget(
      bgColor: color,
      height: height,
      margin: EdgeInsets.only(left: left,right: right,top: top, bottom: bottom),
    );
  }
}
