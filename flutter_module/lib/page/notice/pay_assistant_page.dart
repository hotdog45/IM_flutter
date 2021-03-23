import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/bill_model.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'billing_detail_page.dart';

class PayAssistantPage extends StatefulWidget {
  @override
  _PayAssistantPageState createState() => _PayAssistantPageState();
}

class _PayAssistantPageState extends State<PayAssistantPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor("#F8F9FB"),
      appBar: YPAppBar("支付小助手").build(context),
      body:  ListView.builder(
              itemBuilder: (context, index) {
                return _itemWidget();
              },
              itemCount: 5,
              padding: EdgeInsets.only(bottom: 40.w)),
    );
  }

  _itemWidget() {
    return MySuperWidget(
      onTap: () {
        Get.to(BillingDetailPage());
      },
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        children: [
          MySuperWidget(
              text: "1月5日 13:00",
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
                  margin: EdgeInsets.only(left: 30.w, right: 30.w),
                ),
                MySuperWidget(
                  text: "转账凭证",
                  textColor: kAppTextColor,
                  fontSize: 32.w,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          MySuperWidget(
            text: "¥ 354.34",
            bgColor: Colors.white,
            textColor: kAppTextColor,
            fontSize: 60.sp,
            fontWeight: FontWeight.bold,
            padding: EdgeInsets.only(top: 10.w),
          ),
          MySuperWidget(
            text: "退款金额",
            bgColor: Colors.white,
            textColor: kAppColor("#B7B7BB"),
            fontSize: 30.sp,
            padding: EdgeInsets.only(top: 10.w, bottom: 30.w),
          ),
          _itemRowWidget("退回方式", "钱包零钱"),
          _itemRowWidget("退款原因", "好友“王小丫”24小时内未领取您发的红包，自动退回"),
          _itemRowWidget("到账时间", "2021-02-04 12:51:20", top: 3),
          MySuperWidget(
            bgColor: Colors.white,
            padding: EdgeInsets.only(top: 30.w),
          ),
          LineWidget(),
          Container(
              width: 690.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MySuperWidget(
                      text: "查看详情",
                      textColor: kAppTextColor,
                      fontSize: 32.w,
                      margin: EdgeInsets.only(left: 30.w),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  MyImage(
                    "icon_right_b.png",
                    isAssetImage: true,
                    width: 30.w,
                    height: 30.w,
                    margin: EdgeInsets.only(right: 30.w),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  _itemRowWidget(title, subTitle, {double top = 0}) {
    return MySuperWidget(
      bgColor: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySuperWidget(
              text: title,
              textColor: kAppColor("#B7B7BB"),
              fontSize: 30.w,
              margin: EdgeInsets.only(left: 30.w, right: 30.w)),
          Expanded(
            child: MySuperWidget(
              text: subTitle,
              alignment: Alignment.centerLeft,
              textColor: kAppTextColor,
              fontSize: 30.w,
              margin: EdgeInsets.only(top: top),
            ),
          ),
        ],
      ),
    );
  }
}
