import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/base/base_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'envelope_detail_page.dart';

/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: red_pop
 * Author: lishunfeng
 * Date: 3/3/21 9:27 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class RedPop extends StatefulWidget {
  final String redId;

  const RedPop({Key key, this.redId}) : super(key: key);
  @override
  _RedPopState createState() => _RedPopState();
}

class _RedPopState extends State<RedPop> {
  var isOpen = true;
  var desc = "大吉大利,恭喜发财";
  BaseModel baseModel;
  @override
  void initState() {
    super.initState();
    getDesc();
  }

  getDesc() async {
    baseModel = await reqAccountRedPay(widget.redId, type: 0);

    if (baseModel != null && baseModel.code !=0 && baseModel.message != null) {
      desc = baseModel.message;
      isOpen = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 1110.w,
          width: 660.w,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    MyImage(
                      isOpen ? "bg_red_pkg_open.png" : "bg_red_pkg.png",
                      isAssetImage: true,
                      height: double.infinity,
                    ),
                    Column(
                      children: [
                        MyImage(
                          testImage,
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(top: 68, bottom: 3),
                        ),
                        MySuperWidget(
                          text: "王小丫的红包",
                          textColor: kAppColor("#F8DF9D"),
                          fontSize: 16,
                        ),
                        MySuperWidget(
                          text: desc,
                          textColor: kAppColor("#F8DF9D"),
                          fontSize: 25,
                          margin: EdgeInsets.only(top: 68),
                        ),
                        MySuperWidget(
                          width: 500.w,
                          height: 420.w,
                          onTap: () {
                            reqAccountRedPay(widget.redId);
                          },
                        )
                      ],
                    ),
                    Positioned(
                        child: MySuperWidget(
                          text: "查看大家的手气",
                          textColor: kAppColor("#F8DF9D"),
                          fontSize: 17,
                          onTap: () {
                            Get.to(EnvelopeDetailPage(redId: widget.redId));
                            HiFlutterBridge.getInstance().dismiss();
                            HiFlutterBridge.getInstance().goToNative({
                              "action": "pushPage",
                              "page": "EnvelopeDetailPage?redId=" + widget.redId
                            });
                          },
                        ),
                        bottom: 10,
                        left: 0,
                        right: 0)
                  ],
                ),
              ),
              MyImage(
                "close_icon_red.png",
                isAssetImage: true,
                width: 42,
                height: 42,
                margin: EdgeInsets.only(top: 22),
                onTap: () {
                  HiFlutterBridge.getInstance().dismiss();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
