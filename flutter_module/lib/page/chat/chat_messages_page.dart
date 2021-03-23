import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/app_init_utils.dart';
import 'package:flutter_module/page/user/complaints_page.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../user/about_page.dart';
import '../user/head_portrait_page.dart';
import '../user/login_page.dart';
import '../user/setting_gender_page.dart';
import '../user/setting_name_page.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: user_info_page
 * Author: lishunfeng
 * Date: 3/10/21 9:15 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class ChatMessagesPage extends StatefulWidget {
  final String uid;

  const ChatMessagesPage({Key key, this.uid}) : super(key: key);

  @override
  _ChatMessagesPageState createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("聊天信息").build(context),
        body: Container(
          child: Column(
            children: [
              Container(
                height: 204.w,
                color: Colors.white,
                child: Row(
                  children: [
                    _userIconWidget("",name: "阿里巴巴"),
                    _userIconWidget("icon_add_chat.png",type: 1)
                  ],
                ),
              ),
              MySuperWidget(
                height: 20.w,
              ),
              MyItemWidget(
                title: "消息免打扰",
                isSwitch: true,
                onChanged: () {

                },
              ),
              MyItemWidget(
                title: "聊天置顶",
                isSwitch: true,
                onChanged: () {

                },
              ),
              MyItemWidget(
                title: "阅后即焚",

                onChanged: () {

                },
              ),
              MySuperWidget(
                height: 20.w,
              ),
              MyItemWidget(
                title: "投诉",
                onTap: () {
                  Get.to(ComplaintsPage());
                },
              ),
              MyItemWidget(
                title: "查找聊天记录",
                onTap: () {},
              ),
              MyItemWidget(
                title: "清空聊天记录",
                onTap: () {


                },
              )
            ],
          ),
        ));
  }

  _userIconWidget(userAvatar,{name, type = 0}) {
    return Container(
      width: (1.sw - 60.w) / 5,
      alignment: Alignment.center,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          MyImage(
            userAvatar,
            height: 88.w,
            width: 88.w,
            isOval: true,
            isAssetImage: type==1,
          ),

          (name?.length ?? 0) > 0
              ? Positioned(
            bottom: -32.w,
            left: -20.w,
            right: -20.w,
            child: MySuperWidget(
              text: name ?? "",
              textColor: kAppColor("#78787C"),
              fontSize: 20.sp,
              maxLines: 1,
            ),
          )
              : Positioned(
              bottom: -32.w, left: -20.w, right: -20.w, child: Container()),
        ],
      ),
    );
  }

}
