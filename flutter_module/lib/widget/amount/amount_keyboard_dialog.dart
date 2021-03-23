import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/amount/my_keyboard2_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'key_event.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_keyboard2_widget.dart
 * Author: lishunfeng
 * Date: 2/13/21 3:07 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述 amount_keyboard_dialog.dart
 */

class AmountKeyboardDialog extends StatefulWidget {
  final onChanged;
  final onDone;
  final int type; //1 充值 2,转账,3 提现

  const AmountKeyboardDialog({Key key, this.onChanged,this.type = 1,  this.onDone})
      : super(key: key);

  @override
  _AmountKeyboardDialogState createState() => _AmountKeyboardDialogState();
}

class _AmountKeyboardDialogState extends State<AmountKeyboardDialog> {
  String keyWord = "";

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            Expanded(child: Container()),
            MyKeyboard2(callback: _keyWordChanged,type:widget.type)
          ],
        ));
  }

  _keyWordChanged(KeyEvent data) {
    if (data.isDelete()) {
      if (keyWord.length > 0) {
        keyWord = keyWord.substring(0, keyWord.length - 1);
      }
    } else if (data.isDot()) {
      if (keyWord.contains(".")) return;
      if (keyWord.length > 0) {
        keyWord += ".";
      }

    } else if (data.isCommit()) {
      widget.onDone(keyWord);
    } else {
      keyWord += data.key;
    }

    widget.onChanged(keyWord);
  }
}
