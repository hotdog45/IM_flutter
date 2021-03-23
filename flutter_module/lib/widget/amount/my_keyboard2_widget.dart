import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'custom_kb2_widget.dart';
import 'key_event.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_keyboard2_widget.dart
 * Author: lishunfeng
 * Date: 2/13/21 3:07 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class MyKeyboard2 extends StatelessWidget {
  final callback;
  final int type; //1 充值 2,转账,3 提现

  MyKeyboard2({Key key, this.type, this.callback}) : super(key: key);

  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 2.4),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 2.4),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(4, 1.2),
  ];

  List _list = [
    "1",
    "2",
    "3",
    "del",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "ok",
    "·",
    "0"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kAppColor("#DFDFDF"),
        child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            crossAxisCount: 8,
            crossAxisSpacing: 1.w,
            mainAxisSpacing: 1.w,
            itemCount: _staggeredTiles.length,
            itemBuilder: (context, index) {
              return CustomKb2Widget(
                  text: _list[index],
                  type:type,
                  callback: (val) {
                    callback(KeyEvent(_list[index]));
                  });
            },
            staggeredTileBuilder: (index) => _staggeredTiles[index]));
  }
}
