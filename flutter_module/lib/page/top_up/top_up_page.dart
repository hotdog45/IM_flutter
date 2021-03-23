import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/amount/amount_keyboard_dialog.dart';
import 'package:flutter_module/widget/amount/my_keyboard2_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'bank_card_list.dart';

/// Copyright (C), 2015-2021, 谊品生鲜
/// FileName: top_up_page
/// Author: LISHUNFENG
/// Date: 2/12/21 10:07 PM
/// Description:
/// History:
/// <author> <time> <version> <desc>
/// 作者姓名 修改时间 版本号 描述

class TopUpPage extends StatefulWidget {
  final bool isTopUp; //1充值  2提现

  const TopUpPage({Key key, this.isTopUp = true}) : super(key: key);
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppColor("#F8F9FB"),
        appBar: YPAppBar(widget.isTopUp ? "充值" : "提现").build(context),
        body: MySuperWidget(
          bgColor: Colors.white,
          height: 510.w,
          width: 690.w,
          radius: 12.w,
          margin: EdgeInsets.all(30.w),
          child: Column(
            children: [
              MySuperWidget(
                text: widget.isTopUp ? "充值金额" : "提现金额",
                textColor: kAppColor("#363638"),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 30.w, top: 30.w),
                fontSize: 30.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, top: 80.w),
                child: Row(
                  children: [
                    MyImage("icon_money.png",
                        width: 40.w,
                        height: 58.w,
                        isAssetImage: true,
                        margin: EdgeInsets.only(right: 30.w)),
                    // MySuperWidget(
                    //   text: "888.97",
                    //   fontSize: 80.sp,
                    //   textColor: kAppTextColor,
                    //   fontWeight: FontWeight.bold,
                    //   padding: EdgeInsets.only(left: 56.w),
                    // )
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onTap: () {
                          showDialog<bool>(
                              context: context,
                              barrierColor: Colors.transparent,
                              // barrierDismissible: false,
                              builder: (context) {
                                return AmountKeyboardDialog(
                                  onChanged: (val) {
                                    _controller.text = val;
                                    setState(() {});
                                  },
                                  onDone: (val) {
                                    Get.back();
                                  },
                                );
                              });

                          // Get.to(AmountKeyboardDialog());
                        },
                        onChanged: (val) {},
                        decoration: InputDecoration.collapsed(
                            hintText: "请输入充值金额",
                            hintStyle: TextStyle(
                                fontSize: 32.sp, color: kAppSub2TextColor)),
                        style: TextStyle(fontSize: 80.sp, color: kAppTextColor),
                      ),
                    )
                  ],
                ),
              ),
              MySuperWidget(
                height: 1.w,
                bgColor: kAppColor("#D6D6D6"),
                margin:
                    EdgeInsets.only(left: 108.w, right: 30.w, bottom: 107.w),
              ),
              MySuperWidget(
                height: 1.w,
                bgColor: kAppColor("#F0F0F0"),
              ),
              _itemWidget(
                  "https://t9.baidu.com/it/u=3725320398,1601986061&fm=193",
                  "工商银行(3819)", onTap: () {
                showDialog<bool>(
                    context: context,
                    barrierColor: Colors.transparent,
                    // barrierDismissible: false,
                    builder: (context) {
                      return BankCardDialog(
                        onDone: (val) {
                          MyToast.show( val);
                        },
                      );
                    });
              })
            ],
          ),
        ));
  }

  _itemWidget(icon, title, {bool hasLine = false, onTap}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MySuperWidget(
            onTap: onTap,
            height: 80.w,
            bgColor: Colors.white,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              children: [
                MyImage(
                  icon,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.fill,
                ),
                MySuperWidget(
                  text: title,
                  fontSize: 40.sp,
                  padding: EdgeInsets.only(left: 20.w),
                  textColor: kAppColor("#0D0E15"),
                ),
                Expanded(child: Container()),
                Image.asset(
                  Config.KEY_IMAGE_PATH + "icon_right_b.png",
                  width: 34.w,
                  height: 34.w,
                ),
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
      ),
    );
  }
}
