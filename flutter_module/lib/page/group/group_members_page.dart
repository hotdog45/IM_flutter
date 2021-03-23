import 'package:flutter/material.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: red_envelope_page
 * Author: lishunfeng
 * Date: 2/14/21 10:30 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class GroupMembersPage extends StatefulWidget {
  final String id;

  const GroupMembersPage({Key key, this.id}) : super(key: key);

  @override
  GroupMembersPageState createState() => GroupMembersPageState();
}

class GroupMembersPageState extends State<GroupMembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60.w),
              bottomRight: Radius.circular(60.w)),
          child: MyImage(
            "bg_mine.png",
            isAssetImage: true,
            height: 575.w,
            width: 750.w,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            child: MyImage("icon_back_ww.png",
                isAssetImage: true,
                width: 20,
                height: 20,
                padding: EdgeInsets.only(right: 50, bottom: 50), onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                HiFlutterBridge.getInstance().onBack({});
              }
            }),
            left: 30.w,
            top: 25.w + ScreenUtil().statusBarHeight),
        Positioned(
            child: MyImage(
              "icon_more_w.png",
              isAssetImage: true,
              width: 20,
              height: 20,
              padding: EdgeInsets.only(left: 50, bottom: 50),
              onTap: () {
                MyToast.show("text");
              },
            ),
            right: 30.w,
            top: 25.w + ScreenUtil().statusBarHeight),
        Padding(
          padding: EdgeInsets.only(
              top: 120.w + ScreenUtil().statusBarHeight,
              left: 30.w,
              right: 30.w),
          child: Column(
            children: [
              _headerView(),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MySuperWidget(
                  bgColor: Colors.white,
                  radius: 10,
                  child: Column(
                    children: [
                      MyItemWidget(
                        title: "相册",
                        onTap: () {},
                      ),
                      MyItemWidget(
                        title: "语音",
                        subTitle: "2",
                        onTap: () {},
                      ),
                      MyItemWidget(
                        title: "个性签名",
                        subTitle: "不积跬步无以至千里",
                        onTap: () {},
                      ),
                      MyItemWidget(
                        title: "其它说明",
                        subTitle: "爱哭又爱笑，爱吵有爱闹",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 20.w,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MySuperWidget(
                  bgColor: Colors.white,
                  radius: 10,
                  child: Column(
                    children: [
                      // MyItemWidget(
                      //   title: "设置备注",
                      //   onTap: () {},
                      // ),
                      MyItemWidget(
                        title: "进群方式",
                        subTitle: "太阳女神  邀请进群",
                        onTap: () {},
                      ),
                      MyItemWidget(
                        title: "最近活跃",
                        subTitle: "02-23 14:23",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              MySuperWidget(
                height: 88.w,
                width: 690.w,
                bgColor: Colors.white,
                radius: 10,
                margin: EdgeInsets.only(top: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      "icon_renlian.png",
                      isAssetImage: true,
                      width: 26.w,
                      margin: EdgeInsets.only(right: 10.w),
                    ),
                    Text(
                      "发消息",
                      style: TextStyle(color: kAppColor("#596B90")),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  _headerView() {
    return Container(
      height: 220.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              MyImage(
                "",
                width: 140.w,
              ),
              Positioned(
                  right: 2,
                  top: 5,
                  child: MyImage(
                    "icon_man_1.png",
                    isAssetImage: true,
                    width: 34.w,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w, left: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MySuperWidget(
                  textColor: Colors.white,
                  text: "王小丫",
                  fontSize: 44.sp,
                ),
                MySuperWidget(
                  textColor: Color(0x99ffffff),
                  text: "昵称：蒲公英的约定",
                  fontSize: 30.sp,
                ),
                MySuperWidget(
                  textColor: Color(0x99ffffff),
                  text: "ID：MY7829108312",
                  fontSize: 30.sp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
