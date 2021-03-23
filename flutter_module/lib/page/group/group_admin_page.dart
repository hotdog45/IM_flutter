import 'package:flutter/material.dart';
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

class GroupAdminPage extends StatefulWidget {
  final String gid;

  const GroupAdminPage({Key key, this.gid}) : super(key: key);
  @override
  _GroupAdminPageState createState() => _GroupAdminPageState();
}

class _GroupAdminPageState extends State<GroupAdminPage> {
  List<GroupUserModel> _list;

  @override
  void initState() {
    super.initState();

    getGroupUser();
  }

  getGroupUser() async {
    List<GroupUserModel> list = await reqGroupUserList(widget.gid);
    _list = [];
    list.forEach((element) {
      if (element.level == 20){
        _list.add(element);
      }
    });


    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("群管理员").build(context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight:  600.w,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _itemWidget(_list[index]);
                },
                itemCount: _list?.length ?? 0,
              ),
            ),
            MySuperWidget(
              text: "添加管理员",
              textColor: kAppColor("#78787C"),
              fontSize: 32.w,
              bgColor: kAppColor("#F8F9FB"),
              hasBorder: true,
              borderColor: kAppColor("#B7B7BB"),
              height: 88.w,
              margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
              radius: 10.w,
              onTap: () async {
                await Get.to(GroupUserListPage(type: 4,gid: widget.gid,)).then((value) {
                  getGroupUser();
                });
              },
            ),
            MyExpanded(),
            Container(
              color: kAppColor("#F8F9FB"),
              child: Column(
                children: [
                  MySuperWidget(
                    text: "管理员权限说明：",
                    textColor: kAppColor("#363638"),
                    fontSize: 30.w,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 46.w, top: 40.w),
                  ),
                  MySuperWidget(
                    text:
                        "· 当前可设置50名管理员 \n· 修改群聊基本信息(群头像、群聊名称、群公告等) \n· 删除群成员(群主、群管理员除外) \n· 同意进群申请",
                    textColor: kAppColor("#78787C"),
                    fontSize: 28.w,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30.w, top: 10.w,bottom: 150.w),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(GroupUserModel model, {bool hasLine = true, onTap}) {
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
                model.userAvatarFileName,
                width: 88.w,
                height: 88.w,
              ),
              MySuperWidget(
                text: model.nickname,
                fontSize: 34.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              MySuperWidget(
                text: "移出",
                fontSize: 34.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#C1342D"),
                onTap: (){

                  reqGroupLevelSet(widget.gid, 0, int.parse(model.userUid));
                  Future.delayed(const Duration(milliseconds: 900), () {
                    getGroupUser();
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
