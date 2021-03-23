import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/event/index.dart';
import 'package:flutter_module/common/model/alarm_message_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/date_time_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/page/notice/announcement_page.dart';
import 'package:flutter_module/page/notice/pay_assistant_page.dart';
import 'package:flutter_module/page/red_envelope/envelope_detail_page.dart';
import 'package:flutter_module/widget/common/my_app_bar.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_item_widget.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/pop_up_menu.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/dialog/add_friend_dialog.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../red_envelope/red_envelope_page.dart';
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

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<AlarmMessageModel> _list = [];
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      getList();
    });
    eventBus.on<LoginEvent>().listen((LoginEvent event) {
      Future.delayed(Duration(seconds: 1), () {
        getHistory();
      });
    });
  }

  getHistory() async {
    await HiFlutterBridge.getInstance().getVal("alarm_history_list");
  }

  getList() async {
    List<AlarmMessageModel> list = [];
    var listData = await HiFlutterBridge.getInstance().getVal("alarm_list");

    if (listData != null) {
      (listData as List).forEach((element) {
        AlarmMessageModel model;
        Map json = jsonDecode(element);
        model = AlarmMessageModel.fromJson(json);
        list.add(model);
      });
    }
    if (list.length > 0) {
      if (list.length != _list.length ||
          list[0].alarmContent != _list[0].alarmContent) {
        _list = list;
        setState(() {});
      }
    }
  }

//个人4  群9
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("消息",
            rightIcon: MyImage(
              "icon_add.png",
              isAssetImage: true,
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.only(top: 3,bottom: 3),
              onTap: () => Get.dialog(AddFriendWidget(), useSafeArea: false),
            )).build(context),
        body: Stack(
          children: [
            Container(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return _itemWidget(_list[index]);
              },
              itemCount: _list.length,
            )),


          ],
        ));
  }

  _itemWidget(AlarmMessageModel model) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.19, // 侧滑按钮所占的宽度
      enabled: true, // 是否启用侧滑 默认启用
      secondaryActions: <Widget>[
        SlideAction(
          child: MySuperWidget(
            text: "置顶",
            textColor: Colors.white,
          ),
          color: Colors.black26,
          onTap: () => Get.snackbar("测试", "嘻嘻嘻嘻嘻嘻嘻嘻寻寻寻寻寻"),
          closeOnTap: true,
        ),
        SlideAction(
          child: MySuperWidget(
            text: "设为未读",
            textColor: Colors.white,
            bgColor: Colors.orange,
          ),
          onTap: () => Get.snackbar("测试", "嘻嘻嘻嘻嘻嘻嘻嘻寻寻寻寻寻"),
          closeOnTap: true,
        ),
        SlideAction(
          child: MySuperWidget(
            text: "删除",
            textColor: Colors.white,
            bgColor: Colors.red,
          ),
          onTap: () => Get.snackbar("删除", "嘻嘻嘻嘻嘻嘻嘻嘻寻寻寻寻寻"),
          closeOnTap: true,
        ),
      ],
      child: MySuperWidget(
        onTap: () {
          if (model.alarmType == 4 || model.alarmType == 8) {
            //个人/陌生人
            HiFlutterBridge.getInstance().goToNative({
              "action": "createChat",
              "uid": model.dataId,
              "nickname": model.title ?? ""
            });
          } else if (model.alarmType == 9) {
            //群
            HiFlutterBridge.getInstance().goToNative({
              "action": "chatGroup",
              "uid": model.dataId,
              "name": model.title ?? ""
            });
          } else if (model.alarmType == 1 || model.alarmType == 2) {
            // 添加好友

          } else if (model.alarmType == 11) {
            // 系统通知
            Get.to(AnnouncementPage());
          } else if (model.alarmType == 12) {
//支付小助手
            Get.to(PayAssistantPage());
          } else if (model.alarmType == 13) {
            // 客服

          }
        },
        child: Column(
          children: [
            MySuperWidget(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              height: 150.w,
              bgColor: Colors.white,
              child: Row(
                children: [
                  Stack(
                    children: [
                      MyImage(
                        model.extraString1,
                        width: 106.w,
                        height: 106.w,
                        margin: EdgeInsets.only(right: 30.w),
                        isOval: true,
                      ),
                      Positioned(
                        child: (int.parse(model?.flagNum ?? "0") ?? 0) > 0
                            ? MySuperWidget(
                                text: model.flagNum,
                                bgColor: kAppColor("#ED2B40"),
                                textColor: Colors.white,
                                radius: 16.w,
                                fontSize: 24.w,
                                height: 32.w,
                                padding: EdgeInsets.only(right: 8.w, left: 8.w),
                              )
                            : Container(height: 32.w),
                        top: 0,
                        right: 28.w,
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MySuperWidget(
                          alignment: Alignment.centerLeft,
                          text: model?.title ?? "",
                          fontSize: 34.sp,
                          textColor: kAppColor("#0D0E15"),
                        ),
                        MySuperWidget(
                          alignment: Alignment.centerLeft,
                          maxLines: 1,
                          text: model?.alarmContent ?? "",
                          fontSize: 28.sp,
                          margin: EdgeInsets.only(top: 5),
                          textColor: kAppColor("#B7B7BB"),
                        ),
                      ],
                    ),
                  ),
                  MySuperWidget(
                    text: DateTimeUtils.dateFormatMillisecondsSince(
                        model?.date.toString() ?? "0",
                        format: "hh:mm"),
                    fontSize: 28.sp,
                    margin: EdgeInsets.only(bottom: 40.w),
                    textColor: kAppColor("#B7B7BB"),
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
        ),
      ),
    );
  }
}
