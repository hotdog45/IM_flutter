import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/page/contacts/search_friend_page.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'search_results_page.dart';

/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: message_page
 * Author: lishunfeng
 * Date: 2/4/21 9:08 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class NewFriendPage extends StatefulWidget {
  final String title;

  const NewFriendPage({Key key, this.title}) : super(key: key);
  @override
  _NewFriendPageState createState() => _NewFriendPageState();
}

class _NewFriendPageState extends State<NewFriendPage> {
  final TextEditingController descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("新朋友", actions: [
        MySuperWidget(
          text: "添加",
          width: 100.w,
          height: 56.w,
          radius: 4,
          fontSize: 32.w,
          textColor: kAppColor("#0D0E15"),
          margin: EdgeInsets.symmetric(vertical: 23.w, horizontal: 30.w),
          onTap: () {
            Get.to(SearchFriendPage());
          },
        )
      ]).build(context),
      body: Container(
        color: kAppColor("#F8F9FB"),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return _itemWidget(index);
            },
            itemCount: 10),
      ),
    );
  }

  Widget _itemWidget(index) {
    return MySuperWidget(
      onTap: () {},
      bgColor: Colors.white,
      radius: 12.w,
      // margin: EdgeInsets.only(left: 30.w,right: 30.w,top: 30.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.w, top: 30.w),
            child: Row(
              children: [
                MyImage(
                  "",
                  width: 106.w,
                  height: 106.w,
                  margin: EdgeInsets.only(right: 30.w),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MySuperWidget(
                        textColor: kAppColor("#0D0E15"),
                        text: "王小丫",
                        fontSize: 34.sp,
                        alignment: Alignment.centerLeft,
                      ),
                      MySuperWidget(
                        textColor: kAppColor("#B7B7BB"),
                        text: "我是群聊“搞笑联盟”的王小丫",
                        maxLines: 1,
                        fontSize: 28.sp,
                      ),
                    ],
                  ),
                ),
                index % 2 == 1
                    ? MySuperWidget(
                        textColor: kAppColor("#C1342D"),
                        text: "同意",
                        fontSize: 30.sp,
                        width: 104.w,
                        height: 60.w,
                        bgColor: kAppColor("#F0F0F0"),
                        radius: 5,
                        margin: EdgeInsets.only(right: 30.w),
                      )
                    : MySuperWidget(
                        textColor: kAppColor("#78787C"),
                        text: "已添加",
                        fontSize: 26.sp,
                        width: 104.w,
                        height: 60.w,
                        margin: EdgeInsets.only(right: 30.w),
                      ),
              ],
            ),
          ),
          LineWidget(
            top: 30.w,
          ),
        ],
      ),
    );
  }
}
