import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
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

class GroupUserListPage extends StatefulWidget {
  final String gid;

  final int type;

  const GroupUserListPage({Key key, this.gid, this.type = 5}) : super(key: key);
//1列表 2删除 3禁言 4增加管理  5 好友列表(创建群组)

  @override
  _GroupUserListPageState createState() => _GroupUserListPageState();
}

class _GroupUserListPageState extends State<GroupUserListPage> {
  List<GroupUserModel> _selList;
  List<GroupUserModel> _list;
  String _title;

  @override
  void initState() {
    super.initState();
    if (widget.type == 3) {
      _title = "选择禁言人员";
      getGroupUser();
    } else if (widget.type == 1) {
      _title = "群成员";
      getGroupUser();
    } else if (widget.type == 4) {
      _title = "添加群管理员";
      getGroupUser();
    }else if (widget.type == 5){
      _title = "创建群组";

    }



  }

  getGroupUser() async {
    _list = await reqGroupUserList(widget.gid);
    // _selList = _list;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar(_title).build(context),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            padding:
                EdgeInsets.only(bottom: widget.type == 2 ? 120.w : 0),
            itemBuilder: (context, index) {
              return _itemWidget(_list[index], onTap: () {
                if (widget.type == 3) {
                  BanListDialog.show(context, widget.gid,
                      int.parse(_list[index].userUid));
                } else if (widget.type == 4) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("设置管理员"),
                          content: Text("您确定设置 "+_list[index].nickname+"，为管理员"),
                          actions: <Widget>[
                            FlatButton(
                                child: Text("取消"),
                                onPressed: () => Get.back()),
                            FlatButton(
                                child: Text("确定"),
                                onPressed: () {
                                  //设置管理
                                  reqGroupLevelSet(
                                      widget.gid, 20, int.parse(_list[index].userUid));
                                  Get.back();
                                }),
                          ],
                        );
                      });

                } else {}
              });
            },
            itemCount: _list?.length ?? 0,
          ),
        ),
      ),
    );
  }

  Widget _itemWidget(GroupUserModel item,
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
              // Visibility(
              //   visible: widget.type != 1,
              //   child: MyImage(
              //     selXy ? "icon_xy_sel.png" : "icon_xy_no.png",
              //     isAssetImage: true,
              //     width: 48.w,
              //     height: 48.w,
              //   ),
              // ),
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
