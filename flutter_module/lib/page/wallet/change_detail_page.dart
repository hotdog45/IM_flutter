import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_bill_page
 * Author: lishunfeng
 * Date: 2/13/21 7:57 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class ChangeDetailPage extends StatefulWidget {
  @override
  _ChangeDetailPageState createState() => _ChangeDetailPageState();
}

class _ChangeDetailPageState extends State<ChangeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("零钱详情").build(context),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return _itemWidget(index %2 == 0 ? 2343.32:-132.2);
          },
          itemCount: 5,
          padding: EdgeInsets.all(0)),
    );
  }

  _itemWidget(double price) {
    return MySuperWidget(
      onTap: () {},
      child: Column(
        children: [
          MySuperWidget(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            height: 164.w,
            bgColor: Colors.white,
            child: Row(
              children: [

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MySuperWidget(
                        text: "飞鸽红包",
                        fontSize: 32.sp,
                        maxLines: 1,
                        alignment: Alignment.centerLeft,
                        textColor: kAppTextColor,
                      ),
                      MySuperWidget(
                        text: "1月29日 19:34",
                        fontSize: 28.sp,
                        maxLines: 1,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 16.w),
                        textColor: kAppColor("#B7B7BB"),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySuperWidget(
                      text: price > 0 ? "+" +price.toString(): price.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                      textColor: price > 0 ? kAppColor("#FFA640"):kAppTextColor,
                    ),
                    MySuperWidget(
                      text: "余额8998.29",
                      fontSize: 28.sp,
                      maxLines: 1,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 16.w),
                      textColor: kAppColor("#B7B7BB"),
                    ),
                  ],
                ),
              ],
            ),
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
