import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/group_data_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/page/user/my_qr_page.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'group_admin_page.dart';
import 'group_ban_page.dart';
import 'group_user_list_page.dart';

/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: group_manage_page
 * Author: lishunfeng
 * Date: 3/6/21 12:55 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class GroupManagePage extends StatefulWidget {
  final String gid;

  const GroupManagePage({Key key, this.gid}) : super(key: key);


  @override
  _GroupManagePageState createState() => _GroupManagePageState();
}

class _GroupManagePageState extends State<GroupManagePage> {
  var switchOpen1 = false;
  var switchOpen2 = false;
  var switchOpen3 = false;
  var switchOpen4 = false;
  GroupDataModel _model;

  @override
  void initState() {
    super.initState();
    getGroupData();
  }

  getGroupData() async {

    _model = await reqGroupData(widget.gid);
    switchOpen2 = _model.gIsBan != 0;

    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("群管理").build(context),
      body: Container(
        child: ListView(
          children: [
            MyItemWidget(title: "群管理员",onTap: (){
              Get.to(GroupAdminPage(gid: widget.gid,));

            },),//GroupUserListPage
            // MyItemWidget(title: "转让群",onTap: (){
            //   Get.to(GroupUserListPage(type: 1,gid: widget.gid));
            // },),
            // MyItemWidget(
            //   title: "群聊邀请确认",
            //   desc: "开启后，群成员邀请好友入群需经过群主确认",
            //   isSwitch: true,
            //   switchOpen: switchOpen1,
            //   onChanged: (val) {
            //     switchOpen1 = val;
            //     setState(() {});
            //   },
            // ),
            MySuperWidget(
              height: 20.w,
            ),
            MyItemWidget(
              title: "全员禁言",
              isSwitch: true,
              switchOpen: switchOpen2,
              onChanged: (val) {
                switchOpen2 = val;
                reqGroupBan(widget.gid, switchOpen2);
                setState(() {});
              },
            ),
            MyItemWidget(title: "群内禁言",onTap: (){
              Get.to(GroupBanPage(gid: widget.gid,));
            },),
            MyItemWidget(
              title: "禁止私聊",
              desc: "开启后，群成员点击群内其他成员头像没有反应",
              isSwitch: true,
              switchOpen: switchOpen3,
              onChanged: (val) {
                switchOpen3 = val;
                setState(() {});
              },
            ),
            MySuperWidget(
              height: 20.w,
            ),
            // MyItemWidget(
            //   title: "允许显示群成员",
            //   desc: "关闭后，群成员在成员列表中只能看到群主和管理员",
            //   isSwitch: true,
            //   switchOpen: switchOpen4,
            //   onChanged: (val) {
            //     switchOpen4 = val;
            //     setState(() {});
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
