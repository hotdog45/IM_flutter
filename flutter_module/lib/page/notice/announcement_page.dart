import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/model/notice_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/date_time_utils.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_module/common/net/rok_dao.dart';

/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: MyBankCard_page
 * Author: lishunfeng
 * Date: 2/13/21 7:57 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List<NoticeModel> list = [];
  @override
  void initState() {

    super.initState();
    HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
      if (Navigator.canPop(context)){
        Navigator.pop(context);
      }else{
        HiFlutterBridge.getInstance().onBack({});
      }
    });

    getList();

  }

  getList() async {
     list = await reqAppNotice();
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor("#F8F9FB"),
      appBar: YPAppBar("系统通知").build(context),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return _itemWidget(list[index]);
          },
          itemCount: list.length,
          padding: EdgeInsets.only(bottom: 40.w)),
    );
  }

  _itemWidget(NoticeModel model) {
    return Column(
      children: [
        MySuperWidget(
            text: DateTimeUtils.dateFormatByTime(model.ctime),
            fontSize: 28.sp,
            textColor: kAppColor("#B7B7BB"),
            margin: EdgeInsets.only(top: 30.w, bottom: 20)),
        Container(
          width: 690.w,
          height: 84.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          ),
          child: Row(
            children: [
              MyImage(
                "icon_notice.png",
                isAssetImage: true,
                width: 35.w,
                height: 30.w,
                margin: EdgeInsets.only(left: 30.w),
              ),
              MySuperWidget(
                text: "【"+model.title+"】",
                textColor: kAppTextColor,
                fontSize: 32.w,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        LineWidget(),
        Container(
          width: 690.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6)),
          ),
          child: MySuperWidget(
            text: model.body,
            width: 690.w,
            textColor: kAppColor("#78787C"),
            fontSize: 32.w,
            margin: EdgeInsets.all(26.w),
          ),
        )
      ],
    );
  }
}
