import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: success_page
 * Author: lishunfeng
 * Date: 2/11/21 3:37 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class SuccessPage extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final int type; //1 支付成功 2转账/提现 3实名
  const SuccessPage(
      {Key key,
      this.type = 3,
      this.icon = "icon_done.png",
      this.title = "充值成功",
      this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 330.w,
              child: Column(
                children: [
                  Image.asset(
                    Config.KEY_IMAGE_PATH + icon,
                    width: 154.w,
                    height: 154.w,
                  ),
                  MySuperWidget(
                    text: title,
                    fontSize: 32.sp,
                    padding: EdgeInsets.only(top: 20.w),
                    textColor: kAppColor(type == 2 ? "#00A43C" : "#0D0E15"),
                  ),
                  type == 2
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 16.w, right: 10.w),
                              child: Image.asset(
                                Config.KEY_IMAGE_PATH + "icon_money.png",
                                width: 24.w,
                                height: 30.w,
                              ),
                            ),
                            MySuperWidget(
                              text: subTitle ?? "888.90",
                              fontSize: 60.sp,
                              padding: EdgeInsets.only(top: 20.w),
                              textColor: kAppColor("#0D0E15"),
                            ),
                          ],
                        )
                      : Container(),
                  type == 3
                      ? MySuperWidget(
                          text: "您提交的认证资料已通过审核",
                          fontSize: 32.sp,
                          padding: EdgeInsets.only(top: 20.w),
                          textColor: kAppColor("#B7B7BB"),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 210.w,
            right: 210.w,
            child: MySuperWidget(
                onTap: Get.back,
                text: "完成",
                fontSize: 32.sp,
                textColor: Colors.white,
                radius: 8.w,
                bgColor: kAppColor("#C1342D"),
                width: 330.w,
                height: 80.w),
          )
        ],
      ),
    );
  }
}
