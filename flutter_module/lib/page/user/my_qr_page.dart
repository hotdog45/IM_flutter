import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_qr_page
 * Author: lishunfeng
 * Date: 3/2/21 11:18 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class MyQrPage extends StatefulWidget {
  final bool isGroup;
  final String uid;
  final String name;

  const MyQrPage({Key key, this.isGroup = false, this.uid, this.name}) : super(key: key);


  @override
  _MyQrPageState createState() => _MyQrPageState();
}

class _MyQrPageState extends State<MyQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar(widget.isGroup ?"群二维码名片" :"我的二维码名片").build(context),
      backgroundColor: kAppColor("#F35F4D"),
      body: Container(
        margin: EdgeInsets.only(top: 50.w),
        height: 1157.w,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MyImage("qr_bg.png",
                width: 690.w, height: 1157.w, isAssetImage: true),
            Column(
              children: [
                MyImage(testImage, width: 130.w, height: 130.w, isOval: true),
                MySuperWidget(
                  text: "王小丫",
                  textColor: kAppColor("#0D0E15"),
                  fontSize: 36.w,
                  margin: EdgeInsets.only(bottom: 115.w, top: 30.w),
                ),
                Center(
                    child: QrImage(
                  data:
                      "12345678456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
                  version: QrVersions.auto,
                  size: 442.w,
                )),
                MySuperWidget(
                  text:widget.isGroup?"群专属二维码名片": "我的专属二维码名片",
                  textColor: kAppColor("#78787C"),
                  fontSize: 32.w,
                  margin: EdgeInsets.only(bottom: 115.w, top: 30.w),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        MyImage("icon_copy.png",
                            width: 104.w, height: 104.w, isAssetImage: true),
                        MySuperWidget(
                          text: "复制链接",
                          textColor: kAppColor("#363638"),
                          fontSize: 28.sp,
                          margin: EdgeInsets.only(bottom: 40.w, top: 23.w),
                        ),
                      ],
                    ),
                    Container(
                      width: 200.w,
                    ),
                    Column(
                      children: [
                        MyImage("icon_phone_donw.png",
                            width: 104.w, height: 104.w, isAssetImage: true),
                        MySuperWidget(
                          text: "保存相册",
                          textColor: kAppColor("#363638"),
                          fontSize: 28.sp,
                          margin: EdgeInsets.only(bottom: 40.w, top: 23.w),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
