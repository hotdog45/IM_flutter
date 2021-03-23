import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: billing_detail
 * Author: lishunfeng
 * Date: 2/14/21 9:34 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class BillingDetailPage extends StatefulWidget {
  @override
  _BillingDetailPageState createState() => _BillingDetailPageState();
}

class _BillingDetailPageState extends State<BillingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppColor("#F8F9FB"),
      appBar: YPAppBar("账单详情").build(context),
      body: ListView(
        children: [
          _item1Widget(),
          _item2Widget(),
        ],
      ),
    );
  }

  _item1Widget() {
    return MySuperWidget(
      margin: EdgeInsets.all(30.w),
      bgColor: Colors.white,
      radius: 12.w,
      child: Column(
        children: [
          MyImage(
            "icon_notice.png",
            isAssetImage: true,
            width: 88.w,
            height: 88.w,
            margin: EdgeInsets.all(30.w),
          ),
          MySuperWidget(
            text: "红包-发给王小丫",
            textColor: kAppColor("#363638"),
            fontSize: 34.w,
          ),
          MySuperWidget(
            text: "¥ 354.34",
            textColor: kAppTextColor,
            fontSize: 60.sp,
            fontWeight: FontWeight.bold,
            padding: EdgeInsets.only(top: 25.w),
          ),
          MySuperWidget(
            text: "已全额退款",
            bgColor: Colors.white,
            textColor: kAppColor("#C1342D"),
            fontSize: 32.sp,
            padding: EdgeInsets.only(top: 10.w,bottom: 20.w),
          ),
        ],
      ),
    );
  }
  _item2Widget() {
    return MySuperWidget(
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      bgColor: Colors.white,
      radius: 12.w,
      child: Column(
        children: [
          _itemRowWidget("红包详情", "查看", hasRight: true),
          LineWidget(left: 30.w,right: 30.w),
          _itemRowWidget("付款方式", "招商银行(3911)"),
          LineWidget(left: 30.w,right: 30.w),
          _itemRowWidget("对方账户", "ID：23892931"),
          LineWidget(left: 30.w,right: 30.w),
          _itemRowWidget("支付时间", "2021-02-03 13:08"),
          LineWidget(left: 30.w,right: 30.w),
          _itemRowWidget("退款时间", "2021-02-03 13:08")
        ],
      ),
    );
  }

  _itemRowWidget(title, subTitle, {hasRight = false}) {
    return MySuperWidget(
      bgColor: Colors.white,
      height: 100.w,
      radius: 12.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MySuperWidget(
              text: title,
              textColor: kAppColor("#B7B7BB"),
              fontSize: 32.sp,
              margin: EdgeInsets.only(left: 30.w, right: 30.w)),
          MyExpanded(),
          MySuperWidget(
            text: subTitle,
            alignment: Alignment.centerLeft,
            textColor: kAppTextColor,
            fontSize: 32.sp,
            margin: EdgeInsets.only(right: hasRight ? 0:30.w),
          ),
          Visibility(
            visible: hasRight,
            child: MyImage(
              "icon_right_b.png",
              isAssetImage: true,
              width: 30.w,
              height: 30.w,
              margin: EdgeInsets.only(right: 30.w),
            ),
          ),
        ],
      ),
    );
  }
}
