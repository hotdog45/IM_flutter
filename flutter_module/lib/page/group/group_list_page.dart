import 'package:flutter/material.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/model/buddy_model.dart';
import 'package:flutter_module/common/model/group_data_model.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/page/contacts/friend_list_page.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/dialog/ban_list_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

class GroupListPage extends StatefulWidget {
  final int type;

  const GroupListPage({Key key, this.type = 1}) : super(key: key);
//1  好友列表(创建群组)

  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  List<GroupDataModel> _list = [];


  @override
  void initState() {
    super.initState();


    _getList();
  }

  _getList() async {
    _list = await  reqGroupListData();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("群组", actions: [
        MySuperWidget(
          text: "新建",
          width: 100.w,
          height: 56.w,
          radius: 4,
          fontSize: 32.w,
          textColor: kAppColor("#0D0E15"),
          margin: EdgeInsets.symmetric(vertical: 23.w, horizontal: 30.w),
          onTap: () => Get.to(FriendListPage()),
        )
      ]).build(context),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: widget.type == 2 ? 120.w : 0),
          itemBuilder: (context, index) {
            return _itemWidget(_list[index],onTap: () {
              //群
              HiFlutterBridge.getInstance().goToNative({
                "action": "chatGroup",
                "uid": _list[index].gId,
                "name": _list[index].gName ?? ""
              });
            });
          },
          itemCount: _list.length,
        ),
      ),
    );
  }

  Widget _itemWidget(GroupDataModel model,{
    bool hasLine = true,
    onTap,
  }) {
    return Column(
      children: [
        MySuperWidget(
          bgColor: Colors.white,
          onTap: onTap,
          height: 124.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Row(
            children: [
              MyImage("", width: 88.w, height: 88.w, isOval: true),
              MySuperWidget(
                text: model.gName,
                fontSize: 34.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              MySuperWidget(
                text: model.gMemberCount+"人",
                fontSize: 28.sp,
                textColor: kAppColor("#78787C"),
              ),
              MyImage(
                "icon_right_b.png",
                width: 24.w,
                height: 24.w,
                isAssetImage: true,
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
