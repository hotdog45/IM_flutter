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

class RoundWidget extends StatelessWidget {
  final Color bgColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const RoundWidget({Key key, this.bgColor, this.radius, this.padding, this.margin}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MySuperWidget(
      width: radius*2,
      height: radius*2,
      bgColor: bgColor,
      margin: margin,
      padding: padding,
      radius: radius,
    );
  }
}
