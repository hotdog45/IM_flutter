import 'package:flutter/material.dart';
import 'package:flutter_module/page/contacts/friend_list_page.dart';
import 'package:flutter_module/page/contacts/search_friend_page.dart';
import 'package:flutter_module/page/group/group_members_page.dart';
import 'package:flutter_module/page/group/group_user_list_page.dart';
import 'package:flutter_module/page/other/my_qr_page.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_qr_widget.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: add_friend_dialog
 * Author: lishunfeng
 * Date: 3/17/21 9:24 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */




class AddFriendWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xeeffffff),
      // color: Colors.transparent,
      child: MySuperWidget(
        onTap: () {
          Get.back();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MyImage(
              "icon_red_xx.png",
              isAssetImage: true,
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.only(right: 30.w, top: 30.w),
              margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
              onTap: () {
                Get.back();
              },
            ),
            _itemWidget("添加好友", "icon_add_friend.png",onTap: ()=>Get.off(SearchFriendPage())),
            _itemWidget("扫一扫", "icon_saosao.png",onTap: ()=>Get.off(QrCodePage())),
            _itemWidget("创建群聊", "icon_chat_group_add.png",onTap: ()=>Get.off(FriendListPage(type: 1))),
            MyExpanded()
          ],
        ),
      ),
    );
  }

  _itemWidget(title, icon,{onTap}) {
    return MySuperWidget(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyImage(icon, isAssetImage: true, width: 100.w, height: 100.w),
          MySuperWidget(
            text: title,
            fontSize: 32.sp,
            margin: EdgeInsets.only(left: 20.w),
            alignment: Alignment.centerLeft,
            height: 120.w,
            width: 180.w,
          )
        ],
      ),
    );
  }
}
