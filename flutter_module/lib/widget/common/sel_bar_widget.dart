import 'package:flutter/material.dart';

import '../../common/style/style.dart';
import 'my_super_widget.dart';
/**
 * Copyright (C), 2015-2020, 谊品生鲜
 * FileName: sel_bar_widget
 * Author: lishunfeng
 * Date: 2020/10/2 12:05 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class SelBarWidget extends StatefulWidget {
  final List list;
  final int index;
  final Function callbackAction;

  const SelBarWidget({Key key, this.list, this.index, this.callbackAction}) : super(key: key);

  @override
  _SelBarWidgetState createState() => _SelBarWidgetState();
}

class _SelBarWidgetState extends State<SelBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      margin: EdgeInsets.all(15),
      child: Row(
        children: widget.list.asMap().keys.map((index){
          return Expanded(
            child: MySuperWidget(
              onTap: (){
                widget.callbackAction(index);
              },
              text: widget.list[index],
              bgColor: widget.index == index ? Colors.white: Colors.transparent,
              radius: widget.index == index ? 6 : 0,
              hasBorder: widget.index == index,
              borderWidth: 3,
              borderColor: Colors.black12,
              fontSize: fontSizeNormal,
              textColor: kAppTextColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
