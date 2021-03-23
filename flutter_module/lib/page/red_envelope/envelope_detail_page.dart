import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/model/red_list_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/date_time_utils.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: red_envelope_page
 * Author: lishunfeng
 * Date: 2/14/21 10:30 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class EnvelopeDetailPage extends StatefulWidget {
  final String redId;

  const EnvelopeDetailPage({Key key, this.redId}) : super(key: key);

  @override
  EnvelopeDetailPageState createState() => EnvelopeDetailPageState();
}

class EnvelopeDetailPageState extends State<EnvelopeDetailPage> {
  RedListModel redListModel;
  var num = "";

  @override
  void initState() {
    super.initState();
    HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        HiFlutterBridge.getInstance().onBack({});
      }
    });
    getList();
    showDebugBtn(context);
  }

  getList() async {
    var uid = await LocalStorage.get(AppConstant.USER_ID) ?? "0";

    redListModel = await reqAccountAccGet(int.parse(widget.redId));
    if (redListModel?.items != null && redListModel.items.length > 0) {
      redListModel.items.forEach((element) {
        if (element.userId == int.parse(uid)) {
          num = "¥ " + element.amount;
        }
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60.w),
                  bottomRight: Radius.circular(60.w)),
              child: MyImage("bg_qb_header.png",
                  isAssetImage: true,
                  height: 387.w,
                  width: 750.w,
                  fit: BoxFit.fill),
            ),
            redListModel == null
                ? Container()
                : MySuperWidget(
                    margin: EdgeInsets.only(
                        top: 20.w + ScreenUtil().statusBarHeight),
                    child: Column(
                      children: [
                        MySuperWidget(
                            text: redListModel.type == 2 ? "拼手气红包" : "普通红包",
                            textColor: kAppWhiteColor,
                            fontSize: 34.sp),
                        MyImage(
                          testImage,
                          width: 148.w,
                          height: 148.w,
                          isOval: true,
                          hasBorder: true,
                          borderWidth: 2,
                          borderColor: kAppWhiteColor,
                          margin: EdgeInsets.only(top: 150.w, bottom: 20.w),
                        ),
                        MySuperWidget(
                          text: redListModel.fromNickname ?? "",
                          textColor: kAppTextColor,
                          fontSize: 36.w,
                        ),
                        MySuperWidget(
                          text: (redListModel?.notice == null ||
                                  redListModel.notice.length < 1)
                              ? "牛年大吉，牛转乾坤"
                              : redListModel?.notice,
                          textColor: kAppColor("#78787C"),
                          fontSize: 32.w,
                          margin: EdgeInsets.only(top: 20.w, bottom: 20.w),
                        ),
                        num.isEmpty
                            ? Container()
                            : MySuperWidget(
                                text: num,
                                textColor: kAppTextColor,
                                fontSize: 80.sp,
                                fontWeight: FontWeight.bold,
                                margin: EdgeInsets.only(bottom: 20.w),
                              ),
                        num.isEmpty
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MySuperWidget(
                                    text: "已存入钱包",
                                    textColor: kAppColor("#F35F4D"),
                                    fontSize: 32.sp,
                                  ),
                                  Icon(Icons.keyboard_arrow_right,
                                      color: kAppColor("#F35F4D"), size: 44.w)
                                ],
                              ),
                        MySuperWidget(
                                text: redListModel?.items?.length == redListModel?.total
                                    ? redListModel?.total.toString() + "个红包,已被抢完"
                                    : "已领取" +
                                    (redListModel?.items == null? "0" : redListModel?.items?.length.toString()) +
                                        "/" +
                                        redListModel?.total.toString() +
                                        "个 共" + redListModel?.amount+ "元" ,
                                textColor: kAppColor("#B7B7BB"),
                                fontSize: 28.sp,
                                height: 60.w,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20.w),
                                margin: EdgeInsets.only(top: 20.w),
                                bgColor: kAppColor("#F8F9FB"),
                              ),
                        Expanded(
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return _itemWidget(redListModel?.items[index]);
                              },
                              itemCount: redListModel?.items == null
                                  ? 0
                                  : redListModel?.items?.length,
                              padding: EdgeInsets.all(0)),
                        )
                      ],
                    ),
                  ),
            Positioned(
                child: MyImage("icon_left_back.png",
                    isAssetImage: true,
                    width: 20,
                    height: 20,
                    padding: EdgeInsets.only(right: 50, bottom: 50), onTap: () {
                  Get.back();
                  HiFlutterBridge.getInstance().onBack(null);
                }),
                left: 30.w,
                top: 25.w + ScreenUtil().statusBarHeight),
          ],
        ));
  }

  _itemWidget(Item item, {onTap}) {
    return MySuperWidget(
      onTap: onTap,
      child: Column(
        children: [
          MySuperWidget(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            height: 128.w,
            bgColor: Colors.white,
            child: Row(
              children: [
                MyImage(item.avatar,
                    width: 76.w,
                    height: 76.w,
                    isOval: true,
                    margin: EdgeInsets.only(right: 30.w)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MySuperWidget(
                          text: item.nickname,
                          fontSize: 34.sp,
                          textColor: kAppColor("#0D0E15"),
                        ),
                      ],
                    ),
                    MySuperWidget(
                      text: DateTimeUtils.dateFormatByTime(item.utime),
                      fontSize: 28.sp,
                      margin: EdgeInsets.only(top: 5),
                      textColor: kAppColor("#B7B7BB"),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                MySuperWidget(
                    text: item.amount + "元",
                    fontSize: 28.sp,
                    textColor: kAppTextColor),
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
    );
  }
}
