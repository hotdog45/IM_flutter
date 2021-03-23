import 'package:flutter/material.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: key_event
 * Author: lishunfeng
 * Date: 2/11/21 12:25 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

///  支符密码  用于 密码输入框和键盘之间进行通信
class KeyEvent {
  ///  当前点击的按钮所代表的值
  String key;
  KeyEvent(this.key);

  bool isDelete() => this.key == "del";
  bool isCommit() => this.key == "ok";
  bool isDot() => this.key == "·";
}
