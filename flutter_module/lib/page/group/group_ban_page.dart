import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/group_user2_model.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'group_user_list_page.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: group_admin_page
 * Author: lishunfeng
 * Date: 3/6/21 5:20 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class GroupBanPage extends StatefulWidget {

  final String gid;

  const GroupBanPage({Key key, this.gid}) : super(key: key);


  @override
  _GroupBanPageState createState() => _GroupBanPageState();
}

class _GroupBanPageState extends State<GroupBanPage> {
  List<GroupUser2Model> _list = [];

  @override
  void initState() {
    super.initState();

    getGroupBanUser();
  }

  getGroupBanUser() async {
    _list = await reqGroupBanUserList(widget.gid);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("群内禁言").build(context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 600.w, minHeight: 200.w),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _itemWidget(_list[index]);
                },
                itemCount: _list?.length ?? 0,
              ),
            ),
            MySuperWidget(
              text: "添加禁言",
              textColor: kAppColor("#78787C"),
              fontSize: 32.w,
              bgColor: kAppColor("#F8F9FB"),
              hasBorder: true,
              borderColor: kAppColor("#B7B7BB"),
              height: 88.w,
              margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
              radius: 10.w,
              onTap: () async {
                await Get.to(GroupUserListPage(type: 3,gid: widget.gid,)).then((value) {
                  getGroupBanUser();

                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(GroupUser2Model model, {bool hasLine = true, onTap}) {
    return Column(
      children: [
        MySuperWidget(
          bgColor: Colors.white,
          onTap: onTap,
          height: 124.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Row(
            children: [
              MyImage(
                testImage,
                width: 88.w,
                height: 88.w,
              ),
              MySuperWidget(
                text: model?.nickname ?? "嘻嘻嘻嘻嘻嘻",
                fontSize: 34.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              MySuperWidget(
                text: "解禁",
                fontSize: 34.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#C1342D"),
                onTap: () {
                  reqGroupBanUser("0000000363", 1, model.userId);
                  Future.delayed(const Duration(milliseconds: 1200), () {
                    getGroupBanUser();
                  });
                },
              ),
            ],
          ),
        ),
        hasLine
            ? MySuperWidget(
                margin: EdgeInsets.only(left: 104.w, right: 30.w),
                bgColor: kAppColor("#F0F0F0"),
                height: 0.5,
              )
            : Container()
      ],
    );
  }
}
