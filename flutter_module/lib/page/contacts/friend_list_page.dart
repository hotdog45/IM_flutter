import 'package:flutter/material.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/model/buddy_model.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/dialog/ban_list_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'contacts_service.dart';
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

class FriendListPage extends StatefulWidget {


  final int type;

  const FriendListPage({Key key,  this.type = 1}) : super(key: key);
//1  好友列表(创建群组)

  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  List<BuddyModel> _selList;
  List<BuddyModel> _list;
  String _title;

  @override
  void initState() {
    super.initState();
    if (widget.type == 1){
      _title = "创建群组";

    }
    _fetchContacts();


  }
  /// 请求联系人列表
  void _fetchContacts() async {
    String uid = await LocalStorage.get(AppConstant.USER_ID);
    List<BuddyModel> list = [];
    list = await ContactsService.sharedInstance.fetchContacts(uid);
    setState(() {
      _list = list;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar(_title).build(context),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: ListView.builder(
                padding:
                    EdgeInsets.only(bottom: widget.type == 2 ? 120.w : 0),
                itemBuilder: (context, index) {
                  return _itemWidget(_list[index], onTap: () {
                    if (widget.type == 1){

                    }


                  });
                },
                itemCount: _list?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(BuddyModel item,
      {bool hasLine = true, onTap, selXy = false}) {
    return Column(
      children: [
        MySuperWidget(
          bgColor: Colors.white,
          onTap: onTap,
          height: 124.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Row(
            children: [
              MyImage(item.userAvatarFileName,
                  width: 88.w, height: 88.w, isOval: true),
              MySuperWidget(
                text: item.nickname,
                fontSize: 34.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              MyImage(
                selXy ? "icon_xy_sel.png" : "icon_xy_no.png",
                isAssetImage: true,
                width: 48.w,
                height: 48.w,
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
