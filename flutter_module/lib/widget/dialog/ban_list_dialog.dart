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

class BanListDialog {
  static show(BuildContext context,gid, int uid) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BanListWidget(gid: gid,uid: uid,);
        });
  }
}

List _list = [
  {"title": "禁言10分钟", "time": 10 * 60},
  {"title": "禁言1小时", "time": 60 * 60},
  {"title": "禁言12小时", "time": 12 * 60 * 60},
  {"title": "禁言1天", "time": 24 * 60 * 60},
  {"title": "禁言30天", "time": 30 * 24 * 60 * 60},
  {"title": "永久禁言", "time": -1},
  {"title": "取消禁言", "time": 1},
];

class BanListWidget extends StatefulWidget {

  final String gid;
  final int uid;

  const BanListWidget({Key key, this.gid, this.uid}) : super(key: key);


  @override
  _BanListWidgetState createState() => _BanListWidgetState();
}

class _BanListWidgetState extends State<BanListWidget> {
  var indexSel = 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MySuperWidget(
        height: 900.w,
        bgColor: Colors.white,
        radius: 12.w,
        child: Column(
          children: [
            Stack(children: [
              MySuperWidget(
                text: "选择禁言时长",
                fontSize: 36.sp,
                radius: 12.w,
                height: 120.w,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Positioned(
                right: 0,
                child: MyImage(
                  "icon_xxx.png",
                  onTap: () {
                    Get.back();
                  },
                  width: 30.w,
                  height: 30.w,
                  isAssetImage: true,
                  padding: EdgeInsets.only(right: 30.w),
                ),
              )
            ], alignment: Alignment.center),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _itemWidget(_list[index], index);
              },
              itemCount: _list?.length ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  _itemWidget(Map map, int index) {
    return MySuperWidget(
      margin: EdgeInsets.only(left: 30.w, right: 30),
      onTap: () {
        indexSel = index;
        setState(() {});
        reqGroupBanUser(widget.gid, map["time"], widget.uid);
        Get.back();

      },
      child: Column(
        children: [
          Container(
            height: 98.w,
            child: Row(children: [
              MySuperWidget(
                text: map["title"],
                fontSize: 30.sp,
                textColor: kAppColor("#363638"),
              ),
              Expanded(child: Container()),
              Visibility(
                visible: indexSel == index,
                child: MyImage("icon_dui.png",
                    width: 42.w, height: 42.w, isAssetImage: true),
              )
            ]),
          ),
          MySuperWidget(
            margin: EdgeInsets.only(left: 30.w, right: 30.w),
            bgColor: kAppColor("#F0F0F0"),
            height: 0.5,
          )
        ],
      ),
    );
  }
}
