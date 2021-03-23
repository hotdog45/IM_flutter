import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';

/// Copyright (C), 2015-2020, 谊品生鲜
/// FileName: pop_up_menu
/// Author: lishunfeng
/// Date: 2020/8/3 9:35 PM
/// Description:
/// History:
/// <author> <time> <version> <desc>
/// 作者姓名 修改时间 版本号 描述
// leverage
class MyPopupMenuBtn extends StatefulWidget {
  final int type;

  const MyPopupMenuBtn({Key key, this.type = 1}) : super(key: key);

  @override
  _MyPopupMenuBtnState createState() => _MyPopupMenuBtnState();
}

class _MyPopupMenuBtnState extends State<MyPopupMenuBtn> {
  final map = {
    "添加好友": Icons.account_box_rounded,
    "创建群聊": Icons.account_box_rounded,
  };
  final map2 = {
    "邀请朋友": Icons.account_box_rounded,
    "创建群聊": Icons.account_box_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => buildItems(),
      offset: Offset(100, 40),
      color: kAppWhiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onSelected: (e) {
        if (e == "添加好友") {
          HiFlutterBridge.getInstance()
              .goToNative({"action": "addFriend"});
        } else if (e == "创建群聊") {
          HiFlutterBridge.getInstance()
              .goToNative({"action": "createQunChat"});
        } else if (e == "邀请朋友") {
          HiFlutterBridge.getInstance()
              .goToNative({"action": "inviteFriends"});

        }
      },
      onCanceled: () => print('onCanceled'),
      child: Image.asset(
        Config.KEY_IMAGE_PATH + (widget.type == 1 ? "icon_add.png":"icon_more.png"),
        width: 18,
        height: 18,
      ),
    );
  }

  List<PopupMenuItem<String>> buildItems() {
    return (widget.type == 1 ? map : map2)
        .keys
        .toList()
        .map((e) => PopupMenuItem<String>(
            value: e,
            child: Row(
              children: <Widget>[
                Icon(
                  widget.type == 1 ? map[e] : map2[e],
                  color: kAppTextColor,
                  size: 22,
                ),
                Text(
                  e,
                  style:
                      TextStyle(fontSize: fontSizeSmall, color: kAppTextColor),
                ),
              ],
            )))
        .toList();
  }
}
