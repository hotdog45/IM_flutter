import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/model/group_data_model.dart';
import 'package:flutter_module/common/model/group_user_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/page/group/notice_list_page.dart';
import 'package:flutter_module/page/user/complaints_page.dart';
import 'package:flutter_module/page/user/my_qr_page.dart';
import 'package:flutter_module/page/user/setting_name_page.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'group_user_list_page.dart';
import 'group_manage_page.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: message_page
 * Author: lishunfeng
 * Date: 2/4/21 9:08 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述 0000000363
 */

class GroupDataPage extends StatefulWidget {
  final String gid;

  const GroupDataPage({Key key, this.gid = "0000000363"}) : super(key: key);

  @override
  _GroupDataPageState createState() => _GroupDataPageState();
}

class _GroupDataPageState extends State<GroupDataPage> {
  var switchOpen1 = false;
  var switchOpen2 = false;
  GroupDataModel _model;
  List<GroupUserModel> _list = [];

  var isAdmin = false;

  var name = "";
  var uid = "";

  @override
  void initState() {
    super.initState();
    showDebugBtn(context);

    getGroupData();
  }

  getGroupData() async {
    name = await LocalStorage.get(AppConstant.USER_NICKNAME) ?? "";
    uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";

    _model = await reqGroupData(widget.gid);

    getGroupUser();
  }

  getGroupUser() async {
    _list = await reqGroupUserList(widget.gid);
    _list.forEach((element) {
      if (element.userUid == uid) {
        if (element.level == 20 || _model.gOwnerUserUid == uid) {
          isAdmin = true;
        } else {
          isAdmin = false;
        }
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("群聊信息").build(context),
      body: Container(
        child: ListView(
          children: [
            _getNameWidget(),
            _headerView(),
            MyItemWidget(
              title: "我的群昵称",
              subTitle: (_model?.nicknameIngroup != null &&
                      _model.nicknameIngroup.length > 0)
                  ? _model?.nicknameIngroup
                  : name,
              onTap: () {
                Get.to(SettingNamePage(
                  type: -1,
                  name: _model?.nicknameIngroup,gid: widget.gid,
                )).then((value) {
                  getGroupData();
                });
              },
            ),
            MyItemWidget(
              title: "群公告",
              desc: _model?.gNotice ?? "",
              onTap: () {
                if (isAdmin) {}
                Get.to(NoticeListPage());
              },
            ), //GroupManagePage
            isAdmin
                ? MyItemWidget(
                    title: "群管理",
                    onTap: () {
                      Get.to(GroupManagePage(
                        gid: widget.gid,
                      ));
                    },
                  )
                : Container(),
            MyItemWidget(
              title: "群名片",
              onTap: () {
                Get.to(MyQrPage(isGroup: true));
              },
            ),
            MySuperWidget(
              height: 20.w,
            ),
            MyItemWidget(
              title: "消息免打扰",
              isSwitch: true,
              switchOpen: switchOpen1,
              onChanged: (val) {
                switchOpen1 = val;
                setState(() {});
              },
            ),
            MyItemWidget(
              title: "聊天置顶",
              isSwitch: true,
              switchOpen: switchOpen2,
              onChanged: (val) {
                switchOpen2 = val;
                setState(() {});
              },
            ),
            MySuperWidget(
              height: 20.w,
            ),
            MyItemWidget(title: "投诉", onTap: () => Get.to(ComplaintsPage())),
            MyItemWidget(
              title: "查找聊天记录",
            ),
            MyItemWidget(title: "清空聊天记录", onTap: () => MyToast.show("清空成功~")),

            MySuperWidget(
              text: uid == _model?.gOwnerUserUid ? "解散群聊" : "删除并退出",
              textColor: kAppColor("#C1342D"),
              fontSize: 30.w,
              width: 1.sw,
              height: 108.w,
              bgColor: Colors.white,
              onTap: () {
                _outGroup();
              },
            ),
          ],
        ),
      ),
    );
  }

  _outGroup() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text(uid == _model?.gOwnerUserUid ? "您确定解散此群" : "你确定退出此群"),
            actions: <Widget>[
              FlatButton(child: Text("取消"), onPressed: () => Get.back()),
              FlatButton(
                  child: Text("确定"),
                  onPressed: () {
                    if (uid == _model?.gOwnerUserUid) {
                    } else {}
                    Get.back();
                  }),
            ],
          );
        });
  }

  _headerView() {
    return MySuperWidget(
      bgColor: Colors.white,
      margin: EdgeInsets.only(top: 20.w, bottom: 20.w),
      padding: EdgeInsets.all(30.w),
      onTap: () {
        Get.to(GroupUserListPage(
          type: 1,
          gid: widget.gid,
        ));
      },
      child: Column(
        children: [
          Row(
            children: [
              MySuperWidget(
                text: "群成员",
                textColor: kAppColor("#0D0E15"),
                fontSize: 32.sp,
              ),
              MyExpanded(),
              MySuperWidget(
                text: "共" + (_list?.length ?? 0).toString() + "人",
                textColor: kAppColor("#99999C"),
                fontSize: 28.sp,
              ),
              MyImage(
                "icon_right_b.png",
                isAssetImage: true,
                height: 24.w,
                width: 20.w,
              )
            ],
          ),
          Container(
            height: 150.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _userIconWidget(_list[index]);
              },
              itemCount: _list?.length,
            ),
          )
        ],
      ),
    );
  }

  _userIconWidget(GroupUserModel model, {type = 0}) {
    return Container(
      width: (1.sw - 60.w) / 5,
      alignment: Alignment.center,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          MyImage(
            model?.userAvatarFileName ?? "",
            height: 88.w,
            width: 88.w,
            isOval: true,
          ),
          type == 0
              ? Positioned(top: -20.w, right: -36.w, child: Container())
              : Positioned(
                  top: -20.w,
                  right: -36.w,
                  child: MyImage(
                      type == 1 ? "icon_group_main.png" : "icon_group_m.png",
                      isAssetImage: true,
                      height: 42.w)),
          (model?.nickname?.length ?? 0) > 0
              ? Positioned(
                  bottom: -32.w,
                  left: -20.w,
                  right: -20.w,
                  child: MySuperWidget(
                    text: model?.nickname ?? "",
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

  _getNameWidget() {
    return Column(
      children: [
        MySuperWidget(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          height: 150.w,
          bgColor: Colors.white,
          onTap: () {
            Get.to(SettingNamePage(type: 0, name: _model?.gName,gid: widget.gid,))
                .then((value) {
              getGroupData();
            });
          },
          child: Row(
            children: [
              MyImage(
                "",
                width: 106.w,
                height: 106.w,
                margin: EdgeInsets.only(right: 30.w),
                isOval: true,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySuperWidget(
                      alignment: Alignment.centerLeft,
                      text: _model?.gName ?? "群聊",
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      textColor: kAppColor("#0D0E15"),
                    ),
                    MySuperWidget(
                      alignment: Alignment.centerLeft,
                      maxLines: 1,
                      text: "群组聊天已加密",
                      fontSize: 24.sp,
                      margin: EdgeInsets.only(top: 5),
                      textColor: kAppColor("#78787C"),
                    ),
                  ],
                ),
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
        MySuperWidget(
          margin: EdgeInsets.only(left: 104.w, right: 30.w),
          bgColor: kAppColor("#F0F0F0"),
          height: 0.5,
        )
      ],
    );
  }
}
