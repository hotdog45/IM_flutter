import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_gender_page.dart';

class MyVoicePage extends StatefulWidget {
  @override
  _MyVoicePageState createState() => _MyVoicePageState();
}

class _MyVoicePageState extends State<MyVoicePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            appBar: YPAppBar("").build(context),
            body: Column(children: <Widget>[
              MySuperWidget(
                text: "语音介绍",
                fontSize: 50.sp,
                textColor: kAppColor("#0D0E15"),
                fontWeight: FontWeight.bold,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 107.w, left: 75.w),
              ),
              MySuperWidget(
                text: "用语音诠释自己，全方位展示独特的你",
                fontSize: 32.sp,
                textColor: kAppColor("#B7B7BB"),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16.w, left: 75.w, right: 60.w,bottom: 70.w),
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0){
                        return MySuperWidget(
                          height: 88.w,
                          width: 630.w,
                          bgColor: Colors.white,
                          radius: 10,
                          margin: EdgeInsets.only(left: 60.w,right: 60.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyImage(
                                "icon_v_add.png",
                                isAssetImage: true,
                                width: 54.w,
                                margin: EdgeInsets.only(right: 10.w),
                              ),
                              Text("新建我的声音",style: TextStyle(color: kAppColor("#78787C"),fontSize: 32.w),)

                            ],
                          ),
                        );
                      }
                      return _itemWidget();
                    },
                    itemCount: 10),
              ),
            ])),
      ),
    );
  }

  Widget _itemWidget() {
    return Stack(
      children: [
        MySuperWidget(
          bgColor: Colors.white,
          radius: 18.w,
          margin: EdgeInsets.only(left: 60.w, right: 60.w, top: 30.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.w, top: 34.w,bottom: 36.w),
                child: Row(
                  children: [
                    MyImage(
                      "icon_zanting.png",
                      isAssetImage: true,
                      width: 78.w,
                    ),
                    MyImage(
                      "icon_v_bbb.png",
                      isAssetImage: true,
                      width: 334.w,
                      margin: EdgeInsets.only(left: 24.w, right: 24.w),
                    ),
                    MySuperWidget(
                      text: "3’23”",
                      fontSize: 32.w,
                      textColor: kAppColor("#B7B7BB"),
                      margin: EdgeInsets.only(right: 20.w, left: 10.w),
                    )
                  ],
                ),
              ),
              LineWidget(left: 30.w,right: 30.w,),
              MySuperWidget(
                alignment: Alignment.centerLeft,
                text: "382次播放",
                fontSize: 28.w,
                textColor: kAppColor("#B7B7BB"),
                margin: EdgeInsets.only(top: 20.w,bottom: 20.w, left: 30.w),

              )
            ],
          ),
        ),
        Positioned(child: MyImage(
          "icon_v_xx.png",
          isAssetImage: true,
          width: 25.w,
        ),right: 85.w,top: 50.w)
      ],
    );
  }
}
